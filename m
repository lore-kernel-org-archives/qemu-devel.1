Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6396CC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1A020756
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItsoJKzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1A020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaoyr-0008Ds-9f
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 18:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaoxf-0007fI-JW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:46:38 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:46875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaoxN-0005yJ-Jv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:46:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id w13so5119009eju.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 15:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tiC+tztL0+pKnyq6+BMpYKlDBghPae5NUlBdt/xJ3dA=;
 b=ItsoJKzBR+GZ4OC4d3qIlAm9yRMh3Wajhpd5LM6DcSN2FyPsFxmUSkO8IGmkU0aav+
 ZIVpgcGrJiveyrs6Y4/eqHIneTNQ7U06yW3Obe17scPe5amh7KSl5U479sgr0RvUbgp/
 LykwzZKhNjV8mTzb4nxHK3OGPd+TBzILJAhRXV/tz0/08Q7KTGhDFC26lcllszRCkEVm
 OoTuX+zIBukblvnC9BXX2pqbvbP/xlUQ7lgVCYS5axv/y96HpNnOpg5m1FNVEIVQ6+W1
 Q33r7ph1XZv6mMkk3BLnSI1GQAeMTzNus3ruGW3ZCSb86KRoKsO5Hm7WRdtpUQG84nIs
 BZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tiC+tztL0+pKnyq6+BMpYKlDBghPae5NUlBdt/xJ3dA=;
 b=CfoovDKSebA7jKjWXNwrSJYvV4kini2CExKk01y0fjoV0k332xOoncdFxNm3RpszAw
 snnyN4arIqT1c1UgxGyzZBtl5OOJN3fR2BMXJIcZkSE3TxTdQrddWQOnJWsmS1gTkPuK
 LFkQ6Aj6TRzsPinWRDmE+It687MliiU3ksncFqDbHIdtBqPeWKDdAbwxI8Tipo5wa04i
 Cdb2TjR3iDPTHaPYUm9NSLcVxTk5ImNV95Gzeyzv5pF174qnrEb0cFGH8MNHFLsvPz6S
 Oglku8X2tWJPlyDRYH2jur3miKLT1GxCqRGTeQcW2xu6LDpA9Tj2E4ajR6n04lzz9MVY
 tYPw==
X-Gm-Message-State: AOAM531FTD/wxT7q6DJi0h8sZMLn/6TuENfz7aN3rJaxZVvhhQTB8kMf
 fpEvcOhjKCSGG8nhC8MMCHmbIfqdtbQfhUkgQ2it4Q==
X-Google-Smtp-Source: ABdhPJyEXYjlbk8cZUcCqM8PKK5WiNq9yhMJD+Mpx7WwHnsdmM/n4uk0d5XyKXuXD/ygcUKWRxZSC2/auzhHqH3XjJ0=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr4927397ejc.4.1604619975127; 
 Thu, 05 Nov 2020 15:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20201105034919.393653-1-david@gibson.dropbear.id.au>
In-Reply-To: <20201105034919.393653-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 23:46:04 +0000
Message-ID: <CAFEAcA9AhEoYL+NApMDpH7dWHKBoRs98B0z20mCb6-_FCYuFRQ@mail.gmail.com>
Subject: Re: [PULL 0/3] ppc-for-5.2 patch queue 2020-11-05
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 at 03:49, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 3c8c36c9087da957f580a9bb5ebf7814a753d1c6:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201104-pull-request' into staging (2020-11-04 16:52:17 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/dgibson/qemu.git tags/ppc-for-5.2-20201105
>
> for you to fetch changes up to f29b959dc6871c9d8df781d1bedcfaebc76d5565:
>
>   spapr: Convert hpt_prepare_thread() to use qemu_try_memalign() (2020-11-05 12:18:48 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2020-11-05
>
> A small PR this time, one bugfix, one removal of minor dead code, one
> warning suppression.
>
> ----------------------------------------------------------------
> Chen Qun (1):
>       target/ppc/excp_helper: Add a fallthrough for fix compiler warning
>
> Greg Kurz (2):
>       spapr: Drop dead code in spapr_reallocate_hpt()
>       spapr: Convert hpt_prepare_thread() to use qemu_try_memalign()


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

