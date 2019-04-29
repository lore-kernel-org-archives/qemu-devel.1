Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6186C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EFE20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDK1iSCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EFE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9rr-0007u9-Ng
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:15:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ee-0004fW-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eX-0006cb-4c
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eV-0006Ev-UJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r6so17126930wrm.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=C5ELT6YRQDH3x2HFJvJf8ZZNn5ZtD6+g/82yTJwrTMg=;
	b=RDK1iSCqOVSkW7h/LXdUrXuItYxD3n7vLCbzGI+wtiG+GE5fy48rFHdbFOGxnnXhya
	HYq5sP9mNXwXPJ8/AI3mNv6PIR15x71ctk5bHiAMQBMnUVK97vWkW/ikXtMNXA9PpNsn
	0Oijn99zC7G8X4WOG+y4ao9qjWGuwTT2VOQUEXlP7ZVFR93PNBm4k9vPEHM6O69lA4sD
	I0OnUuKPvuxRYWkbH0NWxxtZOK0bpSSaVGDnY4tLa9Kq7gv4DD8JmgIfGJXacptpqxAb
	MuDC794LiS/ifKKVytSIw7/KITyEwZVLNwzWUxBnDjQth1IS1KsErSaUJd7BHICSF2hg
	KrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=C5ELT6YRQDH3x2HFJvJf8ZZNn5ZtD6+g/82yTJwrTMg=;
	b=dkdFB4vaVYbbRV3+Y4eEAvawZiobwXTElMPIO165HBqvZ9ZJ7bMotNg3BSJgmu4GZG
	bqtI9Fjta5MSSb/I/ktxM5AnFVZuYxARPoAIEUmF9Q+RUPFawOcR2hc1rmIgc7CuSf2t
	WJ5aZaFWIoF0wDSekd9EYN5MIgjZJYKhpjPt2FhIvx9ylu32gPZoDf4QkwPnEjEIwJwb
	hWLtm1pqRxmpA5G7z0/ifcWTrUrZ2tHanVHp2mbTWXcgN/s50+i3tL/k3DNjXzrUSEa2
	8jqMm2AhkTFSqvBW/i5Do3H8OINPEJX+WZRBLKhOCC5O8zEFQgKdHO91cGaJM08EiO44
	TDdA==
X-Gm-Message-State: APjAAAVam6fnY+50aNfpzKsJtJagJyFJaKJuGS4iBequIJeULVEhGZ8m
	5d98NTdaF1bGt+VmOBR3kiBN8u3eZ3g=
X-Google-Smtp-Source: APXvYqwLKxKdXANomuDhpHUIro0omoF7DXuLBgWyRqZCPotw/A6GHhPQRJj5YpgUB1G8qMaKiG9m1g==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr15335188wrs.5.1556557244189; 
	Mon, 29 Apr 2019 10:00:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:57 +0100
Message-Id: <20190429170030.11323-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 09/42] target/arm: Decode FP instructions for M
 profile
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165957.VYMpue9daH1X6K8ShWJou__Yy55m2AcUDxqgwCS0F2s@z>

Correct the decode of the M-profile "coprocessor and
floating-point instructions" space:
 * op0 == 0b11 is always unallocated
 * if the CPU has an FPU then all insns with op1 == 0b101
   are floating point and go to disas_vfp_insn()

For the moment we leave VLLDM and VLSTM as NOPs; in
a later commit we will fill in the proper implementation
for the case where an FPU is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-7-peter.maydell@linaro.org
---
 target/arm/translate.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6a11921d0b8..0747f7847a9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11728,10 +11728,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     case 6: case 7: case 14: case 15:
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            /* We don't currently implement M profile FP support,
-             * so this entire space should give a NOCP fault, with
-             * the exception of the v8M VLLDM and VLSTM insns, which
-             * must be NOPs in Secure state and UNDEF in Nonsecure state.
+            /* 0b111x_11xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx */
+            if (extract32(insn, 24, 2) == 3) {
+                goto illegal_op; /* op0 = 0b11 : unallocated */
+            }
+
+            /*
+             * Decode VLLDM and VLSTM first: these are nonstandard because:
+             *  * if there is no FPU then these insns must NOP in
+             *    Secure state and UNDEF in Nonsecure state
+             *  * if there is an FPU then these insns do not have
+             *    the usual behaviour that disas_vfp_insn() provides of
+             *    being controlled by CPACR/NSACR enable bits or the
+             *    lazy-stacking logic.
              */
             if (arm_dc_feature(s, ARM_FEATURE_V8) &&
                 (insn & 0xffa00f00) == 0xec200a00) {
@@ -11745,6 +11754,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Just NOP since FP support is not implemented */
                 break;
             }
+            if (arm_dc_feature(s, ARM_FEATURE_VFP) &&
+                ((insn >> 8) & 0xe) == 10) {
+                /* FP, and the CPU supports it */
+                if (disas_vfp_insn(s, insn)) {
+                    goto illegal_op;
+                }
+                break;
+            }
+
             /* All other insns: NOCP */
             gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
                                default_exception_el(s));
-- 
2.20.1


