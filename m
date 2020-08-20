Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27306207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj6VCQaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27306207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oXc-0002K1-Dj
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k8oWe-0001Au-OE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:39:00 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k8oWb-0002rM-9p
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:38:56 -0400
Received: by mail-lj1-x241.google.com with SMTP id v9so3016716ljk.6
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DC6q91k50nAXhhByYQexK4Z1sDogJMD7wXja4A2RFXU=;
 b=Jj6VCQaByiT1RqPlT9v3LXNAJFsfM0NA31VEV/PXLVSUe/78zaFW8KyCGNVOI+Zkfw
 RYrT5JJjCLZx2k2wrG9h1hAQe8Ma1q8D1ACL3n9nN9ZUZfOvxcdcDhQUI79qCAw9C+/+
 MjEgrJt2reFKGeAWanWm2ZFFoXzZ+AJbpSGfcWpI+qLPM/PgbLa+7lLWLrnueJelb6O0
 Ik2R5s/Hpe35EbhaDtVHQBstLGytwCe6IZFCFVpWL1KVFUQWt1S4fMEGKM8nxm9Pz6IK
 +lJ06W5KRySPeas41lMinSLtd4sCybdcI13A4L5fUpnUV716EQs7gUXq9sJsEgTiKM5C
 C/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DC6q91k50nAXhhByYQexK4Z1sDogJMD7wXja4A2RFXU=;
 b=TBcgjQwmqzJWQwDuhV652McMKZtA95BDA+R2WCWFB0lnuFP4ifEH8Q1V3vNKS+Uf3j
 0MxiDp+ivqSwwFzK5IZjdANQwnxodX8irrG/LY9sCeVwCq/JIP1pbJBAcB1ORTIzwk0X
 zs3vR1DOsg2MURns3VWdqVmj129dtus6BrtMoOQDUER+T5XPruiZdFjjcrzdAchUpVNS
 OgOkXVuQ2s1f0neKd0pgvJ+vQsMK8rAPVxy1+bfpELDv/ot6/y0vmty7UGQYzkLHppEq
 DLUUpv8C6kPcs/1kpS9J6L6vEyX1Z+F74rntjJXprfusoKVh4wVD/fu7IInZbx8PPBbE
 hfZg==
X-Gm-Message-State: AOAM5327GIRgxqVRQ0tTN1lifB4hxeUHnsxxnOPivQOM0/6ZefgkwLsa
 cLkidMhLG4eYAS3VZ/XpbEFXe5O90qHiWg==
X-Google-Smtp-Source: ABdhPJwOLJzdJVLTUrpAmpFqsOzhsuu124GVWi6CqJtfr63N2sp9UdUeCuM+GSSxQ/MqbDjgaDEZ0Q==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr2088486ljj.415.1597945130297; 
 Thu, 20 Aug 2020 10:38:50 -0700 (PDT)
Received: from mini.lan (ns331963.ip-37-187-122.eu. [37.187.122.190])
 by smtp.gmail.com with ESMTPSA id g19sm566930ljn.91.2020.08.20.10.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:38:49 -0700 (PDT)
From: Andrew Aladjev <aladjev.andrew@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux user: fixed proc myself execfd behaviour,
 added tests for proc myself fd
Date: Thu, 20 Aug 2020 20:38:38 +0300
Message-Id: <20200820173839.20184-1-aladjev.andrew@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Andrew Aladjev <aladjev.andrew@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
---
 linux-user/elfload.c             |  3 +-
 linux-user/main.c                | 11 ++++-
 linux-user/syscall.c             |  7 ++-
 tests/tcg/multiarch/linux-test.c | 85 ++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fe9dfe795d..353094da34 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2363,6 +2363,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
 
    IMAGE_NAME is the filename of the image, to use in error messages.
    IMAGE_FD is the open file descriptor for the image.
+   WARNING : IMAGE_FD won't be closed.
 
    BPRM_BUF is a copy of the beginning of the file; this of course
    contains the elf file header at offset 0.  It is assumed that this
@@ -2632,7 +2633,6 @@ static void load_elf_image(const char *image_name, int image_fd,
 
     mmap_unlock();
 
-    close(image_fd);
     return;
 
  exit_read:
@@ -2666,6 +2666,7 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     }
 
     load_elf_image(filename, fd, info, NULL, bprm_buf);
+    close(fd);
     return;
 
  exit_perror:
diff --git a/linux-user/main.c b/linux-user/main.c
index 75c9785157..29b61d4a09 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -629,6 +629,7 @@ int main(int argc, char **argv, char **envp)
     int target_argc;
     int i;
     int ret;
+    int at_execfd;
     int execfd;
     int log_mask;
     unsigned long max_reserved_va;
@@ -690,13 +691,15 @@ int main(int argc, char **argv, char **envp)
 
     init_qemu_uname_release();
 
