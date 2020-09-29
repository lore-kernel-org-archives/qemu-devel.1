Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE98C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4910520773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4910520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPCC-0003zs-3v
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuj-0000xc-Jh; Tue, 29 Sep 2020 19:20:07 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOue-0000AA-Nj; Tue, 29 Sep 2020 19:20:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 09226EAB;
 Tue, 29 Sep 2020 19:19:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=F9KxneCu7sQ8Y
 q9t+Jyk/wjRwtWvywodl5Tkh60KQ44=; b=lY4gSmPij6ysow3rlo2N6zhwTa7+f
 rrURSnb7olBmIoR2QqDffZOizcCmo7GQA2xd5sETAvRNmxDhWK8vsoxB8sQBVH0m
 qNxrjW9Nl+VwpobvaDuREj6nhhpBtIpQBUv650jb7jHCo51Wy/aX9x4Y4kBDeWSB
 hDTOoZWITUpdJgyEOVvIK0H7gPvKqY71qSsAUS2XVXHfnhmw4neXTGG4Bworj7nm
 O4PFxfs979vCyy8INVN8Ytl0YQmbu6vyfMQILuUUtfu0+ieuws+1IM9j8exMUA+6
 Dbw0HgvfYRXlABNwcJjE5G7ANRmicrYHYl54agpIkiq+ggchD6wwoV9aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=F9KxneCu7sQ8Yq9t+Jyk/wjRwtWvywodl5Tkh60KQ44=; b=cl/S0mWp
 3nBQHv3d7k0N2SqB63UE7ZJCb5HwMoRndyIfUMR1r0cB+MwusesRA1e69IrimJH3
 sJQL45rjmiRTYbcsyjsuuxbrXtEVD/sBkmgWGmTCHA3h/+ZgQprt5h48BCJrLT5y
 X1wJ2X8OcsbC60h4UYZi6mx56A8AJcMseuVw5kmbdmbbPh4Aze2F7pSOILt20W2S
 eExgz/5uNFq8SHiFiPXinLKliSDCKJRnUiigvPzvG44Mt5YpQj5TRKwNdXXVCpre
 Z/kJ9hhOX8K8bxINFP77LIE5vAlQSV+0hIHcPTIFesoXOFZAAZsvceYS0+8JbKCq
 j40cbb8HRbFtIA==
X-ME-Sender: <xms:CcFzX3BKBjY-n18oZfwqff3Oaat7JPNHuyacFcs9X3ZFyjpFSXUOkw>
 <xme:CcFzX9htxK5ft3M8_TRRxUtxfXv-mhOZ4uyJCPb5T4jCWrLakqt8xk2cZ2LTcbtcT
 6-CAdqPYLndwtoADAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeefjeejjeffleefuefhffdtvdfggedujedvvdfftddvhfegjeekheeuhfejjeeu
 necuffhomhgrihhnpehrvghsohhurhgtvghsrdgrtghtihhvvgdprhgvshhouhhrtggvsh
 drohhpvghnnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukh
X-ME-Proxy: <xmx:CcFzXykt025svD8oX57bAnR1gVcFthU3jJJwaQVvEAUjKam2vFdI3w>
 <xmx:CcFzX5x8LF9q8VsuNTPOEQLjhgxru18DHgNYjtQpanDEin28VV8OEA>
 <xmx:CcFzX8T6-OHpQv7U-vHoi5G5KTNtin-PgSErS9e16zH8J-amCxSFGQ>
 <xmx:CcFzXxILeri8kUIrju-kxdKV1uQRhQ2yA1yS3oBMsnHkrZEAzG0n835zpLc>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 44A2A328005A;
 Tue, 29 Sep 2020 19:19:36 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/14] hw/block/nvme: track and enforce zone resources
Date: Wed, 30 Sep 2020 01:19:16 +0200
Message-Id: <20200929231917.433586-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Track number of open/active resources.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt  |  7 +++++
 hw/block/nvme-ns.h   |  7 +++++
 include/block/nvme.h |  2 ++
 hw/block/nvme-ns.c   | 25 +++++++++++++++--
 hw/block/nvme.c      | 67 +++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index b23e59dd3075..e3810843cd2d 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -42,6 +42,13 @@ nvme-ns Options
      zns.zcap; if the zone capacity is a power of two, the zone size will be
      set to that, otherwise it will default to the next power of two.
 
+  `zns.mar`; Specifies the number of active resources available. This is a 0s
+     based value.
+
+  `zns.mor`; Specifies the number of open resources available. This is a 0s
+     based value.
+
+
 Reference Specifications
 ------------------------
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 82cb0b0bce82..ff34cd37af7d 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -52,6 +52,8 @@ typedef struct NvmeNamespaceParams {
         uint64_t zcap;
         uint64_t zsze;
         uint8_t  zdes;
+        uint32_t mar;
+        uint32_t mor;
     } zns;
 } NvmeNamespaceParams;
 
