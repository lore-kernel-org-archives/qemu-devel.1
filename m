Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A98C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF3B206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWm6+yVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF3B206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFSe-0008Bx-3s
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNFQu-0006Wt-6x
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:12:40 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNFQs-0005Xp-Cj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:12:39 -0400
Received: by mail-ed1-x541.google.com with SMTP id l17so6254570edq.12
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JLgkXTJa6H4z68GskkgNHNy8FRqTuYI1/2tEJ5ixUCw=;
 b=nWm6+yVlndyw6UoUXKZfkLTPYx6GSRL3/INvboXJHwN9H88ITGsPc6pdpHd0sxpT7t
 u9ieGJdmrXozrrNYVIiq+pYmNBocFQ/2meac+Vyg+6mpSnESvSndCQrQ03MKCNpEShr4
 41mTl9vu7E0/aQ+JEnmuYH5V/4Ui1sPkpYySibVcS4/8eAqveCX3JgAVKNdo0yg7yc1G
 eMujE6kuxG2dWe45SF5IOxuBbk23XEs3NCg5Sg0sRUb77CQVjjWmhqC5p5z3zqRJgCfF
 U6EBTDDUP2Y4OTNloIO3GaKs/V1bIvHiG9342AUTWJYV++UHH+Dj9EmaAKEbRhj0AYFd
 tDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JLgkXTJa6H4z68GskkgNHNy8FRqTuYI1/2tEJ5ixUCw=;
 b=QMLAtecbcjYTfgcEM+11PErahCIpmLNU0Tn9r9tYdg2jRZrQ0NBlCNqiFnKl3GV3qB
 +G9pS0eu+lmFiEHgCmwKazBpS56ef/pHSVwHxLgfPp1+4w40rMutEXQJ9xvSwLK9m8VK
 6jeY8QPAk8lZEmePbvA59WI80FKikf+yffsFCdCchOV/pjM7Y8hJDPtVjAOTii+CXb4C
 zCLuiq8LajdiYCINKgSnNamhZAovGVQSiWZG8SycuLsEEyu8FiZCV6+OJjGxe7cHCqQZ
 uE1R4fLaNXTtyEcGkoTRg/ab+Qcy1fQj8BJmOG4RLYSQFZu9UT2oWlWdyH9LCOkueG1O
 lADw==
X-Gm-Message-State: AOAM530CQOiOrC8Qnf2m2DLuw1rKVHb+UFUZJw1spwYkj+5YND4rOQe4
 8ikOrxEL+b29VghFds1B9po3p1amg+jN6GJfiMP4Ig==
X-Google-Smtp-Source: ABdhPJzqdNXRJLarMhi96XJ2o/O7MCBiyABtirYznNwkndn0A44+PRqyoVozIdKJvTyrIVIjjcy269Q+mgh3Y3ucQm0=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr3105663edv.146.1601385156757; 
 Tue, 29 Sep 2020 06:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200929111255.381871-1-mst@redhat.com>
In-Reply-To: <20200929111255.381871-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 14:12:25 +0100
Message-ID: <CAFEAcA9NkC6WHdM3ZaVLrHqDdTx_nLMyd+K=Z=aza+ccYYDyVw@mail.gmail.com>
Subject: Re: [PULL 0/1] acpi: fixup
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 12:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 213057383c9f73a17cfe635b204d88e11f918df1:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 11:10:29 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to f142e4ede72853aaa7d306bc79b099caed45769b:
>
>   tests/acpi: drop unnecessary files (2020-09-29 07:10:37 -0400)
>
> ----------------------------------------------------------------
> acpi: fixup
>
> My last pull included a ton of useless files by mistake.
> Drop them all.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Michael S. Tsirkin (1):
>       tests/acpi: drop unnecessary files
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

