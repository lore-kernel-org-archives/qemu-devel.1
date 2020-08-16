Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4520C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 22:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AECB2078D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 22:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlySxjlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AECB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7R30-0007tl-Rx
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 18:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7R2A-0007Ab-N7
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 18:21:46 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7R27-0004v4-S8
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 18:21:46 -0400
Received: by mail-pj1-x1044.google.com with SMTP id mt12so6839103pjb.4
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b0SdwrsYedY049tu9iuSLzX/MrMDD/JbZ6cFFYG/7v8=;
 b=OlySxjlTLNSIrr7lFHINnQ6yUO4jjaZOwnwf+QZI7QHs327l4Nyt8EbVOKAkjUUrcw
 VAooQFTHAIEeNL99F+SNT9Kg2eNBiVGEP8GT9HZdf5oCi3OninPVjyHwxq5qW5nl/++I
 9sm3G7v2aidjppzydTa7TCsjJiCkFmfXqXKYSIoHdIEJ1HNJK13TaZcmuisCs6ywEs3a
 /m2pOZyLegBOfteQER3pvkGNbNl/B83oVmBI7Dbi8oYgiLPgrIf+eufasKsUReji0gip
 MYrzVvk3Qag71Qrm7pgHK8pNlptLiS2D8GVnD/zDZo2XHo3UFxW0gY2TmadNqjWFiU1h
 MVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b0SdwrsYedY049tu9iuSLzX/MrMDD/JbZ6cFFYG/7v8=;
 b=p+7jqqu8sp7EzcJEjL/lwKDQJIUIeApCPudlEt96Mge2z5lWwK3em9/pXLLcDZmcWr
 Q82yLe3Zl8IroApBu31tw65ouLHYc5cC4tgiXuzINjwDZ8BIZKvEioqo+sQOFkiKLzIk
 C6ErgA1h2Jd6roxPAU9nQVA9kvBf37DnHPfQ3MgYbnhNl8lkdop5wiCcIM5uNB7No1cp
 6FvRlbXkwdo7x7/DVENYGMPy/ZSW6QU4u3eMz5k0AxsRa9Q4yopQh/trLiVWIazICyJN
 byHJClZ2qGmzQH3abPX4lLNpRFJWthPozodWoSn4KXeEi8S8F3ScZpiQlLSsLaa7USCj
 HLRA==
X-Gm-Message-State: AOAM531twL1s4xn7X8UewOfV0iUd35Tqa2n70nW/JPbut0Hg2bJ29Dw0
 75nlO3k7UOMmZ0i7w02GqWkl/ufQcLV48FeGgkE=
X-Google-Smtp-Source: ABdhPJzd/Ze8CUiGcWa2zdQDgoNCbSBZL4nyj3WtJgDlnVLclrnPrQ60+u3415IdAdxnEm85CljHq65gfiG3A6zG2+U=
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr9982106pjj.6.1597616501968; 
 Sun, 16 Aug 2020 15:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
 <e406661a-b581-2e35-ff3a-d9321ba6ee33@amsat.org>
In-Reply-To: <e406661a-b581-2e35-ff3a-d9321ba6ee33@amsat.org>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>
Date: Mon, 17 Aug 2020 01:21:30 +0300
Message-ID: <CAMw0szJ4g++8agt0gpvUfYMLbO_NMsK4VZbZOXagd2+AeXRy7g@mail.gmail.com>
Subject: Re: [PATCH] fixed proc myself (linux user) for musl
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000001651fc05ad06148b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001651fc05ad06148b
Content-Type: text/plain; charset="UTF-8"

