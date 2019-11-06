Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C322C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F022077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgGJHZVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F022077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJfP-0002br-E3
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZM-00042i-Ne
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZI-0007Z8-Mz
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:48 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZI-0007Yi-Fa
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:44 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so25302216wrm.8
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wugc25C0qaoSEGWNFWHf1zt/qP9CJkEKha5hGMZVoIA=;
 b=YgGJHZVv5Xx4DzIBMm/RDcG5Yd0NI4ED9025ayqOx7Z8NLF5OAWgQgwloo2iZHkcQc
 pKM97hHREhSeuKE7Dhh9KekciKR4BojU2i26gu1jdD3ih/xg0/RG/Dhi5kQt9K6ZxZ2e
 7WuFs3nG0iEw3E9gDD0W4L4QkPy+jwJPMHbBhOpOng0WtIMzgQ4MpdIUf3R9zczvIBHi
 e/23m8+3Fyg7WQ8Il0S77CkAxl/Q/5r1PSXUrlgBL2pvqm1Qnjex8/7R3nsaa/zefrTY
 +Z+m0io4Dc7t72vUwVSIVOwUyCA2/ffl+0oK08H0W+A2DM0rC9gg481rHAoLJCg8W00m
 RaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wugc25C0qaoSEGWNFWHf1zt/qP9CJkEKha5hGMZVoIA=;
 b=apOWhPLg8rjEHL1GDVOkDxh0Walxv479vaeeiOYMH0cNIyQxKltr3/jgZHMDEF3Oc2
 /ItAfv9RdCsxifX3M7zVQhpAxSj3rIPtuUbELLjvAmb2CGLQgGJVG6LxRydX1HuaVIIB
 5B85V05qm+19KvNdqRnZVHC8lWyZrkQpS9ULv6cFwx/iPYfxq13R+4502BSf8w/6zZfT
 UaFuZECURfSxjDmhXhT+0+ctkwRwBHY9h8uoZ8BT43oG3Kwq7s1w91dm/K8ITmwHpKDQ
 LPINv04ECPC1b+avePRrgyeJtxeahbiQ/SDkoxSUKq+kpjC96RDPWcU2wdl1VPNVSH0a
 gAEg==
X-Gm-Message-State: APjAAAWinnT6T0DxxBBAxnvjluyTVRDPGqUY/QnyCzARRjW2R2wswnpZ
 j8/hAFV4Ok9THZinRkwN8V7k+pNIHs353w==
X-Google-Smtp-Source: APXvYqwYJweh5KZXFqPmdNODjMvH8fv92x6de4F5HCHnfAHqLSMTnkLKYpWbp4lmGezB1QTffO2w7A==
X-Received: by 2002:adf:f585:: with SMTP id f5mr2191064wro.272.1573040023134; 
 Wed, 06 Nov 2019 03:33:43 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] linux-user: Introduce cpu_clone_regs_parent
