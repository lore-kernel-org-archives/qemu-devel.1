Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692FFECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3832B215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJYyCEow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3832B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLpf-0005dQ-Ty
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl7-0001Sn-Rd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl6-0005SU-F0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:21 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:41179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLl6-0005SF-8w
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:20 -0400
Received: by mail-pg1-x531.google.com with SMTP id s1so10093615pgv.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0KNz+iOsX4QMQJox/KvD2oB0+dKW6HscqmDu5dXQGFM=;
 b=CJYyCEowrNqjH7x/r/Kh1vtNcmPxjSfHto1N7UGklCZEX8u+RUaKXuKzCs+bpCmVr8
 g4Jq1ljR+pr/QsT3gZ3aU7B1TH5Hr/3llud3KsamHfSpIyzEwWa/dmLt1Gvz9h0Ee5NU
 wU4/KsX+/ca3Gin3nrfNw0w7V1YHJ2LFjE5lPTX4rbSLR3TF/cFp43a0SpXOHZq/UyyW
 8W/bHrjnphSFARMstxrMgxnibqcPJC/Ci9eXWtQuc00G27WOH1wgY/Tv/3hojs9aVG/4
 dF/5omz4AYrlvcBNkY9S6zmPRiwcKZmsGn295/QWCwjQYD+/3ypEAZcUS2HQ/8FT+wyr
 bCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0KNz+iOsX4QMQJox/KvD2oB0+dKW6HscqmDu5dXQGFM=;
 b=IEI2ULLuiVUKwlX3MBJzOf7G6rnWI8kwd6sCn3e9TVUOAXVdGKk3a/tGyqGjMymjCi
 e3ZriZu5Nx+3yKAsHvun6OpAkw9ug1oD2BHGruZyW30RixpA1ECKOB8UfmC0uiaLOoBt
 T4UDu7KD5xTidEBaOVwDM753q1LD6J/y072BOEfCVS+KAwYwxJFO5We57CSxoeKfmXka
 lmbYvKVHnVErsja7nPAy3TVAW90iTTE8a/pI7a60LHEmsSo5/bpV1GtytEEGkM354J8g
 y623szjGWrHRmrmbT2MutwSBA1wyNghvHLWaTryFz/dYyW2AsahjT8BHWGNjLxp8Oru/
 hgnQ==
X-Gm-Message-State: APjAAAUn3/PK2fbFZztbXOUpuIT+Vr+OiPFbI4Zh8eBYrfjddsePBPoc
 jsFGhHdaOytpdf1f0xPedJ+woO7JEZM=
X-Google-Smtp-Source: APXvYqztzGmSNJ7Yg4LcHf5LnKApKiLOGWDoCLpQPKw74YNQr45GrC68bLDZM9cXFDvep6c8yD5rYg==
X-Received: by 2002:a62:d45a:: with SMTP id u26mr29175091pfl.137.1569950178828; 
 Tue, 01 Oct 2019 10:16:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/18] target/s390x: Remove ilen parameter from
 tcg_s390_program_interrupt
Date: Tue,  1 Oct 2019 10:15:58 -0700
Message-Id: <20191001171614.8405-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
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

Since we begin the operation with an unwind, we have the proper
value of ilen immediately available.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg_s390x.h   |  4 ++--
 target/s390x/excp_helper.c | 10 +++++-----
 target/s390x/interrupt.c   |  2 +-
 target/s390x/tcg-stub.c    |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

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
index 892f659d5a..eb55e5ef53 100644
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
@@ -75,7 +75,7 @@ void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
 
     /* Always store the VXC into the FPC, without AFP it is undefined */
     env->fpc = deposit32(env->fpc, 8, 8, vxc);
-    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ILEN_AUTO, ra);
+    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ra);
 }
 
 void HELPER(data_exception)(CPUS390XState *env, uint32_t dxc)
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


