Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B7CC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DB7206F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYhKu9K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DB7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie8Ho-0003HX-TV
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 20:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chanmickyyun@gmail.com>) id 1ie8FB-0001ss-Q3
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chanmickyyun@gmail.com>) id 1ie8FA-0001p2-5w
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:53:49 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chanmickyyun@gmail.com>)
 id 1ie8F9-0001ni-VZ
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:53:48 -0500
Received: by mail-pg1-x542.google.com with SMTP id i5so6283671pgj.9
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 17:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f/CHHckRiBXqEtYZAXyiuak0sc3yM7WzqBVmKgFk66E=;
 b=lYhKu9K0jp7gOGX4P6z+lIGEQAr3XwENkkeoR2S3dG74qvP5IrrobNSXAH+1xe3dQz
 RuzP6pKDEBWxBKtAr+U1n1n4sGAXtl7oSK9MAuGydMSKr1RZfSalBK7NoIr+3nzcDWW/
 cDaTif99A0Rnwo0TH+ex4FG6mwIrBioaelW09x8Vob+zw66WVCnpFSGZmgCTjV+F48Bm
 2HnEsfqbF9fCDd2X0YQvxBwcCpwOPh6xRJSuVKmI9pnAEAOC1ciTPF0qYiruk2R910rD
 4tny1uxoxhKG4pjpGiaDEXKHhdO3cl8MkaLw4/9cItillGBBhmSeL9VPgcj7gtAN95y0
 dqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f/CHHckRiBXqEtYZAXyiuak0sc3yM7WzqBVmKgFk66E=;
 b=rzRxgJxHGgOhz19IH9BTpP8GFkINym30P2Os4CDybvVpEQiaAf16RF9ZkEUcIxAtYp
 zHYtXUt02Q2h2YLusC8eBpUsjmGPjd9/Bgn3jHKJlm7BQGkTMLzFcM31Kt+oS3p31c3d
 m+4t499X+AJgLuRoKPGg4zeI9kDA/vqUt8J6qzWi2/FL5UTUJcUqCGYMedz+gPaPJPLO
 aOhymyOmXJkruM1VC4jNbywh8sW86ZWx5ME6wKyINqdjd/8m/K0l7kD1Ke74LK1rfN+L
 /4FwSV+NgA8UMf49BaXjE3DsVIcLfmLxHl3+88+rTRAJmsEVX223zOAygISlTyS60Wgq
 Z7bw==
X-Gm-Message-State: APjAAAUVGY8BgYgwhUda3pqIpG++O31DlAt5AIHLSMOb0VkL2QjETbmS
 BDFoksSZnE/OKZtxLzhLf4VCRuiRc53olXUk
X-Google-Smtp-Source: APXvYqzgLh5ot0tq+ikNTisNDlz79Uuc8Q2QP6Zr0FyYJcW2eG1MIyaQ8XqfXiZRPJsmkoGEbcTzvA==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr27351522pfg.51.1575856425118; 
 Sun, 08 Dec 2019 17:53:45 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o3sm9911374pju.13.2019.12.08.17.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2019 17:53:44 -0800 (PST)
From: "Micky Yun Chan(michiboo)" <chanmickyyun@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8] Implement backend program convention command for
 vhost-user-blk
Date: Mon,  9 Dec 2019 09:53:31 +0800
Message-Id: <20191209015331.5455-1-chanmickyyun@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Micky Yun Chan <chanmickyyun@gmail.com>, stefanha@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Micky Yun Chan <chanmickyyun@gmail.com>

This patch is to add standard commands defined in docs/interop/vhost-user.rst
For vhost-user-* program

Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
 docs/interop/vhost-user.json            |  31 +++++++
 docs/interop/vhost-user.rst             |  17 ++++
 3 files changed, 112 insertions(+), 44 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index ae61034656..6fd91c7e99 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -576,70 +576,90 @@ vub_new(char *blk_file)
     return vdev_blk;
 }
 
