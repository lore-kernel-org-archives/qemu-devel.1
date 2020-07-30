Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE907C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BAB20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+y8E1Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BAB20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B8j-0002sd-Uu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rj.bcjesus@gmail.com>)
 id 1k1AzU-0005F3-Gi
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:01:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rj.bcjesus@gmail.com>)
 id 1k1AzR-0005xm-Gb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:01:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so6702246wmi.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zqQAF9xKE/5F3X4KG56kpfJdotSVLh0P38cqHIhjICA=;
 b=f+y8E1Z8zCvP411CgM/izmZKnE8vURoP2Dx4cjq3XYc6X6a/PTvO65/Hkm+BMoq254
 LkmuoMQYNzQNegy0W77/HdcEoSujr+Ki/HAdBFgZRPhcBSUGrau+LIlNyFzv6GPOa2dS
 OedEf3cbgKij7/xRzi3WiaP+70RN1hMT5Gz8B8XHP+M7Mkz6MdwJJRJ4PgtfjAQN/BZr
 h/SKbkrB5xBkhgWrUAE8dwo+2azafj3m+uIyiZOaxhwVVBA8pJK+hr583NZI+IeEkwk4
 8Lke1SQ0X5UVvnuhKdBHMfkEHg+7uteifKy30u2mlMEk0e0TDZ1MLvhYaFKpax0EvJff
 306w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zqQAF9xKE/5F3X4KG56kpfJdotSVLh0P38cqHIhjICA=;
 b=DKBRayEg0rwIBrkTCob2rFDdaZMlNBPpHDU+AVm4PTzETUwuY14LszenMaDZJLcc6K
 JnU/p7zVVMH6zZFTIGY4d9Wef9IUilbwu3mHRRdxh7kbRAOpTVEyo9UQfcL4tgzSNSrg
 uxqphJwI39LkjedOUz7X8m00e9ql51Tu8xuUiYi5GDueL1/k22PN3gwwUzACd/HOgj0H
 gH6u9Wowkk7jqwyrkH/K37mBWJmDof3vdTFeI6e7t1Xi1rud8Fakb4XcMnatMIZu/C1I
 vh4LW59rj/360yLQFbALgzGztkolFmcqYOVbWWdEGGdSpb4/CoYKdqnjLw0WAMYe9qSR
 7+3g==
X-Gm-Message-State: AOAM533OPoTMajnIuJWu6ULUPv3BhdCOj9D2F1nHmyY1Out3CPjZmkSk
 pI9A1fXTRgtMarE63Wdq5pasoROs/y8=
X-Google-Smtp-Source: ABdhPJwsRVVaU6iyXzRZm4vflijzyRXLhrP5k9jMaX+B1zDA6g9awvvWSgMzyntS46IVzACB2HaTvg==
X-Received: by 2002:a1c:4183:: with SMTP id
 o125mr13888093wma.101.1596124862869; 
 Thu, 30 Jul 2020 09:01:02 -0700 (PDT)
Received: from localhost ([193.136.93.218])
 by smtp.gmail.com with ESMTPSA id w2sm12319861wre.5.2020.07.30.09.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 09:01:01 -0700 (PDT)
From: Ricardo Jesus <rj.bcjesus@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] [v4] linux-user: add option to intercept execve() syscalls
Date: Thu, 30 Jul 2020 17:01:06 +0100
Message-Id: <20200730160106.16613-1-rj.bcjesus@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=rj.bcjesus@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

This patch is based on the original work by Petros Angelatos [1], which
I have updated to the current git master. The following commit message
is largely based on Petros' original message.

In order for one to use QEMU user mode emulation under a chroot, it is
required to use binfmt_misc. This can be avoided by QEMU never doing a
raw execve() to the host system.

Introduce a new option, --execve, that uses the current QEMU interpreter
to intercept execve().

qemu_execve() will prepend the interpreter path, similar to what
binfmt_misc would do, and then pass the modified execve() to the host.

[1] https://patchwork.ozlabs.org/patch/582756/

Signed-off-by: Ricardo Jesus <rj.bcjesus@gmail.com>
---
 linux-user/main.c    |   8 +++
 linux-user/qemu.h    |   1 +
 linux-user/syscall.c | 138 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 75c9785157..52f6860b45 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -107,6 +107,7 @@ static void usage(int exitcode);
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
+const char *qemu_execve_path;
 
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
    we allocate a bigger stack. Need a better solution, for example
@@ -337,6 +338,11 @@ static void handle_arg_guest_base(const char *arg)
     have_guest_base = true;
 }
 
