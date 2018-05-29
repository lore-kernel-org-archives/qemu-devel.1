Received: from eggs.gnu.org ([2001:4830:134:3::10]:38054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVr-0004IL-Tp
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVn-0000Uy-Vo
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:32 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVn-0000U2-ER
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:42:00 +0200
Message-Id: <20180529194207.31503-9-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 08/15] linux-user: move get_sp_from_cpustate()
 to target_cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Remove useless includes
Fix HPPA include guard.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/signal.c           |  1 -
 linux-user/aarch64/target_cpu.h       |  4 ++++
 linux-user/aarch64/target_signal.h    |  7 -------
 linux-user/alpha/signal.c             |  1 -
 linux-user/alpha/target_cpu.h         |  4 ++++
 linux-user/alpha/target_signal.h      |  8 --------
 linux-user/arm/signal.c               |  1 -
 linux-user/arm/target_cpu.h           |  4 ++++
 linux-user/arm/target_signal.h        |  7 -------
 linux-user/cris/signal.c              |  1 -
 linux-user/cris/target_cpu.h          |  4 ++++
 linux-user/cris/target_signal.h       |  7 -------
 linux-user/hppa/signal.c              |  1 -
 linux-user/hppa/target_cpu.h          |  8 ++++++--
 linux-user/hppa/target_signal.h       |  6 ------
 linux-user/i386/signal.c              |  1 -
 linux-user/i386/target_cpu.h          |  4 ++++
 linux-user/i386/target_signal.h       |  7 -------
 linux-user/m68k/signal.c              |  1 -
 linux-user/m68k/target_cpu.h          |  4 ++++
 linux-user/m68k/target_signal.h       |  7 -------
 linux-user/microblaze/signal.c        |  1 -
 linux-user/microblaze/target_cpu.h    |  4 ++++
 linux-user/microblaze/target_signal.h |  7 -------
 linux-user/mips/signal.c              |  1 -
 linux-user/mips/target_cpu.h          |  4 ++++
 linux-user/mips/target_signal.h       |  7 -------
 linux-user/mips64/target_signal.h     |  6 ------
 linux-user/nios2/signal.c             |  1 -
 linux-user/nios2/target_cpu.h         |  4 ++++
 linux-user/nios2/target_signal.h      |  6 ------
 linux-user/openrisc/signal.c          |  1 -
 linux-user/openrisc/target_cpu.h      |  4 ++++
 linux-user/openrisc/target_signal.h   |  6 ------
 linux-user/ppc/signal.c               |  1 -
 linux-user/ppc/target_cpu.h           |  5 ++++-
 linux-user/ppc/target_signal.h        |  7 -------
 linux-user/qemu.h                     |  1 -
 linux-user/riscv/signal.c             |  1 -
 linux-user/riscv/target_cpu.h         |  4 ++++
 linux-user/riscv/target_signal.h      |  6 ------
 linux-user/s390x/signal.c             |  1 -
 linux-user/s390x/target_cpu.h         |  4 ++++
 linux-user/s390x/target_signal.h      |  7 -------
 linux-user/sh4/signal.c               |  1 -
 linux-user/sh4/target_cpu.h           |  4 ++++
 linux-user/sh4/target_signal.h        |  7 -------
 linux-user/signal.c                   |  1 -
 linux-user/sparc/signal.c             |  1 -
 linux-user/sparc/target_cpu.h         | 11 +++++++++++
 linux-user/sparc/target_signal.h      | 14 --------------
 linux-user/sparc64/target_signal.h    | 14 --------------
 linux-user/syscall_defs.h             |  2 ++
 linux-user/tilegx/signal.c            |  1 -
 linux-user/tilegx/target_cpu.h        |  4 ++++
 linux-user/tilegx/target_signal.h     |  6 ------
 linux-user/x86_64/target_signal.h     |  6 ------
 linux-user/xtensa/signal.c            |  1 -
 linux-user/xtensa/target_cpu.h        |  4 ++++
 linux-user/xtensa/target_signal.h     |  6 ------
 60 files changed, 83 insertions(+), 177 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f95dc61dfb..07fedfc33c 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index 777ce29f16..a021c95fa4 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -35,4 +35,8 @@ static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
     env->cp15.tpidr_el[0] = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
+{
+   return state->xregs[31];
+}
 #endif
diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 0b7ae25120..18599b1447 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef AARCH64_TARGET_SIGNAL_H
 #define AARCH64_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ 2048
 #define TARGET_SIGSTKSZ 8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
