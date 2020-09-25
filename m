Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273BC20756
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ng2mbfBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273BC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnNC-0004HI-03
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJb-0002Od-UY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJZ-0002G2-Rd
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so3553835wrn.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9fkNiykv8ADFgLC/XdCeeBy0xSrSjYwQRRXXIjcsZfQ=;
 b=ng2mbfBaraUgOB2YcxAblz8zL/B2JiLaRmUITJQx7pI/RpR/qZr0cy2sSwPxSWDRCT
 GOaiiUyVeZnnyMd1JAeliXANvRli3jJpypwA3K+piwLhuP58yghIcf2FHiK3i/I6w8Y2
 8squPohCNbuCKFU5zycOQ2ZA3fuUfBDWeB/2H+4NN/Wa74uEGyo5zIiRZuqBPj2f236o
 ysTS4djRAw3rwKqug6u+wsiLi66HBgznwi/DWJUcKL3s9UEKzPg0EaXjnDVUL56+Kn19
 jG/A0xENSMpLe761AysdmZZjWvB7DK8NqKj8nvYZ/pOdT7FBFcx6MaCzt9mDFEu9quNV
 +F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9fkNiykv8ADFgLC/XdCeeBy0xSrSjYwQRRXXIjcsZfQ=;
 b=B5zcq7s+cgMK/Eo9Rxf8awPfJlAVQGUUi3m2bsOGLnfOvtKV9KwclFEiCeFjmPUOcK
 3pLZ3+PrbxqF0WfFupDNnz+8OJVxEp+YjHjSjxsLuj7dW33TiXmQnLjdbyrUMnLeOhKi
 bpCbKLetifu/2yLwlttGdoYMHHshsLxDvSdtkzup3QeCMizwKzh4nlMY8CCUheRaIIDt
 VO0LI4S7499iJymbUIfqijf+IE8OeohFSS6+eOiHMlNSQ9zbyOynRTqW3IkI5NF8Wdky
 pDx/74a0u9wGmYPqGc304QNBzUt710FxawKQnOY8ymVSnxeak1i3rvcdyd+Vd7BfWzmb
 YS2Q==
X-Gm-Message-State: AOAM531Ti6Q8jlWRMbuNAjchCQUliITJriZopL+qtziy3BtlI3MKYmEB
 q6iFC5Ku4S6yBlSu5L59NVQgGQ==
X-Google-Smtp-Source: ABdhPJwZXb/aMNaYKd7Fb9nlyToAZPmVmFIUciP/z/7p3m/cMVRnn2njwc65CUypQ59VcJIyBLwOWg==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4681024wrn.175.1601038743834; 
 Fri, 25 Sep 2020 05:59:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm2681834wmc.43.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CBB9F1FFA5;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  17/19] tools/vhost-user-rpmb: add key persistence
Date: Fri, 25 Sep 2020 13:51:45 +0100
Message-Id: <20200925125147.26943-18-alex.bennee@linaro.org>
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

Add support for persisting the key in --key-path. By default it will
accept the program-key command and store the key in the key file. If
you pass --key-set then the key is deemed to be programmed and can't
be re-programmed. Obviously you will need some other mechanism to let
the guest know what the key is so it can do other operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 49d4e00b24a9..34607ad19429 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -38,15 +38,19 @@
 
 static gchar *socket_path;
 static char *flash_path;
+static char *key_path;
 static gint socket_fd = -1;
 static gboolean print_cap;
 static gboolean verbose;
 static gboolean debug;
+static gboolean key_set;
 
 static GOptionEntry options[] =
 {
     { "socket-path", 0, 0, G_OPTION_ARG_FILENAME, &socket_path, "Location of vhost-user Unix domain socket, incompatible with --fd", "PATH" },
     { "flash-path", 0, 0, G_OPTION_ARG_FILENAME, &flash_path, "Location of raw flash image file", "PATH" },
+    { "key-path", 0, 0, G_OPTION_ARG_FILENAME, &key_path, "Location of persistent keyfile", "KEY"},
+    { "key-set", 0, 0, G_OPTION_ARG_NONE, &key_set, "Is the key already programmed", NULL},
     { "fd", 0, 0, G_OPTION_ARG_INT, &socket_fd, "Specify the file-descriptor of the backend, incompatible with --socket-path", "FD" },
     { "print-capabilities", 0, 0, G_OPTION_ARG_NONE, &print_cap, "Output to stdout the backend capabilities in JSON format and exit", NULL},
     { "verbose", 'v', 0, G_OPTION_ARG_NONE, &verbose, "Be more verbose in output", NULL},
@@ -296,8 +300,18 @@ static void vrpmb_handle_program_key(VuDev *dev, struct virtio_rpmb_frame *frame
     } else {
         r->key = g_memdup(&frame->key_mac[0], RPMB_KEY_MAC_SIZE);
         r->last_result = VIRTIO_RPMB_RES_OK;
+        if (key_path) {
+            GError *err = NULL;
+            if (!g_file_set_contents(key_path, (char *) r->key,
+                                     RPMB_KEY_MAC_SIZE, &err)) {
+                g_warning("%s: unable to persist key data to %s: %s",
+                          __func__, key_path, err->message);
+                g_error_free(err);
+            }
+        }
     }
 
+
     g_info("%s: req_resp = %x, result = %x", __func__,
            r->last_reqresp, r->last_result);
     return;
@@ -709,6 +723,25 @@ static bool vrpmb_load_flash_image(VuRpmb *r, char *img_path)
     return true;
 }
 
+static void vrpmb_set_key(VuRpmb *r, char *key_path)
+{
+    GError *err = NULL;
+    gsize length;
+
+    if (!g_file_get_contents(key_path, (char **) &r->key, &length, &err)) {
+        g_print("Unable to read %s: %s", key_path, err->message);
+        exit(1);
+    }
+    if (length < RPMB_KEY_MAC_SIZE) {
+        g_print("key file to small %ld < %d", length, RPMB_KEY_MAC_SIZE);
+        exit(1);
+    } else if (length > RPMB_KEY_MAC_SIZE) {
+        /* being too big isn't fatal, we just ignore the excess */
+        g_warning("%ld bytes of %s ignore (file too big)",
+                  length - RPMB_KEY_MAC_SIZE, key_path);
+    }
+}
+
 static void vrpmb_destroy(VuRpmb *r)
 {
     vug_deinit(&r->dev);
@@ -760,6 +793,10 @@ int main(int argc, char *argv[])
         vrpmb_load_flash_image(&rpmb, flash_path);
     }
 
+    if (key_path && key_set) {
+        vrpmb_set_key(&rpmb, key_path);
+    }
+
     if (!socket_path && socket_fd < 0) {
         g_printerr("Please specify either --fd or --socket-path\n");
         exit(EXIT_FAILURE);
-- 
2.20.1


