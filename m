Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80DC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A640720862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqkYbBtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A640720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABEV-0001SL-6E
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAB9g-0005rc-2x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAB9d-0001Oe-Oh
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:56:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAB9c-0001Lm-4O
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:56:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so2576232oti.12
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lvaj2hnZt+ar6Y5yxpTurTxL2haiZLli/lN4YWHVGQE=;
 b=cqkYbBtpxsoJ4E5zpnjgG1KHc8zzDl0f92IDKgvY0vcjSU3zu/pKUa/IL85CqbbkPa
 7Aow9AKDZMGdolgMS7S4Ry2gKQ69WeKcS/iL20pm6k5TtUyiXdaMICPtjMgG5OrHG8vy
 yRL/sehr2RjfLeAlvRQ5UaLqOe17oSiOCOgnJUrQlPejAAKcRmPYm4TzeFwLXEpbiGhw
 CWx9F21uW3yZNod88vB+Q5floxWCpgD9CxosHsVgQXmPhmMGuhOPzhDxN6k6nNcp2R/e
 2a+l4DaPPPemEgp5/bWHduPXV1Jg0RsJjrsAez5DAzIXTzMvwRy6pbB49RVAMD6U0MaD
 5Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lvaj2hnZt+ar6Y5yxpTurTxL2haiZLli/lN4YWHVGQE=;
 b=k8dgpABJfgbwIS5UrCnaHlLmVRaSsWLwQ1w302/8No/2/DVDUDBsxfbFn4VUHXz1dO
 60eTXGCnzzkTpmPaLlnQsp9cHbmVkB3Whukbwa3D0GTMDr96X2ecaV2xC5l67F5huP42
 EV+FO08CQ+recd+uOBz1ho7mdj/LQBJs7hCS6ulc2sgpvQT+vpS1MDqI/EOcGD//RFYB
 2DmWRjOFR8JMb+XCyfCUxUm1ApInELR75K2YBg7p4TisnRyEOaxnXHM/YMDNLiRqvjv1
 lHo69vFa+SjZbvNmZ+zszVdXBCX1Jzwq0oiRaFTcMGl6DKSNOZgV+JZPIDz9Dl6JBkf9
 WAjA==
X-Gm-Message-State: APjAAAUCPewQA+GYwSjOypW+BOs87L8zuLS5iF3zYa/Bp2hycRD4pP/O
 QSsRFeV143bRgSqyQJY47gp0IIATS7WCkfPzbSKmgw==
X-Google-Smtp-Source: APXvYqzXw8F+4I0gKpq93daEpT5I8c18Xd9kwkfKUpV5lGS1x6AtpX2ya0sxnB7kHsapr7THBFao0smZy0og9z/yrwg=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr1951585otq.97.1568717772553; 
 Tue, 17 Sep 2019 03:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190912110103.1417887-1-luc.michel@greensocs.com>
 <CAFEAcA-WO=O5zwRDQoNz2zT4sx61j8Jy5px0uFPiWgF_JUpa+A@mail.gmail.com>
 <204007b1-1c1e-432b-399f-b3784f812710@greensocs.com>
 <c3a22836-0435-e09b-6fe0-eff85124c0ca@greensocs.com>
In-Reply-To: <c3a22836-0435-e09b-6fe0-eff85124c0ca@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 11:56:01 +0100
Message-ID: <CAFEAcA8b1XUpwq-NefVL+BD0bNfDu6Rhxygbb3mfyV1t17NZUQ@mail.gmail.com>
To: Luc Michel <luc.michel@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix CBAR register for AArch64
 CPUs
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 at 09:43, Luc Michel <luc.michel@greensocs.com> wrote:
>
> On 9/13/19 9:26 AM, Luc Michel wrote:
> > Hi Peter,
> >
> > On 9/12/19 6:03 PM, Peter Maydell wrote:
> >> I think we need to check through the TRMs to confirm which CPUs use
> >> which format for the CBAR, and have a different feature bit for the
> >> newer format/sysreg encoding, so we can provide the right sysregs for
> >> the right cores.
> > I checked all the AArch64 Cortex's TRMs, for those having a PERIPHBASE
> > signal and CBAR register (namely Cortex-A53, 57, 72, 73), they all match
> > the mapping I put in this patch, so I think we don't need to split the
> > CBAR feature further. I believe more recent Cortex's address the GIC
> > using coprocessor registers, and CBAR does not exist in those ones.
>
> Hi Peter,
>
> Do you want me to re-roll this patch with some modifications?

No, that's OK. Thanks for checking the TRMs. I think what I'll
do is squash in this comment to the patch:

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 755aa18a2dc..bc1130d989d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6733,6 +6733,19 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }

     if (arm_feature(env, ARM_FEATURE_CBAR)) {
+        /*
+         * CBAR is IMPDEF, but common on Arm Cortex-A implementations.
+         * There are two flavours:
+         *  (1) older 32-bit only cores have a simple 32-bit CBAR
+         *  (2) 64-bit cores have a 64-bit CBAR visible to AArch64, plus a
+         *      32-bit register visible to AArch32 at a different encoding
+         *      to the "flavour 1" register and with the bits rearranged to
+         *      be able to squash a 64-bit address into the 32-bit view.
+         * We distinguish the two via the ARM_FEATURE_AARCH64 flag, but
+         * in future if we support AArch32-only configs of some of the
+         * AArch64 cores we might need to add a specific feature flag
+         * to indicate cores with "flavour 2" CBAR.
+         */
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             /* 32 bit view is [31:18] 0...0 [43:32]. */
             uint32_t cbar32 = (extract64(cpu->reset_cbar, 18, 14) << 18)


and apply it to target-arm.next, if that's OK with you.

thanks
-- PMM

