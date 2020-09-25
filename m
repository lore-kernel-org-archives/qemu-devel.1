Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF6C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67429206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eb6ALVdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67429206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnIF-0007Xc-IP
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCt-0007pi-Uo
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCr-0001Qz-4I
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so3429359wrn.13
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9eI5ySrz2OiQLFHfiZ2ocnjA2ayiRqTZ1gQtwjJhv6Q=;
 b=eb6ALVdnmFHCTlliFN8w9QQPFweSJ6Di6etcFIdumY21j+3VWYHbhdRz7orrZd4HNW
 BC4nCBlDbhKhp6XnTOh2XkBcX/rpHXp3DeYZ34PeLz4kqPPrY/F5SNXgz7NrQCyoBNGy
 KNB1ehCec9b7w+DJrxTUXT2jfRP2isSynh5wWCGH7z+PirCFWe6mkr56BuMx3N/o4LaE
 PNOprC+3WFDvrcMxerUHXbCs0Sb7JsONYWNzLbecNDWZuHuTaveLGuI7HmFLAXC2FOxF
 DmT1faygi6/tecLZE2OKcL89BFE2X2kCsFiu3TRkNllSt59innjb3U6sG8Sy3jpE5FZQ
 EulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9eI5ySrz2OiQLFHfiZ2ocnjA2ayiRqTZ1gQtwjJhv6Q=;
 b=TMPCoS0OgteJYyAYWLS+7UFF53dCZtLqLcFrUOhcwV2k122KefkRrT7vJsPdCamrMc
 TXV+DXAe49CfXu7p9KQCoUC5d4pjIJ+OWyvkaF3R9+wMNwwxBaeq0J8MlX3CcTtwHzjs
 PgQyVBNSwxPr+Qwr37bcEa9GOY3Hmal3j37VJVNjHdOilUvQqYAVmQeStdKcjRstXKY1
 Ua22fDu8uKg7bT5brlW2RpiZz4oTXVrHArjJtF6h89Am9GM55vHw/Zk6nHS7TGQ5HLXI
 2Jnvz23pxzW0vq6AiEH/CCz3sLVavSfo8n2ZVJAIfZQr4X5XV55tWlVVddmrARFACqbn
 3qpg==
X-Gm-Message-State: AOAM533yKkaNHs3KkwhHmY9jQQrjP/9VAakezPY2OKPp7XLVmFqTDTkb
 ysvZj7+XVewOm2bH4V1k2Uzmtw==
X-Google-Smtp-Source: ABdhPJwrBoyZaa9ySYnxA8u48SmELYctXq1T0Fdj46EQTS15QzgJZGB+uHCKPTfkdtsZGNMxEX84TA==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr4620923wrx.16.1601038327710; 
 Fri, 25 Sep 2020 05:52:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v9sm3129761wrv.35.2020.09.25.05.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41FCB1FF9A;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 11/19] tools/vhost-user-rpmb: add --flash-path for backing
 store
Date: Fri, 25 Sep 2020 13:51:39 +0100
Message-Id: <20200925125147.26943-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need to store the data somewhere so add the option to point to
the file where we will keep the data.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 58 +++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 7b3b29ccfc5b..64bd7e79f573 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -13,9 +13,15 @@
 #include <gio/gio.h>
 #include <gio/gunixsocketaddress.h>
 #include <glib-unix.h>
+#include <glib/gstdio.h>
 #include <stdio.h>
 #include <string.h>
 #include <inttypes.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <unistd.h>
 
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "contrib/libvhost-user/libvhost-user.h"
@@ -27,6 +33,7 @@
 #endif
 
 static gchar *socket_path;
+static char *flash_path;
 static gint socket_fd = -1;
 static gboolean print_cap;
 static gboolean verbose;
