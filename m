Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F9C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602962072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GXDDeCPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602962072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j74Kv-0007hf-JY
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=318e6e5d7=alistair.francis@wdc.com>)
 id 1j74Jb-0006OA-6n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=318e6e5d7=alistair.francis@wdc.com>)
 id 1j74JZ-00081m-Qe
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:33:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=318e6e5d7=alistair.francis@wdc.com>)
 id 1j74JY-0007l8-By; Wed, 26 Feb 2020 16:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582752836; x=1614288836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k0c0ugoYRAqKkS8oTvWREh22YI+VnP4cmxoY3AkUADw=;
 b=GXDDeCPyeNSlkg3vlvaPY2Z1Lgc6gNEoRwO6P8LshDnVkS4xTEXVce5N
 zJ9CCMMywziHIFNoDm9Qt2buWWJGRQwPtdiq1+/byXeRW2tBw4iip8EGG
 T2IXMcPOR7wsNoNd+v8kXUTJGB1Umv8+SDRlgfUg64S9n8y9Ur8pofJwm
 54/wRP0C45hcKYXEDJTau8wmcod1g5CT7vt5PzUfanScMHxrAn76+ZLZi
 aupoiZXFNpSDjsgC9deURw97vf9RxQMN3KgSBEowlvYt9IUH2MQLKUgTd
 Tvc9VtrXby3HwNGqy13cZB/7m2sQHjRj/LHQY+O/fxKWtnMWujCXneKai w==;
IronPort-SDR: 9XJkbXv3UBQHMAPuSmlOf7BZLDM5b8lhMIExkv1+ONrSymJgxKs85/bU6Cydk9jNKORwedjTfG
 HUZCa5hUABOIz42T03Ksr44otGDj6gjj+m7ElVv7ycgqXDZDky7xBnwivXExyXoiY+tCm6IhH0
 lhJNdqvnM3luTPGPOFN/dXR9eGjVTUW5zBYVtFe3XjvhzYkWFCIpSHMSLqDGhF/Edrl7cllRtS
 H1ym5KFxPkt1vqymoxg/tnLeOEHrB/2CiFk7mkYG+avQICniZrLj7aB2gl3HyBvnjqnblFEa/+
 b08=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; d="scan'208";a="130835626"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 05:33:54 +0800
IronPort-SDR: 3sxEvDpgXBFnFuAkZ4fsQTOauJNM3IVzAbWn3gky5bNdx0pGJ68E/jNbPfeil28dxsNbjJS/6b
 5/tB2xAI70dcIRrHodFQZ0RmeGuoiUh4cM13ueQADE1m9YN0oH8o0OE2XiXi02081FFBFo+IVG
 tKYdHEdiz9Fyzgy2qSS5dSjM6SfXuPM8Xf52VuBxtur1AmtceDR8zBGAmwwEWi2rb9yBgmJuow
 Od37VwreflL60u+0wSimfvEHgDmGYGXVmgtKBffidLeJjOgjBqxxbNtjD0Rx+P919ugaE/peuW
 RzkbMiiyFDMx8XbtXtCNS79m
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2020 13:26:19 -0800
IronPort-SDR: jXanbtO3S8mzfyjy7qeA5A7aZpxN+ak+16a+VGd7vUcwNU5T01McMcC02ZMX5UT1QmTJUNLZuS
 IuGEXlNQ011he9Ua2e7+kaKwWBY2YUCpb4s6clElWUkiY48MQ+sT6MAFTtog2Kmm8Et58K61w9
 Hq2gBHQ+HUaY0/kARLn805xGVUp0/6rwDifUPLKuCyuf6dTubxgCtNqSk2DRRuIqQwVWc5Z239
 SkNTmSrTZLfQkLsLxsBDRq+m45qm9n9dayxEk3VRadHyz8HNrl7I9vMogTXu+DEdD1fBpMuGuG
 +ck=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Feb 2020 13:33:54 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v3 1/2] linux-user: Protect more syscalls
Date: Wed, 26 Feb 2020 13:26:43 -0800
Message-Id: <116a3b5db2bd582b6f94f3816818ebbeb5f84e47.1582752329.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582752329.git.alistair.francis@wdc.com>
References: <cover.1582752329.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
index 8d27d10807..fecb58773b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -742,8 +742,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
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


