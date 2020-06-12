Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2300020853
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNZManRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2300020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjYnJ-0002YV-AQ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 21:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Y97iXgMKCqgRShOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--jkz.bounces.google.com>)
 id 1jjYly-0000w9-DO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:22 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:54976)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Y97iXgMKCqgRShOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--jkz.bounces.google.com>)
 id 1jjYlv-0001Ul-Kd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:22 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id p22so8734099ybg.21
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 18:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=gapAc62Y0td/O+BfFuvMHL0I99L+MBv6AKtq97q67nA=;
 b=UNZManRrcIOG3hz2BSX5qgzphaRjWDLtbBPKQ+Dz7cDgkGoScO52FB+IEPRLQkPs53
 krBkpS0JR92U9mZNSJn3992tk6usaMBxwYr5vSqtom4WBY0pKEQ51vikRjdMhqi/xIbZ
 hfdYBrmCxCA1HeBzyDmk7nVQv5KVgU12csdfPJ1qKqCHT6pZJeazX4DU5FR8CNh55oyS
 ChjhTZCur2mMHy4VbhHB2idTuQemYRRUVnHXWUc1a66ASR31DmISGom/AQ4V8IH5VgvB
 C4PM8mrmV9MwQzEqgKWOuuYMhQOFuVpTbt2vEv1zixw8bRstvD3D/7XEU/3hIH3RQl+i
 ++5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=gapAc62Y0td/O+BfFuvMHL0I99L+MBv6AKtq97q67nA=;
 b=D7bT7nOFAG/MqoNm0eXykyvTSgB8Uvt69Mo/EwoWXxpWMyh5gpR3scQI2by/NWWt0L
 jERyv9Xf+fN0foz/KYEpvKiZ7N0uXv5gtONkh9nUWa+qO1T2nXyJlp8TV8+4TUlWwLwn
 6uskHONXOLaAvb2/jqzyimT/esZTR+ITGKOkHiIegdg6BuzRi9d0ToQyhIYXZoFaTV6I
 LX3v9EMTJoDyWDIJZUlz7gVnEky5DRrIvhFPhKFGC3wWI6iryi1/bq80brHj3Wjm9QN6
 yI7Au+6b+PwRQYCQsiMXZlmdBSRdhpAz1OIb8d7utPc61I9ritvrzMbS7IOzrEDnKHP3
 ZLYA==
X-Gm-Message-State: AOAM531ZgxFbCOe/fCkPbUeqtfMIDcPXmj4mFQABDvmiXhf3JEwu2XYK
 ucX6P5hjNcwKA4AsmpgiSF7l4k/EldLVcTQYibt3YbQgMkrNnBgOxYr9pMGvh3E2l21IkfLHoYj
 xuB3CuIaNp6DFPII1VPwVpC7xT4k/Xi7ME8glUmZUwQCgOsjSq0/y
X-Google-Smtp-Source: ABdhPJxNNBIu+raP6oEUgHk2C3aGta4khQdCFs5N8n4PqFrlqFzvKTWB6xf1e77zu07PmR2iYtVOkv4=
X-Received: by 2002:a25:bc81:: with SMTP id e1mr7623586ybk.375.1591926371420; 
 Thu, 11 Jun 2020 18:46:11 -0700 (PDT)
