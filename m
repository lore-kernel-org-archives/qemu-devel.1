Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B5C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 21:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185BE2078D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 21:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4yN7dQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185BE2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Ptj-0003IA-BW
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 17:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7Onl-0001Qn-6i
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 15:58:45 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7Oni-0008Bx-4l
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 15:58:44 -0400
Received: by mail-pj1-x1043.google.com with SMTP id f9so6649900pju.4
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=RR/l3QLVjtUSZefrjjmsFX4eCrZFAST0t+QHsIHRunw=;
 b=P4yN7dQd06yU70R34eg8UCPRn/gi3sXp2VNs3FZckIODvKxHtlPPkyVirmNbHbyYem
 tcfvduXampavXy3f6yfU7L0Rh4JRzMN23PhwWkZ61lsVD3j+K8u6b+FtQZWgOK3UG8xK
 8LfMWiv4+hnAL0KdrI0312V97CZpGlZV9Xw1HkNS+rie+89BlCnCJRKlPQLuYINIfZvb
 PWv1gQ55K0IxNSlmjVVx582gwyzDLYCs3lEJYO8RgrM4Hf/DGxs60f2bYNzWHIx1RI4J
 QvDteJgHFJkwlGgY/SqEoQTI7THk5bNz0FJgEI83YtNegw2A1aaywIGeoNvYJ9wzslL6
 3kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RR/l3QLVjtUSZefrjjmsFX4eCrZFAST0t+QHsIHRunw=;
 b=dfa6+wDAmkCYYe1URY5H1QjxA/aphJnw5j8hp7WU3h3z+gN8ISg1108BRvRqpHwhQ2
 M3V1ychOcdc5NVd2X8BCCEIsVxDH0yWCvHEYN6rnMGRmpixpL0wTylkhL0GsHw01oQBr
 9VZ1dnTbsTKrnwjsYRKKu+j2VScnrQXyE0WuD5/3UTb9Ya8GbBbKaZDtywbW2iNNqRLR
 m6QsKowpcJZGk6jPLkglTiPTGxgeRZnYvn4cCGQoS6bD+C3ANDvkh78YkYpv3BM6TRR6
 jJy+/EAGkKQp/nbHvSiO1TWF7najz5bThLbsZBtTYBpZsyRY+XHIVNx+h9Mm/Qnp+tXd
 vK5A==
X-Gm-Message-State: AOAM533RVTXbNLGWJGsTMwy5mA7HKCRn+Xpfkisht7bsYrRTjPAB2mEe
 hEZ9x8YbLyaoF47nUaWme/3Sx/O3upEa5QTCUAlgfWgyQYs=
X-Google-Smtp-Source: ABdhPJwlRMynfB9q0kDKZatV8RtoK9keyRE8IGCJ7KHpKV2E3Dm2u2/sSVwJBcZDoaopJPtxo5Earh2MQkUl1mGCd04=
X-Received: by 2002:a17:90b:94c:: with SMTP id
 dw12mr9798960pjb.214.1597607919824; 
 Sun, 16 Aug 2020 12:58:39 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>
Date: Sun, 16 Aug 2020 22:58:28 +0300
Message-ID: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
Subject: [PATCH] fixed proc myself (linux user) for musl
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008d337b05ad04143a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-pj1-x1043.google.com
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
X-Mailman-Approved-At: Sun, 16 Aug 2020 17:08:20 -0400
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

--0000000000008d337b05ad04143a
Content-Type: text/plain; charset="UTF-8"

From: Andrew Aladjev <aladjev.andrew@gmail.com>
Date: Sun, 16 Aug 2020 22:50:13 +0300
Subject: [PATCH] fixed proc myself (linux user) for musl
Buglink: https://bugs.gentoo.org/587230
Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
---
 linux-user/Makefile.objs  |  5 +-
 linux-user/elfload.c      |  7 ++-
 linux-user/exit.c         |  7 ++-
 linux-user/main.c         |  2 +-
 linux-user/qemu.h         |  1 +
 linux-user/syscall.c      | 85 +++++++++++++---------------------
 linux-user/syscall_proc.c | 96 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_proc.h |  8 ++++
 8 files changed, 150 insertions(+), 61 deletions(-)
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
index 05f03919ff..483a735c1a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -122,6 +122,7 @@
 #include "qapi/error.h"
 #include "fd-trans.h"
 #include "tcg/tcg.h"
