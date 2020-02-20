Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC50C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 23:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAC520801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 23:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e+OQc6bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAC520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4vDz-0002rX-93
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 18:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=31236d5d8=alistair.francis@wdc.com>)
 id 1j4vCM-0000PW-3i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 18:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=31236d5d8=alistair.francis@wdc.com>)
 id 1j4vCK-0000hz-Kh
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 18:25:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=31236d5d8=alistair.francis@wdc.com>)
 id 1j4vCK-0000h3-CR; Thu, 20 Feb 2020 18:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582241136; x=1613777136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vx2cxzup8vY5IuEbJlVv7GFIa45fWd375ToC+PpsS6c=;
 b=e+OQc6bv6lUqjFsI3gPHsQSH7KdRqRQ+i0SpaT2qp96+ti6iJ96yQIt9
 JOjaKbufNbiX1Cx2eV1kXq+xukX9KzJK13kq9WXaZgD/4dbZhD1eXeDO0
 KLDD+YjZvN6vahBKENjbgn5E0rwzAw4h89KOZlZJ4hXMZcjTG41sh1Jfw
 pAK9EXYG/p/6YOl5LE5vSJNKXrdnsct+9TBjtlJMlXDm8V53/jZU2/SD8
 /hFu5ynRyzpsVNoWKPJ00nSQh5EK/9NzYZZgEpPx3OS62AhxHqY6IlEe1
 20tQjFB1t42D2tFWulgRyfvrF5KAv4hyzeNvh++1AVacx4njh4KHA5c1+ w==;
IronPort-SDR: ebeWKn3AHm/p0dvnDo+KpYEl44JjYhvoCvG3TNeddBFn4u0984VR0h7VLaJvfYLNhZifGgVQnn
 UwXzRBRccIHSkXYzk/FzO1912NVMPhEkzraOB/dXGUzwzwiAfL/M4Pv3HtsPj/MtPTcgFMAZQ6
 80S5nJHPBPSd0Nwk0gNFPx3IEB4VSPsBHWdeq/4jVSt/ck8B7obW1aWEOsTIr4UqUuf0H1hQqG
 UeNCqYrBXUZDPLLrJ2/OE0GWKJbABRWk6bZQEc3ykr1X3Kl4vtAdTlkmO1aRrlRqfMdVTcfD1L
 iBU=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; d="scan'208";a="238445369"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 07:25:32 +0800
IronPort-SDR: cSXEs0a74B95GWAYMphGbHeQ7Fa8faFHq7EMCz0ISKxwZhOkZtsBEYDi/NGNtDA7WTM0nDq+Nx
 nby30nWwDbLtlbZVMAxvE81VvxLPYHvo0tFqY/Y3QzOPlh8CODr6/o2Olx6R54pqqVZej9+Znz
 JhWpPAuQCXGCR7dHAGAy6y1tqzPIr+r4jynGBYMWI01AUvsEc53RmOrNfy35bShGJj9LOxd8Us
 WjoyTYsRXIGFuX753fEZWsdcgz0SuwdSX/RtAyBz7CSOYWJAGyb9+tlzVjG3O02/2kragUy96C
 WgYkyhLMxMG32CqecgFj9a7U
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2020 15:18:07 -0800
IronPort-SDR: M6qZzrYVnUwdBsCewUNc2clQPmAuDVfolpmWfhmbeLNDY/YcfTSL6uD5sbFIw4ZGR6xSmlPGb6
 XWZffDasY0if7Oj9YdKnCwpiEjBbM5XSGaXf0fDzVBjzpUyWnJpLjgvuUBbNpQQ88PsbxIv+9T
 uXAAR5BQNuY8ktkpmU6GSQBrZd8gjq3a2nWAUgle8FTVrDwGzWsMRivIiujWXNMPw34fUO97ZC
 AmqB1JKptYYjxzenrbl3UfP44zN0zvbeyYablJpQPXNZ6uieWs2vAalyIKQfg+t3tUbpHirmya
 4+Q=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 15:25:33 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/2] linux-user: Protect more syscalls
Date: Thu, 20 Feb 2020 15:18:30 -0800
Message-Id: <3fd846fa30a95eb11e2b27d95fce19f3d619d8f0.1582240656.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582240656.git.alistair.francis@wdc.com>
References: <cover.1582240656.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, laurent@vivier.eu,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New y2038 safe 32-bit architectures (like RISC-V) don't support old
syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
allow us to compile without these old syscalls.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/strace.c  |  2 ++
 linux-user/syscall.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3d4d684450..2eb8ae3d31 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -770,6 +770,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_OOP      3   /* leap second in progress */
 #define TARGET_TIME_WAIT     4   /* leap second has occurred */
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
+#ifdef TARGET_NR_adjtimex
 static void
 print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 {
@@ -808,6 +809,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 
     gemu_log("\n");
 }
+#endif
 
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c930577686..44632a7f6a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -738,8 +738,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+#if defined(TARGET_NR_wait4)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
+#endif
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
 safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
@@ -776,8 +778,10 @@ safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
               const struct timespec *, uts, size_t, sigsetsize)
 safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
               int, flags)
+#if defined(TARGET_NR_nanosleep)
 safe_syscall2(int, nanosleep, const struct timespec *, req,
               struct timespec *, rem)
+#endif
 #ifdef TARGET_NR_clock_nanosleep
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
@@ -1063,6 +1067,7 @@ static inline abi_long host_to_target_rusage(abi_ulong target_addr,
     return 0;
 }
 
+#ifdef TARGET_NR_setrlimit
 static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1078,7 +1083,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
     
     return result;
 }
+#endif
 
+#if defined(TARGET_NR_getrlimit) || defined (TARGET_NR_ugetrlimit)
 static inline abi_ulong host_to_target_rlim(rlim_t rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1092,6 +1099,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
     
     return result;
 }
+#endif
 
 static inline int target_to_host_resource(int code)
 {
@@ -8584,6 +8592,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#if defined(TARGET_NR_gettimeofday)
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
@@ -8594,6 +8603,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_settimeofday)
     case TARGET_NR_settimeofday:
         {
             struct timeval tv, *ptv = NULL;
@@ -8615,6 +8626,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             return get_errno(settimeofday(ptv, ptz));
         }
+#endif
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -9260,6 +9272,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
 #endif
+#if defined(TARGET_NR_wait4)
     case TARGET_NR_wait4:
         {
             int status;
@@ -9287,6 +9300,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
@@ -9431,6 +9445,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_vm86(cpu_env, arg1, arg2);
 #endif
 #endif
+#if defined(TARGET_NR_adjtimex)
     case TARGET_NR_adjtimex:
         {
             struct timex host_buf;
@@ -9446,6 +9461,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
@@ -9971,6 +9987,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#if defined(TARGET_NR_nanosleep)
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -9981,6 +9998,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
     case TARGET_NR_prctl:
         switch (arg1) {
         case PR_GET_PDEATHSIG:
-- 
2.25.0


