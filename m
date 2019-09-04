Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26694C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76A221726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ld91WBGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76A221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bJS-00089a-Fu
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azy-0004Ni-0t
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azw-0002H5-2b
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:21 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azv-0002GF-QF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id f19so6951plr.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=p0cMte2SRC3KsDP3LAvH1k1gjZ4hGiRJKgyQQsOuHnA=;
 b=ld91WBGkyc8h/T2O9bfWaE+zmvsMDDewA2X5eV/oEOMTosAU3Uz9mIHepKWN/7q3Ld
 xxNIg32lhZ2unF63sEytbzpNblpnRB5iCmWRkGGaNYuSQlqvepU0prO0NtJgSN3d1Hd0
 Ph+Vp0hOvFXZsIJzhTDZj09/h5wYpvTB/jKvImVAsCuYieRjKsqUkq3UxhaTTCZyJRxp
 3Vu8Dj7aDWWgqhDVs8XKzvt62t2MZOch2zC7SvZgSbQf8Tf2euKupVXvJT4cODSqg3xQ
 I7JZTgRsDqmeDVYwrOZSxlFPIOZkfSlzxPz5Bt7VBACSP9PvxfcuGu1QEweZsDTVn1pC
 Vcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=p0cMte2SRC3KsDP3LAvH1k1gjZ4hGiRJKgyQQsOuHnA=;
 b=RuNPxrDm6K3L/80BIZ3z6OiVpPV/Ly/unyjkd6Iy8V1o8sxbZw//r305Kx2aNTZLwL
 SQxm5lyKTp4aqry0P5L6hKSs1S4mDUcYbI9zNBq1tdaone7q1ZVhgqpuec/CNYlK6oBI
 OPWE2qVm4H0Ynr2939YJAih0c6V/8fCtS8WWfxjC3LPjbxS2eYkEbQ5RuUYTVdXseY8k
 d7jiSJpZJP9bjgaBz39ec/VOcm9FhBN3H8JApVTF9geslRG2gK3zXYaAJZnxEZm2DzCR
 HmQ9Iihy3ZO+p6It7W8X8BHMQBgWVeqdWgl9lWWRAB+IP9S05ubFsdZukIx6sfbCYjMe
 BCZQ==
X-Gm-Message-State: APjAAAWN8Tx+c4KaW4NW7cAZ28Vm8QAxaP95He48bb81ts30l9n8EF3r
 WvvND3pzG1wOMLhyijbFOYenSxcqayk=
X-Google-Smtp-Source: APXvYqzzIb9mqdflYSGrZUBepHFX8Dcjlr7Ui1spO5/tjyDcZjNkSBkuzgB1YIr2TvVitanbebtDPA==
X-Received: by 2002:a17:902:8202:: with SMTP id
 x2mr3071331pln.182.1567625478468; 
 Wed, 04 Sep 2019 12:31:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:04 -0700
Message-Id: <20190904193059.26202-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v4 14/69] target/arm: Convert Cyclic Redundancy
 Check
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
 target/arm/translate.c | 121 +++++++++++++++++++----------------------
 target/arm/a32.decode  |   9 +++
 target/arm/t32.decode  |   7 +++
 3 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 02dd4a2ab8..9d3f31f569 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8320,6 +8320,57 @@ static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
     return true;
 }
 