-{
-   return state->xregs[31];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* AARCH64_TARGET_SIGNAL_H */
diff --git a/linux-user/alpha/signal.c b/linux-user/alpha/signal.c
index f24de02c6f..c5c27ce084 100644
--- a/linux-user/alpha/signal.c
+++ b/linux-user/alpha/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ad124da7c0..ac4d255ae7 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -33,4 +33,8 @@ static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
     env->unique = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUAlphaState *state)
+{
+    return state->ir[IR_SP];
+}
 #endif
diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index 4e912e1cf9..e6f2f04911 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef ALPHA_TARGET_SIGNAL_H
 #define ALPHA_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -22,12 +20,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	4096
 #define TARGET_SIGSTKSZ		16384
 
-static inline abi_ulong get_sp_from_cpustate(CPUAlphaState *state)
-{
-    return state->ir[IR_SP];
-}
-
-
 /* From <asm/gentrap.h>.  */
 #define TARGET_GEN_INTOVF      -1      /* integer overflow */
 #define TARGET_GEN_INTDIV      -2      /* integer division by zero */
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 59b5b65ed1..b0e753801b 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index c3eb4b243d..8a3764919a 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -49,4 +49,8 @@ static inline target_ulong cpu_get_tls(CPUARMState *env)
     }
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
+{
+   return state->regs[13];
+}
 #endif
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index d6a03ec87d..f80eb0a215 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef ARM_TARGET_SIGNAL_H
 #define ARM_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
-{
-   return state->regs[13];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* ARM_TARGET_SIGNAL_H */
diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
index 322d9db1a7..0b405247cf 100644
--- a/linux-user/cris/signal.c
+++ b/linux-user/cris/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index c43aac62f9..2309343979 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -33,4 +33,8 @@ static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
     env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUCRISState *state)
+{
+    return state->regs[14];
+}
 #endif
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index 74ff2f3382..bf404a85fd 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef CRIS_TARGET_SIGNAL_H
 #define CRIS_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUCRISState *state)
-{
-    return state->regs[14];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* CRIS_TARGET_SIGNAL_H */
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index 6e7a295aee..b6927ee673 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 7b78bbea80..1c539bdbd6 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -16,8 +16,8 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef ALPHA_TARGET_CPU_H
-#define ALPHA_TARGET_CPU_H
+#ifndef HPPA_TARGET_CPU_H
+#define HPPA_TARGET_CPU_H
 
 static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
 {
@@ -36,4 +36,8 @@ static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
     env->cr[27] = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUHPPAState *state)
+{
+    return state->gr[30];
+}
 #endif
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index f28b4bf6e8..1beae6485a 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef HPPA_TARGET_SIGNAL_H
 #define HPPA_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,8 +19,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUHPPAState *state)
-{
-    return state->gr[30];
-}
 #endif /* HPPA_TARGET_SIGNAL_H */
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index e9a23a2dec..fecb4c99c3 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 7fbcf9bb57..ece04d0966 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -45,4 +45,8 @@ static inline void cpu_set_tls(CPUX86State *env, target_ulong newtls)
 }
 #endif /* defined(TARGET_ABI32) */
 
+static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
+{
+    return state->regs[R_ESP];
+}
 #endif /* I386_TARGET_CPU_H */
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index 6ad4089482..8a284f4b57 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef I386_TARGET_SIGNAL_H
 #define I386_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
-{
-    return state->regs[R_ESP];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* I386_TARGET_SIGNAL_H */
diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
index 5dd8bb5f99..38bd77ec16 100644
--- a/linux-user/m68k/signal.c
+++ b/linux-user/m68k/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index cc0bfc298e..611df065ca 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -37,4 +37,8 @@ static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
     ts->tp_value = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUM68KState *state)
+{
+    return state->aregs[7];
+}
 #endif
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index ff303f2b3c..0cf26b79e5 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef M68K_TARGET_SIGNAL_H
 #define M68K_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ	8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUM68KState *state)
