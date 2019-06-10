Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF3C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5368020833
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msUqT3n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5368020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haADE-00020x-Jw
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eM-0006wg-PI
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eJ-00023T-Im
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eJ-00021e-AN
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:03 -0400
Received: by mail-pf1-x442.google.com with SMTP id 81so4301314pfy.13
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nyb/izNU+CZGIl2n4uXhdOJHSCKl/iYXQVy4MjNPw48=;
 b=msUqT3n6aQtYwVmIa79QCCEieKWvCE1Oc+kf+DjhRjsWHike3mzvRTcX4va2SPAT8/
 BvGBZm7It5ilyCfNEJTMobtwJGqLl5BhULU3TR5DNpL66z3BycBjxuw5k+MUbeUBvpkD
 WXDj6OFlB3Xv0mxCk7VHUVBs0l9so8g2B900C8hKPMslVsBspye5E5FmB9MdFhE/zKo5
 qxZQfEJZpna0dGFE+yi7E/WhsaxVvJWfEs1paLK7YckAVI43daouX7tnZG4uXEnMb9lB
 JdkrAah2SrbkwOFoZ70mjbupDRZUAkyyodx6Wu0XcgG2EOSfUnbLDkYuaftJXYjgi9gb
 EMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nyb/izNU+CZGIl2n4uXhdOJHSCKl/iYXQVy4MjNPw48=;
 b=gxmYHEy/Q37lQIz8MlUzy0Slp9nb30DjT54ObcXPVjac8kFun2SajtJ2tYhYJgqSgx
 WQVj36b+xjWyNsErIjc1ur1fYPjqRfCJ2qnPu2gJ9f+pEmkD6ttJuwgBbulz02z+4b4s
 zMBK1jMoUPRj2VXg3YjzuG06TmodVdalYPWaHqLJKDOi/FN4auj+ydqKVn79nUU83Wnh
 scV7TlEu7oMfKQM8Cp6nWEI2rUYOYwq/rnMkjMfyOUxuyEdPKfAEd8MKaJc4atTXQ4y/
 bTZEUToAAxQoOiWjj/eUevufpRYiGdsCKPmjLP8zD61dYFmk5UadgSuTttiy3InLXexp
 cYSw==
X-Gm-Message-State: APjAAAUE0u1PbS8Th5muBJdxC43pczxJfM7pEj28pGhWrLKf+37KEahJ
 MdCe2gKkauv1sD1pF/mrIHDXdmRifrk=
X-Google-Smtp-Source: APXvYqxL32lE9xJQflOidRupG2s3E0wT07yqn5xEp3Dh6VvGpUc3MtPXCK5yUWWLzCEjMLrKy1+UWw==
X-Received: by 2002:a17:90a:26a1:: with SMTP id
 m30mr8714017pje.59.1560132180232; 
 Sun, 09 Jun 2019 19:03:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:12 -0700
Message-Id: <20190610020218.9228-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PULL 33/39] cpu: Introduce CPUNegativeOffsetState
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nothing in there so far, but all of the plumbing done
within the target ArchCPU state.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h  | 24 ++++++++++++++++++++++++
 include/exec/cpu-defs.h |  8 ++++++++
 target/alpha/cpu.h      |  1 +
 target/arm/cpu.h        |  1 +
 target/cris/cpu.h       |  1 +
 target/hppa/cpu.h       |  1 +
 target/i386/cpu.h       |  1 +
 target/lm32/cpu.h       |  1 +
 target/m68k/cpu.h       |  1 +
 target/microblaze/cpu.h |  5 +++--
 target/mips/cpu.h       |  1 +
 target/moxie/cpu.h      |  1 +
 target/nios2/cpu.h      |  2 ++
 target/openrisc/cpu.h   |  2 +-
 target/ppc/cpu.h        |  2 ++
 target/riscv/cpu.h      |  1 +
 target/s390x/cpu.h      |  1 +
 target/sh4/cpu.h        |  1 +
 target/sparc/cpu.h      |  1 +
 target/tilegx/cpu.h     |  1 +
 target/tricore/cpu.h    |  1 +
 target/unicore32/cpu.h  |  1 +
 target/xtensa/cpu.h     |  1 +
 23 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 71154070a7..5ae83405c8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -404,4 +404,28 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return &env_archcpu(env)->parent_obj;
 }
 