Date: Thu, 11 Jun 2020 18:46:02 -0700
In-Reply-To: <20200612014606.147691-1-jkz@google.com>
Message-Id: <20200612014606.147691-2-jkz@google.com>
Mime-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 1/5] linux-user: Refactor do_fork to use new `qemu_clone`
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Y97iXgMKCqgRShOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--jkz.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is pre-work for adding full support for the `CLONE_VM` `clone`
flag. In a follow-up patch, we'll add support to `clone.c` for
`clone_vm`-type clones beyond threads. CLONE_VM support is more
complicated, so first we're splitting existing clone mechanisms
(pthread_create, and fork) into a separate file.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/Makefile.objs |   2 +-
 linux-user/clone.c       | 152 ++++++++++++++++
 linux-user/clone.h       |  27 +++
 linux-user/syscall.c     | 376 +++++++++++++++++++--------------------
 4 files changed, 365 insertions(+), 192 deletions(-)
 create mode 100644 linux-user/clone.c
 create mode 100644 linux-user/clone.h

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 1940910a73..d6788f012c 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
+        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o clone.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/clone.c b/linux-user/clone.c
new file mode 100644
index 0000000000..f02ae8c464
--- /dev/null
+++ b/linux-user/clone.c
@@ -0,0 +1,152 @@
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "clone.h"
+#include <pthread.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <assert.h>
+
+static const unsigned long NEW_STACK_SIZE = 0x40000UL;
+
+/*
+ * A completion tracks an event that can be completed. It's based on the
+ * kernel concept with the same name, but implemented with userspace locks.
+ */
+struct completion {
+    /* done is set once this completion has been completed. */
+    bool done;
+    /* mu syncronizes access to this completion. */
+    pthread_mutex_t mu;
+    /* cond is used to broadcast completion status to awaiting threads. */
+    pthread_cond_t cond;
+};
+
+static void completion_init(struct completion *c)
+{
+    c->done = false;
+    pthread_mutex_init(&c->mu, NULL);
+    pthread_cond_init(&c->cond, NULL);
+}
+
+/*
+ * Block until the given completion finishes. Returns immediately if the
+ * completion has already finished.
+ */
+static void completion_await(struct completion *c)
+{
+    pthread_mutex_lock(&c->mu);
+    if (c->done) {
+        pthread_mutex_unlock(&c->mu);
+        return;
+    }
+    pthread_cond_wait(&c->cond, &c->mu);
+    assert(c->done && "returned from cond wait without being marked as done");
+    pthread_mutex_unlock(&c->mu);
+}
+
+/*
+ * Finish the completion. Unblocks all awaiters.
+ */
+static void completion_finish(struct completion *c)
+{
+    pthread_mutex_lock(&c->mu);
+    assert(!c->done && "trying to finish an already finished completion");
+    c->done = true;
+    pthread_cond_broadcast(&c->cond);
+    pthread_mutex_unlock(&c->mu);
+}
+
+struct clone_thread_info {
+    struct completion running;
+    int tid;
+    int (*callback)(void *);
+    void *payload;
+};
+
+static void *clone_thread_run(void *raw_info)
+{
+    struct clone_thread_info *info = (struct clone_thread_info *) raw_info;
+    info->tid = syscall(SYS_gettid);
+
+    /*
+     * Save out callback/payload since lifetime of info is only guaranteed
+     * until we finish the completion.
+     */
+    int (*callback)(void *) = info->callback;
+    void *payload = info->payload;
+    completion_finish(&info->running);
+
+    _exit(callback(payload));
+}
+
+static int clone_thread(int flags, int (*callback)(void *), void *payload)
+{
+    struct clone_thread_info info;
+    pthread_attr_t attr;
+    int ret;
+    pthread_t thread_unused;
+
+    memset(&info, 0, sizeof(info));
+
+    completion_init(&info.running);
+    info.callback = callback;
+    info.payload = payload;
+
+    (void)pthread_attr_init(&attr);
+    (void)pthread_attr_setstacksize(&attr, NEW_STACK_SIZE);
+    (void)pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+    ret = pthread_create(&thread_unused, &attr, clone_thread_run, (void *) &info);
+    /* pthread_create returns errors directly, instead of via errno. */
+    if (ret != 0) {
+        errno = ret;
+        ret = -1;
+    } else {
+        completion_await(&info.running);
+        ret = info.tid;
+    }
+
+    pthread_attr_destroy(&attr);
+    return ret;
+}
+
+int qemu_clone(int flags, int (*callback)(void *), void *payload)
+{
+    int ret;
+
+    if (clone_flags_are_thread(flags)) {
+        /*
+         * The new process uses the same flags as pthread_create, so we can
+         * use pthread_create directly. This is an optimization.
+         */
+        return clone_thread(flags, callback, payload);
+    }
+
+    if (clone_flags_are_fork(flags)) {
+        /*
+         * Special case a true `fork` clone call. This is so we can take
+         * advantage of special pthread_atfork handlers in libraries we
+         * depend on (e.g., glibc). Without this, existing users of `fork`
+         * in multi-threaded environments will likely get new flaky
+         * deadlocks.
+         */
+        fork_start();
+        ret = fork();
+        if (ret == 0) {
+            fork_end(1);
+            _exit(callback(payload));
+        }
+        fork_end(0);
+        return ret;
+    }
+
+    /* !fork && !thread */
+    errno = EINVAL;
+    return -1;
+}
diff --git a/linux-user/clone.h b/linux-user/clone.h
new file mode 100644
index 0000000000..34ae9b3780
--- /dev/null
+++ b/linux-user/clone.h
@@ -0,0 +1,27 @@
+#ifndef CLONE_H
+#define CLONE_H
+
+/*
+ * qemu_clone executes the given `callback`, with the given payload as the
+ * first argument, in a new process created with the given flags. Some clone
+ * flags, such as *SETTLS, *CLEARTID are not supported. The child thread ID is
+ * returned on success, otherwise negative errno is returned on clone failure.
+ */
+int qemu_clone(int flags, int (*callback)(void *), void *payload);
+
+/* Returns true if the given clone flags can be emulated with libc fork. */
+static bool clone_flags_are_fork(unsigned int flags)
+{
+    return flags == SIGCHLD;
+}
+
+/* Returns true if the given clone flags can be emulated with pthread_create. */
+static bool clone_flags_are_thread(unsigned int flags)
+{
+    return flags == (
+        CLONE_VM | CLONE_FS | CLONE_FILES |
+        CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM
+    );
+}
+
+#endif /* CLONE_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 97de9fb5c9..7ce021cea2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -122,6 +122,7 @@
 #include "qapi/error.h"
 #include "fd-trans.h"
 #include "tcg/tcg.h"
