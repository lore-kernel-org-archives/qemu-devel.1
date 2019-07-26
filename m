Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F33C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C59A218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ukzzjtgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C59A218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4P8-0003s7-2k
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Ms-0002oM-Ku
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mq-0007zy-62
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mq-0007v5-0a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id y15so24860433pfn.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4ALWL+uoJUM+006aGewT3E/ArRPeObW9mCQYZxOKNhg=;
 b=UkzzjtgkD3XEQARx/R51cETEunwutE29JNVmjuiVAQYcmK/Xv3BwkhKofr9fDDyTct
 2gU575BmE1wSjA0Dgs40/lZleoJHxagmioyMn0e4pGsCwATXkZNp5jAdRWcFaipXFPJl
 RGyuR72Pv1d98IKUHAgJuV4L3C/QfG5KI05zsX/TaN+GUPJfPtkzCh8OCn70XHQZVY3H
 i469v3RIHnYEBajRgk1UxJx/O2vaFAVVAWQIEMQVCkezHHLyPoFrAaRTETYqcfYCpJew
 liA3mtdb+IOt5lpll76H9rFwo1Lpkxal0+jNcf52YcBnTsPZui5QIS354FMqqLG5+IN1
 SE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4ALWL+uoJUM+006aGewT3E/ArRPeObW9mCQYZxOKNhg=;
 b=uF8Vrrq9KS5e0fb/SKUnayRnSAf491Bt0UZcG2oHTSk2btjCchVIU4SkOoA5fCnS4g
 +FiyVA1gw1M3r2V+rLCg+p+xgWCy11L+eOSuxIxR9XgfAJwR9ReI/ST3C0AvBObp/HW/
 1aQ9xvjgWUVMWa8GljYQQvShjUZBuFPDh1IQfS8roESmu52loW9cqApXWu1ggqu2JJao
 I/5gz38Sq4vqpl0E6CxjnfWb+cjiLRCeaVhi14AGGfo6QplfkbOvizkYrFqZx5vtIbNe
 06dlCz+wv6RU+wZxLCGnnv5xXZWndrqL2W3e306Fd6zZMoi6Rrmlai8QmwlsniEhTeT1
 vH4Q==
X-Gm-Message-State: APjAAAWVEf2ZpFq52f0b6LYJp0jWHHJ2fHTA1lucNwR0qVuFjQLN3EBQ
 e9hmQgcE9Ppyz/9qR12lQZa7O+5O0B4=
X-Google-Smtp-Source: APXvYqwca/sC2H39BeVHtUg87j3D7LIfq9XM2zSriG3K2ZAtpxlC6nunc0IQkYcNjZeBWO85V0ksrQ==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr22624844pfi.221.1564163453745; 
 Fri, 26 Jul 2019 10:50:53 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:42 -0700
Message-Id: <20190726175032.6769-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 17/67] target/arm: Convert MSR (immediate) and
 hints
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
 target/arm/translate.c | 61 +++++++++++++++++++++++++++++-------------
 target/arm/a32.decode  | 25 +++++++++++++++++
 target/arm/t32.decode  | 17 ++++++++++++
 3 files changed, 84 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2140671eb2..36c815caf3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8324,6 +8324,44 @@ DO_SMLAWX(SMLAWT, 1, 1)
 
 #undef DO_SMLAWX
 
