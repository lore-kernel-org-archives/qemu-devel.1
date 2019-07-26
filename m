Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0CC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F3C22BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F3C22BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr48B-0004SU-Sx
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hr47s-0003gX-Md
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hr47p-0004vh-6r
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:35:27 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hr47o-0004my-Sg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:35:25 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N9doJ-1iVe3Y0kDN-015dlg; Fri, 26 Jul 2019 19:35:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 19:35:02 +0200
Message-Id: <20190726173502.17172-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726173502.17172-1-laurent@vivier.eu>
References: <20190726173502.17172-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eep8em1eVwiv8vqquoYX3hUhv8xPmW/bPAbGohSCE1ZTfu7ldte
 F9f/+Yml0At7Ng1+9FgBY7shyZ/FRHoIObPT3WQIE3SynAqkioi7eqT6kfhftrZCum1f2f+
 ONhsCyzmhYyY8+D/wJ5P/tLWzul8y2IDttTzE9DUXIQEomvfKkT72b8z/mKMVqoYd5rcjpl
 d69p+XFoburvgq4KRrlBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QUq0/WEXMBE=:dQUq82Atq5ByJjhBSS9D3m
 gcHe9ohx/DJeVqTIv++1RfuXveAxLgUv86tLkFJp41H6a6RGd6zObK+eJozCcG7crSkc+mNf4
 puXVkalcNWIg6+93VY8IsSxRAPdZJX1fS+e2fFvOJf0Ct+U0+HQ+W+ozbF45l8Y6zU8mgGyoq
 ke2UUj888Tz0oPh68hkH5xVO5HKzc2C8jP5wkczH7yUkxq5qwvfgpQT+iMHXxanCl+0yP36nq
 giEFLt47+ViCTr2ESUNwjykfUZ3S/8IpW6B01c/E5MeqpP7hPMt2Oc3yiFgSiGKtcmZj3HAbk
 2EEmpq0Mz5/CPMp74JPrZPFD1S6hmuPsvI+tYacy6uluZFhfFXIjv/jRPBIlLCy1y9e7Uy9IN
 gMa8S1ZZD+Bn0jKxE2Fe3uM4DYiwWaljAVrUj3xrno8jwd+XtuCOzsxsYIFWRRiPKwcSjLcSC
 vVQDTsHOjCJJLiBZ6E4fP+yz8hwonP8PcxDjKz9OQhbgblBXVKO+ojJgfe3/JlwHtcc90Sod5
 dyel77kxbzVrrByoRaKIgRxRf7p1UnYMXbGNb+Ch1NhRX29pwWf6kyArm5z7uHgEsOUcsmlen
 1sb76+KQXE0AxTLaGAQThf+87eYg13tEPGws1FDMhZOZR+SNgR8ibZXilMlwtB5xGsJ1/+Ux8
 mhkLON/7tFWOMnGFDFLiSLFX+nFgvmfyrB2PnsE4/74zQOs0GxPDrkzGg7p50P5xK6FJSbFNK
 IJcBdqrGYNPI2cKkumiNpR8gObykTutYiUeozw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 1/1] linux-user: Make sigaltstack stacks
 per-thread
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The alternate signal stack set up by the sigaltstack syscall is
supposed to be per-thread.  We were incorrectly implementing it as
process-wide.  This causes problems for guest binaries that rely on
this.  Notably the Go runtime does, and so we were seeing crashes
caused by races where two guest threads might incorrectly both
execute on the same stack simultaneously.

Replace the global target_sigaltstack_used with a field
sigaltstack_used in the TaskState, and make all the references to the
old global instead get a pointer to the TaskState and use the field.

Fixes: https://bugs.launchpad.net/qemu/+bug/1696773
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190725131645.19501-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/signal.c   |  3 ++-
 linux-user/main.c          |  5 +++++
 linux-user/qemu.h          |  2 ++
 linux-user/signal-common.h |  1 -
 linux-user/signal.c        | 35 +++++++++++++++++++----------------
 5 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index b6927ee67351..d1a58feeb36f 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -111,10 +111,11 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr, sp, haddr;
     struct target_rt_sigframe *frame;
     int i;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     sp = get_sp_from_cpustate(env);
     if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
