Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD2621841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L7bSmZHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD2621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlg4O-0003ZI-MF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfih-00057c-TH; Wed, 17 Jun 2020 17:35:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfid-0005I4-Uc; Wed, 17 Jun 2020 17:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429739; x=1623965739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hCiBihXKhrGYvmr/DCEkxrCWLvTyFSwDX1pbG2ju8+8=;
 b=L7bSmZHAreNwuUsEiJrOAiU0eGqjEOWs9OtR13YXfPgRxWwCG4jaETYh
 tIaMl79WaD4wcOXSiu4b+iOijluUyIR6Ok5MOdb4PN0gBTDKMtlXxcZTD
 Q4S1anqY2HThoXPlIC2nv9sUsjEP7v9Bvnr/2DkG2wOYv71pYibc4yjoq
 bd71Zq45L+rZoyxGqZykRZsZmoopDoqvD9IdRPHG9KFivXS4Y53k/zJ6D
 F7swZldXGOjm7xGll9nr6arLWVsBw1EplOaHS/FoosYgmkSLNIiNqeHE+
 f7hsonzrwmJ1J6Wr5PMT+c1MnCVqC6UXXJvt38QOGqUkeHXxRKyrXsRFm Q==;
IronPort-SDR: EnTkio7aGhYn/2VW0MDwsZ0Q8wUVW1P6pOeLPKWD4CQb+lTnWzGfNV3Ts+9fFQiev8exwm8fV9
 TAIEuuLrEaF268UXar8k2i1QoGnJdiOBnlqKeuN5T00zAPnugWmFYoBNnCeWbKh8qHT3q+aMVW
 q1rN5Rx+I/s5ADpyCAyiTWgtl/JC91jvnSSlpE2ceIqsA24DaQzvTHW1hqhVindzBMUWbdnGbM
 Mwmg1jOFMSr7bnTssZ9NTRkBsdPHLftui607BJ5syW+SpliPYQsEbXJTdQ6OEZeV6f/f3OgOEj
 JIU=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439841"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:57 +0800
IronPort-SDR: /yYqzkwZy+dnecLa3iR9Yf8FNswy/XsEeYOjDaV+84C5aoOqBlJpJicex2iZMOawqV26H/4m9K
 7Bn455yecqINhAi4E9YBaQLmwebj2MMfo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:38 -0700
IronPort-SDR: hw51t470GWvgcY65yZZ7hglqP/N/sdjX5eGTo0rOkaB6oyTC08jTVLpdFFl31qmZGqd2TneR9A
 qPkwNMjuQvXA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:56 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 16/18] hw/block/nvme: Add injection of Offline/Read-Only
 zones
Date: Thu, 18 Jun 2020 06:34:13 +0900
Message-Id: <20200617213415.22417-17-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZNS specification defines two zone conditions for the zones that no
longer can function properly, possibly because of flash wear or other
internal fault. It is useful to be able to "inject" a small number of
such zones for testing purposes.

This commit defines two optional driver properties, "offline_zones"
and "rdonly_zones". User can assign non-zero values to these variables
to specify the number of zones to be initialized as Offline or
Read-Only. The actual number of injected zones may be smaller than the
requested amount - Read-Only and Offline counts are expected to be much
smaller than the total number of drive zones.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index eb41081627..14d5f1d155 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2980,8 +2980,11 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
     uint64_t capacity)
 {
     NvmeZone *zone;
+    Error *err;
     uint64_t start = 0, zone_size = n->params.zone_size;
+    uint32_t rnd;
     int i;
+    uint16_t zs;
 
     ns->zone_array = g_malloc0(n->zone_array_size);
     ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
@@ -3011,6 +3014,37 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
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
 
@@ -3063,6 +3097,16 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
     if (n->params.max_active_zones > nz) {
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
@@ -3471,6 +3515,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT64("finish_rcmnd_delay", NvmeCtrl,
                        params.fzr_delay_usec, 0),
     DEFINE_PROP_UINT64("finish_rcmnd_limit", NvmeCtrl, params.frl_usec, 0),
+    DEFINE_PROP_UINT32("offline_zones", NvmeCtrl, params.nr_offline_zones, 0),
+    DEFINE_PROP_UINT32("rdonly_zones", NvmeCtrl, params.nr_rdonly_zones, 0),
     DEFINE_PROP_BOOL("zone_async_events", NvmeCtrl, params.zone_async_events,
                      true),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 4251295917..900fc54809 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -24,6 +24,8 @@ typedef struct NvmeParams {
     uint64_t    zone_capacity;
     int32_t     max_active_zones;
     int32_t     max_open_zones;
+    uint32_t    nr_offline_zones;
+    uint32_t    nr_rdonly_zones;
     uint32_t    zd_extension_size;
     uint64_t    rzr_delay_usec;
     uint64_t    rrl_usec;
-- 
2.21.0


