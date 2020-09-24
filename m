Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3AC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EE72399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EE72399A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYQN-00076e-OS
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY80-0004ps-1m; Thu, 24 Sep 2020 16:46:10 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7r-0007ni-16; Thu, 24 Sep 2020 16:46:04 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id DD21F580512;
 Thu, 24 Sep 2020 16:45:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=/InMfmGWiht9c
 kFzlBfmOp7xYg2i7a0LZ/IF7fQZo5o=; b=qA9G2P+IKfuxJwOlms7X/tQ/LQutV
 JQJXwT4fuT7tQ02PwHVDQF+7bYND/AozfXBmHGm4UB28JkNmrBm+bp3jRd7fYRfD
 bxKwERvzEv+6EsPPRfaKqSu6QJ3lztawOpYIUozr09WRUWVIqmyMSJdEsOHpaib9
 7uuIsiJLhlE6Zgo9g5hQ2PfCXf5ihmx2qpseoCdDTKyugUT5Xg82SDBbPdzOMXon
 8zF3fTUdP3YO4BfiDo3UUGgVC57Zs924XwwusDItq+A4j6Vpux4EycUwKfWQ6dv/
 wO9tnAs2QfBra/TEKz+UXNeDI0TbfwA1aRguTUKMEtyQYcbncBeh5qC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=/InMfmGWiht9ckFzlBfmOp7xYg2i7a0LZ/IF7fQZo5o=; b=KC1hheak
 xA6ggx978aK8w1gKepYnD3CJ0daNIZp04go3VwD/IgGT2XLVweoAHE7+bBU+Ro+C
 Xh73p2hzdyWnXc8G0nTRGqfDNMTUfdu8MV99lA/zUM/OqNNRWH4ZgyOq2Dr/q666
 KwWC6nX9wENENFv8G63dEb9XyqVzQei4KvmsDZMTUj0TBx84EJDlz0n7M9tSyzmz
 Bj+EFOSqS0vUbzW6v89l9jcgUfz6Ux101qu2R/td30iW9mF6BlizE9g+GHhTHiB0
 4sgz3iYRnPePIJGKJjvwUP8n7tI40RzRgHu9OatsQiMeVJhst0o0Hjp6rwpv/Sq2
 MwnX+/o6eStGcQ==
X-ME-Sender: <xms:cAVtX2wq2-L4e1LMerhR6JegIvGy9LGFhOCVWFThAivSwkWbqTv25A>
 <xme:cAVtXyQ09IqXVbSO25HiYj4mVkFdk_5tBjsPC3qcVVdXjkiMeuTS3XK0Ti0NgWrmJ
 Z8fvg7V22m20Pm-99E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejfeejjeejffelfeeuhffftddvgfegudejvddvffdtvdfhgeejkeehuefhjeej
 ueenucffohhmrghinheprhgvshhouhhrtggvshdrrggtthhivhgvpdhrvghsohhurhgtvg
 hsrdhophgvnhenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnth
 drughk
X-ME-Proxy: <xmx:cAVtX4XjYtHA-yJa5lU7x_0qUhAri0IoG4VgMRbM0JdfNWTVzZ8BRA>
 <xmx:cAVtX8jJA1m0pI04ts7Naz3OeUA_BypvPpibv5RywmPsS-NUYcDksA>
 <xmx:cAVtX4Beiv6cZJKXYUT70D9zHcTrpjHF0lqQ85Mmp0Zbx5ox291nUg>
 <xmx:cAVtX36QA_sXoPKtpb14pFGV2euz03OpMTFE1FxfrNVfzsBwNklVkg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 265253064680;
 Thu, 24 Sep 2020 16:45:35 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] hw/block/nvme: track and enforce zone resources
Date: Thu, 24 Sep 2020 22:45:13 +0200
Message-Id: <20200924204516.1881843-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
References: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
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
 hw/block/nvme.c      | 65 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 82def65d4c78..921dbce2dc01 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -30,6 +30,13 @@ nvme-ns Options
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
index 5a695334a052..f520ffa89c98 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -28,6 +28,8 @@ typedef struct NvmeNamespaceParams {
         uint64_t zcap;
         uint64_t zsze;
         uint8_t  zdes;
+        uint32_t mar;
+        uint32_t mor;
     } zns;
 } NvmeNamespaceParams;
 
@@ -71,6 +73,11 @@ typedef struct NvmeNamespace {
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
index 0fb196c7103e..588fe7a1f018 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -119,8 +119,13 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
 
     id_ns->ncap = ns->zns.num_zones * ns->params.zns.zcap;
 
-    id_ns_zns->mar = 0xffffffff;
-    id_ns_zns->mor = 0xffffffff;
+    id_ns_zns->mar = cpu_to_le32(ns->params.zns.mar);
+    id_ns_zns->mor = cpu_to_le32(ns->params.zns.mor);
+
+    ns->zns.resources.active = ns->params.zns.mar != 0xffffffff ?
+        ns->params.zns.mar + 1 : ns->zns.num_zones;
+    ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
+        ns->params.zns.mor + 1 : ns->zns.num_zones;
 }
 
 static void nvme_ns_init(NvmeNamespace *ns)
@@ -249,9 +254,15 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
                     if (nvme_wp(zone) == nvme_zslba(zone) &&
                         !(zone->zd->za & NVME_ZA_ZDEV)) {
                         nvme_zs_set(zone, NVME_ZS_ZSE);
+                        continue;
                     }
 
-                    continue;
+                    if (ns->zns.resources.active) {
+                        ns->zns.resources.active--;
+                        continue;
+                    }
+
+                    /* fallthrough */
 
                 case NVME_ZS_ZSIO:
                 case NVME_ZS_ZSEO:
@@ -333,6 +344,12 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
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
@@ -418,6 +435,8 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
     DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
     DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
+    DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
+    DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 294bc2fb719d..79732b8a8574 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1204,6 +1204,40 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
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
@@ -1224,7 +1258,13 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
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
@@ -1247,8 +1287,18 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
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
@@ -1652,6 +1702,7 @@ static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
     NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
     NvmeNamespace *ns = req->ns;
     NvmeZone *zone;
+    int count;
 
     uint16_t status = NVME_SUCCESS;
 
@@ -1701,6 +1752,20 @@ static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
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
 
-- 
2.28.0


