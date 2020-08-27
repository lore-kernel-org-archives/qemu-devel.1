Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D0C207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D0C207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNVx-0003qn-Tz
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRw-0003ss-Ah
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRr-00009Y-Bq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:39 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MpDRp-1kxgoM0szX-00qmQD; Thu, 27 Aug 2020 21:20:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] linux-user: Make cpu_env accessible in strace.c
Date: Thu, 27 Aug 2020 21:20:04 +0200
Message-Id: <20200827192018.2442099-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rNsfzhWKFNkQtRLFXcqaw4rdAImCMb3xjtDHrSlicSGjGjI2ZT0
 kOP+fhPV8DZR2kVcEXOkYkEi3G2NfCHbj5PHA4BO13s+5KDk6ORzZAf0bKVi+7d56xKdSKQ
 o94fus2edeq+bCPFhMYLN+I/69OBymj/kaKtroZLn3EM1P3aGKqzpMcqX6lFpv+rufgt6KS
 xOMAYCBMyPo6fEB5SKA+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XXry08dqHAo=:Wr1y9nB1/uYTQHcUdSM6uP
 8jcjSP7CCmAISAvfd8x0125JCW28e4cN2FLY1yaIBi1bzUt4132cbJqj+SRuBOHErge4bnzu7
 zt5KndrhQUcZHz1wkNdNGs4kK4cNrQTIh68CTL8WdF+TM+sDV+pSZeuY1OTDnusMtro6DvsUl
 GZJF9IxGa/hdDI5j8GuuIe0XYICJO30ajClPv+XWh2NFxeTjOin7NZ+cIWq5OCj22zm/DxVWa
 xYhwHzONIaTW/xolyB1jf9ofoEoMAHIgJrULNvL/StxmCcD8ln1CVMmya1SnkbFKslTslstH8
 672fBTCwNTC7Csv0hLWAL4FXflsW4yAZli5IAVHHtQJv3sjI5C1JXZMgy+UQbMr+VQA8qQJBP
 RTsTWzoBuNK+IRm5Vqr7OkAh8NLDcGPFqQcxWcRBdqcK0S842r2jmlOrwKLAHGW6e0H7acZh+
 IpnuQrjemGT3c8dlGW0np7j2Tqi5zUkznoUQA6zBJeIxMGQK5rszsjM7hzjMx1pclc3E5JKbr
 OanjMCqDxXeIpFDKLDZfkx9vU48BTxn4NqxQAd1z8YhNNn1IA7gOt7p5MB1Kz+FFEAIAjUM5w
 jRPrI1NQupQ5XXuje1FSpbIczKowZu5wLiHmVcvPla5o1IQANCCSY9Mrkbz0AAKYNTbrqAfcj
 p+QfCagRcMmzWrvhJUpY3mF90xWFHA/+8trFyIbnGlUKWCuAmUcu6UkuP8XRpGnGcX66MOF42
 ntDDAMfkPZNiMb+byVlcfNz9H335UuRz2TLE4aVA8wSnk9WyDA4lw0A5Kr+uk8dUtkiVW052h
 NGoZI8EGabjoCQN+NXQ2AruFOGOGDcdEQPcQnp9FjAFtOU9mf8Qe5Dsv9yYDCb6/BPlbIFQ
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Variable "cpu_env" is used in file "syscall.c" to store
the information about the cpu environment. This variable
is used because values of some syscalls can vary between
cpu architectures. This patch makes the "cpu_env" accessible
in "strace.c" so it can enable aproppriate "-strace" argument
printing for these syscalls. This will be a useful addition
for future "-strace" implementation in QEMU.

Implementation notes:

    Functions "print_syscall()" and "print_syscall_ret()" which
    are stated and defined in "qemu.h" and "strace.c" respectively
    are used to print syscall arguments before and after syscall
    execution. These functions were changed with addition of a
    new argument "void *cpu_env". Strucute "struct syscallname"
    in "strace.c" is used to store the information about syscalls.
    Fields "call" and "result" represent pointers to functions which
    are used to print syscall arguments before and after execution.
    These fields were also changed with addition of a new "void *"
    argumetn.
    Also, all defined "print_*" and "print_syscall_ret*" functions
    in "strace.c" were changed to have the new "void *cpu_env".
    This was done to not cause build errors (even though none of
    these functions use this argument).

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200811164553.27713-2-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h    |   4 +-
 linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
 linux-user/syscall.c |   5 +-
 3 files changed, 247 insertions(+), 241 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5c964389c101..63ddfe86fd8b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -400,10 +400,10 @@ extern long safe_syscall_base(int *pending, long number, ...);
 int host_to_target_waitstatus(int status);
 
 /* strace.c */
