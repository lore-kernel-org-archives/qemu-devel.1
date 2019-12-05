Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB15C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3D3206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3D3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictDU-00034q-Kw
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsw7-0000FH-6J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsw4-0005va-JK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:20:58 -0500
Received: from relay.sw.ru ([185.231.240.75]:43528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icsw0-0005a4-Fr
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:20:53 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icsvc-00007O-RZ; Thu, 05 Dec 2019 18:20:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/21] qga: rename Error ** parameter to more common errp
Date: Thu,  5 Dec 2019 18:20:10 +0300
Message-Id: <20191205152019.8454-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205152019.8454-1-vsementsov@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: vsementsov@virtuozzo.com, armbru@redhat.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qga/commands-posix.c |  2 +-
 qga/commands-win32.c |  2 +-
 qga/commands.c       | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1c1a165dae..3bd7b54c08 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2781,7 +2781,7 @@ static double ga_get_login_time(struct utmpx *user_info)
     return seconds + useconds;
 }
 
-GuestUserList *qmp_guest_get_users(Error **err)
+GuestUserList *qmp_guest_get_users(Error **errp)
 {
     GHashTable *cache = NULL;
     GuestUserList *head = NULL, *cur_item = NULL;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 55ba5b263a..2461fd19bf 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1946,7 +1946,7 @@ typedef struct _GA_WTSINFOA {
 
 } GA_WTSINFOA;
 
-GuestUserList *qmp_guest_get_users(Error **err)
+GuestUserList *qmp_guest_get_users(Error **errp)
 {
 #define QGA_NANOSECONDS 10000000
 
diff --git a/qga/commands.c b/qga/commands.c
index 0c7d1385c2..43c323cead 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -143,7 +143,7 @@ static GuestExecInfo *guest_exec_info_find(int64_t pid_numeric)
     return NULL;
 }
 
-GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **err)
+GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 {
     GuestExecInfo *gei;
     GuestExecStatus *ges;
@@ -152,7 +152,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **err)
 
     gei = guest_exec_info_find(pid);
     if (gei == NULL) {
-        error_setg(err, QERR_INVALID_PARAMETER, "pid");
+        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
         return NULL;
     }
 
@@ -385,7 +385,7 @@ GuestExec *qmp_guest_exec(const char *path,
                        bool has_env, strList *env,
                        bool has_input_data, const char *input_data,
                        bool has_capture_output, bool capture_output,
-                       Error **err)
+                       Error **errp)
 {
     GPid pid;
     GuestExec *ge = NULL;
@@ -405,7 +405,7 @@ GuestExec *qmp_guest_exec(const char *path,
     arglist.next = has_arg ? arg : NULL;
 
     if (has_input_data) {
-        input = qbase64_decode(input_data, -1, &ninput, err);
+        input = qbase64_decode(input_data, -1, &ninput, errp);
         if (!input) {
             return NULL;
         }
@@ -424,7 +424,7 @@ GuestExec *qmp_guest_exec(const char *path,
             guest_exec_task_setup, NULL, &pid, has_input_data ? &in_fd : NULL,
             has_output ? &out_fd : NULL, has_output ? &err_fd : NULL, &gerr);
     if (!ret) {
-        error_setg(err, QERR_QGA_COMMAND_FAILED, gerr->message);
+        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
         g_error_free(gerr);
         goto done;
     }
@@ -499,7 +499,7 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     return -1;
 }
 
-GuestHostName *qmp_guest_get_host_name(Error **err)
+GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
     GuestHostName *result = NULL;
     gchar const *hostname = g_get_host_name();
-- 
2.21.0