Date: Wed,  6 Nov 2019 12:33:16 +0100
Message-Id: <20191106113318.10226-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need a target-specific hook for adjusting registers
in the parent during clone.  Add an empty inline function for
each target, and invoke it from the proper places.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191025113921.9412-11-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_cpu.h    | 4 ++++
 linux-user/alpha/target_cpu.h      | 4 ++++
 linux-user/arm/target_cpu.h        | 4 ++++
 linux-user/cris/target_cpu.h       | 4 ++++
 linux-user/hppa/target_cpu.h       | 4 ++++
 linux-user/i386/target_cpu.h       | 4 ++++
 linux-user/m68k/target_cpu.h       | 4 ++++
 linux-user/microblaze/target_cpu.h | 4 ++++
 linux-user/mips/target_cpu.h       | 4 ++++
 linux-user/nios2/target_cpu.h      | 4 ++++
 linux-user/openrisc/target_cpu.h   | 4 ++++
 linux-user/ppc/target_cpu.h        | 4 ++++
 linux-user/riscv/target_cpu.h      | 4 ++++
 linux-user/s390x/target_cpu.h      | 4 ++++
 linux-user/sh4/target_cpu.h        | 4 ++++
 linux-user/sparc/target_cpu.h      | 4 ++++
 linux-user/tilegx/target_cpu.h     | 4 ++++
 linux-user/xtensa/target_cpu.h     | 4 ++++
 linux-user/syscall.c               | 2 ++
 19 files changed, 74 insertions(+)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index cd012e0dc1..6cc02e7dcd 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
     env->xregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUARMState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
 {
     /* Note that AArch64 Linux keeps the TLS pointer in TPIDR; this is
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index 37ba00cf41..dd25e18f47 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
     env->ir[IR_A3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
 {
     env->unique = newtls;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 6e2ba8ad4b..2747211b24 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -50,6 +50,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
     env->regs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUARMState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
 {
     if (access_secure_reg(env)) {
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index eacc4d8d13..74ead55c81 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
     env->regs[10] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUCRISState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
 {
     env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index f250770790..71654b3cd4 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -32,6 +32,10 @@ static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
     env->iaoq_b = env->gr[31] + 4;
 }
 
+static inline void cpu_clone_regs_parent(CPUHPPAState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
 {
     env->cr[27] = newtls;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 1fadbf57c3..0b44530854 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp,
     env->regs[R_EAX] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUX86State *env, unsigned flags)
+{
+}
+
 #if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr);
 
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 57b647bc07..c3f288dfe8 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -30,6 +30,10 @@ static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp,
     env->dregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUM68KState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
 {
     CPUState *cs = env_cpu(env);
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index e9bc0fce65..ce7b22ece7 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp,
     env->regs[3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUMBState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUMBState *env, target_ulong newtls)
 {
     env->regs[21] = newtls;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 8601f712e0..758ae4d933 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp,
     env->active_tc.gpr[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
     env->active_tc.CP0_UserLocal = newtls;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index fe5de7a9e3..50f0381067 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp,
     env->regs[R_RET0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUNios2State *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
 {
     /*
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 309cf3eeb7..74370d67c4 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -30,6 +30,10 @@ static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
     cpu_set_gpr(env, 11, 0);
 }
 
+static inline void cpu_clone_regs_parent(CPUOpenRISCState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
 {
     cpu_set_gpr(env, 10, newtls);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index 028b28312c..76b67d2882 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp,
     env->gpr[3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUPPCState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUPPCState *env, target_ulong newtls)
 {
 #if defined(TARGET_PPC64)
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 26dcafab1c..9c642367a3 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -11,6 +11,10 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
     env->gpr[xA0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
 {
     env->gpr[xTP] = newtls;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index 0b19e42f75..7cd71e2dba 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp,
     env->regs[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUS390XState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
 {
     env->aregs[0] = newtls >> 32;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index 857af43ee3..5114f19424 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp,
     env->gregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUSH4State *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUSH4State *env, target_ulong newtls)
 {
   env->gbr = newtls;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 029b0fc547..8ff706adce 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -37,6 +37,10 @@ static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
 #endif
 }
 
+static inline void cpu_clone_regs_parent(CPUSPARCState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
 {
     env->gregs[7] = newtls;
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index 0523dc414c..316b7a639c 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp,
     env->regs[TILEGX_R_RE] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUTLGState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUTLGState *env, target_ulong newtls)
 {
     env->regs[TILEGX_R_TP] = newtls;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index 84f67d469e..0c77bafd66 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -16,6 +16,10 @@ static inline void cpu_clone_regs_child(CPUXtensaState *env,
     env->regs[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUXtensaState *env, unsigned flags)
+{
+}
+
 static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
 {
     env->uregs[THREADPTR] = newtls;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 93749014e4..96cf9deb3d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5720,6 +5720,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
         cpu_clone_regs_child(new_env, newsp, flags);
+        cpu_clone_regs_parent(env, flags);
         new_cpu = env_cpu(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5816,6 +5817,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             if (flags & CLONE_CHILD_CLEARTID)
                 ts->child_tidptr = child_tidptr;
         } else {
+            cpu_clone_regs_parent(env, flags);
             fork_end(0);
         }
     }
-- 
2.17.1


