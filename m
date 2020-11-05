Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE10C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA1220795
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pnysEhPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA1220795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVYR-0002o1-Q8
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPj-0007uk-Ps; Wed, 04 Nov 2020 21:54:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPg-0002ZQ-H3; Wed, 04 Nov 2020 21:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544852; x=1636080852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y+4Hkf4JH02Acl3UmgoBUtRDqe6KVXNmEtKOCZ+YtyY=;
 b=pnysEhPr9d0wcjk61qYPwvlL3pLtLykQpSPTfUlSRhN37/zdJZWgpkgH
 zIB4yGkeEFxkEKo7ZWYAAN8AW2TNDduAqSngjVXoUwvFvoikpdRL9US6v
 bOj440ecYMw2E03HAvOW7ewLRfql5c+nJtCZiJl9apBv3E4plZT+x/bhN
 o/K18nOzNzN3oGJLR7606WHGB9qlr2wV6oAUNB6V4FtaUUbK5ZNkDSScu
 9pqLNcWqam36i5p5EpZk/gQFtP2A+nDqwH5Gn0a1UZnTMWUQWhRLs1LKV
 HyqF7miVxxPCxLLF3ZGbCzvM+0y+ZJa8/A4CrSnsWvDCvWAftoZ5N760C g==;
IronPort-SDR: 3A4ho2QpfqSFbPqlwdm9LR8/TuUT8kvPcG55EZVrygvEbEsEYzFTSKsYlh22vnvCluT5mpEYk1
 iCKRRnSyE8EMOTjBGvK8A9XU8xP1PhT+RpxIB4VdGQQXHC2P1yjnxlNwXt8L8Y6lZf7N3MZ/sP
 NUjnrwQnlfPXCUG+XtkVrB42FOP4CRpX5OBpwW72q94BI7FZeVE360sOeWW29AE7TVkcoHGLmW
 47apkn09vQzFi8FRVN8Koku1BPheyHJ6NSLeVuJjAWNPp1PVQADxiuBNS7upU+9Mm3ybSRQdRO
 czY=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335155"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:54:11 +0800
IronPort-SDR: vknzrkYusSPELJ9clrsAIBhTlQwiZ4kvTC4ftAC1eyiWhDTlxjmd1hXTCwKFBAGiQUxNO+nZMD
 39ZOpSZn44L6C/wRJ4QGcdzsAS4oYQ0tGRrVbFt3EBd4YjIJg5+EPD+hflDbE04mJGxCXpBL+P
 feCbv4lTG37HA/DGtat0Z/1AdzYaw3YzsO4ahkTWzdxDVjznYQjk1BvQ1k+oCex1iwOnn39MOz
 EBp882fp6PKWAYo7t2jEP9gaIFIwU8694wCh57WVUfVmyCGTR+S17eIFsOd8I/+mNSM8EulJ6Y
 24T3mPPnJ7ZDLKmBqMxlE+ZH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:40:18 -0800
IronPort-SDR: WPwAO3Dfle3td1Ad2WdtxmEQsjrz00aelb2Hhtd5RyiRZk3WV4V1L21Z7itSIlAn2tplcsOksY
 0gal/3tYCld9RZcOXAVSCNlmVeFnLBSxwNLonAxCIB0NdqEVWnwa+WTdYEh5w0xS3Y9qMGl/vQ
 o966kFbhNiCOAPQogOAse2jADUOnIcJzFAp347xw9UVsyH3VlmetozXewpl30SgrV/pGz4f2/u
 T8oegN9W/uN8Ri5ATAGPcZMAGKbP2J3j4oUqozZGCs7zGTMEeORiaa6eIqzWPdQlNHwthDJkGf
 aY8=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:54:09 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 11/12] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Thu,  5 Nov 2020 11:53:41 +0900
Message-Id: <20201105025342.9037-12-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=571894d84=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:53:45
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
 hw/block/nvme-ns.h |  2 ++
 hw/block/nvme-ns.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

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
 
-- 
2.21.0


