Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7DC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90ED21D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EnTzJAjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90ED21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaRn-00005x-Md
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaHY-0000v2-6G; Sun, 13 Sep 2020 18:15:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaHW-0001IS-3G; Sun, 13 Sep 2020 18:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035333; x=1631571333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rza44LwKBuiPgf9tC8NgwfcOAh+uwvRuidSXjufbULc=;
 b=EnTzJAjAJ54UZ3nYrTZwn+8iOilxsx4x9r4ZN+xRJ3x4hxKoHftcl9Kr
 EXRDiU6l8glmmsZNFdZgLcwLN562wAlMZdWRX5KgFgvS8OTJ++/nGtLSF
 DzGB5U39Pm4NKjnIR+dXr6HQkI5Huupy1V0VJ/eZYlH5vlzyYTeqyx6wX
 /F8Q+iN8yzBC8BA9udkFHm1887Ro7zOyUxvnIiBczwWcfh31zOzVA+vZa
 QNMQxQz0UeOhmHUA/x0ruZBNxK/Hxn4x1OybiTnsngHhuNywRWycwgB9e
 YibHQOSV9bIUjDizCp0fsSV5cVQqfXks/3+mKsly4aCJH/dnAwqksFxkS w==;
IronPort-SDR: oflwiGlOew7gAHgC4QG40m7/62zXgSMhQqr7QJ+p+2wh1wdKMNmYTNOIs0Wuv3Fp7Ej463yx2o
 ixdVYrMG715YtJZ3uyWcNkJzt5exz8aX8BYhbYd3PtPf4XFUKidCdPLPxPXi/K7hPDmUti+xo1
 nW4gGxiebtK3lLSjys3/ZwarvZ2MSFelv1pK5vOpXraB8eX7hvje+g5KYBrcuar8ljzTd6GCdV
 +N/h/zPSjptpo9L2bl7KtKWK9sb3kD929jHJxuZB+yUoQp1eDYf9/OFV7X4bR2ftR72exi4Ak7
 /zw=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179073"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:15:12 +0800
IronPort-SDR: 25UW4kDuugjmZO+kMvTtTDaRAzy3nrh3YVPoJ3n/W/I7K3cQ8HPxUDigAMr2lsgzTcryXabj2x
 dX8/3KIw6qYA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:02:24 -0700
IronPort-SDR: rcfnjkkhK0oknNw0S0nhCRftuakxMQvLiybj8KMHK8aT3tga1/0TG97/okB2aKOc9ySBJtvdG1
 5IX2z23C1fdg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:15:11 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 13/15] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Mon, 14 Sep 2020 07:14:34 +0900
Message-Id: <20200913221436.22844-14-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
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
 hw/block/nvme.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f15f1d65dd..b49ae83dd5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -3361,8 +3361,11 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
                                uint64_t capacity)
 {
     NvmeZone *zone;
+    Error *err;
     uint64_t start = 0, zone_size = n->zone_size;
+    uint32_t rnd;
     int i;
+    uint16_t zs;
 
     ns->zone_array = g_malloc0(n->zone_array_size);
     ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
@@ -3392,6 +3395,37 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
         start += zone_size;
     }
 
+    /* If required, make some zones Offline or Read Only */
+
+    for (i = 0; i < n->params.nr_offline_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), &err);
+            rnd %= n->num_zones;
+        } while (rnd < n->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_OFFLINE);
+        } else {
+            i--;
+        }
+    }
+
+    for (i = 0; i < n->params.nr_rdonly_zones; i++) {
+        do {
+            qcrypto_random_bytes(&rnd, sizeof(rnd), &err);
+            rnd %= n->num_zones;
+        } while (rnd < n->params.max_open_zones);
+        zone = &ns->zone_array[rnd];
+        zs = nvme_get_zone_state(zone);
+        if (zs != NVME_ZONE_STATE_OFFLINE &&
+            zs != NVME_ZONE_STATE_READ_ONLY) {
+            nvme_set_zone_state(zone, NVME_ZONE_STATE_READ_ONLY);
+        } else {
+            i--;
+        }
+    }
+
     return 0;
 }
 
@@ -3440,6 +3474,16 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
                     " adjusting", n->params.max_active_zones, nz);
         n->params.max_active_zones = nz;
     }
+    if (n->params.max_open_zones < nz) {
+        if (n->params.nr_offline_zones > nz - n->params.max_open_zones) {
+            n->params.nr_offline_zones = nz - n->params.max_open_zones;
+        }
+        if (n->params.nr_rdonly_zones >
+            nz - n->params.max_open_zones - n->params.nr_offline_zones) {
+            n->params.nr_rdonly_zones =
+                nz - n->params.max_open_zones - n->params.nr_offline_zones;
+        }
+    }
     if (n->params.zd_extension_size) {
         if (n->params.zd_extension_size & 0x3f) {
             error_setg(errp,
@@ -3872,6 +3916,8 @@ static Property nvme_props[] = {
                        params.zd_extension_size, 0),
     DEFINE_PROP_UINT32("max_active", NvmeCtrl, params.max_active_zones, 0),
     DEFINE_PROP_UINT32("max_open", NvmeCtrl, params.max_open_zones, 0),
+    DEFINE_PROP_UINT32("offline_zones", NvmeCtrl, params.nr_offline_zones, 0),
+    DEFINE_PROP_UINT32("rdonly_zones", NvmeCtrl, params.nr_rdonly_zones, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
     DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e53388ba66..9a5f4787b7 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -25,6 +25,8 @@ typedef struct NvmeParams {
     uint32_t    max_active_zones;
     uint32_t    max_open_zones;
     uint32_t    zd_extension_size;
+    uint32_t    nr_offline_zones;
+    uint32_t    nr_rdonly_zones;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
-- 
2.21.0