+/**
+ * env_neg(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUNegativeOffsetState associated with the environment.
+ */
+static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
+{
+    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
+    return &arch_cpu->neg;
+}
+
+/**
+ * cpu_neg(cpu)
+ * @cpu: The generic CPUState
+ *
+ * Return the CPUNegativeOffsetState associated with the cpu.
+ */
+static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
+{
+    ArchCPU *arch_cpu = container_of(cpu, ArchCPU, parent_obj);
+    return &arch_cpu->neg;
+}
+
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index b9ec261b01..921fbb4c36 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -227,4 +227,12 @@ typedef struct CPUTLB {
 
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
+/*
+ * This structure must be placed in ArchCPU immedately
+ * before CPUArchState, as a field named "neg".
+ */
+typedef struct CPUNegativeOffsetState {
+    /* Empty */
+} CPUNegativeOffsetState;
+
 #endif
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 361f85c976..94fbc00a3b 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -272,6 +272,7 @@ struct AlphaCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUAlphaState env;
 
     /* This alarm doesn't exist in real hardware; we wish it did.  */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index abe6fce7ab..5965c52f0c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -721,6 +721,7 @@ struct ARMCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUARMState env;
 
     /* Coprocessor information */
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 83c350377a..ad93d1a9ee 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -180,6 +180,7 @@ struct CRISCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUCRISState env;
 };
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7f9f54731b..f7c6205218 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -218,6 +218,7 @@ struct HPPACPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUHPPAState env;
     QEMUTimer *alarm_timer;
 };
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3a155c12d3..e7580a86e5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1369,6 +1369,7 @@ struct X86CPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUX86State env;
 
     bool hyperv_vapic;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 2c934472d6..324bc90f81 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -186,6 +186,7 @@ struct LM32CPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPULM32State env;
 
     uint32_t revision;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 4006663494..d92263b750 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -160,6 +160,7 @@ struct M68kCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUM68KState env;
 };
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a17c12ca2f..d90c4fbcb5 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -287,6 +287,9 @@ struct MicroBlazeCPU {
 
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
+    CPUMBState env;
+
     /* Microblaze Configuration Settings */
     struct {
         bool stackprot;
@@ -306,8 +309,6 @@ struct MicroBlazeCPU {
         char *version;
         uint8_t pvr;
     } cfg;
-
-    CPUMBState env;
 };
 
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 24fe25f61c..62af24937d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1068,6 +1068,7 @@ struct MIPSCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUMIPSState env;
 };
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 3d418c8f1d..c6b681531d 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -87,6 +87,7 @@ typedef struct MoxieCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUMoxieState env;
 } MoxieCPU;
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index c96d797dda..8cc3d4971e 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -182,7 +182,9 @@ typedef struct Nios2CPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUNios2State env;
+
     bool mmu_present;
     uint32_t pid_num_bits;
     uint32_t tlb_num_ways;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 39e2765aa2..51723e9312 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -313,8 +313,8 @@ typedef struct OpenRISCCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUOpenRISCState env;
-
 } OpenRISCCPU;
 
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 73b92c189c..e8962e4655 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1184,7 +1184,9 @@ struct PowerPCCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUPPCState env;
+
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d9611eaced..0ed7031915 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -210,6 +210,7 @@ typedef struct RISCVCPU {
     /*< private >*/
     CPUState parent_obj;
     /*< public >*/
+    CPUNegativeOffsetState neg;
     CPURISCVState env;
 
     /* Configuration Settings */
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index dbf13c9221..21688b7c8c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -156,6 +156,7 @@ struct S390CPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUS390XState env;
     S390CPUModel *model;
     /* needed for live migration */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 610a8db6de..e266db411f 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -204,6 +204,7 @@ struct SuperHCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUSH4State env;
 };
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 0cc36873ce..a3c4f47d40 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -529,6 +529,7 @@ struct SPARCCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUSPARCState env;
 };
 
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 643b7dbd17..deb3e836ea 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -135,6 +135,7 @@ typedef struct TileGXCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUTLGState env;
 } TileGXCPU;
 
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 9f45bb5c24..03b293c1f6 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -205,6 +205,7 @@ struct TriCoreCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUTriCoreState env;
 };
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index c1130e9548..39beb32366 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -73,6 +73,7 @@ struct UniCore32CPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUUniCore32State env;
 };
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index e89605747a..e2d7e8371d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -556,6 +556,7 @@ struct XtensaCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPUXtensaState env;
 };
 
-- 
2.17.1


