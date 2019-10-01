Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF79ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390FD20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DerFKQHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390FD20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLu5-0001oD-BY
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlB-0001X3-Ph
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl9-0005U8-IS
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:25 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLl9-0005Tj-AK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:23 -0400
Received: by mail-pf1-x441.google.com with SMTP id h195so8475533pfe.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q9Mr42wDaAqxtgZGR7xHO1prxR6bIhQ0Pkgg+dKZZYM=;
 b=DerFKQHz38QbJXd5Ws9PdxLzMTQiKfoBqVBq/tgPGWrwZjh1ljW3gC/qBnjGv13xIl
 /6lzMGETTTRnWv35LcTbsOe2pNDj3rrUOyOl2ADp7dl5pdNAZF9lgIw+INXyLQgzUBjZ
 7e3aS6qEiil4k5kLjIpeqY5MaagNG5mKjDF6t3WWOmfDuqSZ7itLIKj0yasht4aL9hFw
 /1uKoBbaLOr5unsalJ3bjN11BCe4BAukArX1wZ7zAC6yElL6ygp9ZOotuv1nF8Jk4gkI
 ZNEatyxKDl90APt8LngkJozi6n0ZWefRw8ALGR2lHYDj8itsqnFe8f5IZXEQTXd5NAMS
 ENMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q9Mr42wDaAqxtgZGR7xHO1prxR6bIhQ0Pkgg+dKZZYM=;
 b=UC0rVBOR4Odwv68nQISyNdyqD4nFpSgI3WO4/+G/XUX9jh9iH4/cY5+oiY00hRIoSV
 U137vym4MWLX1hrbx6XkmPq7r3f2cpRPnXNTxT7ViS3AS4AzI/WZUwZN60UV294xFTL9
 cSlCGZeRjsqIjeq6N8kVSAR5+eePHS+0y8eooI0DOJBkWTtlAdM6ZfUjHNoLkUFvq6f0
 shNZePb9Ba2WZXvyNgwuxUq87rjYGFu2IPCwrHi1YCzQi5Lger0FKtbmeTBoZAWccKY2
 Vsn9sZyViSJdYxueUmBfcMO/CousJo1GN+12Cl1CcEAYsS29OgcqT2fIXTzhMP417Og1
 S5yg==
X-Gm-Message-State: APjAAAUNEMovm7V/pXNyDSKwKIp3UN6GlDi81PQo41ArHHo7gKqooYEa
 9Q6R9aSlN/4MeM67pf6+x8rjPKb7BeI=
X-Google-Smtp-Source: APXvYqwSxYzKDI7jq0qLuiKcNzKaD9Xn9YeKRye/NKurLQtEZPZMDuVXiMUw1fSuLC5VFTaQSzvhRA==
X-Received: by 2002:a63:d1a:: with SMTP id c26mr31735005pgl.286.1569950181637; 
 Tue, 01 Oct 2019 10:16:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/18] target/s390x: Use tcg_s390_program_interrupt in TCG
 helpers
Date: Tue,  1 Oct 2019 10:16:00 -0700
Message-Id: <20191001171614.8405-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace all uses of s390_program_interrupt within files
that are marked CONFIG_TCG.  These are necessarily tcg-only.

This lets each of these users benefit from the QEMU_NORETURN
attribute on tcg_s390_program_interrupt.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cc_helper.c     |  4 ++--
 target/s390x/crypto_helper.c |  7 +++----
 target/s390x/excp_helper.c   |  2 +-
 target/s390x/fpu_helper.c    |  6 +++---
 target/s390x/int_helper.c    | 15 +++++++-------
 target/s390x/mem_helper.c    | 40 ++++++++++++++++++------------------
 target/s390x/misc_helper.c   | 18 ++++++++--------
 7 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 3cb00bcb09..44731e4a85 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
@@ -588,8 +589,7 @@ void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
         break;
     default:
         HELPER_LOG("unknown sacf mode: %" PRIx64 "\n", a1);
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
-        break;
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 }
 #endif
diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
index 1f83987e9d..ff3fbc3950 100644
--- a/target/s390x/crypto_helper.c
+++ b/target/s390x/crypto_helper.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -34,16 +35,14 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         if (mod) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-            return 0;
+            tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         }
         break;
     }
 
     s390_get_feat_block(type, subfunc);
     if (!test_be_bit(fc, subfunc)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        return 0;
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     switch (fc) {
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 089623a248..dbff772d34 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -614,7 +614,7 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
+    tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
 }
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 7228eb96e2..8bb9f54fd0 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -825,7 +825,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
     if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u ||
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     /* Install everything in the main FPC.  */
@@ -843,7 +843,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
 
     if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u ||
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     /*
@@ -880,7 +880,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
 void HELPER(srnm)(CPUS390XState *env, uint64_t rnd)
 {
     if (rnd > 0x7 || fpc_to_rnd[rnd & 0x7] == -1) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     env->fpc = deposit32(env->fpc, 0, 3, rnd);
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index 1d29a1fc1f..658507dd6d 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
@@ -39,7 +40,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
     int64_t q;
 
     if (b == 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     ret = q = a / b;
@@ -47,7 +48,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
 
     /* Catch non-representable quotient.  */
     if (ret != q) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     return ret;
@@ -60,7 +61,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
     uint64_t q;
 
     if (b == 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     ret = q = a / b;
@@ -68,7 +69,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
 
     /* Catch non-representable quotient.  */
     if (ret != q) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
     return ret;
@@ -79,7 +80,7 @@ int64_t HELPER(divs64)(CPUS390XState *env, int64_t a, int64_t b)
 {
     /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
     if (b == 0 || (b == -1 && a == (1ll << 63))) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
     env->retxl = a % b;
     return a / b;
@@ -92,7 +93,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
     uint64_t ret;
     /* Signal divide by zero.  */
     if (b == 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
     if (ah == 0) {
         /* 64 -> 64/64 case */
@@ -106,7 +107,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
         env->retxl = a % b;
         ret = q;
         if (ret != q) {
-            s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
         }
 #else
         /* 32-bit hosts would need special wrapper functionality - just abort if
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 77d2eb96d4..7d2a652823 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -71,7 +72,7 @@ static inline void check_alignment(CPUS390XState *env, uint64_t v,
                                    int wordsize, uintptr_t ra)
 {
     if (v % wordsize) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 }
 
@@ -730,7 +731,7 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
     /* Bits 32-55 must contain all 0.  */
     if (env->regs[0] & 0xffffff00u) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     str = get_address(env, r2);
@@ -767,7 +768,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
     /* Bits 32-47 of R0 must be zero.  */
     if (env->regs[0] & 0xffff0000u) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     str = get_address(env, r2);
@@ -846,7 +847,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
     S390Access srca, desta;
 
     if ((f && s) || extract64(r0, 12, 4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
     r1 = wrap_address(env, r1 & TARGET_PAGE_MASK);
@@ -879,7 +880,7 @@ uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     int i;
 
     if (env->regs[0] & 0xffffff00ull) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     /*
@@ -911,7 +912,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     int i;
 
     if (a2 & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -931,7 +932,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     int i;
 
     if (a2 & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1887,8 +1888,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     return cc;
 
  spec_exception:
-    s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-    g_assert_not_reached();
+    tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
 }
 
 uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
@@ -1911,7 +1911,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (src & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1944,7 +1944,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (src & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1975,7 +1975,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (dest & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -1995,7 +1995,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint32_t i;
 
     if (dest & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     for (i = r1;; i = (i + 1) % 16) {
@@ -2225,7 +2225,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
     uint16_t entries, i, index = 0;
 
     if (r2 & 0xff000) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     if (!(r2 & 0x800)) {
@@ -2369,7 +2369,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
     }
 
     old_exc = cs->exception_index;
@@ -2538,7 +2538,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
                __func__, dest, src, len);
 
     if (!(env->psw.mask & PSW_MASK_DAT)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
 
     /* OAC (operand access control) for the first operand -> dest */
@@ -2569,14 +2569,14 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
     }
 
     if (dest_a && dest_as == AS_HOME && (env->psw.mask & PSW_MASK_PSTATE)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
     if (!(env->cregs[0] & CR0_SECONDARY) &&
         (dest_as == AS_SECONDARY || src_as == AS_SECONDARY)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
     if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
+        tcg_s390_program_interrupt(env, PGM_PRIVILEGED, ra);
     }
 
     len = wrap_length32(env, len);
@@ -2590,7 +2590,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
         (env->psw.mask & PSW_MASK_PSTATE)) {
         qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing\n",
                       __func__);
-        s390_program_interrupt(env, PGM_ADDRESSING, ra);
+        tcg_s390_program_interrupt(env, PGM_ADDRESSING, ra);
     }
 
     /* FIXME: Access using correct keys and AR-mode */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 9fbb37cfb9..bfb457fb63 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -106,7 +106,7 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
     int r = sclp_service_call(env, r1, r2);
     qemu_mutex_unlock_iothread();
     if (r < 0) {
-        s390_program_interrupt(env, -r, GETPC());
+        tcg_s390_program_interrupt(env, -r, GETPC());
     }
     return r;
 }
@@ -143,7 +143,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     }
 
     if (r) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 }
 
@@ -222,7 +222,7 @@ void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
     uint32_t val = r0;
 
     if (val & 0xffff0000) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
     env->todpr = val;
 }
@@ -266,7 +266,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
     }
 
     if ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     if ((r0 & STSI_R0_FC_MASK) == STSI_R0_FC_CURRENT) {
@@ -276,7 +276,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
     }
 
     if (a0 & ~TARGET_PAGE_MASK) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     /* count the cpus and split them into configured and reserved ones */
@@ -509,7 +509,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
     LowCore *lowcore;
 
     if (addr & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     qemu_mutex_lock_iothread();
@@ -574,7 +574,7 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 void HELPER(per_check_exception)(CPUS390XState *env)
 {
     if (env->per_perc_atmid) {
-        s390_program_interrupt(env, PGM_PER, GETPC());
+        tcg_s390_program_interrupt(env, PGM_PER, GETPC());
     }
 }
 
@@ -664,7 +664,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
     int i;
 
     if (addr & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
     prepare_stfl();
@@ -737,7 +737,7 @@ void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
     qemu_mutex_unlock_iothread();
     /* css_do_sic() may actually return a PGM_xxx value to inject */
     if (r) {
-        s390_program_interrupt(env, -r, GETPC());
+        tcg_s390_program_interrupt(env, -r, GETPC());
     }
 }
 
-- 
2.17.1


