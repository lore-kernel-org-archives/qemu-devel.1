Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03AFC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4702075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsfe2ZDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4702075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGas-0000Q1-Mz
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 17:03:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG93-0001gO-CN
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8z-0004th-Li
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8z-0004qI-Da
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id p4so4024706oti.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=h67pDbY19Cg4UtoQKX9gtRcpiPsg13J7hEg0ny3fNUo=;
	b=wsfe2ZDcMtOBg9wNOkf4IxyOAm5CNy8D+xcEBcaNKWt5Cs43ThJi5+hJaFKgPpLbLy
	GKAWlYyPXCNSQNyWtMJsdRj7RX8g2uUihv3yend6wPV66d7BOSWMQh+UiiL+2kqDrHFm
	JHFgCu3pdKXhlXQ3AQuX6lCHOajw9e/RDDWTmjivKOS5Mp000JprDDZIneB3TKG8Q29P
	XZ/Q5GExLzD3jfu9bOgEqdweHwKBO7KPP2elJ6KCdog7KzDh0R5KJ1b5+jYIiPLhn3jx
	ME/HEDWK7AwkI3lTpMYdpBZTMrnhALgNbR1/MUajkZza5eWU/v6B2KJD5DC8EhF5aN80
	TWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=h67pDbY19Cg4UtoQKX9gtRcpiPsg13J7hEg0ny3fNUo=;
	b=cUcnVUjQ3EUPk/0JRC4AeqxnSrh5vxDGQduXprR65h95m94MWu/aBm9UNvqMG+pZBg
	dk3hJ+Bzxle9PtroJqti1XV5gJFo95+8aytBpfuNx9xFqbdwZ4LhX49tq30sUDec5H09
	f5JshY8ttZJorv/1CVWeNGfciU0gFRrmNiVYDjg7lb/CeyVzX1Gfu6BbiZ54W9c2sqy2
	TIIG9nOlU5Txw+g30gxqODqs5TnOqvb66tj3VGJ0pgDpzLGJO2+CslCrPBPY2GMf0mW+
	IX3tTc0NQwCcigeNiMzA/J70ba0OjIvi6LVWamFVLpN/nPYqXEu0bzU5A9PAMww/Yua6
	XNmA==
X-Gm-Message-State: APjAAAWmdt5EGZ4ocBKgewqMpV9KS9zmmFu1kXsp1UhP2PhQltNm6xGy
	LP9O2nlTJhgyRa098RXENYstorrKMcGghQ==
X-Google-Smtp-Source: APXvYqzH+NCJxzZ8cUr+7DMUSH+ch61vFbFUOxy4DogVMs0UFwJpeACApFW317/r+C7EI5zmTK2fkg==
X-Received: by 2002:a9d:17e1:: with SMTP id j88mr5649551otj.369.1559680490336; 
	Tue, 04 Jun 2019 13:34:50 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.49
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:48 -0500
Message-Id: <20190604203351.27778-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v4 36/39] cpu: Remove CPU_COMMON
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

This macro is now always empty, so remove it.  This leaves the
entire contents of CPUArchState under the control of the guest
architecture.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 2 --
 target/alpha/cpu.h      | 3 ---
 target/arm/cpu.h        | 4 +---
 target/cris/cpu.h       | 2 --
 target/hppa/cpu.h       | 3 ---
 target/i386/cpu.h       | 4 +---
 target/lm32/cpu.h       | 2 --
 target/m68k/cpu.h       | 2 --
 target/microblaze/cpu.h | 2 --
 target/mips/cpu.h       | 2 --
 target/moxie/cpu.h      | 3 ---
 target/nios2/cpu.h      | 2 --
 target/openrisc/cpu.h   | 2 --
 target/ppc/cpu.h        | 2 --
 target/riscv/cpu.h      | 3 ---
 target/s390x/cpu.h      | 2 --
 target/sh4/cpu.h        | 2 --
 target/sparc/cpu.h      | 2 --
 target/tilegx/cpu.h     | 2 --
 target/tricore/cpu.h    | 2 --
 target/unicore32/cpu.h  | 2 --
 target/xtensa/cpu.h     | 2 --
 22 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index ac1aa9a1b6..03914abd10 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -233,8 +233,6 @@ typedef struct CPUTLB { } CPUTLB;
 
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
-#define CPU_COMMON  /* Nothing */
-
 /*
  * This structure must be placed in ArchCPU immedately
  * before CPUArchState, as a field named "neg".
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 94fbc00a3b..5d6fb222b5 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -251,9 +251,6 @@ struct CPUAlphaState {
     /* This alarm doesn't exist in real hardware; we wish it did.  */
     uint64_t alarm_expire;
 
