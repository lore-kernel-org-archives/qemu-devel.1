Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B226C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D232F22207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bWMnLzgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D232F22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMjCu-0003cC-V4
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1c-0007j1-Nm; Sun, 27 Sep 2020 22:36:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1a-0003Qn-SP; Sun, 27 Sep 2020 22:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260582; x=1632796582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VAGNi4spwsntd9O1DrvwvG6JaIyYEgfNJFW+sZPWRqI=;
 b=bWMnLzgVMtpGcgegrNAm7h74r3PmD/OApF5JanYBW15+w6OerFzEXpzw
 Y02BOQA8IemuyBwgdmFijvEQ1PxkLDrAAVp/FCe/tPOdnw0RBSaQCq+bX
 YX8PQENRnVdIvVKAg/rVeyrYl/vRmmI4TshUuHnZB0cl89pZkw7gPsTLa
 p0SNWBEQ3T4fhQRgyXMwREOpnuQLu2C8MnT1j1wCnaL7kCS6bqdsqcOvL
 V5EUZ/aW0pp457bOnl3S0uoZLC/qFXfxL+ECum8Ig4cwYrpLgLQk5IsNu
 zDpt7NDW/GQ/Cy5efZHuRDgjlQ3PIt/bXslYdRFjs21Niv7p11FQWZMXe g==;
IronPort-SDR: j1+vUmkjWV0hmIZAO76jfzYWJ/zQV0rQMKC15m4JERe3BeRrezQHEeehqLfDqaBgcEE8dhSP8M
 5JTC+PvZLlSpZJZzsJc9XXHfV47bK6vsgc/UzQ8dYQRAMiqEfmhYpeblDCiqXdlq97z2NMmZuZ
 xSttt5zUqtJnlyo7Q92gPdW3AkI/tfQpD5No+kFvkwa9xvG52WOKIfmNVzFOWkNoWaGsZkl1mE
 Q7jF0ChxJl8+Akj/IRG+j1u8uInyPtTOXVcHme2NkBk0E2iB4UgzNwUHNJJ2UbOAGLc47Xxtnp
 D7g=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125251"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:36:00 +0800
IronPort-SDR: 82Dvgp2jxDTCAusTx0fB1e3SMP39dS8+ag8AWYzg2PmjY1fw00+Ka44KargdIgWg0DU0HBemn4
 05cFxXV2YWoA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:57 -0700
IronPort-SDR: /7X+CZ8f5qcbWvHiD28CG1WhfZlGmopsGvWLjM/hDr5eDU+Xc1/8YuPhpQ64hBKpW3YJmxrMVe
 4RDQu5FoSHDg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:59 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 12/14] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Mon, 28 Sep 2020 11:35:26 +0900
Message-Id: <20200928023528.15260-13-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZNS specification defines two zone conditions for the zones that no
longer can function properly, possibly because of flash wear or other
internal fault. It is useful to be able to "inject" a small number of
such zones for testing purposes.

This commit defines two optional device properties, "offline_zones"
and "rdonly_zones". Users can assign non-zero values to these variables
to specify the number of zones to be initialized as Offline or
Read-Only. The actual number of injected zones may be smaller than the
requested amount - Read-Only and Offline counts are expected to be much
smaller than the total number of zones on a drive.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme-ns.h |  2 ++
 hw/block/nvme.c    |  1 -
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 60156dfeaf..47751f2d54 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -21,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "crypto/random.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
@@ -192,6 +193,32 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    if (ns->params.zd_extension_size) {
+        if (ns->params.zd_extension_size & 0x3f) {
+            error_setg(errp,
+                "zone descriptor extension size must be a multiple of 64B");
+            return -1;
+        }
+        if ((ns->params.zd_extension_size >> 6) > 0xff) {
+            error_setg(errp, "zone descriptor extension size is too large");
+            return -1;
+        }
+    }
+
+    if (ns->params.max_open_zones < nz) {
+        if (ns->params.nr_offline_zones > nz - ns->params.max_open_zones) {
+            error_setg(errp, "offline_zones value %u is too large",
+                ns->params.nr_offline_zones);
+            return -1;
+        }
+        if (ns->params.nr_rdonly_zones >
+            nz - ns->params.max_open_zones - ns->params.nr_offline_zones) {
+            error_setg(errp, "rdonly_zones value %u is too large",
+                ns->params.nr_rdonly_zones);
+            return -1;
+        }
+    }
+
     return 0;
 }
 
@@ -200,7 +227,9 @@ static void nvme_init_zone_meta(NvmeNamespace *ns)
     uint64_t start = 0, zone_size = ns->zone_size;
     uint64_t capacity = ns->num_zones * zone_size;
     NvmeZone *zone;
+    uint32_t rnd;
     int i;
+    uint16_t zs;
 
     ns->zone_array = g_malloc0(ns->zone_array_size);
     ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
@@ -233,6 +262,37 @@ static void nvme_init_zone_meta(NvmeNamespace *ns)
         zone->next = 0;
         start += zone_size;
     }
+
+    /* If required, make some zones Offline or Read Only */
+
+    for (i = 0; i < ns->params.nr_offline_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), NULL);
+            rnd %= ns->num_zones;
+        } while (rnd < ns->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_OFFLINE);
+        } else {
+            i--;
+        }
+    }
+
+    for (i = 0; i < ns->params.nr_rdonly_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), NULL);
+            rnd %= ns->num_zones;
+        } while (rnd < ns->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE &&
+            zs != NVME_ZONE_STATE_READ_ONLY) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_READ_ONLY);
+        } else {
+            i--;
+        }
+    }
 }
 
 static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
@@ -358,6 +418,10 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("max_open", NvmeNamespace, params.max_open_zones, 0),
     DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeNamespace,
                        params.zd_extension_size, 0),
+    DEFINE_PROP_UINT32("offline_zones", NvmeNamespace,
+                       params.nr_offline_zones, 0),
+    DEFINE_PROP_UINT32("rdonly_zones", NvmeNamespace,
+                       params.nr_rdonly_zones, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index ed14644e09..e9b90f9677 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -48,6 +48,8 @@ typedef struct NvmeNamespaceParams {
     uint32_t max_active_zones;
     uint32_t max_open_zones;
     uint32_t zd_extension_size;
+    uint32_t nr_offline_zones;
+    uint32_t nr_rdonly_zones;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 27d191c659..80973f3ff6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -54,7 +54,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "crypto/random.h"
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
-- 
2.21.0