-{
-    return state->aregs[7];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* M68K_TARGET_SIGNAL_H */
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index fada0f1495..712ee522b2 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 7dd979f960..73e139938c 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -32,4 +32,8 @@ static inline void cpu_set_tls(CPUMBState *env, target_ulong newtls)
     env->regs[21] = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
+{
+    return state->regs[1];
+}
 #endif
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 9fe4048292..86adcc1fc9 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef MICROBLAZE_TARGET_SIGNAL_H
 #define MICROBLAZE_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
-{
-    return state->regs[1];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index ed9849c7f6..6aa303ec9c 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 2002920312..02cf5eeff7 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -33,4 +33,8 @@ static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
     env->active_tc.CP0_UserLocal = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
+{
+    return state->active_tc.gpr[29];
+}
 #endif
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index d36f5da0a0..5f68bd7634 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef MIPS_TARGET_SIGNAL_H
 #define MIPS_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,11 +19,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
-{
-    return state->active_tc.gpr[29];
-}
-
 #if defined(TARGET_ABI_MIPSO32)
 /* compare linux/arch/mips/kernel/signal.c:setup_frame() */
 #define TARGET_ARCH_HAS_SETUP_FRAME
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index c074e1592f..7fe6b2f517 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef MIPS64_TARGET_SIGNAL_H
 #define MIPS64_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,8 +19,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
-{
-    return state->active_tc.gpr[29];
-}
 #endif /* MIPS64_TARGET_SIGNAL_H */
diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
index 9a0b36e5ad..4985dc2212 100644
--- a/linux-user/nios2/signal.c
+++ b/linux-user/nios2/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 20ab4790a9..14f63338fa 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -36,4 +36,8 @@ static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
      */
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUNios2State *state)
+{
+    return state->regs[R_SP];
+}
 #endif
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
index f4db4d6d62..1f09f1e6bb 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef TARGET_SIGNAL_H
 #define TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -18,8 +16,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUNios2State *state)
-{
-    return state->regs[R_SP];
-}
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index ecf2897ccd..8be0b74001 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 606ad6f695..d1ea4506e2 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -33,4 +33,8 @@ static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
     cpu_set_gpr(env, 10, newtls);
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUOpenRISCState *state)
+{
+    return cpu_get_gpr(state, 1);
+}
 #endif
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 2a4e00b035..590383302c 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef OPENRISC_TARGET_SIGNAL_H
 #define OPENRISC_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -18,8 +16,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUOpenRISCState *state)
-{
-    return cpu_get_gpr(state, 1);
-}
 #endif /* OPENRISC_TARGET_SIGNAL_H */
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index cacc9afb5a..ef4c518f11 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index 3aab3d185d..c4641834e7 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -47,5 +47,8 @@ static inline uint32_t get_ppc64_abi(struct image_info *infop)
   return infop->elf_flags & EF_PPC64_ABI;
 }
 
-
+static inline abi_ulong get_sp_from_cpustate(CPUPPCState *state)
+{
+    return state->gpr[1];
+}
 #endif
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index e3bf1d2856..6f9e67e321 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef PPC_TARGET_SIGNAL_H
 #define PPC_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,11 +19,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUPPCState *state)
-{
-    return state->gpr[1];
-}
-
 #if !defined(TARGET_PPC64)
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index c55c8e294b..6fa1e968db 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -623,7 +623,6 @@ static inline void *lock_user_string(abi_ulong guest_addr)
  * above, so include them last.
  */
 #include "target_cpu.h"
-#include "target_signal.h"
 #include "target_structs.h"
 
 #endif /* QEMU_H */
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index ef599e319a..f598d41891 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index c5549b1120..7e090f376a 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -15,4 +15,8 @@ static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
     env->gpr[xTP] = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
+{
+   return state->gpr[xSP];
+}
 #endif
diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
index 9dac002c0d..c7fa357008 100644
--- a/linux-user/riscv/target_signal.h
+++ b/linux-user/riscv/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef TARGET_SIGNAL_H
 #define TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 typedef struct target_sigaltstack {
     abi_ulong ss_sp;
     abi_int ss_flags;
@@ -15,8 +13,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ 2048
 #define TARGET_SIGSTKSZ 8192
 
-static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
-{
-   return state->gpr[xSP];
-}
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index e35cbe6870..3d3cb67bbe 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index 87ea4d2d9b..66ef8aa8c2 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -36,4 +36,8 @@ static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
     env->aregs[1] = newtls & 0xffffffffULL;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUS390XState *state)
+{
+   return state->regs[15];
+}
 #endif
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index 4e99f8fadd..8f41ccf9b2 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef S390X_TARGET_SIGNAL_H
 #define S390X_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 typedef struct target_sigaltstack {
     abi_ulong ss_sp;
     int ss_flags;
@@ -18,10 +16,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ     2048
 #define TARGET_SIGSTKSZ        8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUS390XState *state)
