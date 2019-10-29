Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4160CA9EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7A52086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35079 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaor-0004D6-Hj
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaUG-0000jK-Mq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaUF-0004bs-3i
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaUE-0004Zv-PU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:15 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDD12C057EC0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:01:13 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id b29so233020qka.23
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kU+fvYbSi4SNNm416qjlZtMeiPC4Sd5LtfZkMAZWj34=;
 b=ANcObxgWAE6pNuQ7Hd0nFl+fYMXSYryonkOgsCK5khGc1CnHTj1g75T/euM4Qzhipn
 y9xFg+1aWLxZRQROKoZWdLeRTLLVMzEoDJkWD4i+hSqd28AnlUxzi9pPmo8FTjrxOPOB
 mn6FxjWYxUkTLiP/3JRFqSPlNEGeMB01gDsWuMaN9w4L8wKAsV65eJMcNlM+AVNWlcxs
 I9gEe6+fcnhcBtnaTNFgmoP2D7ZromDoRgKva3evvyFKu1NC9fld683ExxHjEmO8hLeY
 3NDq1CWvK0fdd4DN33W2zWYZy6SAoTa1zFs81DWCQ8987c7ktrdgCGR7g6C3WihCa24g
 H3uw==
X-Gm-Message-State: APjAAAWJv78E8Fmh4aDFQoISyZpVzyWMUMBzHmr4AdpmFkz6pBPHOk90
 3QirCJmblSsMmKoeeAtWafi9zin+uR3KC240fMiQgYAu+xDttqTwhGvqWi1efjwJ+qWPsRFkLyn
 DY3p7Pto8H7aLdfI=
X-Received: by 2002:ac8:18af:: with SMTP id s44mr1809706qtj.1.1572390072738;
 Tue, 29 Oct 2019 16:01:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNs3BzoTqDNRPtGt0MT2e51Volguka6sh4JsxJetSEEDq4KlU8hsi6M2vYLmer97XgqdIAqw==
X-Received: by 2002:ac8:18af:: with SMTP id s44mr1809672qtj.1.1572390072346;
 Tue, 29 Oct 2019 16:01:12 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id d76sm365154qkb.57.2019.10.29.16.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:01:11 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:01:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] vfio: unplug failover primary device before migration
Message-ID: <20191029225932.14585-12-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

As usual block all vfio-pci devices from being migrated, but make an
exception for failover primary devices. This is achieved by setting
unmigratable to 0 but also add a migration blocker for all vfio-pci
devices except failover primary devices. These will be unplugged before
migration happens by the migration handler of the corresponding
virtio-net standby device.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <20191029114905.6856-12-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/pci.c | 26 ++++++++++++++++++++------
 hw/vfio/pci.h |  1 +
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 12fac39804..e6569a7968 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -40,6 +40,7 @@
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/blocker.h"
 
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
@@ -2732,6 +2733,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    if (!pdev->failover_pair_id) {
+        error_setg(&vdev->migration_blocker,
+                "VFIO device doesn't support migration");
+        ret = migrate_add_blocker(vdev->migration_blocker, &err);
+        if (err) {
+            error_propagate(errp, err);
+            error_free(vdev->migration_blocker);
+            return;
+        }
+    }
+
     vdev->vbasedev.name = g_path_get_basename(vdev->vbasedev.sysfsdev);
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
@@ -3008,6 +3020,10 @@ out_teardown:
     vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    if (vdev->migration_blocker) {
+        migrate_del_blocker(vdev->migration_blocker);
+        error_free(vdev->migration_blocker);
+    }
 }
 
 static void vfio_instance_finalize(Object *obj)
@@ -3019,6 +3035,10 @@ static void vfio_instance_finalize(Object *obj)
     vfio_bars_finalize(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
+    if (vdev->migration_blocker) {
+        migrate_del_blocker(vdev->migration_blocker);
+        error_free(vdev->migration_blocker);
+    }
     /*
      * XXX Leaking igd_opregion is not an oversight, we can't remove the
      * fw_cfg entry therefore leaking this allocation seems like the safest
@@ -3151,11 +3171,6 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const VMStateDescription vfio_pci_vmstate = {
-    .name = "vfio-pci",
-    .unmigratable = 1,
-};
-
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3163,7 +3178,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vfio_pci_reset;
     dc->props = vfio_pci_dev_properties;
-    dc->vmsd = &vfio_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 834a90d646..b329d50338 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -168,6 +168,7 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
+    Error *migration_blocker;
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
-- 
MST