@@ -35,6 +42,7 @@ static gboolean debug;
 static GOptionEntry options[] =
 {
     { "socket-path", 0, 0, G_OPTION_ARG_FILENAME, &socket_path, "Location of vhost-user Unix domain socket, incompatible with --fd", "PATH" },
+    { "flash-path", 0, 0, G_OPTION_ARG_FILENAME, &flash_path, "Location of raw flash image file", "PATH" },
     { "fd", 0, 0, G_OPTION_ARG_INT, &socket_fd, "Specify the file-descriptor of the backend, incompatible with --socket-path", "FD" },
     { "print-capabilities", 0, 0, G_OPTION_ARG_NONE, &print_cap, "Output to stdout the backend capabilities in JSON format and exit", NULL},
     { "verbose", 'v', 0, G_OPTION_ARG_NONE, &verbose, "Be more verbose in output", NULL},
@@ -47,6 +55,8 @@ enum {
 };
 
 /* These structures are defined in the specification */
+#define KiB     (1UL << 10)
+#define MAX_RPMB_SIZE (KiB * 128 * 256)
 
 struct virtio_rpmb_config {
     uint8_t capacity;
@@ -75,6 +85,8 @@ typedef struct VuRpmb {
     VugDev dev;
     struct virtio_rpmb_config virtio_config;
     GMainLoop *loop;
+    int flash_fd;
+    void *flash_map;
 } VuRpmb;
 
 struct virtio_rpmb_ctrl_command {
@@ -116,6 +128,8 @@ vrpmb_get_config(VuDev *dev, uint8_t *config, uint32_t len)
     VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
     g_return_val_if_fail(len <= sizeof(struct virtio_rpmb_config), -1);
     memcpy(config, &r->virtio_config, len);
+
+    g_info("%s: done", __func__);
     return 0;
 }
 
@@ -192,6 +206,41 @@ static const VuDevIface vuiface = {
     .set_config = vrpmb_set_config,
 };
 
+static bool vrpmb_load_flash_image(VuRpmb *r, char *img_path)
+{
+    GStatBuf statbuf;
+    size_t map_size;
+
+    if (g_stat(img_path, &statbuf) < 0) {
+        g_error("couldn't stat %s", img_path);
+        return false;
+    }
+
+    r->flash_fd = g_open(img_path, O_RDWR, 0);
+    if (r->flash_fd < 0) {
+        g_error("couldn't open %s (%s)", img_path, strerror(errno));
+        return false;
+    }
+
+    if (statbuf.st_size > MAX_RPMB_SIZE) {
+        g_warning("%s larger than maximum size supported", img_path);
+        map_size = MAX_RPMB_SIZE;
+    } else {
+        map_size = statbuf.st_size;
+    }
+    r->virtio_config.capacity = map_size / (128 *KiB);
+    r->virtio_config.max_wr_cnt = 1;
+    r->virtio_config.max_rd_cnt = 1;
+
+    r->flash_map = mmap(NULL, map_size, PROT_READ, MAP_SHARED, r->flash_fd, 0);
+    if (r->flash_map == MAP_FAILED) {
+        g_error("failed to mmap file");
+        return false;
+    }
+
+    return true;
+}
+
 static void vrpmb_destroy(VuRpmb *r)
 {
     vug_deinit(&r->dev);
@@ -216,7 +265,7 @@ static gboolean hangup(gpointer user_data)
     return true;
 }
 
-int main (int argc, char *argv[])
+int main(int argc, char *argv[])
 {
     GError *error = NULL;
     GOptionContext *context;
@@ -236,6 +285,13 @@ int main (int argc, char *argv[])
         exit(0);
     }
 
+    if (!flash_path || !g_file_test(flash_path, G_FILE_TEST_EXISTS)) {
+        g_printerr("Please specify a valid --flash-path for the flash image\n");
+        exit(EXIT_FAILURE);
+    } else {
+        vrpmb_load_flash_image(&rpmb, flash_path);
+    }
+
     if (!socket_path && socket_fd < 0) {
         g_printerr("Please specify either --fd or --socket-path\n");
         exit(EXIT_FAILURE);
-- 
2.20.1