+#include "clone.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -135,12 +136,6 @@
  *  * flags we can implement within QEMU itself
  *  * flags we can't support and will return an error for
  */
-/* For thread creation, all these flags must be present; for
- * fork, none must be present.
- */
-#define CLONE_THREAD_FLAGS                              \
-    (CLONE_VM | CLONE_FS | CLONE_FILES |                \
-     CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM)
 
 /* These flags are ignored:
  * CLONE_DETACHED is now ignored by the kernel;
@@ -150,30 +145,10 @@
     (CLONE_DETACHED | CLONE_IO)
 
 /* Flags for fork which we can implement within QEMU itself */
-#define CLONE_OPTIONAL_FORK_FLAGS               \
+#define CLONE_EMULATED_FLAGS               \
     (CLONE_SETTLS | CLONE_PARENT_SETTID |       \
      CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID)
 
-/* Flags for thread creation which we can implement within QEMU itself */
-#define CLONE_OPTIONAL_THREAD_FLAGS                             \
-    (CLONE_SETTLS | CLONE_PARENT_SETTID |                       \
-     CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID | CLONE_PARENT)
-
-#define CLONE_INVALID_FORK_FLAGS                                        \
-    (~(CSIGNAL | CLONE_OPTIONAL_FORK_FLAGS | CLONE_IGNORED_FLAGS))
-
-#define CLONE_INVALID_THREAD_FLAGS                                      \
-    (~(CSIGNAL | CLONE_THREAD_FLAGS | CLONE_OPTIONAL_THREAD_FLAGS |     \
-       CLONE_IGNORED_FLAGS))
-
-/* CLONE_VFORK is special cased early in do_fork(). The other flag bits
- * have almost all been allocated. We cannot support any of
- * CLONE_NEWNS, CLONE_NEWCGROUP, CLONE_NEWUTS, CLONE_NEWIPC,
- * CLONE_NEWUSER, CLONE_NEWPID, CLONE_NEWNET, CLONE_PTRACE, CLONE_UNTRACED.
- * The checks against the invalid thread masks above will catch these.
- * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
- */
-
 /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
  * once. This exercises the codepaths for restart.
  */
@@ -1104,7 +1079,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
 {
     abi_ulong target_rlim_swap;
     rlim_t result;
-    
+
     target_rlim_swap = tswapal(target_rlim);
     if (target_rlim_swap == TARGET_RLIM_INFINITY)
         return RLIM_INFINITY;
@@ -1112,7 +1087,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
     result = target_rlim_swap;
     if (target_rlim_swap != (rlim_t)result)
         return RLIM_INFINITY;
-    
+
     return result;
 }
 #endif
