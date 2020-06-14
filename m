Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6455C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6C3206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vG4bEski"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6C3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXYv-0002BG-UW
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 14:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXXm-000078-8R
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:39:46 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38223)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXXk-00019O-HG
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:39:45 -0400
Received: by mail-pj1-x1044.google.com with SMTP id d6so6077023pjs.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gQsW4GQWWocPFSbE+a86Ei8A/IwEA+wxuYPi/uczMr0=;
 b=vG4bEski6KSEwz4+7HUke8OoTTMfVacq5DiGsS9R6i1oYX+/PWuG2GD7JhO9h+1Nxj
 krruUxzrtLDDvnSVSxLgwJZlWmHfniBLOc+h/e/oitcUhVbTWW8RujZv1wSurdHs7nvW
 H4c4gykcaqbqmHilw25M3rcm2+6q7SynaXy2vEtzDbemZSFLAIibFg2gYmIUvYw0SMMG
 mCEmuMfSgNouVrs4f3I4Zxgo8syObJCM9cuZ8O8fh0Akd8stJjaiSBrUyfQKHPGo3M45
 4fnSqyxbeu0LLLvdH93ZsHVB4NaKc0600+4PRxeu9N6kG34r/k8M88AwmrkZAHC4cNDD
 82JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gQsW4GQWWocPFSbE+a86Ei8A/IwEA+wxuYPi/uczMr0=;
 b=Q+l6Fe+Vla2yXY95B7QYDAJJHqt/BD7+wXuwYWBkdZLBd24nVcwC92wfhuobw3T+lc
 y/HvE8q0mOv942l5N+hLLhCEQVNBTy0ZpbgHGiN6vZGscd87F6Ur9dgHOZUKJ244I+hp
 ICok7BxA1ZNOhmUzqQNI2jFWL1V/NYuQUyZK8K7CS6RgxU5fmg91/wv8/EwwDZoGlkk8
 hgs+LtGQCuVeG01EIIMedPKADxTp7Dc5AfxSiO1JWcxba2MiPpffIy87z8swD0R1al9B
 rtyvoSSkJ7sKJHQ26KwMocz06ejtYEK7Cns4apln1S6/Gjk7V1zwUYeRENgskH5/gxss
 gzMQ==
X-Gm-Message-State: AOAM533Tfaoi0khOQNq9ORTLqBvWL9IUi5tAQbdUzbqbBS4hYMpuOMRK
 3fAZzmwxCm8oDLogsnzVkmkJ0MbkxF5Fvms7
X-Google-Smtp-Source: ABdhPJy6O9eEqIOZwHe6oOuPyehX9iYTSrAO1JY5u4Js1B5q7vbc1hZNbj4TWn7dacb8yoDh6Gj33Q==
X-Received: by 2002:a17:90a:a405:: with SMTP id
 y5mr8534338pjp.15.1592159978079; 
 Sun, 14 Jun 2020 11:39:38 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id b14sm11354728pft.23.2020.06.14.11.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 11:39:37 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 3/5] move logical block size check function to a common
 utility function
Date: Mon, 15 Jun 2020 02:39:05 +0800
Message-Id: <20200614183907.514282-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614183907.514282-1-coiby.xu@gmail.com>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move logical block size check function in hw/core/qdev-properties.c:set_blocksize() to util/block-helpers.c

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 hw/core/qdev-properties.c | 18 +++------------
 util/Makefile.objs        |  1 +
 util/block-helpers.c      | 46 +++++++++++++++++++++++++++++++++++++++
 util/block-helpers.h      |  7 ++++++
 4 files changed, 57 insertions(+), 15 deletions(-)
 create mode 100644 util/block-helpers.c
 create mode 100644 util/block-helpers.h

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index cc924815da..a4a6aa5204 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -14,6 +14,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "util/block-helpers.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -736,8 +737,6 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
     Error *local_err = NULL;
-    const int64_t min = 512;
-    const int64_t max = 32768;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -749,21 +748,10 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
         error_propagate(errp, local_err);
         return;
     }
-    /* value of 0 means "unset" */
-    if (value && (value < min || value > max)) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   dev->id ? : "", name, (int64_t)value, min, max);
+    check_logical_block_size(dev->id ? : "", name, value, errp);
+    if (errp) {
         return;
     }
-
-    /* We rely on power-of-2 blocksizes for bitmasks */
-    if ((value & (value - 1)) != 0) {
-        error_setg(errp,
-                  "Property %s.%s doesn't take value '%" PRId64 "', it's not a power of 2",
-                  dev->id ?: "", name, (int64_t)value);
-        return;
-    }
-
     *ptr = value;
 }
 
diff --git a/util/Makefile.objs b/util/Makefile.objs
index b4d4af06dc..fa5380ddab 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -66,6 +66,7 @@ util-obj-y += hbitmap.o
 util-obj-y += main-loop.o
 util-obj-y += nvdimm-utils.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
+util-obj-y += block-helpers.o
 util-obj-$(CONFIG_LINUX) += vhost-user-server.o
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += qemu-co-shared-resource.o
diff --git a/util/block-helpers.c b/util/block-helpers.c
new file mode 100644
index 0000000000..d31309cc0e
--- /dev/null
+++ b/util/block-helpers.c
@@ -0,0 +1,46 @@
+/*
+ * Block utility functions
+ *
+ * Copyright (c) 2020 Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "block-helpers.h"
+
+/*
+ * Logical block size input validation
+ *
+ * The size should meet the following conditions:
+ * 1. min=512
+ * 2. max=32768
+ * 3. a power of 2
+ *
+ *  Moved from hw/core/qdev-properties.c:set_blocksize()
+ */
+void check_logical_block_size(const char *id, const char *name, uint16_t value,
+                     Error **errp)
+{
+    const int64_t min = 512;
+    const int64_t max = 32768;
+
+    /* value of 0 means "unset" */
+    if (value && (value < min || value > max)) {
+        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
+                   id, name, (int64_t)value, min, max);
+        return;
+    }
+
+    /* We rely on power-of-2 blocksizes for bitmasks */
+    if ((value & (value - 1)) != 0) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value '%" PRId64
+                   "', it's not a power of 2",
+                   id, name, (int64_t)value);
+        return;
+    }
+}
diff --git a/util/block-helpers.h b/util/block-helpers.h
new file mode 100644
index 0000000000..f06be282a1
--- /dev/null
+++ b/util/block-helpers.h
@@ -0,0 +1,7 @@
+#ifndef BLOCK_HELPERS_H
+#define BLOCK_HELPERS_H
+
+void check_logical_block_size(const char *id, const char *name, uint16_t value,
+                     Error **errp);
+
+#endif /* BLOCK_HELPERS_H */
-- 
2.27.0


