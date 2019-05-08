Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CDC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B682020656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/8pk0Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B682020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAWn-0005tf-0e
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:33:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7T-0007vJ-3x
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7Q-0007sN-DQ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:35 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:34821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7Q-0007pt-4M
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:32 -0400
Received: by mail-pg1-x530.google.com with SMTP id h1so9128798pgs.2
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=qFDdhEU6WgmOaatNQgi8vKFakq4BNf+wr7RRn2ei8MI=;
	b=m/8pk0QyFBwOxt0M9Z6XF6W5LfKQufQQcsL58JzA65ZM69T9R9dp2isnG6ZKDIWERc
	R+t+skqLxBjQjAxVY8oYs1daeH13w+pN+/60qSkhdgnOyhhuYIaDRRTlttrcihY35QRI
	C8wLit2sn2XzdFrKTzckDBo9/QEeqLAbyWlOh/xct/s5/35Q/W4UaimXMi7/BpNY7PKH
	hNqEddp1O0sgLUPvUjy2UE7e9isLj0Kizv4Z5oObGh7tsPYYBbVXep/4dITTLILt0MLv
	8BxaDABBSzRzDC9MzP8o29bd64W4EaInktv2wxxF9lJv6QWLKD2a1hdBz8nfR8+jK0LX
	VO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=qFDdhEU6WgmOaatNQgi8vKFakq4BNf+wr7RRn2ei8MI=;
	b=a4+s5MJ1dfKHzXp97H/PGILet6OZEpJYUSl60cxd4dTbfRX5Gyzyuj/6kLAbu7+BiD
	HOixVlpxyMBuRmbrsI5j64TXxeQeueQpLuAxX+DQqughj+MYKVjBxsUPZashFDNSQirB
	ArKXovy+p4MC1X/w6XuWDpl1TfQ0Ht6zlygULDxpnR6Y+T5pPCv0RX4jfoVUIw5RizeL
	2tr1sc2ekKUOBIBlZLbFxo3MhUvpqVXYYLxNM6nclRaZ3QPj3sLkcUOp0tkxLLNY3gJu
	G+keooYD106Wmn8VooWkppITMdwwJuftBkTG4RScIpe63BW1SmVbH7SbiDc7avNiOUSv
	dXlg==
X-Gm-Message-State: APjAAAU3zT93nH0hqQeiLF3vYih9rPXpHrl4FAzlY8ZBIRK7VbgWaDP3
	ByghdzwZA/ipikgn8CO+A2pny0OxgBU=
X-Google-Smtp-Source: APXvYqxTQVsY/bWiY3AkWSUNQ8aM2nt3bF48UwAYMAtrJKhGBQ404U72rELH9OhUHJfKMf/cJC0XWg==
X-Received: by 2002:a63:6804:: with SMTP id d4mr43280672pgc.240.1557274050614; 
	Tue, 07 May 2019 17:07:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:38 -0700
Message-Id: <20190508000641.19090-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: [Qemu-devel] [PATCH v3 36/39] cpu: Remove CPU_COMMON
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
 target/riscv/cpu.h      | 4 ----
 target/s390x/cpu.h      | 2 --
 target/sh4/cpu.h        | 2 --
 target/sparc/cpu.h      | 2 --
 target/tilegx/cpu.h     | 2 --
 target/tricore/cpu.h    | 2 --
 target/unicore32/cpu.h  | 2 --
 target/xtensa/cpu.h     | 2 --
 22 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 4cde7d611c..1f75a97701 100644
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
index f4bb67c101..5bd90b7ce5 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -246,9 +246,6 @@ struct CPUAlphaState {
     /* This alarm doesn't exist in real hardware; we wish it did.  */
     uint64_t alarm_expire;
 
-    /* Those resources are used only in QEMU core */
-    CPU_COMMON
-
     int error_code;
 
     uint32_t features;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 909cb4604d..135a16a351 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -643,9 +643,7 @@ typedef struct CPUARMState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
-    /* Fields after CPU_COMMON are preserved across CPU reset. */
+    /* Fields after this point are preserved across CPU reset. */
 
     /* Internal CPU feature flags.  */
     uint64_t features;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index eeab483dba..6dc4502e9a 100644
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
index 0661ff60c1..3ed2ac3c25 100644
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
index 43bb6ab841..8069e5b19d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1288,9 +1288,7 @@ typedef struct CPUX86State {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
-    /* Fields after CPU_COMMON are preserved across CPU reset. */
+    /* Fields after this point are preserved across CPU reset. */
 
     /* processor features (e.g. for CPUID insn) */
     /* Minimum level/xlevel/xlevel2, based on CPU model + features */
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 0ec898eb1d..563600a30a 100644
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
index 096d1eb588..4e27ff677f 100644
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
index 732653caed..6a470a2492 100644
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
index 2d9c5f26eb..b9e58ed883 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1021,8 +1021,6 @@ struct CPUMIPSState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPU_COMMON
-
     /* Fields from here on are preserved across CPU reset. */
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index f5ee8a02f4..a62cca1817 100644
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
index cd06a2ef41..75ea964632 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -166,8 +166,6 @@ struct CPUNios2State {
 
     uint32_t irq_pending;
 #endif
-
-    CPU_COMMON
 };
 
 /**
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index e1acd48652..e3ffa618c9 100644
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
index bb57496212..bbc8eb0cfc 100644
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
index 30a01e8386..7086b336c6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -169,10 +169,6 @@ struct CPURISCVState {
 
     float_status fp_status;
 
-    /* QEMU */
-    CPU_COMMON
-
-    /* Fields from here on are preserved across CPU reset. */
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
index 944854dbe0..974d46aae1 100644
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
index ae9ac07a9d..69e2199569 100644
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
index 43ef29b6bd..9fe501f98f 100644
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
index 140c590ec1..1ae0d78f4f 100644
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
index 1bbb839bed..4e289dfa6e 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -511,8 +511,6 @@ typedef struct CPUXtensaState {
 
     /* Watchpoints for DBREAK registers */
     struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
-
-    CPU_COMMON
 } CPUXtensaState;
 
 /**
-- 
2.17.1