@@ -1122,13 +1097,13 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
 {
     abi_ulong target_rlim_swap;
     abi_ulong result;
-    
+
     if (rlim == RLIM_INFINITY || rlim != (abi_long)rlim)
         target_rlim_swap = TARGET_RLIM_INFINITY;
     else
         target_rlim_swap = rlim;
     result = tswapal(target_rlim_swap);
-    
+
     return result;
 }
 #endif
@@ -1615,10 +1590,11 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
     abi_ulong target_cmsg_addr;
     struct target_cmsghdr *target_cmsg, *target_cmsg_start;
     socklen_t space = 0;
-    
+
     msg_controllen = tswapal(target_msgh->msg_controllen);
-    if (msg_controllen < sizeof (struct target_cmsghdr)) 
+    if (msg_controllen < sizeof(struct target_cmsghdr)) {
         goto the_end;
+    }
     target_cmsg_addr = tswapal(target_msgh->msg_control);
     target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr, msg_controllen, 1);
     target_cmsg_start = target_cmsg;
@@ -1703,8 +1679,9 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
     socklen_t space = 0;
 
     msg_controllen = tswapal(target_msgh->msg_controllen);
-    if (msg_controllen < sizeof (struct target_cmsghdr)) 
+    if (msg_controllen < sizeof(struct target_cmsghdr)) {
         goto the_end;
+    }
     target_cmsg_addr = tswapal(target_msgh->msg_control);
     target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr, msg_controllen, 0);
     target_cmsg_start = target_cmsg;
@@ -5750,9 +5727,10 @@ abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
     }
     unlock_user_struct(target_ldt_info, ptr, 1);
 
-    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN || 
-        ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
-           return -TARGET_EINVAL;
+    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
+        ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX) {
+        return -TARGET_EINVAL;
+    }
     seg_32bit = ldt_info.flags & 1;
     contents = (ldt_info.flags >> 1) & 3;
     read_exec_only = (ldt_info.flags >> 3) & 1;
@@ -5828,7 +5806,7 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
     lp = (uint32_t *)(gdt_table + idx);
     entry_1 = tswap32(lp[0]);
     entry_2 = tswap32(lp[1]);
-    
+
     read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
     contents = (entry_2 >> 10) & 3;
     seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
@@ -5844,8 +5822,8 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
         (read_exec_only << 3) | (limit_in_pages << 4) |
         (seg_not_present << 5) | (useable << 6) | (lm << 7);
     limit = (entry_1 & 0xffff) | (entry_2  & 0xf0000);
-    base_addr = (entry_1 >> 16) | 
-        (entry_2 & 0xff000000) | 
+    base_addr = (entry_1 >> 16) |
+        (entry_2 & 0xff000000) |
         ((entry_2 & 0xff) << 16);
     target_ldt_info->base_addr = tswapal(base_addr);
     target_ldt_info->limit = tswap32(limit);
@@ -5895,53 +5873,71 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 
 #endif /* defined(TARGET_I386) */
 
-#define NEW_STACK_SIZE 0x40000
-
-
 static pthread_mutex_t clone_lock = PTHREAD_MUTEX_INITIALIZER;
 typedef struct {
-    CPUArchState *env;
+    /* Used to synchronize thread/process creation between parent and child. */
     pthread_mutex_t mutex;
     pthread_cond_t cond;
-    pthread_t thread;
-    uint32_t tid;
+    /*
+     * Guest pointers for implementing CLONE_PARENT_SETTID
+     * and CLONE_CHILD_SETTID.
+     */
     abi_ulong child_tidptr;
     abi_ulong parent_tidptr;
-    sigset_t sigmask;
-} new_thread_info;
+    struct {
+        sigset_t sigmask;
+        CPUArchState *env;
+        bool register_thread;
+        bool signal_setup;
+    } child;
+} clone_info;
 