+/*
+ * Cyclic Redundancy Check
+ */
+
+static bool op_crc32(DisasContext *s, arg_rrr *a, bool c, MemOp sz)
+{
+    TCGv_i32 t1, t2, t3;
+
+    if (!dc_isar_feature(aa32_crc32, s)) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    switch (sz) {
+    case MO_8:
+        gen_uxtb(t2);
+        break;
+    case MO_16:
+        gen_uxth(t2);
+        break;
+    case MO_32:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    t3 = tcg_const_i32(1 << sz);
+    if (c) {
+        gen_helper_crc32c(t1, t1, t2, t3);
+    } else {
+        gen_helper_crc32(t1, t1, t2, t3);
+    }
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t3);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+#define DO_CRC32(NAME, c, sz) \
+static bool trans_##NAME(DisasContext *s, arg_rrr *a)  \
+    { return op_crc32(s, a, c, sz); }
+
+DO_CRC32(CRC32B, false, MO_8)
+DO_CRC32(CRC32H, false, MO_16)
+DO_CRC32(CRC32W, false, MO_32)
+DO_CRC32(CRC32CB, true, MO_8)
+DO_CRC32(CRC32CH, true, MO_16)
+DO_CRC32(CRC32CW, true, MO_32)
+
+#undef DO_CRC32
+
 /*
  * Miscellaneous instructions
  */
@@ -8735,39 +8786,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             gen_bx(s, tmp);
             break;
         case 0x4:
-        {
-            /* crc32/crc32c */
-            uint32_t c = extract32(insn, 8, 4);
-
-            /* Check this CPU supports ARMv8 CRC instructions.
-             * op1 == 3 is UNPREDICTABLE but handle as UNDEFINED.
-             * Bits 8, 10 and 11 should be zero.
-             */
-            if (!dc_isar_feature(aa32_crc32, s) || op1 == 0x3 || (c & 0xd) != 0) {
-                goto illegal_op;
-            }
-
-            rn = extract32(insn, 16, 4);
-            rd = extract32(insn, 12, 4);
-
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            if (op1 == 0) {
-                tcg_gen_andi_i32(tmp2, tmp2, 0xff);
-            } else if (op1 == 1) {
-                tcg_gen_andi_i32(tmp2, tmp2, 0xffff);
-            }
-            tmp3 = tcg_const_i32(1 << op1);
-            if (c & 0x2) {
-                gen_helper_crc32c(tmp, tmp, tmp2, tmp3);
-            } else {
-                gen_helper_crc32(tmp, tmp, tmp2, tmp3);
-            }
-            tcg_temp_free_i32(tmp2);
-            tcg_temp_free_i32(tmp3);
-            store_reg(s, rd, tmp);
-            break;
-        }
+            /* crc32 */
+            /* All done in decodetree.  Illegal ops reach here.  */
+            goto illegal_op;
         case 0x5:
             /* Saturating addition and subtraction.  */
             /* All done in decodetree.  Reach here for illegal ops.  */
@@ -10216,16 +10237,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         goto illegal_op;
                     }
                     break;
-                case 0x20: /* crc32/crc32c */
+                case 0x20: /* crc32/crc32c, in decodetree */
                 case 0x21:
                 case 0x22:
                 case 0x28:
                 case 0x29:
                 case 0x2a:
-                    if (!dc_isar_feature(aa32_crc32, s)) {
-                        goto illegal_op;
-                    }
-                    break;
+                    goto illegal_op;
                 default:
                     goto illegal_op;
                 }
@@ -10254,33 +10272,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 0x18: /* clz */
                     tcg_gen_clzi_i32(tmp, tmp, 32);
                     break;
-                case 0x20:
-                case 0x21:
-                case 0x22:
-                case 0x28:
-                case 0x29:
-                case 0x2a:
-                {
-                    /* crc32/crc32c */
-                    uint32_t sz = op & 0x3;
-                    uint32_t c = op & 0x8;
-
-                    tmp2 = load_reg(s, rm);
-                    if (sz == 0) {
-                        tcg_gen_andi_i32(tmp2, tmp2, 0xff);
-                    } else if (sz == 1) {
-                        tcg_gen_andi_i32(tmp2, tmp2, 0xffff);
-                    }
-                    tmp3 = tcg_const_i32(1 << sz);
-                    if (c) {
-                        gen_helper_crc32c(tmp, tmp, tmp2, tmp3);
-                    } else {
-                        gen_helper_crc32(tmp, tmp, tmp2, tmp3);
-                    }
-                    tcg_temp_free_i32(tmp2);
-                    tcg_temp_free_i32(tmp3);
-                    break;
-                }
                 default:
                     g_assert_not_reached();
                 }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 6ee12c1140..a8ef435b15 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -182,6 +182,15 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
 }
 MSR_imm          .... 0011 0110 .... 1111 .... .... ....      @msr_i r=1
 
+# Cyclic Redundancy Check
+
+CRC32B           .... 0001 0000 .... .... 0000 0100 ....      @rndm
+CRC32H           .... 0001 0010 .... .... 0000 0100 ....      @rndm
+CRC32W           .... 0001 0100 .... .... 0000 0100 ....      @rndm
+CRC32CB          .... 0001 0000 .... .... 0010 0100 ....      @rndm
+CRC32CH          .... 0001 0010 .... .... 0010 0100 ....      @rndm
+CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
+
 # Miscellaneous instructions
 
 %sysm            8:1 16:4
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 98b682e7ec..261db100ff 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -172,6 +172,13 @@ QSUB             1111 1010 1000 .... 1111 .... 1010 ....      @rndm
 QDADD            1111 1010 1000 .... 1111 .... 1001 ....      @rndm
 QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
 
+CRC32B           1111 1010 1100 .... 1111 .... 1000 ....      @rndm
+CRC32H           1111 1010 1100 .... 1111 .... 1001 ....      @rndm
+CRC32W           1111 1010 1100 .... 1111 .... 1010 ....      @rndm
+CRC32CB          1111 1010 1101 .... 1111 .... 1000 ....      @rndm
+CRC32CH          1111 1010 1101 .... 1111 .... 1001 ....      @rndm
+CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
+
 # Branches and miscellaneous control
 
 %msr_sysm        4:1 8:4
-- 
2.17.1