+static void handle_arg_execve(const char *arg)
+{
+    qemu_execve_path = strdup(arg);
+}
+
 static void handle_arg_reserved_va(const char *arg)
 {
     char *p;
@@ -441,6 +447,8 @@ static const struct qemu_argument arg_table[] = {
      "uname",      "set qemu uname release string to 'uname'"},
     {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
      "address",    "set guest_base address to 'address'"},
+    {"execve",     "QEMU_EXECVE",      true,  handle_arg_execve,
+     "",           "use this interpreter when a process calls execve()"},
     {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
      "size",       "reserve 'size' bytes for guest virtual address space"},
     {"d",          "QEMU_LOG",         true,  handle_arg_log,
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5c964389c1..d1b0d5716b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -160,6 +160,7 @@ void init_task_state(TaskState *ts);
 void task_settid(TaskState *);
 void stop_all_tasks(void);
 extern const char *qemu_uname_release;
+extern const char *qemu_execve_path;
 extern unsigned long mmap_min_addr;
 
 /* ??? See if we can avoid exposing so much of the loader internals.  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc25279..a266895a61 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,7 @@
 #ifdef HAVE_DRM_H
 #include <libdrm/drm.h>
 #endif
+#include <linux/binfmts.h>
 #include "linux_loop.h"
 #include "uname.h"
 
@@ -7674,6 +7675,131 @@ static target_timer_t get_timer_id(abi_long arg)
     return timerid;
 }
 
+/* qemu_execve() Must return target values and target errnos.
+ *
+ * Although execve() is not an interruptible syscall it is
+ * a special case where we must use the safe_syscall wrapper:
+ * if we allow a signal to happen before we make the host
+ * syscall then we will 'lose' it, because at the point of
+ * execve the process leaves QEMU's control. So we use the
+ * safe syscall wrapper to ensure that we either take the
+ * signal as a guest signal, or else it does not happen
+ * before the execve completes and makes it the other
+ * program's problem.
+ */
+static abi_long qemu_execve(char *filename, char *argv[],
+                  char *envp[])
+{
+    char *i_arg = NULL, *i_name = NULL;
+    char **new_argp;
+    int argc, fd, ret, i, offset = 5;
+    char *cp;
+    char buf[BINPRM_BUF_SIZE];
+
+    /* normal execve case */
+    if (qemu_execve_path == NULL || *qemu_execve_path == 0) {
+        return get_errno(safe_execve(filename, argv, envp));
+    }
+
+    for (argc = 0; argv[argc] != NULL; argc++) {
+        /* nothing */ ;
+    }
+
+    fd = open(filename, O_RDONLY);
+    if (fd == -1) {
+        return get_errno(fd);
+    }
+
+    ret = read(fd, buf, BINPRM_BUF_SIZE);
+    if (ret == -1) {
+        close(fd);
+        return get_errno(ret);
+    }
+
+    /* if we have less than 2 bytes, we can guess it is not executable */
+    if (ret < 2) {
+        close(fd);
+        return -host_to_target_errno(ENOEXEC);
+    }
+
+    close(fd);
+
+    /* adapted from the kernel
+     * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/binfmt_script.c
+     */
+    if ((buf[0] == '#') && (buf[1] == '!')) {
+        /*
+         * This section does the #! interpretation.
+         * Sorta complicated, but hopefully it will work.  -TYT
+         */
+
+        buf[BINPRM_BUF_SIZE - 1] = '\0';
+        cp = strchr(buf, '\n');
+        if (cp == NULL) {
+            cp = buf + BINPRM_BUF_SIZE - 1;
+        }
+        *cp = '\0';
+        while (cp > buf) {
+            cp--;
+            if ((*cp == ' ') || (*cp == '\t')) {
+                *cp = '\0';
+            } else {
+                break;
+            }
+        }
+        for (cp = buf + 2; (*cp == ' ') || (*cp == '\t'); cp++) {
+            /* nothing */ ;
+        }
+        if (*cp == '\0') {
+            return -ENOEXEC; /* No interpreter name found */
+        }
+        i_name = cp;
+        i_arg = NULL;
+        for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++) {
+            /* nothing */ ;
+        }
+        while ((*cp == ' ') || (*cp == '\t')) {
+            *cp++ = '\0';
+        }
+        if (*cp) {
+            i_arg = cp;
+        }
+
+        if (i_arg) {
+            offset += 2;
+        } else {
+            offset += 1;
+        }
+    }
+
+    new_argp = alloca((argc + offset + 1) * sizeof(void *));
+
+    /* Copy the original arguments with offset */
+    for (i = 0; i < argc; i++) {
+        new_argp[i + offset] = argv[i];
+    }
+
+    new_argp[0] = strdup(qemu_execve_path);
+    new_argp[1] = strdup("--execve");
+    new_argp[2] = strdup(qemu_execve_path);
+    new_argp[3] = strdup("-0");
+    new_argp[offset] = filename;
+    new_argp[argc + offset] = NULL;
+
+    if (i_name) {
+        new_argp[4] = i_name;
+        new_argp[5] = i_name;
+
+        if (i_arg) {
+            new_argp[6] = i_arg;
+        }
+    } else {
+        new_argp[4] = argv[0];
+    }
+
+    return get_errno(safe_execve(qemu_execve_path, new_argp, envp));
+}
+
 static int target_to_host_cpu_mask(unsigned long *host_mask,
                                    size_t host_size,
                                    abi_ulong target_addr,
@@ -8023,17 +8149,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             if (!(p = lock_user_string(arg1)))
                 goto execve_efault;
-            /* Although execve() is not an interruptible syscall it is
-             * a special case where we must use the safe_syscall wrapper:
-             * if we allow a signal to happen before we make the host
-             * syscall then we will 'lose' it, because at the point of
-             * execve the process leaves QEMU's control. So we use the
-             * safe syscall wrapper to ensure that we either take the
-             * signal as a guest signal, or else it does not happen
-             * before the execve completes and makes it the other
-             * program's problem.
-             */
-            ret = get_errno(safe_execve(p, argp, envp));
+            ret = qemu_execve(p, argp, envp);
             unlock_user(p, arg1, 0);
 
             goto execve_end;
-- 
2.27.0