+/*
+ * MSR (immediate) and hints
+ */
+
+static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
+{
+    gen_nop_hint(s, 1);
+    return true;
+}
+
+static bool trans_WFE(DisasContext *s, arg_WFE *a)
+{
+    gen_nop_hint(s, 2);
+    return true;
+}
+
+static bool trans_WFI(DisasContext *s, arg_WFI *a)
+{
+    gen_nop_hint(s, 2);
+    return true;
+}
+
+static bool trans_NOP(DisasContext *s, arg_NOP *a)
+{
+    return true;
+}
+
+static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
+{
+    uint32_t val = ror32(a->imm, a->rot * 2);
+    uint32_t mask = msr_mask(s, a->mask, a->r);
+
+    if (gen_set_psr_im(s, mask, a->r, val)) {
+        gen_illegal_op(s);
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8594,22 +8632,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             store_reg(s, rd, tmp);
         } else {
-            if (((insn >> 12) & 0xf) != 0xf)
-                goto illegal_op;
-            if (((insn >> 16) & 0xf) == 0) {
-                gen_nop_hint(s, insn & 0xff);
-            } else {
-                /* CPSR = immediate */
-                val = insn & 0xff;
-                shift = ((insn >> 8) & 0xf) * 2;
-                if (shift)
-                    val = (val >> shift) | (val << (32 - shift));
-                i = ((insn & (1 << 22)) != 0);
-                if (gen_set_psr_im(s, msr_mask(s, (insn >> 16) & 0xf, i),
-                                   i, val)) {
-                    goto illegal_op;
-                }
-            }
+            /* MSR (immediate) and hints */
+            /* All done in decodetree.  Illegal ops already signalled.  */
+            g_assert_not_reached();
         }
     } else if ((insn & 0x0f900000) == 0x01000000
                && (insn & 0x00000090) != 0x00000090) {
@@ -10569,9 +10594,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             goto illegal_op;
                         break;
                     case 2: /* cps, nop-hint.  */
-                        if (((insn >> 8) & 7) == 0) {
-                            gen_nop_hint(s, insn & 0xff);
-                        }
+                        /* nop hints in decodetree */
                         /* Implemented as NOP in user mode.  */
                         if (IS_USER(s))
                             break;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 8dc74dfdb8..4cefba6f0e 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -22,6 +22,7 @@
 # All insns that have 0xf in insn[31:28] are in a32u.decode.
 #
 
+&empty
 &s_rrr_shi       s rd rn rm shim shty
 &s_rrr_shr       s rn rd rm rs shty
 &s_rri_rot       s rn rd imm rot
@@ -152,3 +153,27 @@ SMULBB           .... 0001 0110 .... 0000 .... 1000 ....      @rd0mn
 SMULBT           .... 0001 0110 .... 0000 .... 1100 ....      @rd0mn
 SMULTB           .... 0001 0110 .... 0000 .... 1010 ....      @rd0mn
 SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
+
+# MSR (immediate) and hints
+
+&msr_i           r mask rot imm
+@msr_i           ---- .... .... mask:4 .... rot:4 imm:8       &msr_i
+
+{
+  {
+    YIELD        ---- 0011 0010 0000 1111 ---- 0000 0001
+    WFE          ---- 0011 0010 0000 1111 ---- 0000 0010
+    WFI          ---- 0011 0010 0000 1111 ---- 0000 0011
+
+    # TODO: Implement SEV, SEVL; may help SMP performance.
+    # SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
+    # SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
+
+    # The canonical nop ends in 00000000, but the whole of the
+    # rest of the space executes as nop if otherwise unsupported.
+    NOP          ---- 0011 0010 0000 1111 ---- ---- ----
+  }
+  # Note mask = 0 is covered by NOP
+  MSR_imm        .... 0011 0010 .... 1111 .... .... ....      @msr_i r=0
+}
+MSR_imm          .... 0011 0110 .... 1111 .... .... ....      @msr_i r=1
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index e611ac4969..b4f0a9632d 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -19,6 +19,7 @@
 # This file is processed by scripts/decodetree.py
 #
 
+&empty           !extern
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
@@ -166,3 +167,19 @@ QADD             1111 1010 1000 .... 1111 .... 1000 ....      @rndm
 QSUB             1111 1010 1000 .... 1111 .... 1010 ....      @rndm
 QDADD            1111 1010 1000 .... 1111 .... 1001 ....      @rndm
 QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
+
+# Branches and miscellaneous control
+
+{
+  YIELD          1111 0011 1010 1111 1000 0000 0000 0001
+  WFE            1111 0011 1010 1111 1000 0000 0000 0010
+  WFI            1111 0011 1010 1111 1000 0000 0000 0011
+
+  # TODO: Implement SEV, SEVL; may help SMP performance.
+  # SEV          1111 0011 1010 1111 1000 0000 0000 0100
+  # SEVL         1111 0011 1010 1111 1000 0000 0000 0101
+
+  # The canonical nop ends in 0000 0000, but the whole rest
+  # of the space is "reserved hint, behaves as nop".
+  NOP            1111 0011 1010 1111 1000 0000 ---- ----
+}
-- 
2.17.1