+static int opt_fdnum = -1;
+static char *opt_socket_path;
+static char *opt_blk_file;
+static gboolean opt_print_caps;
+static gboolean opt_read_only;
+
+static GOptionEntry entries[] = {
+    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
+      "Print capabilities", NULL },
+    { "fd", 'f', 0, G_OPTION_ARG_INT, &opt_fdnum,
+      "Use inherited fd socket", "FDNUM" },
+    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
+      "Use UNIX socket path", "PATH" },
+    {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
+     "block device or file path", "PATH"},
+    { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
+      "Enable read-only", NULL }
+};
+
 int main(int argc, char **argv)
 {
-    int opt;
-    char *unix_socket = NULL;
-    char *blk_file = NULL;
-    bool enable_ro = false;
     int lsock = -1, csock = -1;
     VubDev *vdev_blk = NULL;
+    GError *error = NULL;
+    GOptionContext *context;
 
-    while ((opt = getopt(argc, argv, "b:rs:h")) != -1) {
-        switch (opt) {
-        case 'b':
-            blk_file = g_strdup(optarg);
-            break;
-        case 's':
-            unix_socket = g_strdup(optarg);
-            break;
-        case 'r':
-            enable_ro = true;
-            break;
-        case 'h':
-        default:
-            printf("Usage: %s [ -b block device or file, -s UNIX domain socket"
-                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
-            return 0;
+    context = g_option_context_new(NULL);
+    g_option_context_add_main_entries(context, entries, NULL);
+    if (!g_option_context_parse(context, &argc, &argv, &error)) {
+        g_printerr("Option parsing failed: %s\n", error->message);
+        exit(EXIT_FAILURE);
+    }
+    if (opt_print_caps) {
+        g_print("{\n");
+        g_print("  \"type\": \"block\",\n");
+        g_print("  \"features\": [\n");
+        g_print("    \"read-only\",\n");
+        g_print("    \"blk-file\"\n");
+        g_print("  ]\n");
+        g_print("}\n");
+        exit(EXIT_SUCCESS);
+    }
+
+    if (!opt_blk_file) {
+        g_print("%s\n", g_option_context_get_help(context, true, NULL));
+        exit(EXIT_FAILURE);
+    }
+
+    if (opt_socket_path) {
+        lsock = unix_sock_new(opt_socket_path);
+        if (lsock < 0) {
+            exit(EXIT_FAILURE);
         }
+    } else if (opt_fdnum < 0) {
+        g_print("%s\n", g_option_context_get_help(context, true, NULL));
+        exit(EXIT_FAILURE);
+    } else {
+        lsock = opt_fdnum;
     }
 
-    if (!unix_socket || !blk_file) {
-        printf("Usage: %s [ -b block device or file, -s UNIX domain socket"
-               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
-        return -1;
-    }
-
-    lsock = unix_sock_new(unix_socket);
-    if (lsock < 0) {
-        goto err;
-    }
-
-    csock = accept(lsock, (void *)0, (void *)0);
+    csock = accept(lsock, NULL, NULL);
     if (csock < 0) {
-        fprintf(stderr, "Accept error %s\n", strerror(errno));
-        goto err;
+        g_printerr("Accept error %s\n", strerror(errno));
+        exit(EXIT_FAILURE);
     }
 
-    vdev_blk = vub_new(blk_file);
+    vdev_blk = vub_new(opt_blk_file);
     if (!vdev_blk) {
-        goto err;
+        exit(EXIT_FAILURE);
     }
-    if (enable_ro) {
+    if (opt_read_only) {
         vdev_blk->enable_ro = true;
     }
 
     if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
                   vub_panic_cb, &vub_iface)) {
-        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
-        goto err;
+        g_printerr("Failed to initialize libvhost-user-glib\n");
+        exit(EXIT_FAILURE);
     }
 
     g_main_loop_run(vdev_blk->loop);
-
+    g_main_loop_unref(vdev_blk->loop);
+    g_option_context_free(context);
     vug_deinit(&vdev_blk->parent);
-
-err:
     vub_free(vdev_blk);
     if (csock >= 0) {
         close(csock);
@@ -647,8 +667,8 @@ err:
     if (lsock >= 0) {
         close(lsock);
     }
-    g_free(unix_socket);
-    g_free(blk_file);
+    g_free(opt_socket_path);
+    g_free(opt_blk_file);
 
     return 0;
 }
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index da6aaf51c8..ce0ef74db5 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -54,6 +54,37 @@
   ]
 }
 
+##
+# @VHostUserBackendBlockFeature:
+#
+# List of vhost user "block" features.
+#
+# @read-only: The --read-only command line option is supported.
+# @blk-file: The --blk-file command line option is supported.
+#
+# Since: 5.0
+##
+{
+  'enum': 'VHostUserBackendBlockFeature',
+  'data': [ 'read-only', 'blk-file' ]
+}
+
+##
+# @VHostUserBackendCapabilitiesBlock:
+#
+# Capabilities reported by vhost user "block" backends
+#
+# @features: list of supported features.
+#
+# Since: 5.0
+##
+{
+  'struct': 'VHostUserBackendCapabilitiesBlock',
+  'data': {
+    'features': [ 'VHostUserBackendBlockFeature' ]
+  }
+}
+
 ##
 # @VHostUserBackendInputFeature:
 #
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 7827b710aa..015ac08177 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1376,3 +1376,20 @@ Command line options:
   Enable virgl rendering support.
 
   (optional)
+
+vhost-user-blk
+--------------
+
+Command line options:
+
+--blk-file=PATH
+
+  Specify block device or file path.
+
+  (optional)
+
+--read-only
+
+  Enable read-only.
+
+  (optional)
-- 
2.21.0