-    /* Those resources are used only in QEMU core */
-    CPU_COMMON
-
     int error_code;
 
     uint32_t features;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5965c52f0c..8fa9772c9d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -645,9 +645,7 @@ typedef struct CPUARMState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
-    /* Fields after CPU_COMMON are preserved across CPU reset. */
+    /* Fields after this point are preserved across CPU reset. */
 
     /* Internal CPU feature flags.  */
     uint64_t features;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index ad93d1a9ee..9d2a80d995 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -163,8 +163,6 @@ typedef struct CPUCRISState {
         /* Fields up to this point are cleared by a CPU reset */
         struct {} end_reset_fields;
 
-        CPU_COMMON
-
         /* Members from load_info on are preserved across resets.  */
         void *load_info;
 } CPUCRISState;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f7c6205218..c7db2eca9a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -197,9 +197,6 @@ struct CPUHPPAState {
     target_ureg cr_back[2];  /* back of cr17/cr18 */
     target_ureg shadow[7];   /* shadow registers */
 
-    /* Those resources are used only in QEMU core */
-    CPU_COMMON
-
     /* ??? The number of entries isn't specified by the architecture.  */
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7580a86e5..edad6e1efb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1289,9 +1289,7 @@ typedef struct CPUX86State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
-    /* Fields after CPU_COMMON are preserved across CPU reset. */
+    /* Fields after this point are preserved across CPU reset. */
 
     /* processor features (e.g. for CPUID insn) */
     /* Minimum level/xlevel/xlevel2, based on CPU model + features */
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 324bc90f81..3e10a693a3 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -159,8 +159,6 @@ struct CPULM32State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     uint32_t eba;       /* exception base address */
     uint32_t deba;      /* debug exception base address */
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d92263b750..1ebd360afb 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -143,8 +143,6 @@ typedef struct CPUM68KState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     uint32_t features;
 } CPUM68KState;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d90c4fbcb5..98b4d915d7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -266,8 +266,6 @@ struct CPUMBState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* These fields are preserved on reset.  */
 
     struct {
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 62af24937d..bbf1aa8b0d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1041,8 +1041,6 @@ struct CPUMIPSState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index c6b681531d..2b596d5d45 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -45,9 +45,6 @@ typedef struct CPUMoxieState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
-
-    CPU_COMMON
-
 } CPUMoxieState;
 
 #include "qom/cpu.h"
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 8cc3d4971e..e40ee27e53 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -167,8 +167,6 @@ struct CPUNios2State {
 
     uint32_t irq_pending;
 #endif
-
-    CPU_COMMON
 };
 
 /**
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 51723e9312..9b80834d68 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -286,8 +286,6 @@ typedef struct CPUOpenRISCState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     uint32_t cpucfgr;         /* CPU configure register */
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e8962e4655..c93ebc4c10 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -999,8 +999,6 @@ struct CPUPPCState {
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
 
-    CPU_COMMON
-
     /* MMU context - only relevant for full system emulation */
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ed7031915..a935b17dbd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -171,9 +171,6 @@ struct CPURISCVState {
 
     float_status fp_status;
 
-    /* QEMU */
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     QEMUTimer *timer; /* Internal timer */
 };
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ebcf7863e4..17d54f9587 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -114,8 +114,6 @@ struct CPUS390XState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
 #if !defined(CONFIG_USER_ONLY)
     uint32_t core_id; /* PoP "CPU address", same as cpu_index */
     uint64_t cpuid;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index e266db411f..08cf275f79 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -179,8 +179,6 @@ typedef struct CPUSH4State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved over CPU reset. */
     int id;			/* CPU model */
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index a3c4f47d40..49e0349a81 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -446,8 +446,6 @@ struct CPUSPARCState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     target_ulong version;
     uint32_t nwindows;
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index deb3e836ea..c2acb43c2b 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -93,8 +93,6 @@ typedef struct CPUTLGState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
-
-    CPU_COMMON
 } CPUTLGState;
 
 #include "qom/cpu.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 03b293c1f6..52b07c73bf 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -184,8 +184,6 @@ struct CPUTriCoreState {
     int error_code;
     uint32_t hflags;    /* CPU State */
 
-    CPU_COMMON
-
     /* Internal CPU feature flags.  */
     uint64_t features;
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 39beb32366..6b459dacde 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -55,8 +55,6 @@ typedef struct CPUUniCore32State {
         float_status fp_status;
     } ucf64;
 
-    CPU_COMMON
-
     /* Internal CPU feature flags.  */
     uint32_t features;
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index e2d7e8371d..bfc6604b76 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -541,8 +541,6 @@ typedef struct CPUXtensaState {
 
     /* Watchpoints for DBREAK registers */
     struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
-
-    CPU_COMMON
 } CPUXtensaState;
 
 /**
-- 
2.17.1


