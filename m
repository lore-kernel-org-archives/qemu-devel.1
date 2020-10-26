Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D79223FD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D79223FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyTD-000616-DW
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kWyRt-0004Ka-La; Mon, 26 Oct 2020 05:05:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kWyRr-0000Xh-8f; Mon, 26 Oct 2020 05:05:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CKTT84KrJz6xDM;
 Mon, 26 Oct 2020 17:05:48 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 26 Oct 2020 17:05:38 +0800
Message-ID: <5F969162.2050302@huawei.com>
Date: Mon, 26 Oct 2020 17:05:38 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/4] qga: Add spaces around operator
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=alex.chen@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 05:03:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: AlexChen <alex.chen@huawei.com>
---
 qga/channel-win32.c  |  6 +++---
 qga/commands-posix.c |  4 ++--
 qga/commands-win32.c | 24 ++++++++++++------------
 qga/commands.c       |  4 ++--
 qga/main.c           |  4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 4f04868a76..21ec9268b4 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -292,9 +292,9 @@ static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
         return false;
     }

-    if (method == GA_CHANNEL_ISA_SERIAL){
+    if (method == GA_CHANNEL_ISA_SERIAL) {
         snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
-    }else {
+    } else {
         g_strlcpy(newpath, path, sizeof(newpath));
     }

@@ -307,7 +307,7 @@ static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
         return false;
     }

-    if (method == GA_CHANNEL_ISA_SERIAL && !SetCommTimeouts(c->handle,&comTimeOut)) {
+    if (method == GA_CHANNEL_ISA_SERIAL && !SetCommTimeouts(c->handle, &comTimeOut)) {
         g_autofree gchar *emsg = g_win32_error_message(GetLastError());
         g_critical("error setting timeout for com port: %s", emsg);
         CloseHandle(c->handle);
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3bffee99d4..d5ebb3d83c 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -110,7 +110,7 @@ void qmp_guest_shutdown(bool has_mode, const char *mode, Error **errp)
         reopen_fd_to_null(2);

         execle("/sbin/shutdown", "shutdown", "-h", shutdown_flag, "+0",
-               "hypervisor initiated shutdown", (char*)NULL, environ);
+               "hypervisor initiated shutdown", (char *)NULL, environ);
         _exit(EXIT_FAILURE);
     } else if (pid < 0) {
         error_setg_errno(errp, errno, "failed to create child process");
@@ -479,7 +479,7 @@ GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
         gfh->state = RW_STATE_NEW;
     }

-    buf = g_malloc0(count+1);
+    buf = g_malloc0(count + 1);
     read_count = fread(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to read file");
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c3c05484f..2c341c7bea 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -83,7 +83,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
                        (365 * (1970 - 1601) +       \
                         (1970 - 1601) / 4 - 3))

-#define INVALID_SET_FILE_POINTER ((DWORD)-1)
+#define INVALID_SET_FILE_POINTER ((DWORD) - 1)

 struct GuestFileHandle {
     int64_t id;
@@ -110,15 +110,15 @@ static OpenFlags guest_file_open_modes[] = {
     {"w",   GENERIC_WRITE,                    CREATE_ALWAYS},
     {"wb",  GENERIC_WRITE,                    CREATE_ALWAYS},
     {"a",   FILE_GENERIC_APPEND,              OPEN_ALWAYS  },
-    {"r+",  GENERIC_WRITE|GENERIC_READ,       OPEN_EXISTING},
-    {"rb+", GENERIC_WRITE|GENERIC_READ,       OPEN_EXISTING},
-    {"r+b", GENERIC_WRITE|GENERIC_READ,       OPEN_EXISTING},
-    {"w+",  GENERIC_WRITE|GENERIC_READ,       CREATE_ALWAYS},
-    {"wb+", GENERIC_WRITE|GENERIC_READ,       CREATE_ALWAYS},
-    {"w+b", GENERIC_WRITE|GENERIC_READ,       CREATE_ALWAYS},
-    {"a+",  FILE_GENERIC_APPEND|GENERIC_READ, OPEN_ALWAYS  },
-    {"ab+", FILE_GENERIC_APPEND|GENERIC_READ, OPEN_ALWAYS  },
-    {"a+b", FILE_GENERIC_APPEND|GENERIC_READ, OPEN_ALWAYS  }
+    {"r+",  GENERIC_WRITE | GENERIC_READ,       OPEN_EXISTING},
+    {"rb+", GENERIC_WRITE | GENERIC_READ,       OPEN_EXISTING},
+    {"r+b", GENERIC_WRITE | GENERIC_READ,       OPEN_EXISTING},
+    {"w+",  GENERIC_WRITE | GENERIC_READ,       CREATE_ALWAYS},
+    {"wb+", GENERIC_WRITE | GENERIC_READ,       CREATE_ALWAYS},
+    {"w+b", GENERIC_WRITE | GENERIC_READ,       CREATE_ALWAYS},
+    {"a+",  FILE_GENERIC_APPEND | GENERIC_READ, OPEN_ALWAYS  },
+    {"ab+", FILE_GENERIC_APPEND | GENERIC_READ, OPEN_ALWAYS  },
+    {"a+b", FILE_GENERIC_APPEND | GENERIC_READ, OPEN_ALWAYS  }
 };

 #define debug_error(msg) do { \
@@ -280,7 +280,7 @@ static void acquire_privilege(const char *name, Error **errp)
     Error *local_err = NULL;

     if (OpenProcessToken(GetCurrentProcess(),
-        TOKEN_ADJUST_PRIVILEGES|TOKEN_QUERY, &token))
+        TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &token))
     {
         if (!LookupPrivilegeValue(NULL, name, &priv.Privileges[0].Luid)) {
             error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
@@ -1023,7 +1023,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)

     len = strlen(mnt_point);
     mnt_point[len] = '\\';
-    mnt_point[len+1] = 0;
+    mnt_point[len + 1] = 0;

     if (!GetVolumeInformationByHandleW(hLocalDiskHandle, vol_info,
                                        sizeof(vol_info), NULL, NULL, NULL,
diff --git a/qga/commands.c b/qga/commands.c
index 3dcd5fbe5c..54d0e5eb7e 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -22,9 +22,9 @@
 #include "commands-common.h"

 /* Maximum captured guest-exec out_data/err_data - 16MB */
-#define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
+#define GUEST_EXEC_MAX_OUTPUT (16 * 1024 * 1024)
 /* Allocation and I/O buffer for reading guest-exec out_data/err_data - 4KB */
-#define GUEST_EXEC_IO_SIZE (4*1024)
+#define GUEST_EXEC_IO_SIZE (4 * 1024)
 /*
  * Maximum file size to read - 48MB
  *
diff --git a/qga/main.c b/qga/main.c
index dea6a3aa64..308ebd6581 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -594,7 +594,7 @@ end:
 static gboolean channel_event_cb(GIOCondition condition, gpointer data)
 {
     GAState *s = data;
-    gchar buf[QGA_READ_COUNT_DEFAULT+1];
+    gchar buf[QGA_READ_COUNT_DEFAULT + 1];
     gsize count;
     GIOStatus status = ga_channel_read(s->channel, buf, QGA_READ_COUNT_DEFAULT, &count);
     switch (status) {
@@ -618,7 +618,7 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
          * host-side chardev. sleep a bit to mitigate this
          */
         if (s->virtio) {
-            usleep(100*1000);
+            usleep(100 * 1000);
         }
         return true;
     default:
-- 
2.19.1

