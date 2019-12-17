Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985AAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E2C20684
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOa34wib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihH9I-0003rp-9g
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihH6H-0000zU-7u
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihH6D-0006zV-C2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihH6D-0006ur-4K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id j42so8108093wrj.12
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=laOZi9ZVqXfm59iac6wAKRH/U7LCmfU8oiWAikwr/M8=;
 b=tOa34wibhS08+tFPFnoNxoWR6sIIqqmoRlQa63wBrJ7o4jeZttCTAPCESzlAlnyFQH
 ibLi9vf4jVhowgNnsM1Cqu/1Xk2yt8MuCbUQASMllQi5UDFv4VC56rJWupt5X/pi0m67
 3SRucDOJZcKx+ZYllmKhI558L1CBYKW4IX2Mx5R56amYR1Zz8ATWwY+MCi946aQwT5o0
 EAhrX0kuaCvpPVzinlgPTC4FQIDMpkt1rTlfL1AzMjUa0oNOJaO9GQPgjf9zFcCnfRLu
 atRVnV/NZmv4Z3A4baD29laUOi5L49off8Z9AHg0aPsL4jrevpfNQZfFXawDitYoeRbt
 0+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=laOZi9ZVqXfm59iac6wAKRH/U7LCmfU8oiWAikwr/M8=;
 b=sI737qRHWNMW4L+Wuw+P4VsrrnTGVzCHzoSOl11oNcNSfNb0u+zhGaEZ7cNeCCiPP/
 bgwY/rv5V8hMtm5GKjb1J76Y9/QXce9ts2tyRnWuGc06fo/jLwTBMQG7TB9HJectKYeU
 Jdv7cku1LUn6FUUS+oyG6AM8lZ+KOXC5BO4pmzLop98sGy/2ADOqhLtGmjzLk6oU8hgE
 qH3Zelch2Bz4IbZz2KRSdMOlyILOLfbRtSOVDxxUnsiwpICK9lMWa//b+VBTar5B0yok
 4dMf6Ke7ozB6kvltylwgu78+v2Xjm5ZX4Kww0hdtplHgGnRacCAcfDH4KjzOK7fO9uzQ
 tYCw==
X-Gm-Message-State: APjAAAX6ua0Z/5r12qR68Sb8Rk8OWZ8le0Jjdl8UyMSjEMS2ItvzeLJx
 CMPyLEJmATMfkFXshtCXpozbTqAA
X-Google-Smtp-Source: APXvYqzGcfXtS8c98KgdU9MAQ9vzXSt5o7nRXOGvwPxjKuSFP3Gwz7oZ/DW4dyX1HKStSG7yGum8gg==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr39724988wrh.121.1576605448982; 
 Tue, 17 Dec 2019 09:57:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q8sm3649573wmq.3.2019.12.17.09.57.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 09:57:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/62] migration-test: Use a struct for test_migrate_start
 parameters
Date: Tue, 17 Dec 2019 18:57:24 +0100
Message-Id: <1576605445-28158-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
References: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

It has two bools and two strings, it is very difficult to remember
which does what.  And it makes very difficult to add new parameters as
we need to modify all the callers.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 118 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 40 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 6c7c416..97dd1dc 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -544,10 +544,31 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
     qtest_qmp_eventwait(to, "RESUME");
 }
 
+typedef struct {
+    bool hide_stderr;
+    bool use_shmem;
+    char *opts_source;
+    char *opts_target;
+} MigrateStart;
+
+static MigrateStart *migrate_start_new(void)
+{
+    MigrateStart *args = g_new0(MigrateStart, 1);
+
+    args->opts_source = g_strdup("");
+    args->opts_target = g_strdup("");
+    return args;
+}
+
+static void migrate_start_destroy(MigrateStart *args)
+{
+    g_free(args->opts_source);
+    g_free(args->opts_target);
+    g_free(args);
+}
+
 static int test_migrate_start(QTestState **from, QTestState **to,
-                               const char *uri, bool hide_stderr,
-                               bool use_shmem, const char *opts_src,
-                               const char *opts_dst)
+                              const char *uri, MigrateStart *args)
 {
     gchar *arch_source, *arch_target;
     gchar *cmd_source, *cmd_target;
@@ -560,10 +581,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *machine_args;
     const char *memory_size;
 
-    opts_src = opts_src ? opts_src : "";
-    opts_dst = opts_dst ? opts_dst : "";
-
-    if (use_shmem) {
+    if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
             g_test_skip("/dev/shm is not supported");
             return -1;
@@ -623,13 +641,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     g_free(bootpath);
 
-    if (hide_stderr) {
+    if (args->hide_stderr) {
         ignore_stderr = "2>/dev/null";
     } else {
         ignore_stderr = "";
     }
 
-    if (use_shmem) {
+    if (args->use_shmem) {
         shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
         shmem_opts = g_strdup_printf(
             "-object memory-backend-file,id=mem0,size=%s"
@@ -647,7 +665,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs,
-                                 arch_source, shmem_opts, opts_src,
+                                 arch_source, shmem_opts, args->opts_source,
                                  ignore_stderr);
     g_free(arch_source);
     *from = qtest_init(cmd_source);
@@ -661,8 +679,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs, uri,
-                                 arch_target, shmem_opts, opts_dst,
-                                 ignore_stderr);
+                                 arch_target, shmem_opts,
+                                 args->opts_target, ignore_stderr);
     g_free(arch_target);
     *to = qtest_init(cmd_target);
     g_free(cmd_target);
@@ -672,11 +690,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid becase QEMU has already opened this file
      */
-    if (use_shmem) {
+    if (args->use_shmem) {
         unlink(shmem_path);
         g_free(shmem_path);
     }
 
+    migrate_start_destroy(args);
     return 0;
 }
 
@@ -762,13 +781,13 @@ static void test_deprecated(void)
 }
 
 static int migrate_postcopy_prepare(QTestState **from_ptr,
-                                     QTestState **to_ptr,
-                                     bool hide_error)
+                                    QTestState **to_ptr,
+                                    MigrateStart *args)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, hide_error, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return -1;
     }
 
