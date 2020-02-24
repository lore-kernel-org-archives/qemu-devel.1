Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F6C35DE8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E08F2176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OL1M6bsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E08F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NC0-0004ev-Gv
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=316f2015f=alistair.francis@wdc.com>)
 id 1j6N9v-0001xI-Jp
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=316f2015f=alistair.francis@wdc.com>)
 id 1j6N9u-0003hN-A2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:29:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=316f2015f=alistair.francis@wdc.com>)
 id 1j6N9u-0003gT-0e; Mon, 24 Feb 2020 18:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582586946; x=1614122946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WR1s30QTxgrMwzoOjNhcXBMg/VXTr9of7TRctj5C1jE=;
 b=OL1M6bsu+mZEYD0RBtqYJUSFr/lnptJwmNY0k+aKtZ6PBAhcWnKeH5B9
 wlrp1eQgQuUaMKd8TULeNvZeWHCDWN3OD8ptl1IW6LsbWk6zMXspv71a0
 x7z1ntSr6gtVEsB6DwVd/QUNkk4ZwuCgjQ/HrTbUiMknc9zInxIOrTvYc
 u+8w2WLqLqX6Ah2F9xcAkMQz9MQf0B9qflHO4I2okY6KP+RK+vv4xrQVk
 yDYAJwGZcAqclF4sMSluVsMfStTdJoYxvxAMFa94GBq9KVfbJxy/ncQWJ
 a/4qlirsuN+5I+G3t5HvqddvFLNHEgafYmj++l/OgnfjgUvL7mZnacozB Q==;
IronPort-SDR: Z1btjKQrhNk3gfnN53R0b8AgBJ+E4Ig2m4IPw4VwJF3FEvnX3LLGIoycWlj/nNrSJA9z17232m
 Yz4OcRKE24tvr/+rxSOqjMyYerdArL9kX1+pwjwCAwUdLuLqHtWffeZHiqLxgINmpdou8S131K
 n4Hg+HUMW4IoNItqyf8TA5ImRT876itG0djAJU39jWgtKG06K5g6nLJBfP/UUPrMhiRrzCKMLx
 M4Zi5sruQwP6G0NgP8EBnSUzYBeXbJJyXYDQMaQOoxltqd6Ci6Le4cvRIYLzydbfdkgf16TCx/
 O44=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; d="scan'208";a="131148352"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 07:29:03 +0800
IronPort-SDR: EX5DvkacbNYjOFpSZ1+WDz/N8GaIuCSEm1xQKm0qi/lrJcCx32WPGFju/p31kVK63F0YZEL4UB
 KlRzdSngIp7GDFMAQk/qKz0aaET/SHBn5MWqDCog2JdIZHk4AAYhD3BRps4bLUv0Ux4YtZrNfO
 Ch+2emp5CmlGV/6svXrpEdXrZdFDzX20wYLLWq5geHlGz5Ueqs/AZoULj1CL416HxyeLxGz3ni
 8XRoN2x0mYri5Cw3Tn1YOPLrDI8Y+CqNz9EqzzB8OANsn3MhXRH4J8sK7A6RYHa4yhRbQUKRUX
 aLJYC99HLOUzwyx5V/vPjARS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 15:21:30 -0800
IronPort-SDR: vRFHye3atgXhC6Dcx4xIWLih/7iFpzder6ER0y3PCuRKjk61zeVHk1KRlXGJOS2PGNEcIlZHPe
 nmvQHNX+JPI1MRHDzP1qRoAj7GTbKFFIlYM+2TzoNeElwhmYA+LgiicTPT0DN6ctAc8VEgPE2P
 7p1V8wgope565WhuUh5B4oYRvFXn6gM/asVzsBmr8zIlHMC4Zfa9xXMFxHVXlcJkYehLwuNU3H
 XQ6ordH54sFzReaq/ObNHmR/0W2HOpA16KOGavlzP8SlrgLj1O/UAtWpsjl805umUZ15Gd5pqB
 3i4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2020 15:29:03 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v2 1/2] linux-user: Protect more syscalls
Date: Mon, 24 Feb 2020 15:21:54 -0800
Message-Id: <205d84c5c51c54c8bb6a4a2927b7e1729fe42cdd.1582586444.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582586444.git.alistair.francis@wdc.com>
References: <cover.1582586444.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New y2038 safe 32-bit architectures (like RISC-V) don't support old
syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
allow us to compile without these old syscalls.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 linux-user/strace.c  |  2 ++
 linux-user/syscall.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f7130b2ff..6420ccd97b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -775,6 +775,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_OOP      3   /* leap second in progress */
 #define TARGET_TIME_WAIT     4   /* leap second has occurred */
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
+#ifdef TARGET_NR_adjtimex
 static void
 print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 {
@@ -813,6 +814,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 
     qemu_log("\n");
 }
+#endif
 
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..5a2156f95a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -742,8 +742,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
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
@@ -780,8 +782,10 @@ safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
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
@@ -1067,6 +1071,7 @@ static inline abi_long host_to_target_rusage(abi_ulong target_addr,
     return 0;
 }
 
+#ifdef TARGET_NR_setrlimit
 static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1082,7 +1087,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
     
     return result;
 }
+#endif
 
+#if defined(TARGET_NR_getrlimit) || defined(TARGET_NR_ugetrlimit)
 static inline abi_ulong host_to_target_rlim(rlim_t rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1096,6 +1103,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
     
     return result;
 }
+#endif
 
 static inline int target_to_host_resource(int code)
 {
@@ -1228,6 +1236,7 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_settimeofday)
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -1244,6 +1253,7 @@ static inline abi_long copy_from_user_timezone(struct timezone *tz,
 
     return 0;
 }
+#endif
 
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
 #include <mqueue.h>
@@ -8629,6 +8639,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#if defined(TARGET_NR_gettimeofday)
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
@@ -8639,6 +8650,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_settimeofday)
     case TARGET_NR_settimeofday:
         {
             struct timeval tv, *ptv = NULL;
@@ -8660,6 +8673,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             return get_errno(settimeofday(ptv, ptz));
         }
+#endif
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -9305,6 +9319,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
 #endif
+#if defined(TARGET_NR_wait4)
     case TARGET_NR_wait4:
         {
             int status;
@@ -9332,6 +9347,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
@@ -9476,6 +9492,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_vm86(cpu_env, arg1, arg2);
 #endif
 #endif
+#if defined(TARGET_NR_adjtimex)
     case TARGET_NR_adjtimex:
         {
             struct timex host_buf;
@@ -9491,6 +9508,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
@@ -10016,6 +10034,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#if defined(TARGET_NR_nanosleep)
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -10026,6 +10045,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
     case TARGET_NR_prctl:
         switch (arg1) {
         case PR_GET_PDEATHSIG:
-- 
2.25.0


