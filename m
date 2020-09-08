Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A41AC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D6B205CB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJvr6o8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D6B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgQF-0005iW-Ic
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFgP5-0004Nw-Fa
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:23:31 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFgP3-00085W-IL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:23:31 -0400
Received: by mail-ed1-x541.google.com with SMTP id w1so16657788edr.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y4WsRxhlTx/2hHK9NXItGoisfo4HT4jTNgWzYXpZs6g=;
 b=aJvr6o8SmvjXCZqdpivltjTP2eb/a1TWZWHWPRLDFATolr5sNkd8Ilf90yVj06Y2R2
 JEkR2PIyBuYCEOfeB1oiWXh6sB1CYVaViEfQmSX4JYwNID9/62HzsJ1w09wM0QvEgoQz
 L9o/yKo9QklDjlW1sKvPmNugpu4Nswizp6hQQ3L1Lc/EDgfWkdKWG0LSDJYUbZEH6HgU
 fXgB6rdqHW1RVA+N+rrQNJ3bzy3E7JmosyPUJZuOxgQn9bFsXMmLVuXlv/oe/OEl6OKk
 bunIxqLvnD9lwNEvljK4IFjWBqUhdOog0kMT/u4CjsOKUR+mjCOJl7a8b1tfOPhlf4rp
 saLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4WsRxhlTx/2hHK9NXItGoisfo4HT4jTNgWzYXpZs6g=;
 b=obd5J00qPYyUL5f00Biijwc7zfH/2M7Y9PzfF4xBU0j0mlj557Bn/pvi2FGzJzEMkV
 tTXrrJwqQfj8JFMMzKjAXEHP8JQyq4lP7tHX1rct6Yxy52cfLyA6KRNxDfalzrmxSP8U
 qAAPDKqZjxpP2mPYZ8Sd80yAngbys93QcWKAjizxwgPLUJnd3XNgzm+Vz31IzC9l6KiO
 9gPJiu0d+N2ZDFrywe89PpIDjnf29Olu2OGGynrbE9E5XiPS6RFK0LhCHwXiiioj63uJ
 5ud/UywVPTFHurqqPe/ldJ1aqG6fNcRr9y3fM/6jNvyTviZLZr9zwI8VvPSaAiceBvE7
 HLvA==
X-Gm-Message-State: AOAM5334Z5Vr3nWXusUr9CfBQd4tn6XXhVY1XG2FHuSIo9rjfDiVps+P
 uhCqFGTAYxoHjS5SEFMy7oMeaxsvufXsMLb6/Vn3mg==
X-Google-Smtp-Source: ABdhPJyaZjjbg0c4M2Pr45qUDwQve2aIEFnBPgu1LU7gAiX0DCX4ep13EwEsBLAvHFTk60L6DYPHAWE7cCuFk/940Ig=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr26974052edv.146.1599582207357; 
 Tue, 08 Sep 2020 09:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 17:23:16 +0100
Message-ID: <CAFEAcA9s0N7zz1w1sSQ+d1nuhcMmEU43KO29nzQA-xpBP8v7yg@mail.gmail.com>
Subject: Re: [PULL 00/33] ppc-for-5.2 queue 20200908
To: David Gibson <david@gibson.dropbear.id.au>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 06:20, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200908
>
> for you to fetch changes up to 876ab8d89d0d288945334c8caa908b07ef847de2:
>
>   spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall (2020-09-08 11:34:30 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-09-08
>
> This supersedes ppc-for-5.2-20200904, it fixes a couple of bugs in
> that PR and adds a few extra patches.
>
> Next pull request for qemu-5.2.  The biggest thing here is the
> generalization of ARM's start-powered-off machine property to all
> targets.  This can fix a number of odd little edge cases where KVM
> could run vcpus before they were properly initialized.  This does
> include changes to a number of files that aren't normally in my
> purview.  There are suitable Acked-by lines and Peter requested this
> come in via my tree, since the most pressing requirement for it is in
> pseries machines with the POWER secure virtual machine facility.
>
> In addition we have:
>  * Daniel Barboza's rework and clean up of pseries machine NUMA handling
>  * Correction to behaviour of the nvdimm= generic machine property on
>    pseries
>  * An optimization to the allocation of XIVE interrupts on KVM
>  * Some fixes for confused behaviour with kernel_irqchip when both
>    XICS and XIVE are in play
>  * Add HIOMAP comamnd to pnv flash
>  * Properly advertise the fact that spapr_vscsi doesn't handle
>    hotplugged disks
>  * Some assorted minor enhancements


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

