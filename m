Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055DB20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPmVw9Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055DB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNhx-0006um-7j
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:01:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf4-0004Y9-Pc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf2-00018x-SK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf0-00014I-TY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so26886014wrw.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=xc3UIGC5SvjlHs9DchEFUCKpsleMW6NB4iU50Hc4tGE=;
	b=yPmVw9Vm2MHaue//8t6SPQ/AQlQsCrh3+Bv5D8HFaaVR9Q1mganklBEN6OVfzObcbR
	erJvWHQzigC05an4Luo9d0uLxauQBDxXae8bZw6LlUsJ6qNXoNTeSk9/tOkpYZv2y4v1
	T1HRBkaA5U27N5fB6MLiC1ZZmMBlLORsIE6tE748XMLXZlsQ2cmlYW3fw8xMyhz6V1Qr
	BXA9YaMGAYn0ofaZf10bRfcYGncJsU5ZkgKUzkfTO7Km9pQppcWQllSZEoq9IWuJNbJj
	8K/g8dj9cdhw76SQyK0KqNw39BuisLx3pwVZzQDvRASaPFNjKBpGKojYL4KRzBTlgY7w
	PeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xc3UIGC5SvjlHs9DchEFUCKpsleMW6NB4iU50Hc4tGE=;
	b=ebqgsEfG+Arz5LMc5nGxGCq+EIDTkBvICV/2gxsAWu1/scHUawMGIRTT0U/5JE0F6g
	R8cOYBiWFQZEAMna5v/5vOcqzzG5JcucRLEpsNILwKCv6tc7+Fxnq5xcC6MQEePFeuwR
	dPNJxQgQuJusffEA4MhaNL9Yqsp1Q9ltLUtvf4+kb2BXU5Ikg6SSL3oMc5NDd6OkbdSD
	GCxyZG1F/XTf5Cfp7u7DMyW6jRWRuSg0IerhjuCQo6fkrAVScGnKXiJjLxEYH79ThDc6
	0lkne7x4vhMo3WTlOQuVf4wnyacZVB9h/97BdiQqHzJXQj4mbRGaA912FNzTOdKr/AZe
	mKHg==
X-Gm-Message-State: APjAAAVBC9Vi458XfFzm80VJaw2MpJJoiAuCyEgiyJOSmxYkOnT8PwzC
	nUH2D1yvlyIO32jsy/MsihpDDA==
X-Google-Smtp-Source: APXvYqw2gRjMcAiAtTv/ngrhodkBRKGqmi38Qa5NLwWPjn4DTQHv2oXotLLVIPu5709074X1U+0J0w==
X-Received: by 2002:adf:de07:: with SMTP id b7mr23886402wrm.196.1555419478176; 
	Tue, 16 Apr 2019 05:57:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:24 +0100
Message-Id: <20190416125744.27770-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 06/26] target/arm: Decode FP instructions for M
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
Message-ID: <20190416125724.ORORdDmV2swAFCAdvlLdjS6YXDBacvAHRO8UEVGoqHI@z>

Correct the decode of the M-profile "coprocessor and
floating-point instructions" space:
 * op0 == 0b11 is always unallocated
 * if the CPU has an FPU then all insns with op1 == 0b101
   are floating point and go to disas_vfp_insn()

For the moment we leave VLLDM and VLSTM as NOPs; in
a later commit we will fill in the proper implementation
for the case where an FPU is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bb539111179..d280b3a9a3a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11727,10 +11727,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -11744,6 +11753,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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


