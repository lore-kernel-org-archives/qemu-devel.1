Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF53BC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FA220828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVleF2ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FA220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Gkk-0002E1-NX
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Gic-0000up-LK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Gib-0008Fx-71
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2Gib-0008FD-0v
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so10173959pld.10
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8MFzsPufqFdgCy1pEwhM+wHrg2dggUQBauGMpOYZwlA=;
 b=EVleF2ZKTAs0/vaUtn0ljzHuO1VQ99XAWUj/rPtQk8byuoz0tenW3wHxhntoC75HZE
 1pCUlT9JfYoGCcoCBO48HEDP4Ha2vqxxlRsA7NmlyiQPVGfflGNaLryjz1qFPzD0aiMs
 TBWaY8khPQDVFdr1tX75z3uNKvbvhpsTGY+19MOCN3VrtEgksTjeqJM77NoDYFk/ZGzR
 f9aSQqml6Va5rhj+E38M+YQAQdC16cSNAqg3c+oI4f5l/ltzqyYJEqj9dGg/0pRj2A3O
 q6Wr/xEoy3GjpZ6r/BHT6E1tI3pA6okPBBhDUVP5vk3dwg7zEX9T7kMztz+LAVtimWJ+
 HWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8MFzsPufqFdgCy1pEwhM+wHrg2dggUQBauGMpOYZwlA=;
 b=sfSBAknlvg9mIuzeYzBZeQWbXbvxUItBFzuQPqET0Q5asZscrx6uLbpMJ6znKCcx0J
 s+dssR7lrhObsCL4g1QH59SW9S8g8o5/6fEHkffUN1rnHb/6jfHpJ4S+bRyZxWMOCtp4
 ePXI7YvLZscxJHANVP127b9hPJHbfWQTz4E+tKGINxWLH/ZcXqpzD+9IGMPaRw3v5UeR
 58aRpzFxjUOm4Y34B97F5UrUCJySdjFHliGQ0qgzv2354o1klPlgLBCtbshG27bmSO9i
 JiqlMPqQmKkN3qdntkjBcGeYBy4tmDz+R1gVqaPBWh4ADscta0eY3dvkdbeieJZapjzw
 4lrA==
X-Gm-Message-State: APjAAAUFumSjJOPTLfvxjMtwqcTmQw80eCk2gQa+s6dKWStlELrAtWMS
 I4D/RXBG0rzed98crRzv9VpnSh4xEIw=
X-Google-Smtp-Source: APXvYqwHH2ytZMOjx2OEDUZCB+j8BqBiH95yAcZlG7koMzWNQl4BlRzUDYdmFGuCRJbwApUPY9MOFw==
X-Received: by 2002:a17:902:b48c:: with SMTP id
 y12mr19286238plr.202.1566832539738; 
 Mon, 26 Aug 2019 08:15:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q4sm13563612pff.183.2019.08.26.08.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 08:15:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 08:15:35 -0700
Message-Id: <20190826151536.6771-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826151536.6771-1-richard.henderson@linaro.org>
References: <20190826151536.6771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 1/2] Revert "target/arm: Use
 unallocated_encoding for aarch32"
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 3cb36637157088892e9e33ddb1034bffd1251d3b.

Despite the fact that the text for the call to gen_exception_insn
is identical for aarch64 and aarch32, the implementation inside
gen_exception_insn is totally different.

This fixes exceptions raised from aarch64.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h     |  2 ++
 target/arm/translate.h         |  2 --
 target/arm/translate-a64.c     |  7 +++++++
 target/arm/translate-vfp.inc.c |  3 ++-
 target/arm/translate.c         | 22 ++++++++++------------
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 12ad8ac6ed..9cd2b3d238 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -18,6 +18,8 @@
 #ifndef TARGET_ARM_TRANSLATE_A64_H
 #define TARGET_ARM_TRANSLATE_A64_H
 
+void unallocated_encoding(DisasContext *s);
+
 #define unsupported_encoding(s, insn)                                    \
     do {                                                                 \
         qemu_log_mask(LOG_UNIMP,                                         \
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 92ef790be9..64304c957e 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -99,8 +99,6 @@ typedef struct DisasCompare {
     bool value_global;
 } DisasCompare;
 
-void unallocated_encoding(DisasContext *s);
-
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
 extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
 extern TCGv_i64 cpu_exclusive_addr;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6fd0b779d3..9183f89ba3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -338,6 +338,13 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
     }
 }
 
+void unallocated_encoding(DisasContext *s)
+{
+    /* Unallocated and reserved encodings are uncategorized */
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
+}
+
 static void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 3e8ea80493..5065d4524c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -108,7 +108,8 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        unallocated_encoding(s);
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                           default_exception_el(s));
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cbe19b7a62..2aac9aae68 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1231,13 +1231,6 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-void unallocated_encoding(DisasContext *s)
-{
-    /* Unallocated and reserved encodings are uncategorized */
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
-}
-
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -1268,7 +1261,8 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    unallocated_encoding(s);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7580,7 +7574,8 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        unallocated_encoding(s);
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                           default_exception_el(s));
         return;
     }
 
@@ -9201,7 +9196,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            unallocated_encoding(s);
+            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                               default_exception_el(s));
             break;
         }
     }
@@ -10886,7 +10882,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    unallocated_encoding(s);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11709,7 +11706,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    unallocated_encoding(s);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


