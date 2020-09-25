Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5699C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812CE206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHH9XotP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812CE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnIP-0007rm-GE
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCl-0007dK-Ce
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCj-0001Oo-DX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so3526679wrv.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qsQZO642QNM9thsI3rY2HZwoa6pjzpWob+CVTQWTY9k=;
 b=UHH9XotPcaYd69YG2moOspEe8L59ggJkDB9j8hC7qbik1KRbkYDtM6C4EsDe/h0MLq
 Sq4RMjWheINojM95Qcm/GW4lfrhRJINf4TnM+1AinLXgny7ZLW/WYYXl3aEF6GMGS4vE
 B7UzanlSuTJ+faT1+h1dZiNiabnem737nOmJCmBVT/RvgddxGluHp0DHoyiafjPy78cH
 kgnXQ61iULB1D2ILTuiZcmEJAvAUx2SOPQjH9uaSeHrUnvhpnV9LVEWBujE/yi1F76mn
 VZ0+GzOrusr4XWoGZUpP/HvVuqXDStYmZKgkm9FP0Ljkcs7pxxxtNCk7OlbDgnsPjwsO
 pTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsQZO642QNM9thsI3rY2HZwoa6pjzpWob+CVTQWTY9k=;
 b=TyU6ozxXGMTwTxNx0TiKZknsw803N46xiuqfpeUf5o9ZA2pbJ4YhVnNnpBOJr+5jd2
 6KdoVXMdBoE1BGuH7jlPEWmtEfn4EYYWytOKQ4C4/ZhWXjhlS2m/sEfiyOFCafTwG1hW
 3eUcfsAhuo2AddoCqzssuNY9ya8TnAmkCSuxEkzr6+FbBwcO5t/OydatjPbtYdkXh7PO
 go4nhxxWJmF8b0xv6EPxHxZw5bDazH5viXuYpQWUvHWut1d5q4ir5BQC1eIf7TD7R/Cg
 2ZmAl435t6vRIE6W3w/E/sASae/KQip/vFjbFXUa+YXSz6riJouYekZnoxEYTlDIZY1p
 vbvA==
X-Gm-Message-State: AOAM533ew5Sye41WGa37xzPxi81U0oRm7flhs5wRGgmbqa57Lko/hBqy
 UyYNmydIBOv7R/jd3/lFYjY/0Q==
X-Google-Smtp-Source: ABdhPJzxGOLpvB7rUaudCgm/+nAA6NXLFNZlEuBZJJxkQw7M1L981nLdC9hOSy871SGN+c1FCuXWFA==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr4316749wrc.193.1601038320023; 
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm2730665wrp.84.2020.09.25.05.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C544D1FF92;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 06/19] tools/vhost-user-rpmb: add boilerplate and initial
 main
Date: Fri, 25 Sep 2020 13:51:34 +0100
Message-Id: <20200925125147.26943-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

This adds the boilerplate files for a new vhost-user helper called
vhost-user-rpmb which will support virtio based RPMB (Replay Protected
Memory Block) devices.

This commit just adds the initial boilerplate for building the binary
with the common vhost-user options. As of this commit the only useful
output you get is when running:

  vhost-user-rpmb --help

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c               | 37 ++++++++++++++++++++++
 MAINTAINERS                                |  5 +++
 tools/meson.build                          |  8 +++++
 tools/vhost-user-rpmb/50-qemu-rpmb.json.in |  5 +++
 tools/vhost-user-rpmb/meson.build          | 11 +++++++
 5 files changed, 66 insertions(+)
 create mode 100644 tools/vhost-user-rpmb/main.c
 create mode 100644 tools/vhost-user-rpmb/50-qemu-rpmb.json.in
 create mode 100644 tools/vhost-user-rpmb/meson.build

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
new file mode 100644
index 000000000000..a40a680a74ca
--- /dev/null
+++ b/tools/vhost-user-rpmb/main.c
@@ -0,0 +1,37 @@
+/*
+ * VIRTIO RPMB Emulation via vhost-user
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <glib.h>
+
+static gchar *socket_path;
+static gint socket_fd;
+static gboolean print_cap;
+
+static GOptionEntry options[] =
+{
+    { "socket-path", 0, 0, G_OPTION_ARG_FILENAME, &socket_path, "Location of vhost-user Unix domain socket, incompatible with --fd", "PATH" },
+    { "fd", 0, 0, G_OPTION_ARG_INT, &socket_fd, "Specify the file-descriptor of the backend, incompatible with --socket-path", "FD" },
+    { "print-capabilities", 0, 0, G_OPTION_ARG_NONE, &print_cap, "Output to stdout the backend capabilities in JSON format and exit", NULL},
+    { NULL }
+};
+
+int main (int argc, char *argv[])
+{
+    GError *error = NULL;
+    GOptionContext *context;
+
+    context = g_option_context_new ("vhost-user-rpmb - vhost-user emulation of RPBM device");
+    g_option_context_add_main_entries (context, options, "vhost-user-rpmb");
+    if (!g_option_context_parse (context, &argc, &argv, &error))
+    {
+        g_print ("option parsing failed: %s\n", error->message);
+        exit (1);
+    }
+
+
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad19aa0..e325c1024a33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1873,6 +1873,11 @@ F: hw/virtio/virtio-mem-pci.h
 F: hw/virtio/virtio-mem-pci.c
 F: include/hw/virtio/virtio-mem.h
 
+virtio-rpmb
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Supported
+F: tools/vhost-user-rpmb/*
+
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
diff --git a/tools/meson.build b/tools/meson.build
index 513bd2ff4fd2..408048c6357c 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -8,3 +8,11 @@ have_virtiofsd = (have_system and
 if have_virtiofsd
   subdir('virtiofsd')
 endif
+
+have_virtiorpmb = (have_system and
+    have_tools and
+    'CONFIG_LINUX' in config_host)
+
+if have_virtiorpmb
+  subdir('vhost-user-rpmb')
+endif
diff --git a/tools/vhost-user-rpmb/50-qemu-rpmb.json.in b/tools/vhost-user-rpmb/50-qemu-rpmb.json.in
new file mode 100644
index 000000000000..2b033cda567c
--- /dev/null
+++ b/tools/vhost-user-rpmb/50-qemu-rpmb.json.in
@@ -0,0 +1,5 @@
+{
+  "description": "QEMU vhost-user-rpmb",
+  "type": "block",
+  "binary": "@libexecdir@/vhost-user-rpmb"
+}
diff --git a/tools/vhost-user-rpmb/meson.build b/tools/vhost-user-rpmb/meson.build
new file mode 100644
index 000000000000..e0df1b69a3fb
--- /dev/null
+++ b/tools/vhost-user-rpmb/meson.build
@@ -0,0 +1,11 @@
+executable('vhost-user-rpmb', files(
+  'main.c'),
+  dependencies: [glib],
+  link_with: [libvhost_user],
+  install: true,
+  install_dir: get_option('libexecdir'))
+
+configure_file(input: '50-qemu-rpmb.json.in',
+               output: '50-qemu-rpmb.json',
+               configuration: config_host,
+               install_dir: qemu_datadir / 'vhost-user')
-- 
2.20.1