-    execfd = qemu_getauxval(AT_EXECFD);
-    if (execfd == 0) {
+    at_execfd = qemu_getauxval(AT_EXECFD);
+    if (at_execfd == 0) {
         execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
             printf("Error while loading %s: %s\n", exec_path, strerror(errno));
             _exit(EXIT_FAILURE);
         }
+    } else {
+        execfd = at_execfd;
     }
 
     if (cpu_model == NULL) {
@@ -811,6 +814,10 @@ int main(int argc, char **argv, char **envp)
 
     ret = loader_exec(execfd, exec_path, target_argv, target_environ, regs,
         info, &bprm);
+    /* We shouldn't close at_execfd, it may be used later. */
+    if (execfd != at_execfd) {
+        close(execfd);
+    }
     if (ret != 0) {
         printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
         _exit(EXIT_FAILURE);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc25279..3d8c57522d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7613,8 +7613,11 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
     };
 
     if (is_proc_myself(pathname, "exe")) {
-        int execfd = qemu_getauxval(AT_EXECFD);
-        return execfd ? execfd : safe_openat(dirfd, exec_path, flags, mode);
+        /*
+         * We can't use AT_EXECFD here.
+         * User can close provided fd and another user will receive closed fd.
+         */
+        return safe_openat(dirfd, exec_path, flags, mode);
     }
 
     for (fake_open = fakes; fake_open->filename; fake_open++) {
diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 8a7c15cd31..bd370d973e 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -517,6 +517,89 @@ static void test_shm(void)
     chk_error(shmdt(ptr));
 }
 
+static void test_proc_myself_file(void)
+{
+    int fd1, fd2;
+    char link1[PATH_MAX], link2[PATH_MAX];
+    char buf1[PATH_MAX], buf2[PATH_MAX];
+    int buf1_length, buf2_length;
+
+    /* We can open any file that will always exist. */
+    const char *file_path = "/proc/self/comm";
+
+    char file_realpath[PATH_MAX];
+    if (realpath(file_path, file_realpath) == NULL) {
+        error("proc myself: invalid file");
+    }
+
+    fd1 = chk_error(open(file_path, O_RDONLY));
+    sprintf(link1, "/proc/self/fd/%d", fd1);
+
+    /* Lets try to open same file by first link. */
+    fd2 = chk_error(open(link1, O_RDONLY));
+    sprintf(link2, "/proc/self/fd/%d", fd2);
+
+    /* Two links should point to the same file path. */
+    buf1_length = chk_error(readlink(link1, buf1, PATH_MAX));
+    if (strlen(file_realpath) != buf1_length ||
+        strncmp(file_realpath, buf1, buf1_length) != 0) {
+        error("proc myself: invalid link");
+    }
+    buf2_length = chk_error(readlink(link2, buf2, PATH_MAX));
+    if (strlen(file_realpath) != buf2_length ||
+        strncmp(file_realpath, buf2, buf2_length) != 0) {
+        error("proc myself: invalid link");
+    }
+
+    /* We should be able to read same data from each fd. */
+    buf1_length = chk_error(read(fd1, buf1, PATH_MAX));
+    buf2_length = chk_error(read(fd2, buf2, PATH_MAX));
+    if (buf1_length == 0 || buf1_length != buf2_length ||
+        strncmp(buf1, buf2, buf2_length) != 0) {
+        error("proc myself: invalid file content");
+    }
+
+    chk_error(close(fd2));
+    chk_error(close(fd1));
+}
+
+static void test_proc_myself_exe(void)
+{
+    int fd1, fd2;
+    char link1[PATH_MAX], link2[PATH_MAX];
+    char buf1[PATH_MAX], buf2[PATH_MAX];
+    int buf1_length, buf2_length;
+
+    const char *exe_path = "/proc/self/exe";
+
+    char exe_realpath[PATH_MAX];
+    if (realpath(exe_path, exe_realpath) == NULL) {
+        error("proc myself: invalid exe");
+    }
+
+    fd1 = chk_error(open(exe_path, O_RDONLY));
+    sprintf(link1, "/proc/self/fd/%d", fd1);
+
+    /* Lets try to open link once again. */
+    fd2 = chk_error(open(link1, O_RDONLY));
+    sprintf(link2, "/proc/self/fd/%d", fd2);
+
+    /* Two links should point to the same exe path. */
+    buf1_length = chk_error(readlink(link1, buf1, PATH_MAX));
+    if (strlen(exe_realpath) != buf1_length ||
+        strncmp(exe_realpath, buf1, buf1_length) != 0) {
+        error("proc myself: invalid link");
+    }
+    buf2_length = chk_error(readlink(link2, buf2, PATH_MAX));
+    if (strlen(exe_realpath) != buf2_length ||
+        strncmp(exe_realpath, buf2, buf2_length) != 0) {
+        error("proc myself: invalid link");
+    }
+
+    chk_error(close(fd2));
+    chk_error(close(fd1));
+}
+
 int main(int argc, char **argv)
 {
     test_file();
@@ -532,5 +615,7 @@ int main(int argc, char **argv)
 
     test_signal();
     test_shm();
+    test_proc_myself_file();
+    test_proc_myself_exe();
     return 0;
 }
-- 
2.26.2


