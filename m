Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33069C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED54320863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsTR0IyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED54320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDw8T-00055D-7q
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5Y-0003A9-In
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5X-0006Co-1q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:45292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5W-0006Bp-Sj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id y72so2118151pfb.12
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mEJpPDOXw0D5Zksw9BQVNR7N9VOlOrM1zivyUmzXqRI=;
 b=jsTR0IyCMuEVZx9Lx8RFssEvG/ohK4uRRxVYFjzEWqTlxb3UnWmDVNRTUCupuFxeP1
 xWiTFh8WIjC9w3EhBfSsA8wVsL/AgY92ajqYoF2fJHsV9Rk83ow0T1B2HXIvFOfBPBoa
 DtoTQpFqf4WmE9DJPdc+0uztksJe2Bqy5BV7zpz6yFefhvsRXP798KSSaqvc/WZ+deKG
 dX86WiR1/4vt6t6/M6E+/itdLiToKLhMyy33zyoE2Ow+acOvczMMxr+brTe05AIISmg+
 dYxKkmUF8wbtiWYWpOx87Vk6/a6F3qcququ+5LrDNnOiTM4JwkZ8Iyze/84b1czIpdFC
 +w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mEJpPDOXw0D5Zksw9BQVNR7N9VOlOrM1zivyUmzXqRI=;
 b=g2kOJV7U6VyHJ7qkDsIcuv5Hh2UusvY4tEdznuK/pZdzYma8E5wrTwx0s2Ng8JcBTM
 wqqP9AGLDz98LspkccVOSBc3HqXHp2fGiShRWjm1uSewN0vgeLniJxPyiyx0xDTvBXKW
 VXZKVj1ZD9CpawptrJHYqTRX8INsjlrxGucb/qtBRwxwGlgQQPN5qbK3Y+HaJvPcdu+V
 /FLAf8NHliOtKLU0wL9GXRCK9SH4UBT0AJzpdUE0Z0bdprjHQ9TkWPUm4FKrCAm5KSI6
 PvsSHL+bASR4oP8IMRWq+rSfNRyKALNSM20FzjWHiZNIIeLcoYtqKv8WksUR+mSYfHZW
 EkGw==
X-Gm-Message-State: APjAAAXLCFH6Le35xIRmCGodY/TetRq/4vOt33DBmDScFYBvEXWQwXSm
 QdtAZdJ2ZJd9YV5EcNN7NJ/Nbcy0OsQ=
X-Google-Smtp-Source: APXvYqwYYbM8jO9Vi/lRdNZ/7LivPL9oETd9esgPbLd9IFKBO93WdB6LCzUlA8ilON3XoUFkx5mc3A==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr11106385pgd.190.1569613173324; 
 Fri, 27 Sep 2019 12:39:33 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/18] target/s390x: Remove ilen parameter from
 tcg_s390_program_interrupt
Date: Fri, 27 Sep 2019 12:39:09 -0700
Message-Id: <20190927193925.23567-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we begin the operation with an unwind, we have the proper
value of ilen immediately available.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg_s390x.h   | 4 ++--
 target/s390x/excp_helper.c | 8 ++++----
 target/s390x/interrupt.c   | 2 +-
 target/s390x/tcg-stub.c    | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index 2813f9d48e..2f54ccb027 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -14,8 +14,8 @@
 #define TCG_S390X_H
 
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra);
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra);
 void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
                                            uintptr_t ra);
 void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 892f659d5a..681a9c59e1 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -34,15 +34,15 @@
 #include "hw/boards.h"
 #endif
 
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
 
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ilen);
+    trigger_pgm_exception(env, code, ILEN_UNWIND);
     cpu_loop_exit(cs);
 }
 
@@ -60,7 +60,7 @@ void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     if (env->cregs[0] & CR0_AFP) {
         env->fpc = deposit32(env->fpc, 8, 8, dxc);
     }
-    tcg_s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+    tcg_s390_program_interrupt(env, PGM_DATA, ra);
 }
 
 void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 30a9fb8852..b798e2ecbe 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -40,7 +40,7 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(env_archcpu(env), code);
     } else if (tcg_enabled()) {
-        tcg_s390_program_interrupt(env, code, ilen, ra);
+        tcg_s390_program_interrupt(env, code, ra);
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
index 32adb7276a..d22c898802 100644
--- a/target/s390x/tcg-stub.c
+++ b/target/s390x/tcg-stub.c
@@ -18,8 +18,8 @@
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
 {
 }
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra)
 {
     g_assert_not_reached();
 }
-- 
2.17.1


