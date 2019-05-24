Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB5C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A49D20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A49D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCzX-0006UA-IM
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:24:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUCwN-0003sF-7b
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUCwL-0003hA-NN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:21:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hUCwL-0003g3-EY
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:21:05 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M26n9-1hSGzu008P-002X4S; Fri, 24 May 2019 18:20:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 18:20:49 +0200
Message-Id: <20190524162049.806-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NYryXp87WAac091qTrdYJnKJghBPXF8kJAl7rQBbj32N7CCrI0w
	yzd1QJjTKOHk2i+dzB39F36c5hYSAxU/c7jNdA6FhcrUcM5kEC0m3G6EB5xgLK/zcYU0/by
	EQxoLj1eXai+RuFe56r0YSUDOnhxqPFqL9MV0kzeVLs/M7x6R4j4afK0n0RV830W5GgHe/e
	y3qLdYG2O9+P1EW6fgMDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IefeaDRzRcA=:uQWfGd6SZJN/X0unEhpMwl
	2ix9o1MB+eF49miaSCqnguj9Nezzqhb6Tk0hFFAFEprg135zNkapWVaCIwvKQfOFltx4agxOJ
	XBRVKl/5MmAJyxxB8Dz9x6YVxosX8RIhY041FaarR/ztR8q2abWZ0IlUKrXJXv/009YvMySD2
	Ojlali7wpKl+buMVTCDHU9m8HnfhXB+eRMdhuq4yfaVJOAJQJdj5y4CW2I3Ccjk+OYNZtU+n0
	Lr27oLhPJTcHQcI8yTHaGBg+dZ2cvOl3QpR6l+jWkMkv/6U3Oi0oqjOKvEsA2AZLqMJYV2bI9
	tE8U07lUuQEid1A0LmxwBDTncX7R4dIVZxszhE57C3qjCwtE4ijM8mOdiQwtr9jwWz7/hGINU
	U3S+50rgUwGi2qSnZLvQOObFkaou8rsYKvWNQHubHI4swpaPOM8uC+4Scmx6WYUqPR+tav6sD
	a3rdlfnyq/eFxx8GGuXGIeZotixOYAa5uivReWysT8O+QyfRmBwLp7Fw77TIx3a0gkGUJ2d96
	rpVYFumVvHEuDBJpnY62s1qY8dJwfCDyMqNe3P5xoa4kCL6qUIEjXRxH0tpsG5/fRwUryFtKG
	WmqC/gfsj6MXi4Bx8/MfFOWTrsZ+Xu96mJt5g4GtuQiyV/vg1nq4q4i+ZiC7/SbbglSoqOac+
	KHE1MK/5hnxx8WVSh5X6AOJgZEntBd/90262LTqGvRIyaeQOi7kLgd9AcJmrX+Gx6Ru1tEuGb
	ozwgfrpyU1l3wJJ6KJIuLvqZhlXPIq7URZ9o9Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PATCH] linux-user/m68k: remove simulator syscall
 interface
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This interface has been introduced in 2005 with the
coldfire implementation (e6e5906b6e ColdFire target.)
and looks like to do what the linux-user interface already
does with the TRAP exception rather than the ILLEGAL
exception.

This interface has not been maintained since that.
The semi-hosting interface is not removed so coldfire kernel
with semi-hosting is always supported.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/Makefile.objs         |   1 -
 linux-user/m68k-sim.c            | 164 -------------------------------
 linux-user/m68k/cpu_loop.c       |  17 +---
 linux-user/m68k/target_syscall.h |   2 -
 linux-user/qemu.h                |   1 -
 5 files changed, 1 insertion(+), 184 deletions(-)
 delete mode 100644 linux-user/m68k-sim.c

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 769b8d8336..adae8e1b34 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -6,4 +6,3 @@ obj-y = main.o syscall.o strace.o mmap.o signal.o \
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
 obj-$(TARGET_ARM) += arm/nwfpe/