-static void *clone_func(void *arg)
+static int clone_run(void *arg)
 {
-    new_thread_info *info = arg;
+    clone_info *info = (clone_info *) arg;
     CPUArchState *env;
     CPUState *cpu;
     TaskState *ts;
+    uint32_t tid;
 
-    rcu_register_thread();
-    tcg_register_thread();
-    env = info->env;
+    if (info->child.register_thread) {
+        rcu_register_thread();
+        tcg_register_thread();
+    }
+
+    env = info->child.env;
     cpu = env_cpu(env);
     thread_cpu = cpu;
     ts = (TaskState *)cpu->opaque;
-    info->tid = sys_gettid();
+    tid = sys_gettid();
     task_settid(ts);
-    if (info->child_tidptr)
-        put_user_u32(info->tid, info->child_tidptr);
-    if (info->parent_tidptr)
-        put_user_u32(info->tid, info->parent_tidptr);
+
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
-    /* Enable signals.  */
-    sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
-    /* Signal to the parent that we're ready.  */
-    pthread_mutex_lock(&info->mutex);
-    pthread_cond_broadcast(&info->cond);
-    pthread_mutex_unlock(&info->mutex);
-    /* Wait until the parent has finished initializing the tls state.  */
-    pthread_mutex_lock(&clone_lock);
-    pthread_mutex_unlock(&clone_lock);
+
+    if (info->parent_tidptr) {
+        /*
+         * Even when memory is not shared, parent_tidptr is set before the
+         * process copy, so we need to set it in the child.
+         */
+        put_user_u32(tid, info->parent_tidptr);
+    }
+
+    if (info->child_tidptr) {
+        put_user_u32(tid, info->child_tidptr);
+    }
+
+    /* Enable signals. */
+    sigprocmask(SIG_SETMASK, &info->child.sigmask, NULL);
+
+    if (info->child.signal_setup) {
+        pthread_mutex_lock(&info->mutex);
+        pthread_cond_broadcast(&info->cond);
+        pthread_mutex_unlock(&info->mutex);
+    }
+
     cpu_loop(env);
     /* never exits */
-    return NULL;
+    _exit(1);  /* avoid compiler warning. */
 }
 
 /* do_fork() Must return host values and target errnos (unlike most
@@ -5951,139 +5947,131 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                    abi_ulong child_tidptr)
 {
     CPUState *cpu = env_cpu(env);
-    int ret;
+    int proc_flags, host_sig, ret;
     TaskState *ts;
     CPUState *new_cpu;
-    CPUArchState *new_env;
-    sigset_t sigmask;
+    sigset_t block_sigmask;
+    sigset_t orig_sigmask;
+    clone_info info;
+    TaskState *parent_ts = (TaskState *)cpu->opaque;
 
-    flags &= ~CLONE_IGNORED_FLAGS;
+    memset(&info, 0, sizeof(info));
+
+    /*
+     * When cloning the actual subprocess, we don't need to worry about any
+     * flags that can be ignored, or emulated in QEMU. proc_flags holds only
+     * the flags that need to be passed to `clone` itself.
+     */
+    proc_flags = flags & ~(CLONE_EMULATED_FLAGS | CLONE_IGNORED_FLAGS);
+
+    /*
+     * The exit signal is included in the flags. That signal needs to be mapped
+     * to the appropriate host signal, and we need to check if that signal is
+     * supported.
+     */
+    host_sig = target_to_host_signal(proc_flags & CSIGNAL);
+    if (host_sig > SIGRTMAX) {
+        qemu_log_mask(LOG_UNIMP,
+                      "guest signal %d not supported for exit_signal",
+                      proc_flags & CSIGNAL);
+        return -TARGET_EINVAL;
+    }
+    proc_flags = (proc_flags & ~CSIGNAL) | host_sig;
 
     /* Emulate vfork() with fork() */
-    if (flags & CLONE_VFORK)
-        flags &= ~(CLONE_VFORK | CLONE_VM);
+    if (proc_flags & CLONE_VFORK) {
+        proc_flags &= ~(CLONE_VFORK | CLONE_VM);
+    }
 
