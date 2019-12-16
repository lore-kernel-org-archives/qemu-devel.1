Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F79C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626552067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abncX6BJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626552067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtGr-0006m1-17
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEu-0004fG-VL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEt-0006vN-FJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEt-0006tJ-89
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id d16so8035154wre.10
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dZej0VRwucx2cd/XKW6yBntfdbCcru8xsSOweG22Ze0=;
 b=abncX6BJexU3RZHo5jGnf95aocDIwNmCB9MjGZaK2RXz7vg9HuBLgKxKlYc1KI4Gk0
 ZAgNv1tf9yjHwb1rlZsLsNTvmgUnjyr10Cj5fl9lZ6GL7M5rxYclwEAbxor/2q5KtITT
 ge24YRhZ5Imu28BI6acHS8OUhF2GdN4yweDK3STsdBH5Wpf44GAspXTBcdaHN6k6Z5bV
 ZwFAABRxyCBP//7oh3GWOzSXhl9EzKqf2Qpdjm/Jw4m8oImU3hPqm4MzYi7HMJX/H/GC
 KWKUVaj5rQhNca1nsq3JW063zuMS5p9ydLXwxUX8ZGgLetkjNg+KAKHo6ftTcMJHP6qy
 WoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=dZej0VRwucx2cd/XKW6yBntfdbCcru8xsSOweG22Ze0=;
 b=VkE6Ke4PITfSZbw0a+wM5JJT1MXCuSUICcCftYWqlALIYWjDaRUkZEe+qO12o5f6Bt
 vzbpEaiO5WILFLlFY869Pv1e7ZvPaWOO5uqu3RmFMW4bs+7Q5hy8ER7nB1SKc+sc9IoZ
 tjgxObKUYEsjAmwgf6mOAY3R0Lc+DWArGrM3CoFNS+IMhKjZ0ZXjrulQcbHxxaFPc0tC
 rVs243e5b95TiKM4BBqEeJWSHGN9s2RNbIoKok/jJArgo7rt4ZITS79QnLW40K9Tgg7G
 Dh8L2F3i+6GuSZsiF+AXy1lie+A7wxUUovCO0NeBe840uN/dvS6FLOeVL+hwYEOW/Z18
 mdfA==
X-Gm-Message-State: APjAAAUUkjTsytflprX9oOrwR6GwO5X3n4Fie6XYOJcpgMcnG9tqqBSj
 jTWoOPhFJgsYkj+thbdUYgkIF4MF
X-Google-Smtp-Source: APXvYqw42XUEZtdZU08C7NL0Icu9eI5GEyEyetRBKvzsy0Xo0uwttd2aAK2Nq0NFduR9Waj1W1W24Q==
X-Received: by 2002:a05:6000:1052:: with SMTP id
 c18mr31210745wrx.268.1576513733937; 
 Mon, 16 Dec 2019 08:28:53 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/62] migration-test: Move shmem handling to common commandline
Date: Mon, 16 Dec 2019 17:27:50 +0100
Message-Id: <1576513726-53700-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 76 ++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 18857f0..85c98f0 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -380,13 +380,6 @@ static void cleanup(const char *filename)
     g_free(path);
 }
 
-static char *get_shmem_opts(const char *mem_size, const char *shmem_path)
-{
-    return g_strdup_printf("-object memory-backend-file,id=mem0,size=%s"
-                           ",mem-path=%s,share=on -numa node,memdev=mem0",
-                           mem_size, shmem_path);
-}
-
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
     switch (addr->type) {
@@ -560,8 +553,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     gchar *cmd_source, *cmd_target;
     const gchar *ignore_stderr;
     char *bootpath = NULL;
-    char *extra_opts = NULL;
-    char *shmem_path = NULL;
+    char *shmem_opts;
+    char *shmem_path;
     const char *arch = qtest_get_arch();
     const char *machine_type;
     const char *machine_args;
@@ -575,7 +568,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
             g_test_skip("/dev/shm is not supported");
             return -1;
         }
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
     }
 
     got_stop = false;
@@ -587,18 +579,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf(" -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=%s,format=raw %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  " -drive file=%s,format=raw",
+                                  tmpfs, bootpath);
         cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
-                                  " -incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -606,36 +595,31 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf(" -name source,debug-threads=on"
-                                  " -serial file:%s/src_serial -bios %s %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  " -serial file:%s/src_serial -bios %s",
+                                  tmpfs, bootpath);
         cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial -bios %s"
-                                  " -incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
         memory_size = "256M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf("-nodefaults"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until' %s", tmpfs, end_address,
-                                  start_address, extra_opts ? extra_opts : "");
+                                  "until'", tmpfs, end_address,
+                                  start_address);
         cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s %s",
-                                  tmpfs, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, uri);
 
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
@@ -644,18 +628,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "virt,";
         machine_args = "gic-version=max";
         memory_size = "150M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf("-name vmsource,debug-threads=on -cpu max "
                                   "-serial file:%s/src_serial "
-                                  "-kernel %s %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  "-kernel %s",
+                                  tmpfs, bootpath);
         cmd_dst = g_strdup_printf("-name vmdest,debug-threads=on -cpu max "
                                   "-serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  "-incoming %s",
+                                  tmpfs, bootpath, uri);
 
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -666,7 +647,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     g_free(bootpath);
-    g_free(extra_opts);
 
     if (hide_stderr) {
         ignore_stderr = "2>/dev/null";
@@ -674,26 +654,38 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
+    if (use_shmem) {
+        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
+        shmem_opts = g_strdup_printf(
+            "-object memory-backend-file,id=mem0,size=%s"
+            ",mem-path=%s,share=on -numa node,memdev=mem0",
+            memory_size, shmem_path);
+    } else {
+        shmem_path = NULL;
+        shmem_opts = g_strdup("");
+    }
+
     cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-m %s "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size,
-                                 cmd_src, opts_src, ignore_stderr);
+                                 cmd_src, shmem_opts, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
     cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-m %s "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size,
-                                 cmd_dst, opts_dst, ignore_stderr);
+                                 cmd_dst, shmem_opts, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
     g_free(cmd_target);
 
+    g_free(shmem_opts);
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid becase QEMU has already opened this file
-- 
1.8.3.1