-{
-   return state->regs[15];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* S390X_TARGET_SIGNAL_H */
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 2a5378e16e..c6752baa7e 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index 9d305d2833..1a647ddb98 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -32,4 +32,8 @@ static inline void cpu_set_tls(CPUSH4State *env, target_ulong newtls)
   env->gbr = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUSH4State *state)
+{
+    return state->gregs[15];
+}
 #endif
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index e7b18a6db4..2bdc24c48e 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef SH4_TARGET_SIGNAL_H
 #define SH4_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,10 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUSH4State *state)
-{
-    return state->gregs[15];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SH4_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 01de433e3a..be2815b45d 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -23,7 +23,6 @@
 
 #include "qemu.h"
 #include "qemu-common.h"
-#include "target_signal.h"
 #include "trace.h"
 #include "signal-common.h"
 
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 45e922f328..55e9d6f9b2 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index f2fe526204..1ffc0ae9f2 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -41,4 +41,15 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
     env->gregs[7] = newtls;
 }
 
+#ifndef UREG_I6
+#define UREG_I6        6
+#endif
+#ifndef UREG_FP
+#define UREG_FP        UREG_I6
+#endif
+
+static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
+{
+    return state->regwptr[UREG_FP];
+}
 #endif
diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index 467abea49e..bfa19bbb67 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef SPARC_TARGET_SIGNAL_H
 #define SPARC_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,17 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	4096
 #define TARGET_SIGSTKSZ		16384
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
-static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
-{
-    return state->regwptr[UREG_FP];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SPARC_TARGET_SIGNAL_H */
diff --git a/linux-user/sparc64/target_signal.h b/linux-user/sparc64/target_signal.h
index 14b01d9632..1d804bfe86 100644
--- a/linux-user/sparc64/target_signal.h
+++ b/linux-user/sparc64/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef SPARC64_TARGET_SIGNAL_H
 #define SPARC64_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,17 +19,5 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	4096
 #define TARGET_SIGSTKSZ		16384
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
-static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
-{
-    return state->regwptr[UREG_FP];
-}
-
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SPARC64_TARGET_SIGNAL_H */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fbf1bf995a..85e0d870d8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -482,6 +482,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SA_RESTORER	0x04000000
 #endif
 
+#include "target_signal.h"
+
 #ifdef TARGET_SA_RESTORER
 #define TARGET_ARCH_HAS_SA_RESTORER 1
 #endif
diff --git a/linux-user/tilegx/signal.c b/linux-user/tilegx/signal.c
index d0ed3de569..c5a1c7161d 100644
--- a/linux-user/tilegx/signal.c
+++ b/linux-user/tilegx/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index 4878e01b03..d1aa5824f2 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -32,4 +32,8 @@ static inline void cpu_set_tls(CPUTLGState *env, target_ulong newtls)
     env->regs[TILEGX_R_TP] = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUTLGState *state)
+{
+    return state->regs[TILEGX_R_SP];
+}
 #endif
diff --git a/linux-user/tilegx/target_signal.h b/linux-user/tilegx/target_signal.h
index a74fa37aac..4cb8c56adf 100644
--- a/linux-user/tilegx/target_signal.h
+++ b/linux-user/tilegx/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef TILEGX_TARGET_SIGNAL_H
 #define TILEGX_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -20,8 +18,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUTLGState *state)
-{
-    return state->regs[TILEGX_R_SP];
-}
 #endif /* TILEGX_TARGET_SIGNAL_H */
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index 6b01b5acb7..be054d1e59 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef X86_64_TARGET_SIGNAL_H
 #define X86_64_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -21,8 +19,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
-{
-    return state->regs[R_ESP];
-}
 #endif /* X86_64_TARGET_SIGNAL_H */
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 3e483efc61..8d54ef3ae3 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#include "target_signal.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index 747d828614..e31efe3ea0 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -19,4 +19,8 @@ static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
     env->uregs[THREADPTR] = newtls;
 }
 
+static inline abi_ulong get_sp_from_cpustate(CPUXtensaState *state)
+{
+    return state->regs[1];
+}
 #endif
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index 4376b2e538..de03c0a564 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -1,8 +1,6 @@
 #ifndef XTENSA_TARGET_SIGNAL_H
 #define XTENSA_TARGET_SIGNAL_H
 
-#include "cpu.h"
-
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -20,8 +18,4 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
-static inline abi_ulong get_sp_from_cpustate(CPUXtensaState *state)
-{
-    return state->regs[1];
-}
 #endif
-- 
2.14.3
