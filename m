Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdt-000596-8s
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdp-0000u1-OI
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:37 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:39 +0100
Message-Id: <20180323225739.17329-21-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 20/20] linux-user: define
 TARGET_ARCH_HAS_SETUP_FRAME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

Instead of calling setup_frame() conditionally to a list of known targets,
define TARGET_ARCH_HAS_SETUP_FRAME if the target provides the function
and call it only if the macro is defined.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_signal.h    |  1 +
 linux-user/alpha/target_signal.h      |  1 +
 linux-user/arm/target_signal.h        |  1 +
 linux-user/cris/target_signal.h       |  1 +
 linux-user/i386/target_signal.h       |  1 +
 linux-user/m68k/target_signal.h       |  1 +
 linux-user/microblaze/target_signal.h |  1 +
 linux-user/mips/target_signal.h       |  1 +
 linux-user/ppc/target_signal.h        |  1 +
 linux-user/s390x/target_signal.h      |  1 +
 linux-user/sh4/target_signal.h        |  1 +
 linux-user/signal.c                   | 15 ++++++---------
 linux-user/sparc/target_signal.h      |  1 +
 linux-user/sparc64/target_signal.h    |  1 +
 14 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index af1f1320e2..df8e70fa35 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
    return state->xregs[31];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUARMState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index 42343a1ae6..9cf57b5e51 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -55,6 +55,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUAlphaState *state)
 #define TARGET_GEN_SUBRNG6     -24
 #define TARGET_GEN_SUBRNG7     -25
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUAlphaState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index 4b542c324f..067c261b91 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
    return state->regs[13];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int usig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUARMState *regs);
 void setup_rt_frame(int usig, struct target_sigaction *ka,
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index 19c0d7b539..511af489f2 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUCRISState *state)
     return state->regs[14];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUCRISState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index ec5a3e3373..860a411f1d 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
     return state->regs[R_ESP];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUX86State *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 29e0c01191..97e6cb44ea 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUM68KState *state)
     return state->aregs[7];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUM68KState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 7b25a34256..892b41521f 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
     return state->regs[14];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUMBState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 22ab3e4a94..cd4c82fe5b 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -28,6 +28,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
 
 # if defined(TARGET_ABI_MIPSO32)
 /* compare linux/arch/mips/kernel/signal.c:setup_frame() */
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction * ka,
                  target_sigset_t *set, CPUMIPSState *regs);
 #endif
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 5e293e3b03..54019a4307 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -27,6 +27,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUPPCState *state)
 }
 
 #if !defined(TARGET_PPC64)
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUPPCState *env);
 #endif
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index 9e3733bb38..60b9a7a7a7 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -23,6 +23,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUS390XState *state)
    return state->regs[15];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUS390XState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index a2a93fa04a..448338c7d5 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -26,6 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUSH4State *state)
     return state->gregs[15];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUSH4State *regs);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 7f435c4606..3f8d6d4aa1 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -873,18 +873,15 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         }
 #endif
         /* prepare the stack frame of the virtual CPU */
-#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64) \
-        || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
-        || defined(TARGET_PPC64) || defined(TARGET_HPPA) \
-        || defined(TARGET_NIOS2) || defined(TARGET_X86_64) \
-        || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
+#if defined(TARGET_ARCH_HAS_SETUP_FRAME)
         /* These targets do not have traditional signals.  */
-        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
-#else
-        if (sa->sa_flags & TARGET_SA_SIGINFO)
+        if (sa->sa_flags & TARGET_SA_SIGINFO) {
             setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
-        else
+        } else {
             setup_frame(sig, sa, &target_old_set, cpu_env);
+        }
+#else
+        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #endif
         if (sa->sa_flags & TARGET_SA_RESETHAND) {
             sa->_sa_handler = TARGET_SIG_DFL;
diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index ea2c68c900..e2a17a7408 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -33,6 +33,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
     return state->regwptr[UREG_FP];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUSPARCState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
diff --git a/linux-user/sparc64/target_signal.h b/linux-user/sparc64/target_signal.h
index 7f10db9ede..068d405f56 100644
--- a/linux-user/sparc64/target_signal.h
+++ b/linux-user/sparc64/target_signal.h
@@ -33,6 +33,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
     return state->regwptr[UREG_FP];
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUSPARCState *env);
 void setup_rt_frame(int sig, struct target_sigaction *ka,
-- 
2.14.3
