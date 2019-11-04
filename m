Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34903CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F418F21D7D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFReO8QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F418F21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRcGx-0002l8-7S
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 08:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRcFv-0002JT-G2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRcFt-0006lS-Kp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:18:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRcFt-0006kx-An
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:18:49 -0500
Received: by mail-wr1-x442.google.com with SMTP id w18so17054751wrt.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rOZ0gez1NEpkqAe8mafcBoPYA+rdrF3WN5OlhkpDJ6M=;
 b=nFReO8QRwosmOA6397Jjnk/o5BKTmAjCsO1KOZFmecmmHOu7R5sUQGlZg4fzOsh5JF
 dwEw1mksYyxMnf528y2F5Qya9Jw3VqF8mzjDd0iEVKU7jkXB6qwje00WdnTZP8BIvpd1
 2mbzmpV7t2/H65xVAMF5Dx1DoJAZEu5Z+hURAMGBPHz9eZSBbuLA2UbGMgXkoUnNLKXQ
 NSmL3jM3q0CV1J1h23giU/g5oo4JcaUfQ/a3Db7UcBln/aiLFjXGzugQIS20Um4z7756
 gN3dEMHcsq9RbdEEy6HHVaCJoVSGGVJP8LCqn+zO6WPb7AF4nUXPriFlHQq/VgcK6VYS
 HzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rOZ0gez1NEpkqAe8mafcBoPYA+rdrF3WN5OlhkpDJ6M=;
 b=fpScUXL7f1eYJ7+ygERh7TaqctSnyOJOvdPHWJwcoO7PXTtU2Zp/+0Inux6Xpiddur
 +P2QF68gT0gWCCBXZqnzX4BQUf5NE7NWNZqn9iGeuJyzRs7ieYG68JOUroRrBKrbvz3H
 VtU2pDnGq+MGo1rBJZ4s/68rA4ALrLgRgPll7mtmyPH43NM5+nk5SQAO7eHk20/lMeJK
 nGYvJLbsSScFfBy/ClOU9Zf6uXba7j2Qo8SIOtAqDxbKN2oyW2M/0Necg5aYHrjarM2W
 Gj3dM0twAVDQGbsjS6gH4F3YyDx3SxhoQ1QiXaSm1BHNgMuuW82etMthAi4a6eRI2D7D
 vP9Q==
X-Gm-Message-State: APjAAAUZmMOsZShUG0YP+gOFBjHIiP9AK8o4hxQg6OGx981awWZo4Se8
 Eil5rSLec6PzITWTlABOfGRY9A==
X-Google-Smtp-Source: APXvYqzWbnFgXORA7L3V6vXExw5Bd9zce6nFzN76KrTk7PJD1fcfz7SqyRwGoWaB+kMfptcNphRotg==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr22358438wri.130.1572873526318; 
 Mon, 04 Nov 2019 05:18:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v128sm22625194wmb.14.2019.11.04.05.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 05:18:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 691611FF87;
 Mon,  4 Nov 2019 13:18:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg plugins: expose an API version concept
Date: Mon,  4 Nov 2019 13:18:36 +0000
Message-Id: <20191104131836.12566-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a very simple versioning API which allows the plugin
infrastructure to check the API a plugin was built against. We also
expose a min/cur API version to the plugin via the info block in case
it wants to avoid using old deprecated APIs in the future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h | 19 +++++++++++++++++++
 plugins/loader.c           | 15 +++++++++++++++
 plugins/plugin.h           |  2 ++
 tests/plugin/bb.c          |  2 ++
 tests/plugin/empty.c       |  2 ++
 tests/plugin/hotpages.c    |  2 ++
 tests/plugin/howvec.c      |  2 ++
 tests/plugin/insn.c        |  2 ++
 tests/plugin/mem.c         |  2 ++
 9 files changed, 48 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index a00a7deb461..5502e112c81 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -38,9 +38,28 @@
 
 typedef uint64_t qemu_plugin_id_t;
 
+/*
+ * Versioning plugins:
+ *
+ * The plugin API will pass a minimum and current API version that
+ * QEMU currently supports. The minimum API will be incremented if an
+ * API needs to be deprecated.
+ *
+ * The plugins export the API they were built against by exposing the
+ * symbol qemu_plugin_version which can be checked.
+ */
+
+extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
+
+#define QEMU_PLUGIN_VERSION 0
+
 typedef struct {
     /* string describing architecture */
     const char *target_name;
+    struct {
+        int min;
+        int cur;
+    } version;
     /* is this a full system emulation? */
     bool system_emulation;
     union {
diff --git a/plugins/loader.c b/plugins/loader.c
index ce724ed5839..1bcca909691 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -178,6 +178,19 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
         goto err_symbol;
     }
 
+    if (!g_module_symbol(ctx->handle, "qemu_plugin_version", &sym)) {
+        warn_report("%s: missing version %s", __func__, g_module_error());
+    } else {
+        int version = *(int *)sym;
+        if (version < QEMU_PLUGIN_MIN_VERSION ||
+            version > QEMU_PLUGIN_VERSION) {
+            error_report("%s: bad plugin version %d vs %d/%d",
+                         __func__, version, QEMU_PLUGIN_MIN_VERSION,
+                         QEMU_PLUGIN_VERSION);
+            goto err_symbol;
+        }
+    }
+
     qemu_rec_mutex_lock(&plugin.lock);
 
     /* find an unused random id with &ctx as the seed */
@@ -248,6 +261,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
 
     info->target_name = TARGET_NAME;
+    info->version.min = QEMU_PLUGIN_MIN_VERSION;
+    info->version.cur = QEMU_PLUGIN_VERSION;
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
     info->system_emulation = true;
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5482168d797..1aa29dcaddf 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -14,6 +14,8 @@
 
 #include <gmodule.h>
 
+#define QEMU_PLUGIN_MIN_VERSION 0
+
 /* global state */
 struct qemu_plugin_state {
     QTAILQ_HEAD(, qemu_plugin_ctx) ctxs;
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index 45e1de5bd68..f30bea08dcc 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -14,6 +14,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static uint64_t bb_count;
 static uint64_t insn_count;
 static bool do_inline;
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
index 3f60f690278..8fa6bacd93d 100644
--- a/tests/plugin/empty.c
+++ b/tests/plugin/empty.c
@@ -13,6 +13,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 /*
  * Empty TB translation callback.
  * This allows us to measure the overhead of injecting and then
diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
index 77df07a3ccf..ecd6c187327 100644
--- a/tests/plugin/hotpages.c
+++ b/tests/plugin/hotpages.c
@@ -18,6 +18,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 static uint64_t page_size = 4096;
diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 58fa675e348..4ca555e1239 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -20,6 +20,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 typedef enum {
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index e5fd07fb64b..0a8f5a0000e 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -14,6 +14,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static uint64_t insn_count;
 static bool do_inline;
 
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index d9673889896..878abf09d19 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -14,6 +14,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static uint64_t mem_count;
 static uint64_t io_count;
 static bool do_inline;
-- 
2.20.1