+#include "syscall_proc.h"

 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -1104,7 +1105,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong
target_rlim)
 {
     abi_ulong target_rlim_swap;
     rlim_t result;
-
+
     target_rlim_swap = tswapal(target_rlim);
     if (target_rlim_swap == TARGET_RLIM_INFINITY)
         return RLIM_INFINITY;
@@ -1112,7 +1113,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong
target_rlim)
     result = target_rlim_swap;
     if (target_rlim_swap != (rlim_t)result)
         return RLIM_INFINITY;
-
+
     return result;
 }
 #endif
@@ -1122,13 +1123,13 @@ static inline abi_ulong host_to_target_rlim(rlim_t
rlim)
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
@@ -1615,9 +1616,9 @@ static inline abi_long target_to_host_cmsg(struct
msghdr *msgh,
     abi_ulong target_cmsg_addr;
     struct target_cmsghdr *target_cmsg, *target_cmsg_start;
     socklen_t space = 0;
-
+
     msg_controllen = tswapal(target_msgh->msg_controllen);
-    if (msg_controllen < sizeof (struct target_cmsghdr))
+    if (msg_controllen < sizeof (struct target_cmsghdr))
         goto the_end;
     target_cmsg_addr = tswapal(target_msgh->msg_control);
     target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr, msg_controllen,
1);
@@ -1703,7 +1704,7 @@ static inline abi_long host_to_target_cmsg(struct
target_msghdr *target_msgh,
     socklen_t space = 0;

     msg_controllen = tswapal(target_msgh->msg_controllen);
-    if (msg_controllen < sizeof (struct target_cmsghdr))
+    if (msg_controllen < sizeof (struct target_cmsghdr))
         goto the_end;
     target_cmsg_addr = tswapal(target_msgh->msg_control);
     target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr,
msg_controllen, 0);
@@ -5750,7 +5751,7 @@ abi_long do_set_thread_area(CPUX86State *env,
abi_ulong ptr)
     }
     unlock_user_struct(target_ldt_info, ptr, 1);

-    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
+    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
         ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
            return -TARGET_EINVAL;
     seg_32bit = ldt_info.flags & 1;
@@ -5828,7 +5829,7 @@ static abi_long do_get_thread_area(CPUX86State *env,
abi_ulong ptr)
     lp = (uint32_t *)(gdt_table + idx);
     entry_1 = tswap32(lp[0]);
     entry_2 = tswap32(lp[1]);
-
+
     read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
     contents = (entry_2 >> 10) & 3;
     seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
@@ -5844,8 +5845,8 @@ static abi_long do_get_thread_area(CPUX86State *env,
abi_ulong ptr)
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
@@ -7728,8 +7696,17 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
         return ret;
 #endif
     case TARGET_NR_close:
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
+        {
+            int fd = arg1;
+            if (fd == execfd) {
+                // We don't need to close execfd.
+                // It will be closed on qemu exit.
+                return 0;
+            }
+
+            fd_trans_unregister(fd);
+            return get_errno(close(fd));
+        }

     case TARGET_NR_brk:
         return do_brk(arg1);
@@ -9031,7 +9008,7 @@ static abi_long do_syscall1(void *cpu_env, int num,
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
@@ -9060,7 +9037,7 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
             p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
             if (!p || !p2) {
                 ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself_exe((const char *)p)) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 ret = temp == NULL ? get_errno(-1) : strlen(real) ;
@@ -10847,7 +10824,7 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
         return get_errno(fchown(arg1, low2highuid(arg2),
low2highgid(arg3)));
 #if defined(TARGET_NR_fchownat)
     case TARGET_NR_fchownat:
-        if (!(p = lock_user_string(arg2)))
+        if (!(p = lock_user_string(arg2)))
             return -TARGET_EFAULT;
         ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
                                  low2highgid(arg4), arg5));
diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
new file mode 100644
index 0000000000..e85ca99c16
--- /dev/null
+++ b/linux-user/syscall_proc.c
@@ -0,0 +1,96 @@
+#include "qemu/osdep.h"
+#include "elf.h"
+
+#include "syscall_proc.h"
+#include "qemu.h"
+
+#define PROC "/proc/"
+#define SELF "self/"
+
+#define STARTS_WITH(path, CONSTANT) \
+  strlen(path) >= strlen(CONSTANT) && strncmp(path, CONSTANT,
strlen(CONSTANT)) == 0
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
+    if (strlen(scope_path) >= 1 && *scope_path >= '1' && *scope_path <=
'9') {
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
+int is_proc_myself_exe(const char *path)
+{
+    char *scope_path = scope_to_proc_myself(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    // Kernel creates "fd/#{number}" link after opening "exe" link.
+    // Both "exe" and "fd/#{number}" can be used by application.
+
+    // Kernel can provide infinite amount of fd numbers.
+    // Qemu is going to always return single global execfd.
+
+    // So we need to check "exe" and "fd/#{execfd}" only.
+
+    if (strcmp(scope_path, "exe") == 0) {
+        return 1;
+    }
+
+    if (STARTS_WITH(scope_path, "fd/")) {
+        scope_path += strlen("fd/");
+
+        if (strlen(scope_path) >= 1 && *scope_path >= '1' && *scope_path
<= '9') {
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

--0000000000008d337b05ad04143a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@=
gmail.com">aladjev.andrew@gmail.com</a>&gt;<br>Date: Sun, 16 Aug 2020 22:50=
:13 +0300<br>Subject: [PATCH] fixed proc myself (linux user) for musl<br>Bu=
glink: <a href=3D"https://bugs.gentoo.org/587230">https://bugs.gentoo.org/5=
87230</a><br>Signed-off-by: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.an=
drew@gmail.com">aladjev.andrew@gmail.com</a>&gt;<br>---<br>=C2=A0linux-user=
/Makefile.objs =C2=A0| =C2=A05 +-<br>=C2=A0linux-user/elfload.c =C2=A0 =C2=
=A0 =C2=A0| =C2=A07 ++-<br>=C2=A0linux-user/exit.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A07 ++-<br>=C2=A0linux-user/main.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A02 +-<br>=C2=A0linux-user/qemu.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01=
 +<br>=C2=A0linux-user/syscall.c =C2=A0 =C2=A0 =C2=A0| 85 +++++++++++++----=
-----------------<br>=C2=A0linux-user/syscall_proc.c | 96 +++++++++++++++++=
++++++++++++++++++++++<br>=C2=A0linux-user/syscall_proc.h | =C2=A08 ++++<br=
>=C2=A08 files changed, 150 insertions(+), 61 deletions(-)<br>=C2=A0create =
mode 100644 linux-user/syscall_proc.c<br>=C2=A0create mode 100644 linux-use=
r/syscall_proc.h<br><br>diff --git a/linux-user/Makefile.objs b/linux-user/=
Makefile.objs<br>index 1940910a73..ad84380738 100644<br>--- a/linux-user/Ma=
kefile.objs<br>+++ b/linux-user/Makefile.objs<br>@@ -1,7 +1,8 @@<br>=C2=A0o=
bj-y =3D main.o syscall.o strace.o mmap.o signal.o \<br>=C2=A0	elfload.o li=
nuxload.o uaccess.o uname.o \<br>-	safe-syscall.o $(TARGET_ABI_DIR)/signal.=
o \<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0$(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-=
trans.o<br>+	safe-syscall.o syscall_proc.o \<br>+	$(TARGET_ABI_DIR)/cpu_loo=
p.o $(TARGET_ABI_DIR)/signal.o \<br>+	exit.o fd-trans.o<br>=C2=A0<br>=C2=A0=
obj-$(TARGET_HAS_BFLT) +=3D flatload.o<br>=C2=A0obj-$(TARGET_I386) +=3D vm8=
6.o<br>diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>index 61=
9c054cc4..201db61d91 100644<br>--- a/linux-user/elfload.c<br>+++ b/linux-us=
er/elfload.c<br>@@ -2319,7 +2319,10 @@ exit_errmsg:<br>=C2=A0 =C2=A0 buffer=
 is sufficiently aligned to present no problems to the host<br>=C2=A0 =C2=
=A0 in accessing data at aligned offsets within the buffer.<br>=C2=A0<br>- =
=C2=A0 On return: INFO values will be filled in, as necessary or available.=
 =C2=A0*/<br>+ =C2=A0 On return: INFO values will be filled in, as necessar=
y or available.<br>+<br>+ =C2=A0 WARNING: this function won&#39;t close &qu=
ot;image_fd&quot;.<br>+*/<br>=C2=A0<br>=C2=A0static void load_elf_image(con=
st char *image_name, int image_fd,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct image=
_info *info, char **pinterp_name,<br>@@ -2576,7 +2579,6 @@ static void load=
_elf_image(const char *image_name, int image_fd,<br>=C2=A0<br>=C2=A0 =C2=A0=
 =C2=A0mmap_unlock();<br>=C2=A0<br>- =C2=A0 =C2=A0close(image_fd);<br>=C2=
=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>=C2=A0 exit_read:<br>@@ -2610,6 +2612=
,7 @@ static void load_elf_interp(const char *filename, struct image_info *=
info,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0load_elf_im=
age(filename, fd, info, NULL, bprm_buf);<br>+ =C2=A0 =C2=A0close(fd);<br>=
=C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>=C2=A0 exit_perror:<br>diff --git =
a/linux-user/exit.c b/linux-user/exit.c<br>index 1594015444..f0626fc432 100=
644<br>--- a/linux-user/exit.c<br>+++ b/linux-user/exit.c<br>@@ -28,12 +28,=
15 @@ extern void __gcov_dump(void);<br>=C2=A0<br>=C2=A0void preexit_cleanu=
p(CPUArchState *env, int code)<br>=C2=A0{<br>+ =C2=A0 =C2=A0close(execfd);<=
br>+<br>=C2=A0#ifdef CONFIG_GPROF<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_mcl=
eanup();<br>=C2=A0#endif<br>=C2=A0#ifdef CONFIG_GCOV<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__gcov_dump();<br>=C2=A0#endif<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0gdb_exit(env, code);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_plugin_atex=
it_cb();<br>+<br>+ =C2=A0 =C2=A0gdb_exit(env, code);<br>+ =C2=A0 =C2=A0qemu=
_plugin_atexit_cb();<br>=C2=A0}<br>diff --git a/linux-user/main.c b/linux-u=
ser/main.c<br>index 22578b1633..9cc6c1e6da 100644<br>--- a/linux-user/main.=
c<br>+++ b/linux-user/main.c<br>@@ -48,6 +48,7 @@<br>=C2=A0#include &quot;c=
rypto/init.h&quot;<br>=C2=A0<br>=C2=A0char *exec_path;<br>+int execfd;<br>=
=C2=A0<br>=C2=A0int singlestep;<br>=C2=A0static const char *argv0;<br>@@ -6=
28,7 +629,6 @@ int main(int argc, char **argv, char **envp)<br>=C2=A0 =C2=
=A0 =C2=A0int target_argc;<br>=C2=A0 =C2=A0 =C2=A0int i;<br>=C2=A0 =C2=A0 =
=C2=A0int ret;<br>- =C2=A0 =C2=A0int execfd;<br>=C2=A0 =C2=A0 =C2=A0int log=
_mask;<br>=C2=A0 =C2=A0 =C2=A0unsigned long max_reserved_va;<br>=C2=A0<br>d=
iff --git a/linux-user/qemu.h b/linux-user/qemu.h<br>index 792c74290f..d822=
f2b9df 100644<br>--- a/linux-user/qemu.h<br>+++ b/linux-user/qemu.h<br>@@ -=
156,6 +156,7 @@ typedef struct TaskState {<br>=C2=A0} __attribute__((aligne=
d(16))) TaskState;<br>=C2=A0<br>=C2=A0extern char *exec_path;<br>+extern in=
t execfd;<br>=C2=A0void init_task_state(TaskState *ts);<br>=C2=A0void task_=
settid(TaskState *);<br>=C2=A0void stop_all_tasks(void);<br>diff --git a/li=
nux-user/syscall.c b/linux-user/syscall.c<br>index 05f03919ff..483a735c1a 1=
00644<br>--- a/linux-user/syscall.c<br>+++ b/linux-user/syscall.c<br>@@ -12=
2,6 +122,7 @@<br>=C2=A0#include &quot;qapi/error.h&quot;<br>=C2=A0#include =
&quot;fd-trans.h&quot;<br>=C2=A0#include &quot;tcg/tcg.h&quot;<br>+#include=
 &quot;syscall_proc.h&quot;<br>=C2=A0<br>=C2=A0#ifndef CLONE_IO<br>=C2=A0#d=
efine CLONE_IO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x800=
00000 =C2=A0 =C2=A0 =C2=A0/* Clone io context */<br>@@ -1104,7 +1105,7 @@ s=
tatic inline rlim_t target_to_host_rlim(abi_ulong target_rlim)<br>=C2=A0{<b=
r>=C2=A0 =C2=A0 =C2=A0abi_ulong target_rlim_swap;<br>=C2=A0 =C2=A0 =C2=A0rl=
im_t result;<br>- =C2=A0 =C2=A0<br>+<br>=C2=A0 =C2=A0 =C2=A0target_rlim_swa=
p =3D tswapal(target_rlim);<br>=C2=A0 =C2=A0 =C2=A0if (target_rlim_swap =3D=
=3D TARGET_RLIM_INFINITY)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RLIM_=
INFINITY;<br>@@ -1112,7 +1113,7 @@ static inline rlim_t target_to_host_rlim=
(abi_ulong target_rlim)<br>=C2=A0 =C2=A0 =C2=A0result =3D target_rlim_swap;=
<br>=C2=A0 =C2=A0 =C2=A0if (target_rlim_swap !=3D (rlim_t)result)<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RLIM_INFINITY;<br>- =C2=A0 =C2=A0<br>+<b=
r>=C2=A0 =C2=A0 =C2=A0return result;<br>=C2=A0}<br>=C2=A0#endif<br>@@ -1122=
,13 +1123,13 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)<br=
>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0abi_ulong target_rlim_swap;<br>=C2=A0 =C2=
=A0 =C2=A0abi_ulong result;<br>- =C2=A0 =C2=A0<br>+<br>=C2=A0 =C2=A0 =C2=A0=
if (rlim =3D=3D RLIM_INFINITY || rlim !=3D (abi_long)rlim)<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0target_rlim_swap =3D TARGET_RLIM_INFINITY;<br>=C2=A0 =
=C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_rlim_swap =3D=
 rlim;<br>=C2=A0 =C2=A0 =C2=A0result =3D tswapal(target_rlim_swap);<br>- =
=C2=A0 =C2=A0<br>+<br>=C2=A0 =C2=A0 =C2=A0return result;<br>=C2=A0}<br>=C2=
=A0#endif<br>@@ -1615,9 +1616,9 @@ static inline abi_long target_to_host_cm=
sg(struct msghdr *msgh,<br>=C2=A0 =C2=A0 =C2=A0abi_ulong target_cmsg_addr;<=
br>=C2=A0 =C2=A0 =C2=A0struct target_cmsghdr *target_cmsg, *target_cmsg_sta=
rt;<br>=C2=A0 =C2=A0 =C2=A0socklen_t space =3D 0;<br>- =C2=A0 =C2=A0<br>+<b=
r>=C2=A0 =C2=A0 =C2=A0msg_controllen =3D tswapal(target_msgh-&gt;msg_contro=
llen);<br>- =C2=A0 =C2=A0if (msg_controllen &lt; sizeof (struct target_cmsg=
hdr)) <br>+ =C2=A0 =C2=A0if (msg_controllen &lt; sizeof (struct target_cmsg=
hdr))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto the_end;<br>=C2=A0 =C2=A0 =
=C2=A0target_cmsg_addr =3D tswapal(target_msgh-&gt;msg_control);<br>=C2=A0 =
=C2=A0 =C2=A0target_cmsg =3D lock_user(VERIFY_READ, target_cmsg_addr, msg_c=
ontrollen, 1);<br>@@ -1703,7 +1704,7 @@ static inline abi_long host_to_targ=
et_cmsg(struct target_msghdr *target_msgh,<br>=C2=A0 =C2=A0 =C2=A0socklen_t=
 space =3D 0;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0msg_controllen =3D tswapal(t=
arget_msgh-&gt;msg_controllen);<br>- =C2=A0 =C2=A0if (msg_controllen &lt; s=
izeof (struct target_cmsghdr)) <br>+ =C2=A0 =C2=A0if (msg_controllen &lt; s=
izeof (struct target_cmsghdr))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto th=
e_end;<br>=C2=A0 =C2=A0 =C2=A0target_cmsg_addr =3D tswapal(target_msgh-&gt;=
msg_control);<br>=C2=A0 =C2=A0 =C2=A0target_cmsg =3D lock_user(VERIFY_WRITE=
, target_cmsg_addr, msg_controllen, 0);<br>@@ -5750,7 +5751,7 @@ abi_long d=
o_set_thread_area(CPUX86State *env, abi_ulong ptr)<br>=C2=A0 =C2=A0 =C2=A0}=
<br>=C2=A0 =C2=A0 =C2=A0unlock_user_struct(target_ldt_info, ptr, 1);<br>=C2=
=A0<br>- =C2=A0 =C2=A0if (ldt_info.entry_number &lt; TARGET_GDT_ENTRY_TLS_M=
IN || <br>+ =C2=A0 =C2=A0if (ldt_info.entry_number &lt; TARGET_GDT_ENTRY_TL=
S_MIN ||<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ldt_info.entry_number &gt; TA=
RGET_GDT_ENTRY_TLS_MAX)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return=
 -TARGET_EINVAL;<br>=C2=A0 =C2=A0 =C2=A0seg_32bit =3D ldt_info.flags &amp; =
1;<br>@@ -5828,7 +5829,7 @@ static abi_long do_get_thread_area(CPUX86State =
*env, abi_ulong ptr)<br>=C2=A0 =C2=A0 =C2=A0lp =3D (uint32_t *)(gdt_table +=
 idx);<br>=C2=A0 =C2=A0 =C2=A0entry_1 =3D tswap32(lp[0]);<br>=C2=A0 =C2=A0 =
=C2=A0entry_2 =3D tswap32(lp[1]);<br>- =C2=A0 =C2=A0<br>+<br>=C2=A0 =C2=A0 =
=C2=A0read_exec_only =3D ((entry_2 &gt;&gt; 9) &amp; 1) ^ 1;<br>=C2=A0 =C2=
=A0 =C2=A0contents =3D (entry_2 &gt;&gt; 10) &amp; 3;<br>=C2=A0 =C2=A0 =C2=
=A0seg_not_present =3D ((entry_2 &gt;&gt; 15) &amp; 1) ^ 1;<br>@@ -5844,8 +=
5845,8 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong pt=
r)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(read_exec_only &lt;&lt; 3) | (limi=
t_in_pages &lt;&lt; 4) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(seg_not_pres=
ent &lt;&lt; 5) | (useable &lt;&lt; 6) | (lm &lt;&lt; 7);<br>=C2=A0 =C2=A0 =
=C2=A0limit =3D (entry_1 &amp; 0xffff) | (entry_2 =C2=A0&amp; 0xf0000);<br>=
- =C2=A0 =C2=A0base_addr =3D (entry_1 &gt;&gt; 16) | <br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(entry_2 &amp; 0xff000000) | <br>+ =C2=A0 =C2=A0base_addr =3D =
(entry_1 &gt;&gt; 16) |<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0(entry_2 &amp; 0xff=
000000) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((entry_2 &amp; 0xff) &lt;&l=
t; 16);<br>=C2=A0 =C2=A0 =C2=A0target_ldt_info-&gt;base_addr =3D tswapal(ba=
se_addr);<br>=C2=A0 =C2=A0 =C2=A0target_ldt_info-&gt;limit =3D tswap32(limi=
t);<br>@@ -7353,38 +7354,6 @@ static int open_self_auxv(void *cpu_env, int =
fd)<br>=C2=A0 =C2=A0 =C2=A0return 0;<br>=C2=A0}<br>=C2=A0<br>-static int is=
_proc_myself(const char *filename, const char *entry)<br>-{<br>- =C2=A0 =C2=
=A0if (!strncmp(filename, &quot;/proc/&quot;, strlen(&quot;/proc/&quot;))) =
{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0filename +=3D strlen(&quot;/proc/&quot;);=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strncmp(filename, &quot;self/&quot;, =
strlen(&quot;self/&quot;))) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0filename +=3D strlen(&quot;self/&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} else if (*filename &gt;=3D &#39;1&#39; &amp;&amp; *filename &lt;=3D &#=
39;9&#39;) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char myself[80];=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(myself, sizeof(myse=
lf), &quot;%d/&quot;, getpid());<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (!strncmp(filename, myself, strlen(myself))) {<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename +=3D strlen(myself);<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(filename, entry)) {<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>- =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0return 0;<br>-}<br>-<br>-=
#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN) || \=
<br>- =C2=A0 =C2=A0defined(TARGET_SPARC) || defined(TARGET_M68K)<br>-static=
 int is_proc(const char *filename, const char *entry)<br>-{<br>- =C2=A0 =C2=
=A0return strcmp(filename, entry) =3D=3D 0;<br>-}<br>-#endif<br>-<br>=C2=A0=
#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)<br>=
=C2=A0static int open_net_route(void *cpu_env, int fd)<br>=C2=A0{<br>@@ -74=
60,20 +7429,19 @@ static int do_openat(void *cpu_env, int dirfd, const char=
 *pathname, int flags,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;auxv&qu=
ot;, open_self_auxv, is_proc_myself },<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{ &quot;cmdline&quot;, open_self_cmdline, is_proc_myself },<br>=C2=A0#if=
 defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/net/route&quot;, open_net_route, i=
s_proc },<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;net/route&quot;, open_net=
_route, is_proc },<br>=C2=A0#endif<br>=C2=A0#if defined(TARGET_SPARC)<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/cpuinfo&quot;, open_cpuinfo, is_pr=
oc },<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;cpuinfo&quot;, open_cpuinfo, =
is_proc },<br>=C2=A0#endif<br>=C2=A0#if defined(TARGET_M68K)<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ &quot;/proc/hardware&quot;, open_hardware, is_proc },=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;hardware&quot;, open_hardware, is_=
proc },<br>=C2=A0#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, NULL, =
NULL }<br>=C2=A0 =C2=A0 =C2=A0};<br>=C2=A0<br>- =C2=A0 =C2=A0if (is_proc_my=
self(pathname, &quot;exe&quot;)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0int exec=
fd =3D qemu_getauxval(AT_EXECFD);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return ex=
ecfd ? execfd : safe_openat(dirfd, exec_path, flags, mode);<br>+ =C2=A0 =C2=
=A0if (is_proc_myself_exe(pathname)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn execfd;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0for (f=
ake_open =3D fakes; fake_open-&gt;filename; fake_open++) {<br>@@ -7728,8 +7=
696,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>=C2=A0#endif<br>=C2=
=A0 =C2=A0 =C2=A0case TARGET_NR_close:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_t=
rans_unregister(arg1);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_errno(clo=
se(arg1));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int fd =3D arg1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (fd =3D=3D execfd) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0// We don&#39;t need to close execfd.<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// It will be closed on qemu exit.=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0fd_trans_unregister(fd);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return get_errno(close(fd));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case TARGET_NR_brk:<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return do_brk(arg1);<br>@@ -9031,7 +9008,7 @@ static ab=
i_long do_syscall1(void *cpu_env, int num, abi_long arg1,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!arg3) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Short circuit this for the =
magic exe check. */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -TARGET_EINVAL;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0} else if (is_proc_myself((const char *)p, &quot;exe&quot;)) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself_exe((con=
st char *)p)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0char real[PATH_MAX], *temp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0temp =3D realpath(exec_path, real);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Return value is # of=
 bytes that we wrote to the buffer. */<br>@@ -9060,7 +9037,7 @@ static abi_=
long do_syscall1(void *cpu_env, int num, abi_long arg1,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p2 =3D lock_user(VERIFY_WRITE, arg3, arg4=
, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!p || !p2) {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -TA=
RGET_EFAULT;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_pr=
oc_myself((const char *)p, &quot;exe&quot;)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself_exe((const char *)p)) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char real[PAT=
H_MAX], *temp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0temp =3D realpath(exec_path, real);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D temp =3D=3D NULL ? get_errno(-1) =
: strlen(real) ;<br>@@ -10847,7 +10824,7 @@ static abi_long do_syscall1(voi=
d *cpu_env, int num, abi_long arg1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));<br>=C2=
=A0#if defined(TARGET_NR_fchownat)<br>=C2=A0 =C2=A0 =C2=A0case TARGET_NR_fc=
hownat:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(p =3D lock_user_string(arg2))=
) <br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(p =3D lock_user_string(arg2)))<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D get_errno(fchownat(arg1, p, low2h=
ighuid(arg3),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 low2highgid(=
arg4), arg5));<br>diff --git a/linux-user/syscall_proc.c b/linux-user/sysca=
ll_proc.c<br>new file mode 100644<br>index 0000000000..e85ca99c16<br>--- /d=
ev/null<br>+++ b/linux-user/syscall_proc.c<br>@@ -0,0 +1,96 @@<br>+#include=
 &quot;qemu/osdep.h&quot;<br>+#include &quot;elf.h&quot;<br>+<br>+#include =
&quot;syscall_proc.h&quot;<br>+#include &quot;qemu.h&quot;<br>+<br>+#define=
 PROC &quot;/proc/&quot;<br>+#define SELF &quot;self/&quot;<br>+<br>+#defin=
e STARTS_WITH(path, CONSTANT) \<br>+ =C2=A0strlen(path) &gt;=3D strlen(CONS=
TANT) &amp;&amp; strncmp(path, CONSTANT, strlen(CONSTANT)) =3D=3D 0<br>+<br=
>+static inline char *scope_to_proc(const char *path)<br>+{<br>+ =C2=A0 =C2=
=A0if (STARTS_WITH(path, PROC)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return (c=
har *)path + strlen(PROC);<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0retur=
n NULL;<br>+}<br>+<br>+static inline char *scope_to_proc_myself(const char =
*path)<br>+{<br>+ =C2=A0 =C2=A0char *scope_path =3D scope_to_proc(path);<br=
>+ =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return NULL;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (STARTS_WITH(=
scope_path, SELF)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return scope_path + st=
rlen(SELF);<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (strlen(scope_pat=
h) &gt;=3D 1 &amp;&amp; *scope_path &gt;=3D &#39;1&#39; &amp;&amp; *scope_p=
ath &lt;=3D &#39;9&#39;) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char pid_path[80=
];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(pid_path, sizeof(pid_path), &qu=
ot;%d/&quot;, getpid());<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (STARTS_WITH(sc=
ope_path, pid_path)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 scope_path + strlen(pid_path);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=
=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return NULL;<br>+}<br>+<br>+int is_proc(=
const char *path, const char *entry)<br>+{<br>+ =C2=A0 =C2=A0char *scope_pa=
th =3D scope_to_proc(path);<br>+ =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =
=C2=A0 =C2=A0return strcmp(scope_path, entry) =3D=3D 0;<br>+}<br>+<br>+int =
is_proc_myself(const char *path, const char *entry)<br>+{<br>+ =C2=A0 =C2=
=A0char *scope_path =3D scope_to_proc_myself(path);<br>+ =C2=A0 =C2=A0if (s=
cope_path =3D=3D NULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=
=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return strcmp(scope_path, entry) =3D=3D =
0;<br>+}<br>+<br>+int is_proc_myself_exe(const char *path)<br>+{<br>+ =C2=
=A0 =C2=A0char *scope_path =3D scope_to_proc_myself(path);<br>+ =C2=A0 =C2=
=A0if (scope_path =3D=3D NULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<=
br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0// Kernel creates &quot;fd/#{num=
ber}&quot; link after opening &quot;exe&quot; link.<br>+ =C2=A0 =C2=A0// Bo=
th &quot;exe&quot; and &quot;fd/#{number}&quot; can be used by application.=
<br>+<br>+ =C2=A0 =C2=A0// Kernel can provide infinite amount of fd numbers=
.<br>+ =C2=A0 =C2=A0// Qemu is going to always return single global execfd.=
<br>+<br>+ =C2=A0 =C2=A0// So we need to check &quot;exe&quot; and &quot;fd=
/#{execfd}&quot; only.<br>+<br>+ =C2=A0 =C2=A0if (strcmp(scope_path, &quot;=
exe&quot;) =3D=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>+ =C2=
=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (STARTS_WITH(scope_path, &quot;fd/&qu=
ot;)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0scope_path +=3D strlen(&quot;fd/&qu=
ot;);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strlen(scope_path) &gt;=3D 1=
 &amp;&amp; *scope_path &gt;=3D &#39;1&#39; &amp;&amp; *scope_path &lt;=3D =
&#39;9&#39;) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char execfd_pa=
th[80];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(execfd_path,=
 sizeof(execfd_path), &quot;%d&quot;, execfd);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (strcmp(scope_path, execfd_path) =3D=3D 0) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return 0;<br>+}<br>diff --git a/l=
inux-user/syscall_proc.h b/linux-user/syscall_proc.h<br>new file mode 10064=
4<br>index 0000000000..f0e59c0e96<br>--- /dev/null<br>+++ b/linux-user/sysc=
all_proc.h<br>@@ -0,0 +1,8 @@<br>+#ifndef SYSCALL_PROC_H<br>+#define SYSCAL=
L_PROC_H<br>+<br>+int is_proc(const char *path, const char *entry);<br>+int=
 is_proc_myself(const char *path, const char *entry);<br>+int is_proc_mysel=
f_exe(const char *path);<br>+<br>+#endif<br>-- <br>2.26.2<br><br></div>

--0000000000008d337b05ad04143a--

