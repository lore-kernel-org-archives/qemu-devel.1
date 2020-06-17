Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94052168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jnrs2+Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94052168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfzK-0002Jm-0Z
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfiG-0004VA-TI; Wed, 17 Jun 2020 17:35:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfiB-0005JY-Q0; Wed, 17 Jun 2020 17:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429711; x=1623965711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/sSHcIhm5eWSXAnSAtJNBXblShOO29y8cAr3J7pSXMw=;
 b=jnrs2+GfZYmI1Jg0LoEXtlIs6PSGsMk/g8R/oyv7duocvlTiuSU+5+dS
 Rb0xL6h67IN9AtJCSYvR7jE1b+DfB8HUzYXIbU20l+fky2fWDPQHWZ0Ag
 TwBHZfazA2lVqj3v/4eKVKjeYTXUinmvrlUc7Uy4R8aNlNqPYqrqfTLpu
 ERRXPpLwrpSnH2ZKS57YY2ipW3e/RsiO24aShj9YAM6EmCXaRmBStd8En
 /QPT68aDf15LBMLSGJXX6rKXB6ax5Bo0LKP4Z3MImV1CO0ktpLJxMS/Dm
 DKp1i+JEeJm0aYDopTBVOdlTFmeiMU4+zETPuQR0il557frLXJOuhrnJK Q==;
IronPort-SDR: lZl8vRBTvx66mX/iWSBQsc8GnhL4DVAgmqhwDMe7KhK+vRYrMe9s0sWxnyfc4euOOrhyB00xWo
 xAgBacLAiDh7PmDUdkjzOJ4ucAFKMQRLrv/QJwVGyGsEn6Ad2GWKbqsYCT1eB4L0k4DahQnDFM
 OPhhU4sHMAQjzfPTdJWpDWLe1wRkBEot4Hcg95I+sTtLHkvKAcEsVrOu7Ds+m3rfifPbJ6rf4B
 ONdXIF3UVAKLtvKvdP/02/miKpKcQiRiFOXtCoibBdgBRYPHFjbrRS4Vh9U/X6QvACU1FSTzjx
 nBA=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439830"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:49 +0800
IronPort-SDR: PEa+FCbeO0tHQfV3+wJtdTLzhxcIqOViDxJUmDyOjn2KJraaRVz/q0tWwJS3JJ8q0th04awRlb
 QAm7P4vJiRECs7OCIEgRlgo0IG971j5TA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:31 -0700
IronPort-SDR: W2J6aehr5zbeKew7QrLRUZe2nEe48EBK2+8hMwbwqfb6lPxRC/ck9J+Ij+lpEW3b6nqcWRRk+I
 k5oolLvYdHbA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:48 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 12/18] hw/block/nvme: Simulate Zone Active excursions
Date: Thu, 18 Jun 2020 06:34:09 +0900
Message-Id: <20200617213415.22417-13-dmitry.fomichev@wdc.com>
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

Added a Boolean flag to turn on simulation of Zone Active Excursions.
If the flag, "active_excursions", is set to true, the driver will try
to finish one of the currently open zone if max active zones limit is
going to get exceeded.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 24 +++++++++++++++++++++++-
 hw/block/nvme.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 05a7cbcfcc..a29cbfcc96 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -540,6 +540,26 @@ static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
 {
     NvmeZone *zone;
 
+    if (n->params.active_excursions && adding_active &&
+        n->params.max_active_zones &&
+        ns->nr_active_zones == n->params.max_active_zones) {
+        zone = nvme_peek_zone_head(ns, ns->closed_zones);
+        if (zone) {
+            /*
+             * The namespace is at the limit of active zones.
+             * Try to finish one of the currently active zones
+             * to make the needed active zone resource available.
+             */
+            nvme_aor_dec_active(n, ns);
+            nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
+            zone->d.za &= ~(NVME_ZA_FINISH_RECOMMENDED |
+                            NVME_ZA_RESET_RECOMMENDED);
+            zone->d.za |= NVME_ZA_FINISHED_BY_CTLR;
+            zone->tstamp = 0;
+            trace_pci_nvme_zone_finished_by_controller(zone->d.zslba);
+        }
+    }
+
     if (implicit && n->params.max_open_zones &&
         ns->nr_open_zones == n->params.max_open_zones) {
         zone = nvme_remove_zone_head(n, ns, ns->imp_open_zones);
@@ -2631,7 +2651,7 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
     ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
     ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
-    ns->id_ns_zoned->zoc = 0;
+    ns->id_ns_zoned->zoc = cpu_to_le16(n->params.active_excursions ? 0x2 : 0);
     ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
 
     ns->id_ns_zoned->lbafe[lba_index].zsze = cpu_to_le64(n->params.zone_size);
@@ -2993,6 +3013,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
     DEFINE_PROP_INT32("max_open", NvmeCtrl, params.max_open_zones, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
+    DEFINE_PROP_BOOL("active_excursions", NvmeCtrl, params.active_excursions,
+                     false),
     DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index f5a4679702..8a0aaeb09a 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -15,6 +15,7 @@ typedef struct NvmeParams {
 
     bool        zoned;
     bool        cross_zone_read;
+    bool        active_excursions;
     uint8_t     fill_pattern;
     uint32_t    zamds_bs;
     uint64_t    zone_size;
-- 
2.21.0


