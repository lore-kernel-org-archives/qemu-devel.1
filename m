Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F549C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE752206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZF1F4ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE752206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgq7H-0003Gk-77
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgq6h-0002kN-Hj
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:40:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgq6g-00079D-IH
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:40:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id x6so6107098wrm.13
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yYKjpgihVM7BIyrybHg74VcmdTrT1AUmeK/VFZsIFzI=;
 b=hZF1F4ysXVU2AugW0bO6FfwtcoS9YvDGxhRoGTw6O1GimdcfBNglpCQY0+VllMY6M1
 A9Fgir/DhqT30lRGFCct3sd+l150owQr8hJmgv/phqQ2N8pHzu84QtiNouCvOZK6VSG3
 JN+oIDjdp/b6OPFjwsWIVO0I+bjdhdaBG0RMAsLwB3Cq+FaY/GqVPNnvzqjvzrWVu8gJ
 i0M253KVoI25mvt4mnO9P4KhmT7U8MNMLhIRFkX4ZpZZq+cPGuLWCsCaEd9McmL5b+2Y
 xffLFo7BZgS5fUia0U/Dspfl9XpeiuVJNnr2crOGtCGUvIpMg8SJmKaw6eG+lHneLMp1
 7qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yYKjpgihVM7BIyrybHg74VcmdTrT1AUmeK/VFZsIFzI=;
 b=j3OMqrl0+CooA/s/1vfSI7b15Q2eX/dF+nsbvpa/JqpMylqtYfpQdUHVLbGEwmiAgm
 Y8veATZiKSUH6uXQlshIl2JB+CMMwOogwONQo19MT/CKZ6yS8If2oUXAgO1kEFA4Kxvr
 z1edsjPlGfxJee9MmrtXPlZUFpnT1t5TLMbSCbQErZSrywQ7or5mxPEyy9VRXXeJIHHL
 NSLEdra22qtr1kRH5sVjaoIoHuBVHEUCmu4yP8iVMm2mGrTQmQow0KLL2qzzROrXoVSN
 MOd0zfGzIf3t5kvVhcJeryaRIHnn9apwDp3X3gjXNZU/AOHJ4CDoU0HKduo+sFQu7ahg
 ST/g==
X-Gm-Message-State: AOAM531SY7FQSISQPHpvKEiyLGRuk+SIlt/z3wbMizuCUg89npFp0bw0
 AMKJeidgbgH1F4qVjDV6FRoF4g==
X-Google-Smtp-Source: ABdhPJxsQTJ/WIBkeiA9PCzRUl7fpj2pngBT4jenGnS88l551b7svJPTGB+gqvoy1LyEvR8gY5H9gA==
X-Received: by 2002:adf:f512:: with SMTP id q18mr4903285wro.38.1591278029014; 
 Thu, 04 Jun 2020 06:40:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm6935484wmi.3.2020.06.04.06.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 06:40:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECC1A1FF7E;
 Thu,  4 Jun 2020 14:40:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Date: Thu,  4 Jun 2020 14:40:22 +0100
Message-Id: <20200604134022.10564-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
down the line.

Re-factor the code so:

  - steps are clearer to follow
  - reason for rejection is recorded in the trace point
  - we allow DIRTY_MEMORY_CODE when TCG is enabled

We expand the comment to explain that kernel based vhost has specific
support for migration tracking.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

---
v2
  - drop enum, add trace_vhost_reject_section
  - return false at any fail point
  - unconditionally add DIRTY_MEMORY_CODE to handled cases
  - slightly re-word the explanatory comment and commit message
---
 hw/virtio/vhost.c      | 55 ++++++++++++++++++++++++++++++------------
 hw/virtio/trace-events |  3 ++-
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede5..120c0cc747b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
+#include "sysemu/tcg.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -403,26 +404,48 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
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
+    MemoryRegion *mr = section->mr;
+
+    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
+        uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
+        uint8_t handled_dirty;
+
+        /*
+         * Kernel based vhost doesn't handle any block which is doing
+         * dirty-tracking other than migration for which it has
+         * specific logging support. However for TCG the kernel never
+         * gets involved anyway so we can also ignore it's
+         * self-modiying code detection flags.
+         */
+        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION);
+        handled_dirty |= (1 << DIRTY_MEMORY_CODE);
 
-    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
-        result &=
-            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
-    }
+        if (dirty_mask & ~handled_dirty) {
+            trace_vhost_reject_section(mr->name, 1);
+            return false;
+        }
+
+        if (dev->vhost_ops->vhost_backend_mem_section_filter &&
+            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, section)) {
+            trace_vhost_reject_section(mr->name, 2);
+            return false;
+        }
 
-    trace_vhost_section(section->mr->name, result);
-    return result;
+        trace_vhost_section(mr->name);
+        return true;
+    } else {
+        trace_vhost_reject_section(mr->name, 3);
+        return false;
+    }
 }
 
 static void vhost_begin(MemoryListener *listener)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 84ecb85d445..22427126b97 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -5,7 +5,8 @@ vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_merge(const char *name, uint64_t new_size, uint64_t gpa, uint64_t owr) "%s: size: 0x%"PRIx64 " gpa: 0x%"PRIx64 " owr: 0x%"PRIx64
 vhost_region_add_section_aligned(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
-vhost_section(const char *name, int r) "%s:%d"
+vhost_section(const char *name) "%s"
+vhost_reject_section(const char *name, int d) "%s:%d"
 vhost_iotlb_miss(void *dev, int step) "%p step %d"
 
 # vhost-user.c
-- 
2.20.1


