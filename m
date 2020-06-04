Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BDFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E06E206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wz26euMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E06E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnp7-0005Az-AM
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgnoa-0004jp-4Q
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:13:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgnoY-0007Cm-Ms
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:13:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id u26so6592412wmn.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hPkAn3Wk+ccPQ0JLMy6+RY9Cyczc0SzA1FixicEebSI=;
 b=wz26euMZehF3KIKOaWhQ3qo95B/jWzHXiHsQNUzDczui5/Duf/it41VGopEqK5QzS3
 CcbavhhidF+AV4+cN7VsISVXJ6n6oDo77wfb14c411m2Ufyrq6MafmJbEATixYyY3xnD
 h0ocy5+Cs8J2HhGcsmQ9wBP9ca33fo/BmsWJxrnHGWWnSebfvhb6qixjwR6buM+kCHfc
 YY1yaCpxXymXditc6GM7E4b/rHu+S5jGfYfxobSpuy98R+PP7pp+VG3qhbApz9QQdBKq
 wAN5ySQqAiOh5Ttc2jkw87YXjT7TMO2N4uW7KphUUeBN26aV9J2bpBZzZmwT5aUIbjlq
 /4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hPkAn3Wk+ccPQ0JLMy6+RY9Cyczc0SzA1FixicEebSI=;
 b=PocgNpUb0h7WvcaQAVyOJoH71I3fof51xue7D+JQqcrOFR1CQJlxOn9eZflkam5ZoR
 Vt8YvtHwRwxulmdbeskcoJn2ViwIzF2AzsejoDquUEJxqYtiJgFn4HUeVf2hfowpmx1k
 R/o1PjfmZtD72+1fP1PotcotfQbMpJDi01j2d5mSv2YU9rBHu64BhW3UinTFcpuDw7U2
 rV3W8pkzkKEQHoo9+/Kl+ulKIGYwx0M5U0jISbmyT0EAs1SU7fVdN0q//70gDydkv7fk
 8Sr2LojFKD8r+RzaJAm0OEY1Qh07Q0dIQM538+ic+vC1a97pgbPuqnYHMeRIIG3Kjftz
 0m5Q==
X-Gm-Message-State: AOAM533vmdGUc6RwYGsaPxgT4QB13H/QCYssvAWNkipoTFnjKpgY7Gur
 kbfb0Zh6nwBhB2Hx2zmwFUyU5w==
X-Google-Smtp-Source: ABdhPJw3oQOKNN84mBKtLGl82hysnvpuhzFo9KW15YBMJqV2g6PcCUXOG+aWoj2pl285qZPIp7Ru5Q==
X-Received: by 2002:a05:600c:23ce:: with SMTP id
 p14mr3546448wmb.77.1591269217057; 
 Thu, 04 Jun 2020 04:13:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w3sm7353254wmg.44.2020.06.04.04.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:13:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B29DC1FF7E;
 Thu,  4 Jun 2020 12:13:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Date: Thu,  4 Jun 2020 12:13:23 +0100
Message-Id: <20200604111323.7458-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of vhost_section is to identify RAM regions that need to
be made available to a vhost client. However when running under TCG
all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
down the line. The original comment implies VGA regions are a problem
but doesn't explain why vhost has a problem with it.

Re-factor the code so:

  - steps are clearer to follow
  - reason for rejection is recorded in the trace point
  - we allow DIRTY_MEMORY_CODE when TCG is enabled

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede5..f81fc87e74c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
+#include "sysemu/tcg.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -403,26 +404,43 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
     return r;
 }
 
+/*
+ * vhost_section: identify sections needed for vhost access
+ *
+ * We only care about RAM sections here (where virtqueue can live). If
+ * we find one we still allow the backend to potentially filter it out
+ * of our list.
+ */
 static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
-    bool result;
-    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
-                     ~(1 << DIRTY_MEMORY_MIGRATION);
-    result = memory_region_is_ram(section->mr) &&
-        !memory_region_is_rom(section->mr);
-
-    /* Vhost doesn't handle any block which is doing dirty-tracking other
-     * than migration; this typically fires on VGA areas.
-     */
-    result &= !log_dirty;
+    enum { OK = 0, NOT_RAM, DIRTY, FILTERED } result = NOT_RAM;
+
+    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(section->mr)) {
+        uint8_t dirty_mask = memory_region_get_dirty_log_mask(section->mr);
+        uint8_t handled_dirty;
 
-    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
-        result &=
-            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
+        /*
+         * Vhost doesn't handle any block which is doing dirty-tracking other
+         * than migration; this typically fires on VGA areas. However
+         * for TCG we also do dirty code page tracking which shouldn't
+         * get in the way.
+         */
+        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION);
+        if (tcg_enabled()) {
+            handled_dirty |= (1 << DIRTY_MEMORY_CODE);
+        }
+        if (dirty_mask & ~handled_dirty) {
+            result = DIRTY;
+        } else if (dev->vhost_ops->vhost_backend_mem_section_filter &&
+            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, section)) {
+            result = FILTERED;
+        } else {
+            result = OK;
+        }
     }
 
     trace_vhost_section(section->mr->name, result);
-    return result;
+    return result == OK;
 }
 
 static void vhost_begin(MemoryListener *listener)
-- 
2.20.1


