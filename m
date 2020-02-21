Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0DC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3550B222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yI6Su/Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3550B222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BiD-0003ar-DJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5Bf7-0007od-BF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5Bf5-00046M-Lw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:00:24 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5Bf5-00041r-E6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:00:23 -0500
Received: by mail-ot1-x343.google.com with SMTP id p8so2576142oth.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=uM70t+2Zopn/RrkZNp56Cy6qmLx+q2Dx/+HgocnSrvQ=;
 b=yI6Su/Bq1iP9RR1YK0s6UyLEzzs3Nsox/cKUlWBeEYSShMGlkRuaDUvmqUxF1CSHKU
 dsMQZullvaxcq8o3LV+IxCXYbE39r/xoB0mbw4zNNXiqPVYvFo2CYrVXwbCzc9mgISRX
 qM59saCB2L7RsHFm0jUt5GIOHIUSPSANNjGn2DFin2evbhQa1ecYGJlas8lB6Edsui8S
 nNhTSDkB/uW+GH8Zjc+ePYIKnOxYqW8l88crKhWkXUvMTyGucnWWNPRpbul78aeT8Pf3
 GzMsXL5Q3jaElHDxVpt1XXfZNxMC1E9fvbU0pSI6A35lYJ2PFLJWKdH/R6kXwwwEUgx6
 5viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=uM70t+2Zopn/RrkZNp56Cy6qmLx+q2Dx/+HgocnSrvQ=;
 b=Cbu0S4v7a08utmxLiaN1hQ/1ur+3xS1u72MlLbgXVsFhozLoiQRCRhgNeoUgAHJ1lQ
 42H7EmtjA+hX/yDM5E4eQNElVyvsFk5DhMnkkzH0wRvOuojshDhEsOhDwjtTNKbPUfsn
 bwo715djmO+xBQNw5KMue8fuvaBtawFM9xon0RzUSnaLv3MYhc3zEEKyKNxO4HdYTb6/
 ozCmsehyzeJ6G1mxBEzEzjTEHlaVFXkrutwgEy+wVaKT3DBtVGu55m8WHnG8PEIyMncO
 PJeIVafDnVDJO9u5L8/gd2xmw9vOBqLY++zbgyLoYMQUWm9Ot8XSMSDRbgojf/a6qEr9
 WxvQ==
X-Gm-Message-State: APjAAAXg89N5/5+vnXJbgNnoaq1NbJEe7CBtRTsJKxmQxhHwjBsQNc2G
 Nmjm25ddcCRhhLuQ4pislQHf40nivx7wXzQy8oxGPzAW
X-Google-Smtp-Source: APXvYqw4aTV/dGJt+81LBS5JjkYyvfwYCFiMyO2HjH7HQCDVHezxvHVB8rLPiGzxlYsV4KkLoKuHy7mX1dG77wnHsZo=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr27130817otq.97.1582304422295; 
 Fri, 21 Feb 2020 09:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20200221161829.17142-1-peter.maydell@linaro.org>
In-Reply-To: <20200221161829.17142-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 17:00:11 +0000
Message-ID: <CAFEAcA8TY5LYaUgH+j7GwgmjYi74Hqi22ewzuYtt9Z5U3_2=pA@mail.gmail.com>
Subject: Re: [PULL v2 00/46] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v1->v2 changes: dropped the last 6 patches from rth as there's
> a problem with one of them that's too complicated to try to
> fix up.
>
> thanks
> -- PMM
>
> The following changes since commit a8c6af67e1e8d460e2c6e87070807e0a02c0fec2:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200221' into staging (2020-02-21 14:20:42 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200221-1
>
> for you to fetch changes up to 9eb4f58918a851fb46895fd9b7ce579afeac9d02:
>
>   target/arm: Set MVFR0.FPSP for ARMv5 cpus (2020-02-21 16:07:03 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * aspeed/scu: Implement chip ID register
>  * hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt Clear' register
>  * mainstone: Make providing flash images non-mandatory
>  * z2: Make providing flash images non-mandatory
>  * Fix failures to flush SVE high bits after AdvSIMD INS/ZIP/UZP/TRN/TBL/TBX/EXT
>  * Minor performance improvement: spend less time recalculating hflags values
>  * Code cleanup to isar_feature function tests
>  * Implement ARMv8.1-PMU and ARMv8.4-PMU extensions
>  * Bugfix: correct handling of PMCR_EL0.LC bit
>  * Bugfix: correct definition of PMCRDP
>  * Correctly implement ACTLR2, HACTLR2
>  * allwinner: Wire up USB ports
>  * Vectorize emulation of USHL, SSHL, PMUL*
>  * xilinx_spips: Correct the number of dummy cycles for the FAST_READ_4 cmd
>  * sh4: Fix PCI ISA IO memory subregion
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