-obj-$(TARGET_M68K) += m68k-sim.o
diff --git a/linux-user/m68k-sim.c b/linux-user/m68k-sim.c
deleted file mode 100644
index 34d332d8b1..0000000000
--- a/linux-user/m68k-sim.c
+++ /dev/null
@@ -1,164 +0,0 @@
-/*
- *  m68k simulator syscall interface
- *
- *  Copyright (c) 2005 CodeSourcery, LLC. Written by Paul Brook.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-
-#include "qemu.h"
-
-#define SYS_EXIT        1
-#define SYS_READ        3
-#define SYS_WRITE       4
-#define SYS_OPEN        5
-#define SYS_CLOSE       6
-#define SYS_BRK         17
-#define SYS_FSTAT       28
-#define SYS_ISATTY      29
-#define SYS_LSEEK       199
-
-struct m68k_sim_stat {
-    uint16_t sim_st_dev;
-    uint16_t sim_st_ino;
-    uint32_t sim_st_mode;
-    uint16_t sim_st_nlink;
-    uint16_t sim_st_uid;
-    uint16_t sim_st_gid;
-    uint16_t sim_st_rdev;
-    uint32_t sim_st_size;
-    uint32_t sim_st_atime;
-    uint32_t sim_st_mtime;
-    uint32_t sim_st_ctime;
-    uint32_t sim_st_blksize;
-    uint32_t sim_st_blocks;
-};
-
-static inline uint32_t check_err(CPUM68KState *env, uint32_t code)
-{
-  env->dregs[0] = code;
-  if (code == (uint32_t)-1) {
-      env->dregs[1] = errno;
-  } else {
-      env->dregs[1] = 0;
-  }
-  return code;
-}
-
-#define SIM_O_APPEND    0x0008
-#define SIM_O_CREAT     0x0200
-#define SIM_O_TRUNC     0x0400
-#define SIM_O_EXCL      0x0800
-#define SIM_O_NONBLOCK  0x4000
-#define SIM_O_NOCTTY    0x8000
-#define SIM_O_SYNC      0x2000
-
-static int translate_openflags(int flags)
-{
-    int hf;
-
-    switch (flags & 3) {
-    case 0: hf = O_RDONLY; break;
-    case 1: hf = O_WRONLY; break;
-    case 2: hf = O_RDWR; break;
-    default: hf = O_RDWR; break;
-    }
-
-    if (flags & SIM_O_APPEND) hf |= O_APPEND;
-    if (flags & SIM_O_CREAT) hf |= O_CREAT;
-    if (flags & SIM_O_TRUNC) hf |= O_TRUNC;
-    if (flags & SIM_O_EXCL) hf |= O_EXCL;
-    if (flags & SIM_O_NONBLOCK) hf |= O_NONBLOCK;
-    if (flags & SIM_O_NOCTTY) hf |= O_NOCTTY;
-    if (flags & SIM_O_SYNC) hf |= O_SYNC;
-
-    return hf;
-}
-
-#define ARG(x) tswap32(args[x])
-void do_m68k_simcall(CPUM68KState *env, int nr)
-{
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-    uint32_t *args;
-
-    args = (uint32_t *)(unsigned long)(env->aregs[7] + 4);
-    switch (nr) {
-    case SYS_EXIT:
-        exit(ARG(0));
-    case SYS_READ:
-        check_err(env, read(ARG(0), (void *)(unsigned long)ARG(1), ARG(2)));
-        break;
-    case SYS_WRITE:
-        check_err(env, write(ARG(0), (void *)(unsigned long)ARG(1), ARG(2)));
-        break;
-    case SYS_OPEN:
-        check_err(env, open((char *)(unsigned long)ARG(0),
-                            translate_openflags(ARG(1)), ARG(2)));
-        break;
-    case SYS_CLOSE:
-        {
-            /* Ignore attempts to close stdin/out/err.  */
-            int fd = ARG(0);
-            if (fd > 2)
-              check_err(env, close(fd));
-            else
-              check_err(env, 0);
-            break;
-        }
-    case SYS_BRK:
-        {
-            int32_t ret;
-
-            ret = do_brk((abi_ulong)ARG(0));
-            if (ret == -ENOMEM)
-                ret = -1;
-            check_err(env, ret);
-        }
-        break;
-    case SYS_FSTAT:
-        {
-            struct stat s;
-            int rc;
-            struct m68k_sim_stat *p;
-            rc = check_err(env, fstat(ARG(0), &s));
-            if (rc == 0) {
-                p = (struct m68k_sim_stat *)(unsigned long)ARG(1);
-                p->sim_st_dev = tswap16(s.st_dev);
-                p->sim_st_ino = tswap16(s.st_ino);
-                p->sim_st_mode = tswap32(s.st_mode);
-                p->sim_st_nlink = tswap16(s.st_nlink);
-                p->sim_st_uid = tswap16(s.st_uid);
-                p->sim_st_gid = tswap16(s.st_gid);
-                p->sim_st_rdev = tswap16(s.st_rdev);
-                p->sim_st_size = tswap32(s.st_size);
-                p->sim_st_atime = tswap32(s.st_atime);
-                p->sim_st_mtime = tswap32(s.st_mtime);
-                p->sim_st_ctime = tswap32(s.st_ctime);
-                p->sim_st_blksize = tswap32(s.st_blksize);
-                p->sim_st_blocks = tswap32(s.st_blocks);
-            }
-        }
-        break;
-    case SYS_ISATTY:
-        check_err(env, isatty(ARG(0)));
-        break;
-    case SYS_LSEEK:
-        check_err(env, lseek(ARG(0), (int32_t)ARG(1), ARG(2)));
-        break;
-    default:
-        cpu_abort(CPU(cpu), "Unsupported m68k sim syscall %d\n", nr);
-    }
-}
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index bfb41bbcc5..1c8c2a6f70 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -27,7 +27,6 @@ void cpu_loop(CPUM68KState *env)
     int trapnr;
     unsigned int n;
     target_siginfo_t info;