@@ -95,6 +97,11 @@ typedef struct NvmeNamespace {
         NvmeZone           *zones;
         NvmeZoneDescriptor *zd;
         uint8_t            *zde;
+
+        struct {
+            uint32_t open;
+            uint32_t active;
+        } resources;
     } zns;
 } NvmeNamespace;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5f8914f594f4..d51f397e7ff1 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -776,6 +776,8 @@ enum NvmeStatusCodes {
     NVME_ZONE_IS_READ_ONLY      = 0x01ba,
     NVME_ZONE_IS_OFFLINE        = 0x01bb,
     NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_TOO_MANY_ACTIVE_ZONES  = 0x01bd,
+    NVME_TOO_MANY_OPEN_ZONES    = 0x01be,
     NVME_INVALID_ZONE_STATE_TRANSITION = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index bc49c7f2674f..9584fbb3f62d 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -119,8 +119,8 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
         ns->zns.zde = g_malloc0_n(ns->zns.num_zones, nvme_ns_zdes_bytes(ns));
     }
 
-    id_ns_zns->mar = 0xffffffff;
-    id_ns_zns->mor = 0xffffffff;
+    id_ns_zns->mar = cpu_to_le32(ns->params.zns.mar);
+    id_ns_zns->mor = cpu_to_le32(ns->params.zns.mor);
 }
 
 static void nvme_ns_init(NvmeNamespace *ns)
@@ -220,6 +220,11 @@ static int nvme_ns_pstate_init(NvmeNamespace *ns, Error **errp)
 
 void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
 {
+    ns->zns.resources.active = ns->params.zns.mar != 0xffffffff ?
+        ns->params.zns.mar + 1 : ns->zns.num_zones;
+    ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
+        ns->params.zns.mor + 1 : ns->zns.num_zones;
+
     for (int i = 0; i < ns->zns.num_zones; i++) {
         NvmeZone *zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
@@ -238,9 +243,15 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
             if (nvme_wp(zone) == nvme_zslba(zone) &&
                 !(zone->zd->za & NVME_ZA_ZDEV)) {
                 nvme_zs_set(zone, NVME_ZS_ZSE);
+                continue;
             }
 
-            continue;
+            if (ns->zns.resources.active) {
+                ns->zns.resources.active--;
+                continue;
+            }
+
+            /* fallthrough */
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
@@ -462,6 +473,12 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
             return -1;
         }
 
+        if (ns->params.zns.mor > ns->params.zns.mar) {
+            error_setg(errp, "maximum open resources (zns.mor) must be less "
+                       "than or equal to maximum active resources (zns.mar)");
+            return -1;
+        }
+
         break;
 
     default:
@@ -547,6 +564,8 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
     DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
     DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
+    DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
+    DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a891ee284d1d..fc5b119e3f35 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1221,6 +1221,40 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     switch (from) {
     case NVME_ZS_ZSE:
+        switch (to) {
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+            break;
+
+        case NVME_ZS_ZSC:
+            if (!ns->zns.resources.active) {
+                return NVME_TOO_MANY_ACTIVE_ZONES;
+            }
+
+            ns->zns.resources.active--;
+
+            break;
+
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            if (!ns->zns.resources.active) {
+                return NVME_TOO_MANY_ACTIVE_ZONES;
+            }
+
+            if (!ns->zns.resources.open) {
+                return NVME_TOO_MANY_OPEN_ZONES;
+            }
+
+            ns->zns.resources.active--;
+            ns->zns.resources.open--;
+
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
         break;
 
     case NVME_ZS_ZSIO:
@@ -1241,7 +1275,13 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
+            ns->zns.resources.active++;
+
+            /* fallthrough */
+
         case NVME_ZS_ZSC:
+            ns->zns.resources.open++;
+
             break;
 
         default:
@@ -1264,8 +1304,18 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
+            ns->zns.resources.active++;
+
+            break;
+
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
+            if (!ns->zns.resources.open) {
+                return NVME_TOO_MANY_OPEN_ZONES;
+            }
+
+            ns->zns.resources.open--;
+
             break;
 
         default:
@@ -1669,6 +1719,7 @@ static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
     NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
     NvmeNamespace *ns = req->ns;
     NvmeZone *zone;
+    int count;
 
     uint16_t status = NVME_SUCCESS;
 
@@ -1718,6 +1769,20 @@ static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
         break;
 
     case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        count = 0;
+
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            if (nvme_zs(zone) == NVME_ZS_ZSC) {
+                count++;
+            }
+        }
+
+        if (count > ns->zns.resources.open) {
+            return NVME_TOO_MANY_OPEN_ZONES;
+        }
+
         for (int i = 0; i < ns->zns.num_zones; i++) {
             zone = &ns->zns.zones[i];
 
@@ -3287,7 +3352,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
                 switch (nvme_zs(zone)) {
                 case NVME_ZS_ZSIO:
                 case NVME_ZS_ZSEO:
-                    nvme_zs_set(zone, NVME_ZS_ZSC);
+                    nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
                     nvme_zns_commit_zone(ns, zone);
                     break;
                 default:
-- 
2.28.0


