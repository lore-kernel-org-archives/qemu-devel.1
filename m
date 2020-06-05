Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AE9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 22:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9541B206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 22:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDJaw7R4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9541B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKsk-0000PR-TV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 18:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhKs8-0008Nn-1d
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 18:31:32 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:38638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhKs5-00049B-SY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 18:31:31 -0400
Received: by mail-oi1-x231.google.com with SMTP id c194so9565975oig.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KiwqgsS/i4ytz5Me9ahWScnDpYf2pFdlVNbJh1Un+Q8=;
 b=XDJaw7R4q5JmPD70VwY4LHGYIvOFhTXOKyPVw2LXiNBzg5KvQhhH59AsGSxZcG4B++
 k3zPFm0ypNydAMAUPL3sSmXiA12hQsPjxtJ3+OcyInnCM1biPPQ/TU+cTAhS+zvFTQ3P
 3tzzr3K+EbYnwdSdssy/bK60IRbcKvG+eqmrIhqYEaUZC+b1jE3ULud/a791qMWvlwQk
 yD8rjo1R32OY1b5ttGU95tShbPBq8bluKq2scZtIFC7FewplBf+3xUVNal981SNYHR7B
 Kmz7I2ighD50eRozNixgULOVE3A8yNVfuWy78EUSAtjeMpS3hD6CSR505/fwzA2ZBJuU
 2Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KiwqgsS/i4ytz5Me9ahWScnDpYf2pFdlVNbJh1Un+Q8=;
 b=cSqrtuErzuExZ+O2Shf+1kcabPf3/285hMQSsIs3spjcL0nSteCmvXnEdI/Juce/tn
 xxyKbn9GGe4F0/yffpA8MxmVfKeYvqpZW1VOWaucsMVbd7yG2pZ0MTYnfrRPGDsGN03P
 Z/zzlUj+ht2HDjKf8woeFwe5bMoliQrBpmQkunnV6kR+oxuV9xf2rBwdjfyEzokTfLGM
 vyLpQZ2Rid7vTj1YMQtSLeWk9YVB1sbE2Vp2PfhcsIxvei9xrt379pbIwLdD15Zz+RFb
 uhI6pHeIk7B3QnbdqRQrE/A5/ElZBZq1m0qijl7ahPyE3X6nMpdobyuZgOUBqH1sesiv
 HRhg==
X-Gm-Message-State: AOAM530nMePiWJvqMjjLld+GmEyvZeBu6h3jeXZP3oghZyJhaiuBly1D
 TtOU/kXWWW4du17oo51GtGPWP+D4s/KHPcPQGjjNFQ==
X-Google-Smtp-Source: ABdhPJw8ZEAPBmLiseUaIAFIQOgETaFktPQihaTBVigIjMOjrAm0wDnXvb1mOw4TzZSdElvUHjJvGQKBIEKXIRf6Gmg=
X-Received: by 2002:aca:568c:: with SMTP id k134mr3095894oib.48.1591396288559; 
 Fri, 05 Jun 2020 15:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200605153756.392825-1-cohuck@redhat.com>
In-Reply-To: <20200605153756.392825-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 23:31:17 +0100
Message-ID: <CAFEAcA-c-orTzZ1TYEYVu7EWfwM1FLHRA0RaqyFQnkRFBm=QCA@mail.gmail.com>
Subject: Re: [PULL 00/10] s390x update
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 16:38, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit b489f015fbe2bd59d409211f79ea0a8ac5d2a66d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-06-05 11:53:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20200605
>
> for you to fetch changes up to c44d26a2347177f9bcd558a7c429396b373bb68e:
>
>   target/s390x: Restrict system-mode declarations (2020-06-05 17:13:11 +0200)
>
> ----------------------------------------------------------------
> s390x update:
> - enhance s390x documentation
> - allow ORBs without prefetch specified for vfio-ccw
> - various cleanups and enhancements
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

