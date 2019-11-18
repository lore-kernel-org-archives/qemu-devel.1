Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7874BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442DE2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtbH4NWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442DE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWaof-0003jw-9A
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 01:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chanmickyyun@gmail.com>) id 1iWan6-0002q3-8Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chanmickyyun@gmail.com>) id 1iWan3-00076n-Uv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:45:40 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chanmickyyun@gmail.com>)
 id 1iWan3-000762-MB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:45:37 -0500
Received: by mail-pj1-x1044.google.com with SMTP id o14so1191773pjr.0
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 22:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fZsQl1hYGdy1hKrVBKT30eUn/K34Ho3m0CAeILgYaYo=;
 b=VtbH4NWPOswC5VSTAkWzMRsKEehqejzA7/MRzxhDfX6MAXCRo0dBU7CqcVHM0Htltk
 Nydkq0/UcNu9cEFjlI+Zqde5N5xlNoJlTBC1rx+8u7pm+AiXMCO7dv9H1rDdRP77gupS
 lv8QPXI+KtkOiXYwdeSoZvBcAn0dzF8tjAAusUMmOHwcTflk7/KIvhTF3Djg0/rcydWq
 o2173ytMvCQhmEazzfwNZ9cr3O427B310SXxLmlCf1tBHxDQOmBZ3riGsgGi1m/WPRZc
 w/Dpc8X9hoIg0HmDZOIESJf3vorSc2fr84lO2ctovgoYOQX+PPHThjWkdN4rfr4PL9UE
 qbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fZsQl1hYGdy1hKrVBKT30eUn/K34Ho3m0CAeILgYaYo=;
 b=a95gi4gd4SdkwBdWNlNXXBvp7HxGfV7zPwDcq5Ck9XxE4z5w+CdUFaKULlGMEeXMel
 Y34juWnJbe+SerIx7wXfmDlJB45CP7LiEfekId5OCQE2ZXOtkImKlVQuru7SBOya5Nx0
 Ih1x4b5UfCyz+AeSIApwzK1AF0QJCU6xq4teaV9g3dQf92JVKbbwUvbOo4d69aeN3Sf5
 6NDaLFEcGKXPrOeUISMoSm7h4NlLYQp/ULyp74v1qsPg+cvTYQsg/BOpy05jIPANyVil
 QOgSTTyGA27tlKSoTQg/x5y+1/7T1lkq9YG5mSVCB8xSSk85uf5xihM4r3KRrOaqmY02
 OpoQ==
X-Gm-Message-State: APjAAAWlNslwJWPddYjq1+tF1p/WbCH87qJOVFasbWDkRq8QQFuWJl5G
 Sc7DTdDMR7XUC4bjQw8rSuY8+trPuQ56BGOM
X-Google-Smtp-Source: APXvYqxN1zaWB3+DQgVQMVLoPFldTu5z2PknbpYqIsNwTFQ+WMXOqmINOQykaHLWbPCYoAtI2TzPWw==
X-Received: by 2002:a17:902:a508:: with SMTP id
 s8mr27533294plq.26.1574059534741; 
 Sun, 17 Nov 2019 22:45:34 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
 by smtp.googlemail.com with ESMTPSA id
 x192sm21891082pfd.96.2019.11.17.22.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 22:45:33 -0800 (PST)
From: Micky Yun Chan <chanmickyyun@gmail.com>
X-Google-Original-From: Micky Yun Chan <michan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Implement backend program convention command for
 vhost-user-blk
Date: Mon, 18 Nov 2019 14:45:19 +0800
Message-Id: <20191118064519.16072-1-michan@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: michan <michan@redhat.com>, Micky Yun Chan <chanmickyyun@gmail.com>,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: michan <michan@redhat.com>

Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 102 ++++++++++++++----------
 1 file changed, 58 insertions(+), 44 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index ae61034656..8759b6a5d0 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -576,70 +576,84 @@ vub_new(char *blk_file)
     return vdev_blk;
 }
 
+static int opt_fdnum = -1;
+static char *opt_socket_path;
+static char *opt_blk_file;
+static gboolean opt_print_caps;
+static gboolean opt_read_only;
+
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
+        g_option_context_get_help(context, true, NULL);
+        exit(EXIT_SUCCESS);
+    }
+
+    if (!opt_blk_file) {
+        g_option_context_get_help(context, true, NULL);
+        exit(EXIT_FAILURE);
+    }
+
+    if (opt_socket_path) {
+        lsock = unix_sock_new(opt_socket_path);
+        if (lsock < 0) {
+           exit(EXIT_FAILURE);
         }
+    } else if(opt_fdnum < 0){
+        g_option_context_get_help(context, true, NULL);
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
+        g_printerr("Failed to initialized libvhost-user-glib\n");
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
@@ -647,8 +661,8 @@ err:
     if (lsock >= 0) {
         close(lsock);
     }
-    g_free(unix_socket);
-    g_free(blk_file);
+    g_free(opt_socket_path);
+    g_free(opt_blk_file);
 
     return 0;
 }
-- 
2.21.0


