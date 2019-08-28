Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9535C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905B52189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPvYayY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905B52189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i343U-0004EF-1p
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GX-0003q4-Su
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GT-0000Pl-B9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:41791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GS-0000O4-Ty
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id m9so391048pls.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wIySDhGsNWmiBe1mxSZk+IQzzrYDWNTA5+8A0wQT8Vc=;
 b=gPvYayY6eKCqOn1gIybOGYzSOEUhbEcFWyeUhcQZbLA642f4bJp+or/HNpe7+CtDU4
 3hFuNxEwK4dBV5dGADHN3A1UaUzM39Nzj7Clks0DDebgqp55KrjA0QWWw9MleF2Nn5w4
 CoFkfm4bEVE2HUCY5tgQslImqmLPADbpRHyA22oVmn0gmurk6OWGCjypi6UQctrfucVx
 zzRAeoaMGD0uSaaVCOO4dhyeNb8KhIRR+OIfJQ5THnsayQSRcU8oEd17DTcfbDSuuJkV
 IArw2QXR5zVGBB8bhKvftz1HA51OHWMySBpIxyLLG09/BnCV+YjwjNRlcuZNDOJVhPP2
 ADvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wIySDhGsNWmiBe1mxSZk+IQzzrYDWNTA5+8A0wQT8Vc=;
 b=uW+uK1AB3toU7tfAEkhH3p+9ccje2L1vzqgyeOO3w5+wYK/hIk+4e2BmCe7igFYpCg
 yoRv466i8wDGlCjA83hEQXSDMNPHC+Xq/2oqxCEu9dWE23SHYjstqpMZDHq2NFzHGy5B
 cBbi8OKeK8O8UoJzy6eFHySUfor0gsFZyq4UOLRd/f03UT8or+1E1iC9RBCtGAHl3pY0
 LU4keJYF9vtq9Ry+Iejr71aqABBy1lpBD0FI5pTrNLxTKtN1vHH15RfAaIIPM0/0SuDO
 eJphcDiohn6T09aRearb494cwbLUcikY1Zq9A3M0+yiyVAFKt7PC1UcMjOYKs2LfrKtN
 uLiQ==
X-Gm-Message-State: APjAAAVmFTwY+yh2LgQdRFJQkawelQ5L3ZdYoenLackLXvSZCFe8Zmrr
 NVuAcBl7M+IP0Jf4Iu21KemvDHlVUW8=
X-Google-Smtp-Source: APXvYqxOmyFGoVS9V2iHqUTNS0j7hwi3U1d+yhbe5D/h6E4WhqDAdalSYFnab0kKJ3g2578fDjskrw==
X-Received: by 2002:a17:902:ff02:: with SMTP id
 f2mr5392599plj.99.1567019151318; 
 Wed, 28 Aug 2019 12:05:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:27 -0700
Message-Id: <20190828190456.30315-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PATCH v3 40/69] target/arm: Convert Table Branch
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 57 +++++++++++++++++++++++++-----------------
 target/arm/t32.decode  |  8 +++++-
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 07547f7b6c..92b3a66e05 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10048,6 +10048,37 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
+{
+    TCGv_i32 addr, tmp;
+
+    tmp = load_reg(s, a->rm);
+    if (half) {
+        tcg_gen_add_i32(tmp, tmp, tmp);
+    }
+    addr = load_reg(s, a->rn);
+    tcg_gen_add_i32(addr, addr, tmp);
+
+    gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                    half ? MO_UW | s->be_data : MO_UB);
+    tcg_temp_free_i32(addr);
+
+    tcg_gen_add_i32(tmp, tmp, tmp);
+    tcg_gen_addi_i32(tmp, tmp, read_pc(s));
+    store_reg(s, 15, tmp);
+    return true;
+}
+
+static bool trans_TBB(DisasContext *s, arg_tbranch *a)
+{
+    return op_tbranch(s, a, false);
+}
+
+static bool trans_TBH(DisasContext *s, arg_tbranch *a)
+{
+    return op_tbranch(s, a, true);
+}
+
 /*
  * Supervisor call
  */
@@ -10443,9 +10474,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, rs;
-    TCGv_i32 tmp;
-    TCGv_i32 addr;
+    uint32_t rd, rn, rs;
     int op;
 
     /*
@@ -10491,7 +10520,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     rn = (insn >> 16) & 0xf;
     rs = (insn >> 12) & 0xf;
     rd = (insn >> 8) & 0xf;
-    rm = insn & 0xf;
     switch ((insn >> 25) & 0xf) {
     case 0: case 1: case 2: case 3:
         /* 16-bit instructions.  Should never happen.  */
@@ -10564,25 +10592,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Load/store exclusive, in decodetree */
                 goto illegal_op;
             } else if ((insn & (7 << 5)) == 0) {
-                /* Table Branch.  */
-                addr = load_reg(s, rn);
-                tmp = load_reg(s, rm);
-                tcg_gen_add_i32(addr, addr, tmp);
-                if (insn & (1 << 4)) {
-                    /* tbh */
-                    tcg_gen_add_i32(addr, addr, tmp);
-                    tcg_temp_free_i32(tmp);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                } else { /* tbb */
-                    tcg_temp_free_i32(tmp);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-                }
-                tcg_temp_free_i32(addr);
-                tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, read_pc(s));
-                store_reg(s, 15, tmp);
+                /* Table Branch, in decodetree */
+                goto illegal_op;
             } else {
                 /* Load/store exclusive, load-acq/store-rel, in decodetree */
                 goto illegal_op;
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index fc3e7db4b5..24482e0eeb 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -489,7 +489,7 @@ LDRD_ri_t32      1110 1001 .101 .... .... .... ........    @ldstd_ri8 w=0 p=1
 STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
 LDRD_ri_t32      1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
 
-# Load/Store Exclusive and Load-Acquire/Store-Release
+# Load/Store Exclusive, Load-Acquire/Store-Release, and Table Branch
 
 @strex_i         .... .... .... rn:4 rt:4 rd:4 .... .... \
                  &strex rt2=15 imm=%imm8x4
@@ -533,6 +533,12 @@ LDA              1110 1000 1101 .... .... 1111 1010 1111      @ldrex_0
 LDAB             1110 1000 1101 .... .... 1111 1000 1111      @ldrex_0
 LDAH             1110 1000 1101 .... .... 1111 1001 1111      @ldrex_0
 
+&tbranch         rn rm
+@tbranch         .... .... .... rn:4 .... .... .... rm:4      &tbranch
+
+TBB              1110 1000 1101 .... 1111 0000 0000 ....      @tbranch
+TBH              1110 1000 1101 .... 1111 0000 0001 ....      @tbranch
+
 # Parallel addition and subtraction
 
 SADD8            1111 1010 1000 .... 1111 .... 0000 ....      @rndm
-- 
2.17.1


