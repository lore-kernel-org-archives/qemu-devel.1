Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A59C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A26218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyjxBfl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A26218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4X4-0004Zf-3L
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59558)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nt-0007K9-3w
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nr-0001IO-IQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:35665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nn-00018s-Iu
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id u14so24878698pfn.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3dOWwe1vKbsdIWS0nSZCwW1yYPHjDGBihHkemS/ZoSY=;
 b=dyjxBfl6BToPNY6VUCaToZdn+s3aAJ3ikTyADQR8Az2DKnYBVnzU2dQphCMsyF9HG/
 r0Z9VBcJ5us5CMliebrRm1mSwNgv25a+PiwxJD3uostHSQCLPEKqk3SHbX0wGx188awC
 W4Du//iD6wHfG4KEhfBsK9bijFmA7SYGsG4znsMUEaG0STRCRroeH7ayMz/nD7GQ64Cw
 7mmypMsmAQfjwo46JrX8LU6DR3ojdQ+fDiC5P0z7E/Rcl13GQWkKAWue+OK8N4amtoye
 4j4V3eIG4ka4mnct1ctgZVybj8rCZ0f0Gsf7DbCNT5xgzjOusEs5SFiy4gQCvMCnglAj
 cZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3dOWwe1vKbsdIWS0nSZCwW1yYPHjDGBihHkemS/ZoSY=;
 b=ZAxXVh5NFuOlDZt3B8w8EOXTLbA/3Cuql2a8ZySNJZTHkZN0KxatHjq0OA352kKXrU
 wlPxfceAsmJ4oV5/Vj1Sr+sOiUpdIOFo+bacnFwA2BzMqHMCkNvwef+3kynaieAlBiQe
 9Az5LWrms6mXEjthNZHw/3ORCBYizvNFaUQWYlu3veCfopWUSpqSFpCJBLWg9patvoQb
 Put/IBCYSjtTsYij+YYqRYT9lIsOWUg/cIvBV/iXEoio7teJDBcWxkwuYDscLhvKpNQh
 iwat5Z/SCdQxdKCD/11LqfRiz/LPJgtrlCty3Xf2aZBJrbL4jd8co1+4wfbn3Z8oNDCh
 1+OQ==
X-Gm-Message-State: APjAAAUGg1IxNJ43OIlaYYaFMPDXNGDnicUx8GCFfn3lP5orLGcGUmb8
 ORvgskz0hv/mHPeHNED+CknRNwKkt10=
X-Google-Smtp-Source: APXvYqwrgH57aatk/3onnC93pqHwwPgK+EsFQMEBnq8iAE4QrWKCr+KF9gzL7xiEyfHH3uwulqeu+A==
X-Received: by 2002:a17:90a:37ac:: with SMTP id
 v41mr94950125pjb.6.1564163510598; 
 Fri, 26 Jul 2019 10:51:50 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:29 -0700
Message-Id: <20190726175032.6769-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH 64/67] target/arm: Convert T16, long branches
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 89 +++++++++++++++++++-----------------------
 target/arm/t16.decode  |  3 ++
 2 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 480515a0a9..a8db6e9280 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10055,6 +10055,44 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+static bool trans_BL_BLX_prefix(DisasContext *s, arg_BL_BLX_prefix *a)
+{
+    /*
+     * thumb_insn_is_16bit() ensures we can't get here for
+     * a Thumb2 CPU, so this must be a thumb1 split BL/BLX.
+     */
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    tcg_gen_movi_i32(cpu_R[14], s->pc_read + (a->imm << 12));
+    return true;
+}
+
+static bool trans_BL_suffix(DisasContext *s, arg_BL_suffix *a)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    tcg_gen_addi_i32(tmp, cpu_R[14], (a->imm << 1) | 1);
+    tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
+    gen_bx(s, tmp);
+    return true;
+}
+
+static bool trans_BLX_suffix(DisasContext *s, arg_BLX_suffix *a)
+{
+    TCGv_i32 tmp;
+
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = tcg_temp_new_i32();
+    tcg_gen_addi_i32(tmp, cpu_R[14], a->imm << 1);
+    tcg_gen_andi_i32(tmp, tmp, -4);
+    tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
+    gen_bx(s, tmp);
+    return true;
+}
+
 static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
 {
     TCGv_i32 addr, tmp;
@@ -10639,10 +10677,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    int32_t offset;
-    TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-
     if (disas_t16(s, insn)) {
         return;
     }
@@ -10661,53 +10695,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 11: /* misc, in decodetree */
     case 12: /* load/store multiple, in decodetree */
     case 13: /* conditional branch or swi, in decodetree */
-        goto illegal_op;
-
     case 14:
-        if (insn & (1 << 11)) {
-            /* thumb_insn_is_16bit() ensures we can't get here for
-             * a Thumb2 CPU, so this must be a thumb1 split BL/BLX:
-             * 0b1110_1xxx_xxxx_xxxx : BLX suffix (or UNDEF)
-             */
-            assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
-            ARCH(5);
-            offset = ((insn & 0x7ff) << 1);
-            tmp = load_reg(s, 14);
-            tcg_gen_addi_i32(tmp, tmp, offset);
-            tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
-
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-            break;
-        }
-        /* unconditional branch, in decodetree */
-        goto illegal_op;
-
     case 15:
-        /* thumb_insn_is_16bit() ensures we can't get here for
-         * a Thumb2 CPU, so this must be a thumb1 split BL/BLX.
-         */
-        assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
-
-        if (insn & (1 << 11)) {
-            /* 0b1111_1xxx_xxxx_xxxx : BL suffix */
-            offset = ((insn & 0x7ff) << 1) | 1;
-            tmp = load_reg(s, 14);
-            tcg_gen_addi_i32(tmp, tmp, offset);
-
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-        } else {
-            /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix */
-            uint32_t uoffset = ((int32_t)insn << 21) >> 9;
-
-            tcg_gen_movi_i32(cpu_R[14], s->pc_read + uoffset);
-        }
-        break;
+        /* branches, in decodetree */
+        goto illegal_op;
     }
     return;
 illegal_op:
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 457f2f4178..105218882a 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -274,3 +274,6 @@ LDM             1011 110 ......... \
 %imm11_0x2      0:s11 !function=times_2
 
 B               11100 ...........               &i imm=%imm11_0x2
+BLX_suffix      11101 imm:11                    &i
+BL_BLX_prefix   11110 imm:s11                   &i
+BL_suffix       11111 imm:11                    &i
-- 
2.17.1