@@ -813,9 +832,10 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to)
 
 static void test_postcopy(void)
 {
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to, false)) {
+    if (migrate_postcopy_prepare(&from, &to, args)) {
         return;
     }
     migrate_postcopy_start(from, to);
@@ -824,10 +844,13 @@ static void test_postcopy(void)
 
 static void test_postcopy_recovery(void)
 {
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
     char *uri;
 
-    if (migrate_postcopy_prepare(&from, &to, true)) {
+    args->hide_stderr = true;
+
+    if (migrate_postcopy_prepare(&from, &to, args)) {
         return;
     }
 
@@ -910,9 +933,12 @@ static void wait_for_migration_fail(QTestState *from, bool allow_active)
 
 static void test_baddest(void)
 {
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "tcp:0:0", true, false, NULL, NULL)) {
+    args->hide_stderr = true;
+
+    if (test_migrate_start(&from, &to, "tcp:0:0", args)) {
         return;
     }
     migrate(from, "tcp:0:0", "{}");
@@ -923,9 +949,10 @@ static void test_baddest(void)
 static void test_precopy_unix(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
 
@@ -1001,9 +1028,10 @@ static void test_ignore_shared(void)
 
 static void test_xbzrle(const char *uri)
 {
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
 
@@ -1052,11 +1080,11 @@ static void test_xbzrle_unix(void)
 
 static void test_precopy_tcp(void)
 {
+    MigrateStart *args = migrate_start_new();
     char *uri;
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false,
-                           NULL, NULL)) {
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", args)) {
         return;
     }
 
@@ -1096,13 +1124,14 @@ static void test_precopy_tcp(void)
 
 static void test_migrate_fd_proto(void)
 {
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
     int ret;
     int pair[2];
     QDict *rsp;
     const char *error_desc;
 
-    if (test_migrate_start(&from, &to, "defer", false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, "defer", args)) {
         return;
     }
 
@@ -1178,15 +1207,12 @@ static void test_migrate_fd_proto(void)
     test_migrate_end(from, to, true);
 }
 
-static void do_test_validate_uuid(const char *uuid_arg_src,
-                                  const char *uuid_arg_dst,
-                                  bool should_fail, bool hide_stderr)
+static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, hide_stderr, false,
-                           uuid_arg_src, uuid_arg_dst)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
 
@@ -1216,33 +1242,45 @@ static void do_test_validate_uuid(const char *uuid_arg_src,
 
 static void test_validate_uuid(void)
 {
-    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
-                          "-uuid 11111111-1111-1111-1111-111111111111",
-                          false, false);
+    MigrateStart *args = migrate_start_new();
+
+    args->opts_source = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
+    args->opts_target = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
+    do_test_validate_uuid(args, false);
 }
 
 static void test_validate_uuid_error(void)
 {
-    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
-                          "-uuid 22222222-2222-2222-2222-222222222222",
-                          true, true);
+    MigrateStart *args = migrate_start_new();
+
+    args->opts_source = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
+    args->opts_target = g_strdup("-uuid 22222222-2222-2222-2222-222222222222");
+    args->hide_stderr = true;
+    do_test_validate_uuid(args, true);
 }
 
 static void test_validate_uuid_src_not_set(void)
 {
-    do_test_validate_uuid(NULL, "-uuid 11111111-1111-1111-1111-111111111111",
-                          false, true);
+    MigrateStart *args = migrate_start_new();
+
+    args->opts_target = g_strdup("-uuid 22222222-2222-2222-2222-222222222222");
+    args->hide_stderr = true;
+    do_test_validate_uuid(args, false);
 }
 
 static void test_validate_uuid_dst_not_set(void)
 {
-    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111", NULL,
-                          false, true);
+    MigrateStart *args = migrate_start_new();
+
+    args->opts_source = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
+    args->hide_stderr = true;
+    do_test_validate_uuid(args, false);
 }
 
 static void test_migrate_auto_converge(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateStart *args = migrate_start_new();
     QTestState *from, *to;
     int64_t remaining, percentage;
 
@@ -1261,7 +1299,7 @@ static void test_migrate_auto_converge(void)
      */
     const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
 
-    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
 
-- 
1.8.3.1