-void print_syscall(int num,
+void print_syscall(void *cpu_env, int num,
                    abi_long arg1, abi_long arg2, abi_long arg3,
                    abi_long arg4, abi_long arg5, abi_long arg6);
-void print_syscall_ret(int num, abi_long ret,
+void print_syscall_ret(void *cpu_env, int num, abi_long ret,
                        abi_long arg1, abi_long arg2, abi_long arg3,
                        abi_long arg4, abi_long arg5, abi_long arg6);
 /**
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5e380486433c..2dcc15496a6a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -16,10 +16,10 @@ struct syscallname {
     int nr;
     const char *name;
     const char *format;
-    void (*call)(const struct syscallname *,
+    void (*call)(void *, const struct syscallname *,
                  abi_long, abi_long, abi_long,
                  abi_long, abi_long, abi_long);
-    void (*result)(const struct syscallname *, abi_long,
+    void (*result)(void *, const struct syscallname *, abi_long,
                    abi_long, abi_long, abi_long,
                    abi_long, abi_long, abi_long);
 };
@@ -638,7 +638,7 @@ print_clockid(int clockid, int last)
 /* select */
 #ifdef TARGET_NR__newselect
 static void
-print_newselect(const struct syscallname *name,
+print_newselect(void *cpu_env, const struct syscallname *name,
                 abi_long arg1, abi_long arg2, abi_long arg3,
                 abi_long arg4, abi_long arg5, abi_long arg6)
 {
@@ -656,7 +656,7 @@ print_newselect(const struct syscallname *name,
 
 #ifdef TARGET_NR_semctl
 static void
-print_semctl(const struct syscallname *name,
+print_semctl(void *cpu_env, const struct syscallname *name,
              abi_long arg1, abi_long arg2, abi_long arg3,
              abi_long arg4, abi_long arg5, abi_long arg6)
 {
@@ -668,7 +668,7 @@ print_semctl(const struct syscallname *name,
 #endif
 
 static void
-print_execve(const struct syscallname *name,
+print_execve(void *cpu_env, const struct syscallname *name,
              abi_long arg1, abi_long arg2, abi_long arg3,
              abi_long arg4, abi_long arg5, abi_long arg6)
 {
@@ -701,7 +701,7 @@ print_execve(const struct syscallname *name,
 
 #ifdef TARGET_NR_ipc
 static void
-print_ipc(const struct syscallname *name,
+print_ipc(void *cpu_env, const struct syscallname *name,
           abi_long arg1, abi_long arg2, abi_long arg3,
           abi_long arg4, abi_long arg5, abi_long arg6)
 {
@@ -745,9 +745,10 @@ print_syscall_err(abi_long ret)
 }
 
 static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
-                       abi_long arg0, abi_long arg1, abi_long arg2,
-                       abi_long arg3, abi_long arg4, abi_long arg5)
+print_syscall_ret_addr(void *cpu_env, const struct syscallname *name,
+                       abi_long ret, abi_long arg0, abi_long arg1,
+                       abi_long arg2, abi_long arg3, abi_long arg4,
+                       abi_long arg5)
 {
     if (!print_syscall_err(ret)) {
         qemu_log("0x" TARGET_ABI_FMT_lx, ret);
@@ -765,9 +766,10 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 
 #ifdef TARGET_NR__newselect
 static void
-print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
-                            abi_long arg0, abi_long arg1, abi_long arg2,
-                            abi_long arg3, abi_long arg4, abi_long arg5)
+print_syscall_ret_newselect(void *cpu_env, const struct syscallname *name,
+                            abi_long ret, abi_long arg0, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5)
 {
     if (!print_syscall_err(ret)) {
         qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
@@ -794,9 +796,10 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
 #ifdef TARGET_NR_adjtimex
 static void
-print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
-                           abi_long arg0, abi_long arg1, abi_long arg2,
-                           abi_long arg3, abi_long arg4, abi_long arg5)
+print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
+                           abi_long ret, abi_long arg0, abi_long arg1,
+                           abi_long arg2, abi_long arg3, abi_long arg4,
+                           abi_long arg5)
 {
     if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
@@ -829,9 +832,10 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
 #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
  || defined(TARGGET_NR_flistxattr)
 static void
-print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
-                            abi_long arg0, abi_long arg1, abi_long arg2,
-                            abi_long arg3, abi_long arg4, abi_long arg5)
+print_syscall_ret_listxattr(void *cpu_env, const struct syscallname *name,
+                            abi_long ret, abi_long arg0, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5)
 {
     if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
@@ -860,9 +864,10 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
 
 #ifdef TARGET_NR_ioctl
 static void
-print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
-                        abi_long arg0, abi_long arg1, abi_long arg2,
-                        abi_long arg3, abi_long arg4, abi_long arg5)
+print_syscall_ret_ioctl(void *cpu_env, const struct syscallname *name,
+                        abi_long ret, abi_long arg0, abi_long arg1,
+                        abi_long arg2, abi_long arg3, abi_long arg4,
+                        abi_long arg5)
 {
     if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
@@ -1424,9 +1429,9 @@ print_timezone(abi_ulong tz_addr, int last)
 
 #ifdef TARGET_NR_accept
 static void
-print_accept(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_accept(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1438,9 +1443,9 @@ print_accept(const struct syscallname *name,
 
 #ifdef TARGET_NR_access
 static void
-print_access(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_access(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1451,9 +1456,9 @@ print_access(const struct syscallname *name,
 
 #ifdef TARGET_NR_acct
 static void
-print_acct(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_acct(void *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 1);
@@ -1463,9 +1468,9 @@ print_acct(const struct syscallname *name,
 
 #ifdef TARGET_NR_brk
 static void
-print_brk(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_brk(void *cpu_env, const struct syscallname *name,
+          abi_long arg0, abi_long arg1, abi_long arg2,
+          abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 1);
@@ -1475,9 +1480,9 @@ print_brk(const struct syscallname *name,
 
 #ifdef TARGET_NR_chdir
 static void
-print_chdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_chdir(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 1);
@@ -1487,9 +1492,9 @@ print_chdir(const struct syscallname *name,
 
 #ifdef TARGET_NR_chroot
 static void
-print_chroot(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_chroot(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 1);
@@ -1499,9 +1504,9 @@ print_chroot(const struct syscallname *name,
 
 #ifdef TARGET_NR_chmod
 static void
-print_chmod(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_chmod(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1512,9 +1517,9 @@ print_chmod(const struct syscallname *name,
 
 #if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
 static void
-print_chown(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_chown(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1527,9 +1532,9 @@ print_chown(const struct syscallname *name,
 
 #ifdef TARGET_NR_clock_adjtime
 static void
-print_clock_adjtime(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_clock_adjtime(void *cpu_env, const struct syscallname *name,
+                    abi_long arg0, abi_long arg1, abi_long arg2,
+                    abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_clockid(arg0, 0);
@@ -1551,9 +1556,9 @@ static void do_print_clone(unsigned int flags, abi_ulong newsp,
 }
 
 static void
-print_clone(const struct syscallname *name,
-    abi_long arg1, abi_long arg2, abi_long arg3,
-    abi_long arg4, abi_long arg5, abi_long arg6)
+print_clone(void *cpu_env, const struct syscallname *name,
+            abi_long arg1, abi_long arg2, abi_long arg3,
+            abi_long arg4, abi_long arg5, abi_long arg6)
 {
     print_syscall_prologue(name);
 #if defined(TARGET_MICROBLAZE)
@@ -1571,9 +1576,9 @@ print_clone(const struct syscallname *name,
 
 #ifdef TARGET_NR_creat
 static void
-print_creat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_creat(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1584,9 +1589,9 @@ print_creat(const struct syscallname *name,
 
 #ifdef TARGET_NR_execv
 static void
-print_execv(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_execv(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1597,9 +1602,9 @@ print_execv(const struct syscallname *name,
 
 #ifdef TARGET_NR_faccessat
 static void
-print_faccessat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_faccessat(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -1612,9 +1617,9 @@ print_faccessat(const struct syscallname *name,
 
 #ifdef TARGET_NR_fallocate
 static void
-print_fallocate(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fallocate(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1632,9 +1637,9 @@ print_fallocate(const struct syscallname *name,
 
 #ifdef TARGET_NR_fchmodat
 static void
-print_fchmodat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fchmodat(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -1647,9 +1652,9 @@ print_fchmodat(const struct syscallname *name,
 
 #ifdef TARGET_NR_fchownat
 static void
-print_fchownat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fchownat(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -1663,9 +1668,9 @@ print_fchownat(const struct syscallname *name,
 
 #if defined(TARGET_NR_fcntl) || defined(TARGET_NR_fcntl64)
 static void
-print_fcntl(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fcntl(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1762,9 +1767,9 @@ print_fcntl(const struct syscallname *name,
 
 #ifdef TARGET_NR_fgetxattr
 static void
-print_fgetxattr(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fgetxattr(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1777,9 +1782,9 @@ print_fgetxattr(const struct syscallname *name,
 
 #ifdef TARGET_NR_flistxattr
 static void
-print_flistxattr(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_flistxattr(void *cpu_env, const struct syscallname *name,
+                 abi_long arg0, abi_long arg1, abi_long arg2,
+                 abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1791,9 +1796,9 @@ print_flistxattr(const struct syscallname *name,
 
 #if defined(TARGET_NR_getxattr) || defined(TARGET_NR_lgetxattr)
 static void
-print_getxattr(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_getxattr(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1807,9 +1812,9 @@ print_getxattr(const struct syscallname *name,
 
 #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr)
 static void
-print_listxattr(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_listxattr(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1822,9 +1827,9 @@ print_listxattr(const struct syscallname *name,
 
 #if defined(TARGET_NR_fremovexattr)
 static void
-print_fremovexattr(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fremovexattr(void *cpu_env, const struct syscallname *name,
+                   abi_long arg0, abi_long arg1, abi_long arg2,
+                   abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1835,9 +1840,9 @@ print_fremovexattr(const struct syscallname *name,
 
 #if defined(TARGET_NR_removexattr) || defined(TARGET_NR_lremovexattr)
 static void
-print_removexattr(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_removexattr(void *cpu_env, const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1849,9 +1854,9 @@ print_removexattr(const struct syscallname *name,
 
 #ifdef TARGET_NR_futimesat
 static void
-print_futimesat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_futimesat(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -1864,9 +1869,9 @@ print_futimesat(const struct syscallname *name,
 
 #ifdef TARGET_NR_settimeofday
 static void
-print_settimeofday(const struct syscallname *name,
-                abi_long arg0, abi_long arg1, abi_long arg2,
-                abi_long arg3, abi_long arg4, abi_long arg5)
+print_settimeofday(void *cpu_env, const struct syscallname *name,
+                   abi_long arg0, abi_long arg1, abi_long arg2,
+                   abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_timeval(arg0, 0);
@@ -1877,9 +1882,9 @@ print_settimeofday(const struct syscallname *name,
 
 #ifdef TARGET_NR_link
 static void
-print_link(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_link(void *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -1890,9 +1895,9 @@ print_link(const struct syscallname *name,
 
 #ifdef TARGET_NR_linkat
 static void
-print_linkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_linkat(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -1906,9 +1911,9 @@ print_linkat(const struct syscallname *name,
 
 #ifdef TARGET_NR__llseek
 static void
-print__llseek(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print__llseek(void *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
 {
     const char *whence = "UNKNOWN";
     print_syscall_prologue(name);
@@ -1928,9 +1933,9 @@ print__llseek(const struct syscallname *name,
 
 #ifdef TARGET_NR_lseek
 static void
-print_lseek(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_lseek(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -1959,7 +1964,7 @@ print_lseek(const struct syscallname *name,
 
 #if defined(TARGET_NR_socket)
 static void
-print_socket(const struct syscallname *name,
+print_socket(void *cpu_env, const struct syscallname *name,
              abi_long arg0, abi_long arg1, abi_long arg2,
              abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -2308,7 +2313,7 @@ static struct {
 };
 
 static void
-print_socketcall(const struct syscallname *name,
+print_socketcall(void *cpu_env, const struct syscallname *name,
                  abi_long arg0, abi_long arg1, abi_long arg2,
                  abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -2329,7 +2334,7 @@ print_socketcall(const struct syscallname *name,
 
 #if defined(TARGET_NR_bind)
 static void
-print_bind(const struct syscallname *name,
+print_bind(void *cpu_env, const struct syscallname *name,
            abi_long arg0, abi_long arg1, abi_long arg2,
            abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -2343,9 +2348,9 @@ print_bind(const struct syscallname *name,
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
-print_stat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_stat(void *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2359,9 +2364,9 @@ print_stat(const struct syscallname *name,
 
 #if defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
 static void
-print_fstat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fstat(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -2373,9 +2378,9 @@ print_fstat(const struct syscallname *name,
 
 #ifdef TARGET_NR_mkdir
 static void
-print_mkdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mkdir(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2386,9 +2391,9 @@ print_mkdir(const struct syscallname *name,
 
 #ifdef TARGET_NR_mkdirat
 static void
-print_mkdirat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mkdirat(void *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -2400,9 +2405,9 @@ print_mkdirat(const struct syscallname *name,
 
 #ifdef TARGET_NR_rmdir
 static void
-print_rmdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_rmdir(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2412,9 +2417,9 @@ print_rmdir(const struct syscallname *name,
 
 #ifdef TARGET_NR_rt_sigaction
 static void
-print_rt_sigaction(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_rt_sigaction(void *cpu_env, const struct syscallname *name,
+                   abi_long arg0, abi_long arg1, abi_long arg2,
+                   abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_signal(arg0, 0);
@@ -2426,9 +2431,9 @@ print_rt_sigaction(const struct syscallname *name,
 
 #ifdef TARGET_NR_rt_sigprocmask
 static void
-print_rt_sigprocmask(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_rt_sigprocmask(void *cpu_env, const struct syscallname *name,
+                     abi_long arg0, abi_long arg1, abi_long arg2,
+                     abi_long arg3, abi_long arg4, abi_long arg5)
 {
     const char *how = "UNKNOWN";
     print_syscall_prologue(name);
@@ -2446,9 +2451,9 @@ print_rt_sigprocmask(const struct syscallname *name,
 
 #ifdef TARGET_NR_rt_sigqueueinfo
 static void
-print_rt_sigqueueinfo(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_rt_sigqueueinfo(void *cpu_env, const struct syscallname *name,
+                      abi_long arg0, abi_long arg1, abi_long arg2,
+                      abi_long arg3, abi_long arg4, abi_long arg5)
 {
     void *p;
     target_siginfo_t uinfo;
@@ -2471,9 +2476,9 @@ print_rt_sigqueueinfo(const struct syscallname *name,
 
 #ifdef TARGET_NR_rt_tgsigqueueinfo
 static void
-print_rt_tgsigqueueinfo(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_rt_tgsigqueueinfo(void *cpu_env, const struct syscallname *name,
+                        abi_long arg0, abi_long arg1, abi_long arg2,
+                        abi_long arg3, abi_long arg4, abi_long arg5)
 {
     void *p;
     target_siginfo_t uinfo;
@@ -2555,9 +2560,9 @@ print_syslog_action(abi_ulong arg, int last)
 }
 
 static void
-print_syslog(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_syslog(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_syslog_action(arg0, 0);
@@ -2569,9 +2574,9 @@ print_syslog(const struct syscallname *name,
 
 #ifdef TARGET_NR_mknod
 static void
-print_mknod(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mknod(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     int hasdev = (arg1 & (S_IFCHR|S_IFBLK));
 
@@ -2588,9 +2593,9 @@ print_mknod(const struct syscallname *name,
 
 #ifdef TARGET_NR_mknodat
 static void
-print_mknodat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mknodat(void *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
 {
     int hasdev = (arg2 & (S_IFCHR|S_IFBLK));
 
@@ -2608,9 +2613,9 @@ print_mknodat(const struct syscallname *name,
 
 #ifdef TARGET_NR_mq_open
 static void
-print_mq_open(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mq_open(void *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
 {
     int is_creat = (arg1 & TARGET_O_CREAT);
 
@@ -2627,9 +2632,9 @@ print_mq_open(const struct syscallname *name,
 
 #ifdef TARGET_NR_open
 static void
-print_open(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_open(void *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     int is_creat = (arg1 & TARGET_O_CREAT);
 
@@ -2644,9 +2649,9 @@ print_open(const struct syscallname *name,
 
 #ifdef TARGET_NR_openat
 static void
-print_openat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_openat(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     int is_creat = (arg2 & TARGET_O_CREAT);
 
@@ -2662,9 +2667,9 @@ print_openat(const struct syscallname *name,
 
 #ifdef TARGET_NR_mq_unlink
 static void
-print_mq_unlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mq_unlink(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 1);
@@ -2674,9 +2679,9 @@ print_mq_unlink(const struct syscallname *name,
 
 #if defined(TARGET_NR_fstatat64) || defined(TARGET_NR_newfstatat)
 static void
-print_fstatat64(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_fstatat64(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -2690,9 +2695,9 @@ print_fstatat64(const struct syscallname *name,
 
 #ifdef TARGET_NR_readlink
 static void
-print_readlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_readlink(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2704,9 +2709,9 @@ print_readlink(const struct syscallname *name,
 
 #ifdef TARGET_NR_readlinkat
 static void
-print_readlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_readlinkat(void *cpu_env, const struct syscallname *name,
+                 abi_long arg0, abi_long arg1, abi_long arg2,
+                 abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -2719,9 +2724,9 @@ print_readlinkat(const struct syscallname *name,
 
 #ifdef TARGET_NR_rename
 static void
-print_rename(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_rename(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2732,9 +2737,9 @@ print_rename(const struct syscallname *name,
 
 #ifdef TARGET_NR_renameat
 static void
-print_renameat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_renameat(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -2747,9 +2752,9 @@ print_renameat(const struct syscallname *name,
 
 #ifdef TARGET_NR_statfs
 static void
-print_statfs(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_statfs(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2760,9 +2765,9 @@ print_statfs(const struct syscallname *name,
 
 #ifdef TARGET_NR_statfs64
 static void
-print_statfs64(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_statfs64(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2773,9 +2778,9 @@ print_statfs64(const struct syscallname *name,
 
 #ifdef TARGET_NR_symlink
 static void
-print_symlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_symlink(void *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2786,9 +2791,9 @@ print_symlink(const struct syscallname *name,
 
 #ifdef TARGET_NR_symlinkat
 static void
-print_symlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_symlinkat(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2800,9 +2805,9 @@ print_symlinkat(const struct syscallname *name,
 
 #ifdef TARGET_NR_mount
 static void
-print_mount(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mount(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2816,9 +2821,9 @@ print_mount(const struct syscallname *name,
 
 #ifdef TARGET_NR_umount
 static void
-print_umount(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_umount(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 1);
@@ -2828,9 +2833,9 @@ print_umount(const struct syscallname *name,
 
 #ifdef TARGET_NR_umount2
 static void
-print_umount2(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_umount2(void *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2841,9 +2846,9 @@ print_umount2(const struct syscallname *name,
 
 #ifdef TARGET_NR_unlink
 static void
-print_unlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_unlink(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 1);
@@ -2853,9 +2858,9 @@ print_unlink(const struct syscallname *name,
 
 #ifdef TARGET_NR_unlinkat
 static void
-print_unlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_unlinkat(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -2867,9 +2872,9 @@ print_unlinkat(const struct syscallname *name,
 
 #ifdef TARGET_NR_utime
 static void
-print_utime(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_utime(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2880,9 +2885,9 @@ print_utime(const struct syscallname *name,
 
 #ifdef TARGET_NR_utimes
 static void
-print_utimes(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_utimes(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
@@ -2893,9 +2898,9 @@ print_utimes(const struct syscallname *name,
 
 #ifdef TARGET_NR_utimensat
 static void
-print_utimensat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_utimensat(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_at_dirfd(arg0, 0);
@@ -2908,9 +2913,9 @@ print_utimensat(const struct syscallname *name,
 
 #if defined(TARGET_NR_mmap) || defined(TARGET_NR_mmap2)
 static void
-print_mmap(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mmap(void *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
@@ -2926,9 +2931,9 @@ print_mmap(const struct syscallname *name,
 
 #ifdef TARGET_NR_mprotect
 static void
-print_mprotect(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_mprotect(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
@@ -2940,9 +2945,9 @@ print_mprotect(const struct syscallname *name,
 
 #ifdef TARGET_NR_munmap
 static void
-print_munmap(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_munmap(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
@@ -2993,9 +2998,9 @@ if( cmd == val ) { \
 }
 
 static void
-print_futex(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_futex(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
@@ -3010,9 +3015,9 @@ print_futex(const struct syscallname *name,
 
 #ifdef TARGET_NR_kill
 static void
-print_kill(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_kill(void *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -3023,9 +3028,9 @@ print_kill(const struct syscallname *name,
 
 #ifdef TARGET_NR_tkill
 static void
-print_tkill(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_tkill(void *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -3036,9 +3041,9 @@ print_tkill(const struct syscallname *name,
 
 #ifdef TARGET_NR_tgkill
 static void
-print_tgkill(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
+print_tgkill(void *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
@@ -3050,7 +3055,7 @@ print_tgkill(const struct syscallname *name,
 
 #ifdef TARGET_NR_statx
 static void
-print_statx(const struct syscallname *name,
+print_statx(void *cpu_env, const struct syscallname *name,
             abi_long arg0, abi_long arg1, abi_long arg2,
             abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -3066,7 +3071,7 @@ print_statx(const struct syscallname *name,
 
 #ifdef TARGET_NR_ioctl
 static void
-print_ioctl(const struct syscallname *name,
+print_ioctl(void *cpu_env, const struct syscallname *name,
             abi_long arg0, abi_long arg1, abi_long arg2,
             abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -3151,7 +3156,7 @@ static int nsyscalls = ARRAY_SIZE(scnames);
  * The public interface to this module.
  */
 void
-print_syscall(int num,
+print_syscall(void *cpu_env, int num,
               abi_long arg1, abi_long arg2, abi_long arg3,
               abi_long arg4, abi_long arg5, abi_long arg6)
 {
@@ -3164,7 +3169,7 @@ print_syscall(int num,
         if( scnames[i].nr == num ) {
             if( scnames[i].call != NULL ) {
                 scnames[i].call(
-                    &scnames[i], arg1, arg2, arg3, arg4, arg5, arg6);
+                    cpu_env, &scnames[i], arg1, arg2, arg3, arg4, arg5, arg6);
             } else {
                 /* XXX: this format system is broken because it uses
                    host types and host pointers for strings */
@@ -3180,7 +3185,7 @@ print_syscall(int num,
 
 
 void
-print_syscall_ret(int num, abi_long ret,
+print_syscall_ret(void *cpu_env, int num, abi_long ret,
                   abi_long arg1, abi_long arg2, abi_long arg3,
                   abi_long arg4, abi_long arg5, abi_long arg6)
 {
@@ -3189,7 +3194,7 @@ print_syscall_ret(int num, abi_long ret,
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].result != NULL ) {
-                scnames[i].result(&scnames[i], ret,
+                scnames[i].result(cpu_env, &scnames[i], ret,
                                   arg1, arg2, arg3,
                                   arg4, arg5, arg6);
             } else {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index efaa0a7b8365..42107f37e397 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12769,14 +12769,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
     ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
                       arg5, arg6, arg7, arg8);
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_syscall_ret(num, ret, arg1, arg2, arg3, arg4, arg5, arg6);
+        print_syscall_ret(cpu_env, num, ret, arg1, arg2,
+                          arg3, arg4, arg5, arg6);
     }
 
     record_syscall_return(cpu, num, ret);
-- 
2.26.2