-    if (flags & CLONE_VM) {
-        TaskState *parent_ts = (TaskState *)cpu->opaque;
-        new_thread_info info;
-        pthread_attr_t attr;
+    if (!clone_flags_are_fork(proc_flags) &&
+        !clone_flags_are_thread(proc_flags)) {
+        qemu_log_mask(LOG_UNIMP, "unsupported clone flags");
+        return -TARGET_EINVAL;
+    }
 
-        if (((flags & CLONE_THREAD_FLAGS) != CLONE_THREAD_FLAGS) ||
-            (flags & CLONE_INVALID_THREAD_FLAGS)) {
-            return -TARGET_EINVAL;
-        }
+    pthread_mutex_init(&info.mutex, NULL);
+    pthread_mutex_lock(&info.mutex);
+    pthread_cond_init(&info.cond, NULL);
 
-        ts = g_new0(TaskState, 1);
-        init_task_state(ts);
+    ts = g_new0(TaskState, 1);
+    init_task_state(ts);
 
-        /* Grab a mutex so that thread setup appears atomic.  */
-        pthread_mutex_lock(&clone_lock);
+    /* Guard CPU copy. It is not thread-safe. */
+    pthread_mutex_lock(&clone_lock);
+    info.child.env = cpu_copy(env);
+    pthread_mutex_unlock(&clone_lock);
+    /* Init regs that differ from the parent.  */
+    cpu_clone_regs_child(info.child.env, newsp, flags);
 
-        /* we create a new CPU instance. */
-        new_env = cpu_copy(env);
-        /* Init regs that differ from the parent.  */
-        cpu_clone_regs_child(new_env, newsp, flags);
+    if (flags & CLONE_SETTLS) {
+        cpu_set_tls(info.child.env, newtls);
+    }
+
+    new_cpu = env_cpu(info.child.env);
+    new_cpu->opaque = ts;
+    ts->bprm = parent_ts->bprm;
+    ts->info = parent_ts->info;
+    ts->signal_mask = parent_ts->signal_mask;
+
+    if (flags & CLONE_CHILD_CLEARTID) {
+        ts->child_tidptr = child_tidptr;
+    }
+
+    if (flags & CLONE_CHILD_SETTID) {
+        info.child_tidptr = child_tidptr;
+    }
+    if (flags & CLONE_PARENT_SETTID) {
+        info.parent_tidptr = parent_tidptr;
+    }
+
+    /*
+     * If the child process is going to share memory, and this is our first
+     * such child process or thread, we need to ensure we generate code for
+     * parallel execution and flush old translations.
+     */
+    if (!parallel_cpus && (proc_flags & CLONE_VM)) {
+        parallel_cpus = true;
+        tb_flush(cpu);
+    }
+
+    if (proc_flags & CLONE_VM) {
+        info.child.register_thread = true;
+        info.child.signal_setup = true;
+    }
+
+    /*
+     * It is not safe to deliver signals until the child has finished
+     * initializing, so temporarily block all signals.
+     */
+    sigfillset(&block_sigmask);
+    sigprocmask(SIG_BLOCK, &block_sigmask, &orig_sigmask);
+    info.child.sigmask = orig_sigmask;
+
+    ret = get_errno(qemu_clone(proc_flags, clone_run, (void *) &info));
+
+    if (ret >= 0 && (proc_flags & CLONE_VM)) {
+        /*
+         * Wait for the child to finish setup if the child is running in the
+         * same VM.
+         */
+        pthread_cond_wait(&info.cond, &info.mutex);
+    }
+
+    sigprocmask(SIG_SETMASK, &orig_sigmask, NULL);
+
+    pthread_mutex_unlock(&info.mutex);
+    pthread_cond_destroy(&info.cond);
+    pthread_mutex_destroy(&info.mutex);
+
+    if (ret >= 0 && !(proc_flags & CLONE_VM)) {
+        /*
+         * If !CLONE_VM, then we need to set parent_tidptr, since the child
+         * won't set it for us. Should always be safe to set it here anyways.
+         */
+        put_user_u32(ret, info.parent_tidptr);
         cpu_clone_regs_parent(env, flags);
-        new_cpu = env_cpu(new_env);
-        new_cpu->opaque = ts;
-        ts->bprm = parent_ts->bprm;
-        ts->info = parent_ts->info;
-        ts->signal_mask = parent_ts->signal_mask;
-
-        if (flags & CLONE_CHILD_CLEARTID) {
-            ts->child_tidptr = child_tidptr;
-        }
-
-        if (flags & CLONE_SETTLS) {
-            cpu_set_tls (new_env, newtls);
-        }
-
-        memset(&info, 0, sizeof(info));
-        pthread_mutex_init(&info.mutex, NULL);
-        pthread_mutex_lock(&info.mutex);
-        pthread_cond_init(&info.cond, NULL);
-        info.env = new_env;
-        if (flags & CLONE_CHILD_SETTID) {
-            info.child_tidptr = child_tidptr;
-        }
-        if (flags & CLONE_PARENT_SETTID) {
-            info.parent_tidptr = parent_tidptr;
-        }
-
-        ret = pthread_attr_init(&attr);
-        ret = pthread_attr_setstacksize(&attr, NEW_STACK_SIZE);
-        ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
-        /* It is not safe to deliver signals until the child has finished
-           initializing, so temporarily block all signals.  */
-        sigfillset(&sigmask);
-        sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
-        cpu->random_seed = qemu_guest_random_seed_thread_part1();
-
-        /* If this is our first additional thread, we need to ensure we
-         * generate code for parallel execution and flush old translations.
-         */
-        if (!parallel_cpus) {
-            parallel_cpus = true;
-            tb_flush(cpu);
-        }
-
-        ret = pthread_create(&info.thread, &attr, clone_func, &info);
-        /* TODO: Free new CPU state if thread creation failed.  */
-
-        sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
-        pthread_attr_destroy(&attr);
-        if (ret == 0) {
-            /* Wait for the child to initialize.  */
-            pthread_cond_wait(&info.cond, &info.mutex);
-            ret = info.tid;
-        } else {
-            ret = -1;
-        }
-        pthread_mutex_unlock(&info.mutex);
-        pthread_cond_destroy(&info.cond);
-        pthread_mutex_destroy(&info.mutex);
-        pthread_mutex_unlock(&clone_lock);
-    } else {
-        /* if no CLONE_VM, we consider it is a fork */
-        if (flags & CLONE_INVALID_FORK_FLAGS) {
-            return -TARGET_EINVAL;
-        }
-
-        /* We can't support custom termination signals */
-        if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
-            return -TARGET_EINVAL;
-        }
-
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-
-        fork_start();
-        ret = fork();
-        if (ret == 0) {
-            /* Child Process.  */
-            cpu_clone_regs_child(env, newsp, flags);
-            fork_end(1);
-            /* There is a race condition here.  The parent process could
-               theoretically read the TID in the child process before the child
-               tid is set.  This would require using either ptrace
-               (not implemented) or having *_tidptr to point at a shared memory
-               mapping.  We can't repeat the spinlock hack used above because
-               the child process gets its own copy of the lock.  */
-            if (flags & CLONE_CHILD_SETTID)
-                put_user_u32(sys_gettid(), child_tidptr);
-            if (flags & CLONE_PARENT_SETTID)
-                put_user_u32(sys_gettid(), parent_tidptr);
-            ts = (TaskState *)cpu->opaque;
-            if (flags & CLONE_SETTLS)
-                cpu_set_tls (env, newtls);
-            if (flags & CLONE_CHILD_CLEARTID)
-                ts->child_tidptr = child_tidptr;
-        } else {
-            cpu_clone_regs_parent(env, flags);
-            fork_end(0);
-        }
     }
