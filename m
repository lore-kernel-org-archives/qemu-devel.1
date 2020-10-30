Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF58CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D56F2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nQ7uLYDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D56F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKIx-0004Zt-0r
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKE7-0006Op-5c; Thu, 29 Oct 2020 22:33:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKE4-0006g5-Sy; Thu, 29 Oct 2020 22:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025192; x=1635561192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pvyeyZ/LZaGRVXzLHJy4W4Vfxrqg+cDrcTWs9R/ZrM8=;
 b=nQ7uLYDLgMt24AP37YJ0/+tpcSz80l7TsPT1Ear8s6mxaupVKrAOhdr/
 wRK9DwFXP/5MLjpSTXgxBfuKg+8wotvi5wL/+r3xIScIwujqP2x6QBjim
 uEGwgoRWHEP042Y8k3NUGtOt3l63Lly2P6dGjzOgntD1wcwGHMKpRQ8lN
 2TKmMECbizKE+gmlxJk9i6f5CT9kFbM0LStkDiyZxUZqKYaxqu6gOMRDu
 fOP7l6PGksQQHSZpfDdP+O6nBZF3wfyV0HImBk1FTHAa1Ji2FiwqNuQqk
 jUJ7ioabhsrLPbICCxVnmvcA1m9UUnXxT25KzDpoqN23spfPZ8xI5yLLU g==;
IronPort-SDR: /HLAp32p9kW30bYa6ay8m8WOvBoPDz2hOVX6yXjuJ5RsWleug7TDM1RclGsOQ43/CZ8drzSDJo
 mxpS7k+yBW2DNIP1vdEMma3nxn9B9vWADluRWDra930p1aKWMd8TvdCtTniBuvwNhPtC7EQV4E
 2hNL4G/PkaAdWbgKjqlMLfDXW4d8tC79TNYcp297bB3yLRwPN6dk0aN8AGL5Ua2UHVXPqeVfGg
 8/cfjHn2jUuEzxFDkdUx6sgawOyltmmjgQLxVBgHhnhymkOkVrInGmB16QKm90/o3MhOvymbSV
 o1A=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748100"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:33:10 +0800
IronPort-SDR: KBgxBoBtgExyz6ZrsYCf3DkeHOjBNMDZz3p/ZJ0eYaqGtXknuK/I5POWRw+Yl7eKyxWTLCDCDO
 RMBOdUbgbuOKd0H6sMDAuwV3jLB+PPHBu8ElwyGKaxHbCjl/Ftw/q6NHImYVj9CdCblkgA2RRX
 6zLyZ5OklW0hU38OxtCyTEJm9FReE7D/O6VVahbNvubnkCoFPDi4s98hUS0I45UHBK85iA7K8u
 ojBeGUq1Ej2eKfl0ZZDA1buDcxCgdmhhiq5BcC8B1+nAoHrw+RSTUF141PtIgVfexs75xIXc3M
 yyoOIv8sWLmkU5BTf7fWi63R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:18:15 -0700
IronPort-SDR: 5Mzp/rLsVYt2EpRPBjgxd0ncK7EMqG6GY4uWt2U0qXEBouHUxl/51p/hqTg6tD5SW0y5JATHsV
 qPLkkf7Dr0mYer0Z5+N8b0a58dVZOHf2ypW0BRV9PKMPksDqRexw+F3Q8kyMZ1liS/WcRE0+Fx
 E6LG2CMPYIVX6D3W8pTX3PlXe6DZDUWXfzQiPy0iNlautNaNDqWPRx7UKSIjz5q/JjdpH7+aTC
 NO8+kCZ5TiSD6U2yFmEzDw6cWl5FRzbIkm0C/EafNjyMkVboexOOv0WluQWZ21GrYeh9TpKQut
 EFk=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:33:10 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 10/11] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Fri, 30 Oct 2020 11:32:41 +0900
Message-Id: <20201030023242.5204-11-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=56530b5a8=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:32:49
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
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme-ns.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme-ns.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 85dc73cf06..5e4a6705cd 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -21,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "crypto/random.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
@@ -145,6 +146,20 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
         }
     }
 
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
 
@@ -153,7 +168,9 @@ static void nvme_init_zone_state(NvmeNamespace *ns)
     uint64_t start = 0, zone_size = ns->zone_size;
     uint64_t capacity = ns->num_zones * zone_size;
     NvmeZone *zone;
+    uint32_t rnd;
     int i;
+    uint16_t zs;
 
     ns->zone_array = g_malloc0(ns->zone_array_size);
     if (ns->params.zd_extension_size) {
@@ -180,6 +197,37 @@ static void nvme_init_zone_state(NvmeNamespace *ns)
         zone->w_ptr = start;
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
@@ -353,6 +401,10 @@ static Property nvme_ns_props[] = {
                        params.max_open_zones, 0),
     DEFINE_PROP_UINT32("zoned.descr_ext_size", NvmeNamespace,
                        params.zd_extension_size, 0),
+    DEFINE_PROP_UINT32("zoned.offline_zones", NvmeNamespace,
+                       params.nr_offline_zones, 0),
+    DEFINE_PROP_UINT32("zoned.rdonly_zones", NvmeNamespace,
+                       params.nr_rdonly_zones, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 50a6a0e1ac..b30478e5d7 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -36,6 +36,8 @@ typedef struct NvmeNamespaceParams {
     uint32_t max_active_zones;
     uint32_t max_open_zones;
     uint32_t zd_extension_size;
+    uint32_t nr_offline_zones;
+    uint32_t nr_rdonly_zones;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
-- 
2.21.0