-        sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
+        sp = (ts->sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
     }
     frame_addr = QEMU_ALIGN_UP(sp, 64);
     sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;
diff --git a/linux-user/main.c b/linux-user/main.c
index a59ae9439de1..8ffc52519552 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -180,6 +180,11 @@ void stop_all_tasks(void)
 void init_task_state(TaskState *ts)
 {
     ts->used = 1;
+    ts->sigaltstack_used = (struct target_sigaltstack) {
+        .ss_sp = 0,
+        .ss_size = 0,
+        .ss_flags = TARGET_SS_DISABLE,
+    };
 }
 
 CPUArchState *cpu_copy(CPUArchState *env)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4258e4162d26..aac033462700 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -151,6 +151,8 @@ typedef struct TaskState {
      */
     int signal_pending;
 
+    /* This thread's sigaltstack, if it has one */
+    struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16))) TaskState;
 
 extern char *exec_path;
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 51030a93069a..1df1068552fb 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -19,7 +19,6 @@
 
 #ifndef SIGNAL_COMMON_H
 #define SIGNAL_COMMON_H
-extern struct target_sigaltstack target_sigaltstack_used;
 
 int on_sig_stack(unsigned long sp);
 int sas_ss_flags(unsigned long sp);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5cd237834d9a..5ca6d62b15d3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -25,12 +25,6 @@
 #include "trace.h"
 #include "signal-common.h"
 
-struct target_sigaltstack target_sigaltstack_used = {
-    .ss_sp = 0,
-    .ss_size = 0,
-    .ss_flags = TARGET_SS_DISABLE,
-};
-
 static struct target_sigaction sigact_table[TARGET_NSIG];
 
 static void host_signal_handler(int host_signum, siginfo_t *info,
@@ -251,13 +245,17 @@ void set_sigmask(const sigset_t *set)
 
 int on_sig_stack(unsigned long sp)
 {
-    return (sp - target_sigaltstack_used.ss_sp
-            < target_sigaltstack_used.ss_size);
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
+    return (sp - ts->sigaltstack_used.ss_sp
+            < ts->sigaltstack_used.ss_size);
 }
 
 int sas_ss_flags(unsigned long sp)
 {
-    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
+    return (ts->sigaltstack_used.ss_size == 0 ? SS_DISABLE
             : on_sig_stack(sp) ? SS_ONSTACK : 0);
 }
 
@@ -266,17 +264,21 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka)
     /*
      * This is the X/Open sanctioned signal stack switching.
      */
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
     if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
-        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+        return ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size;
     }
     return sp;
 }
 
 void target_save_altstack(target_stack_t *uss, CPUArchState *env)
 {
-    __put_user(target_sigaltstack_used.ss_sp, &uss->ss_sp);
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
+    __put_user(ts->sigaltstack_used.ss_sp, &uss->ss_sp);
     __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &uss->ss_size);
+    __put_user(ts->sigaltstack_used.ss_size, &uss->ss_size);
 }
 
 /* siginfo conversion */
@@ -708,12 +710,13 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
 {
     int ret;
     struct target_sigaltstack oss;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     /* XXX: test errors */
     if(uoss_addr)
     {
-        __put_user(target_sigaltstack_used.ss_sp, &oss.ss_sp);
-        __put_user(target_sigaltstack_used.ss_size, &oss.ss_size);
+        __put_user(ts->sigaltstack_used.ss_sp, &oss.ss_sp);
+        __put_user(ts->sigaltstack_used.ss_size, &oss.ss_size);
         __put_user(sas_ss_flags(sp), &oss.ss_flags);
     }
 
@@ -760,8 +763,8 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
             }
         }
 
-        target_sigaltstack_used.ss_sp = ss.ss_sp;
-        target_sigaltstack_used.ss_size = ss.ss_size;
+        ts->sigaltstack_used.ss_sp = ss.ss_sp;
+        ts->sigaltstack_used.ss_size = ss.ss_size;
     }
 
     if (uoss_addr) {
-- 
2.21.0