From 738f6ec4598b4618acd7ecbd11e5d250a82f28b7 Mon Sep 17 00:00:00 2001
From: Andrew Aladjev <aladjev.andrew@gmail.com>
Date: Mon, 17 Aug 2020 01:20:03 +0300
Subject: [PATCH] fixed proc myself (linux user) for musl

Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
---
 linux-user/Makefile.objs  |   5 +-
 linux-user/elfload.c      |   7 ++-
 linux-user/exit.c         |   7 ++-
 linux-user/main.c         |   2 +-
 linux-user/qemu.h         |   1 +
 linux-user/syscall.c      |  63 ++++++++---------------
 linux-user/syscall_proc.c | 102 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_proc.h |   8 +++
 8 files changed, 146 insertions(+), 49 deletions(-)
 create mode 100644 linux-user/syscall_proc.c
 create mode 100644 linux-user/syscall_proc.h

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 1940910a73..ad84380738 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,8 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
  elfload.o linuxload.o uaccess.o uname.o \
- safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
+ safe-syscall.o syscall_proc.o \
+ $(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
+ exit.o fd-trans.o

 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 619c054cc4..201db61d91 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2319,7 +2319,10 @@ exit_errmsg:
    buffer is sufficiently aligned to present no problems to the host
    in accessing data at aligned offsets within the buffer.

-   On return: INFO values will be filled in, as necessary or available.  */
+   On return: INFO values will be filled in, as necessary or available.
+
+   WARNING: this function won't close "image_fd".
+*/

 static void load_elf_image(const char *image_name, int image_fd,
                            struct image_info *info, char **pinterp_name,
@@ -2576,7 +2579,6 @@ static void load_elf_image(const char *image_name,
int image_fd,

     mmap_unlock();

-    close(image_fd);
     return;

  exit_read:
@@ -2610,6 +2612,7 @@ static void load_elf_interp(const char *filename,
struct image_info *info,
     }

     load_elf_image(filename, fd, info, NULL, bprm_buf);
+    close(fd);
     return;

  exit_perror:
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 1594015444..f0626fc432 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -28,12 +28,15 @@ extern void __gcov_dump(void);

 void preexit_cleanup(CPUArchState *env, int code)
 {
+    close(execfd);
+
 #ifdef CONFIG_GPROF
         _mcleanup();
 #endif
 #ifdef CONFIG_GCOV
         __gcov_dump();
 #endif
-        gdb_exit(env, code);
-        qemu_plugin_atexit_cb();
+
+    gdb_exit(env, code);
+    qemu_plugin_atexit_cb();
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index 22578b1633..9cc6c1e6da 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -48,6 +48,7 @@
 #include "crypto/init.h"

 char *exec_path;
+int execfd;

 int singlestep;
 static const char *argv0;
@@ -628,7 +629,6 @@ int main(int argc, char **argv, char **envp)
     int target_argc;
     int i;
     int ret;
-    int execfd;
     int log_mask;
     unsigned long max_reserved_va;

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 792c74290f..d822f2b9df 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -156,6 +156,7 @@ typedef struct TaskState {
 } __attribute__((aligned(16))) TaskState;

 extern char *exec_path;
+extern int execfd;
 void init_task_state(TaskState *ts);
 void task_settid(TaskState *);
 void stop_all_tasks(void);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..af86385281 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -122,6 +122,7 @@
 #include "qapi/error.h"
 #include "fd-trans.h"
 #include "tcg/tcg.h"
+#include "syscall_proc.h"

 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -7353,38 +7354,6 @@ static int open_self_auxv(void *cpu_env, int fd)
     return 0;
 }

-static int is_proc_myself(const char *filename, const char *entry)
-{
-    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
-        filename += strlen("/proc/");
-        if (!strncmp(filename, "self/", strlen("self/"))) {
-            filename += strlen("self/");
-        } else if (*filename >= '1' && *filename <= '9') {
-            char myself[80];
-            snprintf(myself, sizeof(myself), "%d/", getpid());
-            if (!strncmp(filename, myself, strlen(myself))) {
-                filename += strlen(myself);
-            } else {
-                return 0;
-            }
-        } else {
-            return 0;
-        }
-        if (!strcmp(filename, entry)) {
-            return 1;
-        }
-    }
-    return 0;
-}
-
-#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
-    defined(TARGET_SPARC) || defined(TARGET_M68K)
-static int is_proc(const char *filename, const char *entry)
-{
-    return strcmp(filename, entry) == 0;
-}
-#endif
-
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
 static int open_net_route(void *cpu_env, int fd)
 {
@@ -7460,20 +7429,19 @@ static int do_openat(void *cpu_env, int dirfd,
const char *pathname, int flags,
         { "auxv", open_self_auxv, is_proc_myself },
         { "cmdline", open_self_cmdline, is_proc_myself },
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
-        { "/proc/net/route", open_net_route, is_proc },
+        { "net/route", open_net_route, is_proc },
 #endif
 #if defined(TARGET_SPARC)
-        { "/proc/cpuinfo", open_cpuinfo, is_proc },
+        { "cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
-        { "/proc/hardware", open_hardware, is_proc },
+        { "hardware", open_hardware, is_proc },
 #endif
         { NULL, NULL, NULL }
     };

-    if (is_proc_myself(pathname, "exe")) {
-        int execfd = qemu_getauxval(AT_EXECFD);
-        return execfd ? execfd : safe_openat(dirfd, exec_path, flags,
mode);
+    if (is_proc_myself_exe(pathname)) {
+        return execfd;
     }

     for (fake_open = fakes; fake_open->filename; fake_open++) {
@@ -7728,8 +7696,19 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
         return ret;
 #endif
     case TARGET_NR_close:
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
+        {
+            int fd = arg1;
+            if (fd == execfd) {
+                /*
+                 * We don't need to close execfd.
+                 * It will be closed on QEMU exit.
+                 */
+                return 0;
+            }
+
+            fd_trans_unregister(fd);
+            return get_errno(close(fd));
+        }

     case TARGET_NR_brk:
         return do_brk(arg1);
@@ -9031,7 +9010,7 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
             } else if (!arg3) {
                 /* Short circuit this for the magic exe check. */
                 ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself_exe((const char *)p)) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 /* Return value is # of bytes that we wrote to the buffer.
*/
@@ -9060,7 +9039,7 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
             p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
             if (!p || !p2) {
                 ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself_exe((const char *)p)) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 ret = temp == NULL ? get_errno(-1) : strlen(real) ;
diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
new file mode 100644
index 0000000000..8688459c7d
--- /dev/null
+++ b/linux-user/syscall_proc.c
@@ -0,0 +1,102 @@
+#include "qemu/osdep.h"
+#include "elf.h"
+
+#include "syscall_proc.h"
+#include "qemu.h"
+
+#define PROC "/proc/"
+#define SELF "self/"
+
+#define STARTS_WITH(path, CONSTANT) (              \
+    strlen(path) >= strlen(CONSTANT) &&            \
+    strncmp(path, CONSTANT, strlen(CONSTANT)) == 0 \
+)
+
+static inline char *scope_to_proc(const char *path)
+{
+    if (STARTS_WITH(path, PROC)) {
+        return (char *)path + strlen(PROC);
+    }
+
+    return NULL;
+}
+
+static inline char *scope_to_proc_myself(const char *path)
+{
+    char *scope_path = scope_to_proc(path);
+    if (scope_path == NULL) {
+        return NULL;
+    }
+
+    if (STARTS_WITH(scope_path, SELF)) {
+        return scope_path + strlen(SELF);
+    }
+
+    if (strlen(scope_path) >= 1 &&
+        *scope_path >= '1' && *scope_path <= '9') {
+        char pid_path[80];
+        snprintf(pid_path, sizeof(pid_path), "%d/", getpid());
+        if (STARTS_WITH(scope_path, pid_path)) {
+            return scope_path + strlen(pid_path);
+        }
+    }
+
+    return NULL;
+}
+
+int is_proc(const char *path, const char *entry)
+{
+    char *scope_path = scope_to_proc(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    return strcmp(scope_path, entry) == 0;
+}
+
+int is_proc_myself(const char *path, const char *entry)
+{
+    char *scope_path = scope_to_proc_myself(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    return strcmp(scope_path, entry) == 0;
+}
+
+/*
+ * Kernel creates "fd/#{number}" link after opening "exe" link.
+ * Both "exe" and "fd/#{number}" can be used by application.
+ *
+ * Kernel can provide infinite amount of fd numbers.
+ * QEMU is going to always return single global execfd.
+ *
+ * So we need to check "exe" and "fd/#{execfd}" only.
+ */
+
+int is_proc_myself_exe(const char *path)
+{
+    char *scope_path = scope_to_proc_myself(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    if (strcmp(scope_path, "exe") == 0) {
+        return 1;
+    }
+
+    if (STARTS_WITH(scope_path, "fd/")) {
+        scope_path += strlen("fd/");
+
+        if (strlen(scope_path) >= 1 &&
+            *scope_path >= '1' && *scope_path <= '9') {
+            char execfd_path[80];
+            snprintf(execfd_path, sizeof(execfd_path), "%d", execfd);
+            if (strcmp(scope_path, execfd_path) == 0) {
+                return 1;
+            }
+        }
+    }
+
+    return 0;
+}
diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
new file mode 100644
index 0000000000..f0e59c0e96
--- /dev/null
+++ b/linux-user/syscall_proc.h
@@ -0,0 +1,8 @@
+#ifndef SYSCALL_PROC_H
+#define SYSCALL_PROC_H
+
+int is_proc(const char *path, const char *entry);
+int is_proc_myself(const char *path, const char *entry);
+int is_proc_myself_exe(const char *path);
+
+#endif
-- 
2.26.2

--0000000000001651fc05ad06148b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From 738f6ec4598b4618acd7ecbd11e5d250a82f28b7 Mon Sep 17 0=
0:00:00 2001<br>From: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@g=
mail.com">aladjev.andrew@gmail.com</a>&gt;<br>Date: Mon, 17 Aug 2020 01:20:=
03 +0300<br>Subject: [PATCH] fixed proc myself (linux user) for musl<br><br=
>Signed-off-by: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@gmail.c=
om">aladjev.andrew@gmail.com</a>&gt;<br>---<br>=C2=A0linux-user/Makefile.ob=
js =C2=A0| =C2=A0 5 +-<br>=C2=A0linux-user/elfload.c =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 7 ++-<br>=C2=A0linux-user/exit.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 7 ++-<br>=C2=A0linux-user/main.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 2=
 +-<br>=C2=A0linux-user/qemu.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 +<br>=
=C2=A0linux-user/syscall.c =C2=A0 =C2=A0 =C2=A0| =C2=A063 ++++++++---------=
------<br>=C2=A0linux-user/syscall_proc.c | 102 +++++++++++++++++++++++++++=
+++++++++++<br>=C2=A0linux-user/syscall_proc.h | =C2=A0 8 +++<br>=C2=A08 fi=
les changed, 146 insertions(+), 49 deletions(-)<br>=C2=A0create mode 100644=
 linux-user/syscall_proc.c<br>=C2=A0create mode 100644 linux-user/syscall_p=
roc.h<br><br>diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.ob=
js<br>index 1940910a73..ad84380738 100644<br>--- a/linux-user/Makefile.objs=
<br>+++ b/linux-user/Makefile.objs<br>@@ -1,7 +1,8 @@<br>=C2=A0obj-y =3D ma=
in.o syscall.o strace.o mmap.o signal.o \<br>=C2=A0	elfload.o linuxload.o u=
access.o uname.o \<br>-	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o<b=
r>+	safe-syscall.o syscall_proc.o \<br>+	$(TARGET_ABI_DIR)/cpu_loop.o $(TAR=
GET_ABI_DIR)/signal.o \<br>+	exit.o fd-trans.o<br>=C2=A0<br>=C2=A0obj-$(TAR=
GET_HAS_BFLT) +=3D flatload.o<br>=C2=A0obj-$(TARGET_I386) +=3D vm86.o<br>di=
ff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>index 619c054cc4.=
.201db61d91 100644<br>--- a/linux-user/elfload.c<br>+++ b/linux-user/elfloa=
d.c<br>@@ -2319,7 +2319,10 @@ exit_errmsg:<br>=C2=A0 =C2=A0 buffer is suffi=
ciently aligned to present no problems to the host<br>=C2=A0 =C2=A0 in acce=
ssing data at aligned offsets within the buffer.<br>=C2=A0<br>- =C2=A0 On r=
eturn: INFO values will be filled in, as necessary or available. =C2=A0*/<b=
r>+ =C2=A0 On return: INFO values will be filled in, as necessary or availa=
ble.<br>+<br>+ =C2=A0 WARNING: this function won&#39;t close &quot;image_fd=
&quot;.<br>+*/<br>=C2=A0<br>=C2=A0static void load_elf_image(const char *im=
age_name, int image_fd,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct image_info *info, =
char **pinterp_name,<br>@@ -2576,7 +2579,6 @@ static void load_elf_image(co=
nst char *image_name, int image_fd,<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0mmap_u=
nlock();<br>=C2=A0<br>- =C2=A0 =C2=A0close(image_fd);<br>=C2=A0 =C2=A0 =C2=
=A0return;<br>=C2=A0<br>=C2=A0 exit_read:<br>@@ -2610,6 +2612,7 @@ static v=
oid load_elf_interp(const char *filename, struct image_info *info,<br>=C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0load_elf_image(filename=
, fd, info, NULL, bprm_buf);<br>+ =C2=A0 =C2=A0close(fd);<br>=C2=A0 =C2=A0 =
=C2=A0return;<br>=C2=A0<br>=C2=A0 exit_perror:<br>diff --git a/linux-user/e=
xit.c b/linux-user/exit.c<br>index 1594015444..f0626fc432 100644<br>--- a/l=
inux-user/exit.c<br>+++ b/linux-user/exit.c<br>@@ -28,12 +28,15 @@ extern v=
oid __gcov_dump(void);<br>=C2=A0<br>=C2=A0void preexit_cleanup(CPUArchState=
 *env, int code)<br>=C2=A0{<br>+ =C2=A0 =C2=A0close(execfd);<br>+<br>=C2=A0=
#ifdef CONFIG_GPROF<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_mcleanup();<br>=
=C2=A0#endif<br>=C2=A0#ifdef CONFIG_GCOV<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__gcov_dump();<br>=C2=A0#endif<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_exit(=
env, code);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_plugin_atexit_cb();<br>+<b=
r>+ =C2=A0 =C2=A0gdb_exit(env, code);<br>+ =C2=A0 =C2=A0qemu_plugin_atexit_=
cb();<br>=C2=A0}<br>diff --git a/linux-user/main.c b/linux-user/main.c<br>i=
ndex 22578b1633..9cc6c1e6da 100644<br>--- a/linux-user/main.c<br>+++ b/linu=
x-user/main.c<br>@@ -48,6 +48,7 @@<br>=C2=A0#include &quot;crypto/init.h&qu=
ot;<br>=C2=A0<br>=C2=A0char *exec_path;<br>+int execfd;<br>=C2=A0<br>=C2=A0=
int singlestep;<br>=C2=A0static const char *argv0;<br>@@ -628,7 +629,6 @@ i=
nt main(int argc, char **argv, char **envp)<br>=C2=A0 =C2=A0 =C2=A0int targ=
et_argc;<br>=C2=A0 =C2=A0 =C2=A0int i;<br>=C2=A0 =C2=A0 =C2=A0int ret;<br>-=
 =C2=A0 =C2=A0int execfd;<br>=C2=A0 =C2=A0 =C2=A0int log_mask;<br>=C2=A0 =
=C2=A0 =C2=A0unsigned long max_reserved_va;<br>=C2=A0<br>diff --git a/linux=
-user/qemu.h b/linux-user/qemu.h<br>index 792c74290f..d822f2b9df 100644<br>=
--- a/linux-user/qemu.h<br>+++ b/linux-user/qemu.h<br>@@ -156,6 +156,7 @@ t=
ypedef struct TaskState {<br>=C2=A0} __attribute__((aligned(16))) TaskState=
;<br>=C2=A0<br>=C2=A0extern char *exec_path;<br>+extern int execfd;<br>=C2=
=A0void init_task_state(TaskState *ts);<br>=C2=A0void task_settid(TaskState=
 *);<br>=C2=A0void stop_all_tasks(void);<br>diff --git a/linux-user/syscall=
.c b/linux-user/syscall.c<br>index 05f03919ff..af86385281 100644<br>--- a/l=
inux-user/syscall.c<br>+++ b/linux-user/syscall.c<br>@@ -122,6 +122,7 @@<br=
>=C2=A0#include &quot;qapi/error.h&quot;<br>=C2=A0#include &quot;fd-trans.h=
&quot;<br>=C2=A0#include &quot;tcg/tcg.h&quot;<br>+#include &quot;syscall_p=
roc.h&quot;<br>=C2=A0<br>=C2=A0#ifndef CLONE_IO<br>=C2=A0#define CLONE_IO =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x80000000 =C2=A0 =
=C2=A0 =C2=A0/* Clone io context */<br>@@ -7353,38 +7354,6 @@ static int op=
en_self_auxv(void *cpu_env, int fd)<br>=C2=A0 =C2=A0 =C2=A0return 0;<br>=C2=
=A0}<br>=C2=A0<br>-static int is_proc_myself(const char *filename, const ch=
ar *entry)<br>-{<br>- =C2=A0 =C2=A0if (!strncmp(filename, &quot;/proc/&quot=
;, strlen(&quot;/proc/&quot;))) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0filename =
+=3D strlen(&quot;/proc/&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strnc=
mp(filename, &quot;self/&quot;, strlen(&quot;self/&quot;))) {<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename +=3D strlen(&quot;self/&quot;);<=
br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (*filename &gt;=3D &#39;1&#39; &a=
mp;&amp; *filename &lt;=3D &#39;9&#39;) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0char myself[80];<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0snprintf(myself, sizeof(myself), &quot;%d/&quot;, getpid());<br>- =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strncmp(filename, myself, strlen(my=
self))) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filen=
ame +=3D strlen(myself);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} el=
se {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<=
br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0} else {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(f=
ilename, entry)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<=
br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0ret=
urn 0;<br>-}<br>-<br>-#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET=
_WORDS_BIGENDIAN) || \<br>- =C2=A0 =C2=A0defined(TARGET_SPARC) || defined(T=
ARGET_M68K)<br>-static int is_proc(const char *filename, const char *entry)=
<br>-{<br>- =C2=A0 =C2=A0return strcmp(filename, entry) =3D=3D 0;<br>-}<br>=
-#endif<br>-<br>=C2=A0#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET=
_WORDS_BIGENDIAN)<br>=C2=A0static int open_net_route(void *cpu_env, int fd)=
<br>=C2=A0{<br>@@ -7460,20 +7429,19 @@ static int do_openat(void *cpu_env, =
int dirfd, const char *pathname, int flags,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{ &quot;auxv&quot;, open_self_auxv, is_proc_myself },<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;cmdline&quot;, open_self_cmdline, is_proc_m=
yself },<br>=C2=A0#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WOR=
DS_BIGENDIAN)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/net/route&quot;=
, open_net_route, is_proc },<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;net/ro=
ute&quot;, open_net_route, is_proc },<br>=C2=A0#endif<br>=C2=A0#if defined(=
TARGET_SPARC)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/cpuinfo&quot;, =
open_cpuinfo, is_proc },<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;cpuinfo&qu=
ot;, open_cpuinfo, is_proc },<br>=C2=A0#endif<br>=C2=A0#if defined(TARGET_M=
68K)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/hardware&quot;, open_har=
dware, is_proc },<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;hardware&quot;, o=
pen_hardware, is_proc },<br>=C2=A0#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{ NULL, NULL, NULL }<br>=C2=A0 =C2=A0 =C2=A0};<br>=C2=A0<br>- =C2=A0 =C2=
=A0if (is_proc_myself(pathname, &quot;exe&quot;)) {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int execfd =3D qemu_getauxval(AT_EXECFD);<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return execfd ? execfd : safe_openat(dirfd, exec_path, flags, mod=
e);<br>+ =C2=A0 =C2=A0if (is_proc_myself_exe(pathname)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return execfd;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0for (fake_open =3D fakes; fake_open-&gt;filename; fake_ope=
n++) {<br>@@ -7728,8 +7696,19 @@ static abi_long do_syscall1(void *cpu_env,=
 int num, abi_long arg1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<b=
r>=C2=A0#endif<br>=C2=A0 =C2=A0 =C2=A0case TARGET_NR_close:<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0fd_trans_unregister(arg1);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return get_errno(close(arg1));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd =3D arg1;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D execfd) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We don&#39;t need to close execfd.<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * It will be closed=
 on QEMU exit.<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fd_trans_unregister(fd);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return get_errno(close(fd));<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case TARGET_NR_brk:<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return do_brk(arg1);<br>@@ -9031,7 +9010,7 @@ stati=
c abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!arg3) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Short circuit this for t=
he magic exe check. */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D -TARGET_EINVAL;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else if (is_proc_myself((const char *)p, &quot;exe&quot;)) {<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself_exe((=
const char *)p)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char real[PATH_MAX], *temp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D realpath(exec_path, real);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Return value is #=
 of bytes that we wrote to the buffer. */<br>@@ -9060,7 +9039,7 @@ static a=
bi_long do_syscall1(void *cpu_env, int num, abi_long arg1,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p2 =3D lock_user(VERIFY_WRITE, arg3, arg=
4, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!p || !p2) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -T=
ARGET_EFAULT;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_p=
roc_myself((const char *)p, &quot;exe&quot;)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself_exe((const char *)p)) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char real[PAT=
H_MAX], *temp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0temp =3D realpath(exec_path, real);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D temp =3D=3D NULL ? get_errno(-1) =
: strlen(real) ;<br>diff --git a/linux-user/syscall_proc.c b/linux-user/sys=
call_proc.c<br>new file mode 100644<br>index 0000000000..8688459c7d<br>--- =
/dev/null<br>+++ b/linux-user/syscall_proc.c<br>@@ -0,0 +1,102 @@<br>+#incl=
ude &quot;qemu/osdep.h&quot;<br>+#include &quot;elf.h&quot;<br>+<br>+#inclu=
de &quot;syscall_proc.h&quot;<br>+#include &quot;qemu.h&quot;<br>+<br>+#def=
ine PROC &quot;/proc/&quot;<br>+#define SELF &quot;self/&quot;<br>+<br>+#de=
fine STARTS_WITH(path, CONSTANT) ( =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>+ =C2=A0 =C2=A0strlen(path) &gt;=3D strlen(CONSTANT) &amp;&a=
mp; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>+ =C2=A0 =C2=A0strncmp(pa=
th, CONSTANT, strlen(CONSTANT)) =3D=3D 0 \<br>+)<br>+<br>+static inline cha=
r *scope_to_proc(const char *path)<br>+{<br>+ =C2=A0 =C2=A0if (STARTS_WITH(=
path, PROC)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return (char *)path + strlen=
(PROC);<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return NULL;<br>+}<br>+<=
br>+static inline char *scope_to_proc_myself(const char *path)<br>+{<br>+ =
=C2=A0 =C2=A0char *scope_path =3D scope_to_proc(path);<br>+ =C2=A0 =C2=A0if=
 (scope_path =3D=3D NULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br=
>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (STARTS_WITH(scope_path, SELF))=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return scope_path + strlen(SELF);<br>+ =
=C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (strlen(scope_path) &gt;=3D 1 &amp=
;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0*scope_path &gt;=3D &#39;1&#39; &amp=
;&amp; *scope_path &lt;=3D &#39;9&#39;) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
har pid_path[80];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(pid_path, sizeof=
(pid_path), &quot;%d/&quot;, getpid());<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(STARTS_WITH(scope_path, pid_path)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return scope_path + strlen(pid_path);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return NULL;<br>+}<br>+<=
br>+int is_proc(const char *path, const char *entry)<br>+{<br>+ =C2=A0 =C2=
=A0char *scope_path =3D scope_to_proc(path);<br>+ =C2=A0 =C2=A0if (scope_pa=
th =3D=3D NULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=
=A0}<br>+<br>+ =C2=A0 =C2=A0return strcmp(scope_path, entry) =3D=3D 0;<br>+=
}<br>+<br>+int is_proc_myself(const char *path, const char *entry)<br>+{<br=
>+ =C2=A0 =C2=A0char *scope_path =3D scope_to_proc_myself(path);<br>+ =C2=
=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn 0;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return strcmp(scope_path,=
 entry) =3D=3D 0;<br>+}<br>+<br>+/*<br>+ * Kernel creates &quot;fd/#{number=
}&quot; link after opening &quot;exe&quot; link.<br>+ * Both &quot;exe&quot=
; and &quot;fd/#{number}&quot; can be used by application.<br>+ *<br>+ * Ke=
rnel can provide infinite amount of fd numbers.<br>+ * QEMU is going to alw=
ays return single global execfd.<br>+ *<br>+ * So we need to check &quot;ex=
e&quot; and &quot;fd/#{execfd}&quot; only.<br>+ */<br>+<br>+int is_proc_mys=
elf_exe(const char *path)<br>+{<br>+ =C2=A0 =C2=A0char *scope_path =3D scop=
e_to_proc_myself(path);<br>+ =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0=
 =C2=A0if (strcmp(scope_path, &quot;exe&quot;) =3D=3D 0) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return 1;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (S=
TARTS_WITH(scope_path, &quot;fd/&quot;)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
scope_path +=3D strlen(&quot;fd/&quot;);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (strlen(scope_path) &gt;=3D 1 &amp;&amp;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*scope_path &gt;=3D &#39;1&#39; &amp;&amp; *scope_path =
&lt;=3D &#39;9&#39;) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char e=
xecfd_path[80];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(exec=
fd_path, sizeof(execfd_path), &quot;%d&quot;, execfd);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(scope_path, execfd_path) =3D=3D 0) {<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return 0;<br>+}<br>diff --git =
a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h<br>new file mode 10=
0644<br>index 0000000000..f0e59c0e96<br>--- /dev/null<br>+++ b/linux-user/s=
yscall_proc.h<br>@@ -0,0 +1,8 @@<br>+#ifndef SYSCALL_PROC_H<br>+#define SYS=
CALL_PROC_H<br>+<br>+int is_proc(const char *path, const char *entry);<br>+=
int is_proc_myself(const char *path, const char *entry);<br>+int is_proc_my=
self_exe(const char *path);<br>+<br>+#endif<br>-- <br>2.26.2<br><br></div>

--0000000000001651fc05ad06148b--