+
     return ret;
 }
 
@@ -7644,6 +7632,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
     switch(num) {
     case TARGET_NR_exit:
+    {
         /* In old applications this may be used to implement _exit(2).
            However in threaded applictions it is used for thread termination,
            and _exit_group is used for application termination.
@@ -7673,6 +7662,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
                           NULL, NULL, 0);
             }
+
             thread_cpu = NULL;
             g_free(ts);
             rcu_unregister_thread();
@@ -7683,6 +7673,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
+    }
     case TARGET_NR_read:
         if (arg2 == 0 && arg3 == 0) {
             return get_errno(safe_read(arg1, 0, 0));
@@ -9679,9 +9670,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef __NR_exit_group
         /* new thread calls */
-    case TARGET_NR_exit_group:
+    case TARGET_NR_exit_group: {
         preexit_cleanup(cpu_env, arg1);
         return get_errno(exit_group(arg1));
+    }
 #endif
     case TARGET_NR_setdomainname:
         if (!(p = lock_user_string(arg1)))
@@ -10873,8 +10865,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
 #if defined(TARGET_NR_fchownat)
     case TARGET_NR_fchownat:
-        if (!(p = lock_user_string(arg2))) 
+        p = lock_user_string(arg2)
+        if (!p) {
             return -TARGET_EFAULT;
+        }
         ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
                                  low2highgid(arg4), arg5));
         unlock_user(p, arg2, 0);
-- 
2.27.0.290.gba653c62da-goog