-    TaskState *ts = cs->opaque;
 
     for(;;) {
         cpu_exec_start(cs);
@@ -36,26 +35,14 @@ void cpu_loop(CPUM68KState *env)
         process_queued_cpu_work(cs);
 
         switch(trapnr) {
-        case EXCP_ILLEGAL:
-            {
-                if (ts->sim_syscalls) {
-                    uint16_t nr;
-                    get_user_u16(nr, env->pc + 2);
-                    env->pc += 4;
-                    do_m68k_simcall(env, nr);
-                } else {
-                    goto do_sigill;
-                }
-            }
-            break;
         case EXCP_HALT_INSN:
             /* Semihosing syscall.  */
             env->pc += 4;
             do_m68k_semihosting(env, env->dregs[0]);
             break;
+        case EXCP_ILLEGAL:
         case EXCP_LINEA:
         case EXCP_LINEF:
-        do_sigill:
             info.si_signo = TARGET_SIGILL;
             info.si_errno = 0;
             info.si_code = TARGET_ILL_ILLOPN;
@@ -79,7 +66,6 @@ void cpu_loop(CPUM68KState *env)
         case EXCP_TRAP0:
             {
                 abi_long ret;
-                ts->sim_syscalls = 0;
                 n = env->dregs[0];
                 env->pc += 2;
                 ret = do_syscall(env,
@@ -153,7 +139,6 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     env->aregs[7] = regs->usp;
     env->sr = regs->sr;
 
-    ts->sim_syscalls = 1;
     ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
diff --git a/linux-user/m68k/target_syscall.h b/linux-user/m68k/target_syscall.h
index 632ee4fcf8..c0366b1c62 100644
--- a/linux-user/m68k/target_syscall.h
+++ b/linux-user/m68k/target_syscall.h
@@ -26,6 +26,4 @@ struct target_pt_regs {
 
 #define TARGET_WANT_OLD_SYS_SELECT
 
-void do_m68k_simcall(CPUM68KState *, int);
-
 #endif /* M68K_TARGET_SYSCALL_H */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 82d33d7e93..fab287b7ec 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -116,7 +116,6 @@ typedef struct TaskState {
 #endif
     abi_ulong child_tidptr;
 #ifdef TARGET_M68K
-    int sim_syscalls;
     abi_ulong tp_value;
 #endif
 #if defined(TARGET_ARM) || defined(TARGET_M68K)
-- 
2.20.1


