Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7077C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618FB206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkqWDkei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618FB206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtNj-0006xn-Vk
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEz-0004nA-PA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEx-00074j-Ut
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:01 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEx-00072j-NE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id u2so7395786wmc.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kuFJ06m8230IZLOlFpe0Wx+0CVcGflWlaDOeFRs7UF0=;
 b=SkqWDkeijfEb6ps7+R8O9MJUMHvRuXde+JS1CH+Z38vUgUfGh3Q/yVqVGQHVNkK5/X
 +vXyGp6wvfmfkOtcbEaO9d3iQhW6dgMbr6N0yMl66UNcxN9k5ML9ORtB/+viBuFaoHFT
 Jw4vddOp0vTGnlIaV9V2dojQ76y3xe8BkY6HA2KYE09KOHQ/iI0BKyG8jjZG0RzmoWZ6
 KX0jlf0BgPPEL89JOGMaTfq3X+ec0HgLH8Kjt2Qj+HGXbCBFgrQATd8uY7y7beC38U0c
 pAyXUZIKmwMTmQVPfUW+bCIS0ZRpeY4HXA+4BLn2MvhIljQ09SDE7C3y6XTvGiEdmIGG
 WtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=kuFJ06m8230IZLOlFpe0Wx+0CVcGflWlaDOeFRs7UF0=;
 b=UXndmUxvTeqUmbRluvwKecRh4nv/F8oSGa1puPTF8B0GcJSHBb6VrG0lftPNRyoTGG
 mbJ8UL5U8tlMQBXR5/n32E1zlJzwwWfELcN7oGkcqp15v0JK0G63UZycNzisK8A4dWp/
 tuV+3G8H+YYobQ8RWQxwXy1q/J7RDd8ucLbOesO8U5FC+LoTYJzh6YQZGJWvTL0vJ7Yl
 j90UFdi02XMHgC/45eXa6a9sYeQ9F+LRB4W3pOkruC9KoG5HaoIPRzrt+jMmOBKCoAa2
 zLge+mEg+0vguEJUOpmcN2fVpj0wx3q3A/DWfMyIjBLQPp491FX+FfInT74zb1Y0qzM2
 Q5YQ==
X-Gm-Message-State: APjAAAXkW6IQc+Cqv/79byJUw7VIPI9BRwzKr4qLg73domj3T3+yNtHF
 O9eQUCUKLo+cOX1cfr0ritgsmFIu
X-Google-Smtp-Source: APXvYqzeBVlGS9WBvuFAFrRVpZyofewMDAQtMqDGWPF0zC/XJaHDZAzBhzMlunSh5QCblM37YbfH4Q==
X-Received: by 2002:a1c:3c45:: with SMTP id j66mr12982765wma.2.1576513738436; 
 Mon, 16 Dec 2019 08:28:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/62] migration-test: Use a struct for test_migrate_start
 parameters
Date: Mon, 16 Dec 2019 17:27:55 +0100
Message-Id: <1576513726-53700-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
index 6c7c416..4a19211 100644
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
@@ -661,18 +679,19 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
 
+    migrate_start_destroy(args);
     g_free(shmem_opts);
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid becase QEMU has already opened this file
      */
-    if (use_shmem) {
+    if (args->use_shmem) {
         unlink(shmem_path);
         g_free(shmem_path);
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



