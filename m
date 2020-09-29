Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB66C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0CF20691
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0CF20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPQx-0003OU-6Q
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOui-0000x8-Q7; Tue, 29 Sep 2020 19:20:04 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:53315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuf-0000AM-Ad; Tue, 29 Sep 2020 19:20:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 5EF0FF73;
 Tue, 29 Sep 2020 19:19:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=woncMQv06VujK
 Kpu9FxP0yRxOEPbqeAUy6ab5yIYLmM=; b=hDjMJsU9FTge/w2iQ73w7Ubx7rOU6
 N7sNmviTq9pOhs5UtDgiLzCS9NkCHpuU5DdoAdPH0VxzOKjVCHRIYPhLPdEol6sH
 PSxLuHKsDYAE2vSb3pmSXIKNhu7nlhwqpwEVLeAMhhFQtY2DoHgUX2U/36Pl00ch
 2kmORrc7zJ8az7gtULYaO/mjMjsq+QRqG89aNshM2WoiCmcNTZap+N3TTIyzo+pT
 dC61uNhQEOcSBLCgqVrwgpGlvH7axv/eRsfLVCdPPS/bewv2vbWCPkCiVTO3riNq
 XRi9CplsM5N3pPevE0xbQuGZ2bxiQrZOD4SaQHKlxMoW8+2P+MSeU81Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=woncMQv06VujKKpu9FxP0yRxOEPbqeAUy6ab5yIYLmM=; b=bzCsRsM3
 elo0Q0PPqcBt/fe2COyllC+5Bb/IciEhJovyqjPh2ViVSB3G+tY2Mb3TWcha7Na3
 OgRS4oe0oq1mNmcYHxhpkqiQYxpSqpYjyJ6nP7oC3iOZ2hpnzdV4BRPsT0qTzzQU
 oZH3/fhwnu0Zs+tbwOuhbc7KUGZUnC4lSC6bOM/H2NTdd01ReJ67aBrXgKVIMqX/
 ihAXzAps+Bo+WVxfCochXTxO5m2OoDjXfZQMrKtvU/yM+kyAJ6nMQJU2mDVT6lzr
 oQQ4o0klX+Y6ODFV3s8hixn7tVNyPG7PL510nEd1+73Rgm31r6P7D1kyFO1zd2cW
 C3+QtKlg0BqiPA==
X-ME-Sender: <xms:CsFzXznt_RzKO_zcNW5KDWIwopdOqdoCwfA5gr0S2mK9ESWgM_zelg>
 <xme:CsFzX21TweGrYXkQN2QF1d77XTXMRq1MTsLcy1k2BcgolNjND88kIkniNgRqLMwNF
 FWmtJDd41sKv8MeGWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepvdffffdugffhfeffvddvvddtvefhffffgfeuffekgffgkeejgfehudehteevgfeh
 necuffhomhgrihhnpehrvghsohhurhgtvghsrdhophgvnhdprhgvshhouhhrtggvshdrrg
 gtthhivhgvnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukh
X-ME-Proxy: <xmx:CsFzX5rLIDY8lOl1c_N-vOAaZsgybiEoPkhxpp-WlhHeBN27rbxJ0Q>
 <xmx:CsFzX7l4vgW1ttUqIeIo50pncy9VS4rNl38t1_tPCekTaMt-W1Ajjg>
 <xmx:CsFzXx1hX4fM_ckpCQ7ggh6Uo06TGstxA2CAHwTTbMixTleqUarcQA>
 <xmx:CsFzX5_cmrXljc2DRa-G6RMVzDHQMCBoFSpgCXfuSg5KA8QuxLLkVijE-Ac>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8A0213280060;
 Tue, 29 Sep 2020 19:19:37 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/14] hw/block/nvme: allow open to close transitions by
 controller
Date: Wed, 30 Sep 2020 01:19:17 +0200
Message-Id: <20200929231917.433586-15-its@irrelevant.dk>
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

Allow the controller to release open resources by transitioning
implicitly and explicitly opened zones to closed. This is done using a
naive "least recently opened" strategy.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    |   5 ++
 hw/block/nvme-ns.c    |   5 ++
 hw/block/nvme.c       | 105 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   5 ++
 4 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index ff34cd37af7d..491a77f3ae2f 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -62,6 +62,8 @@ typedef struct NvmeZone {
     uint8_t            *zde;
 
     uint64_t wp_staging;
+
+    QTAILQ_ENTRY(NvmeZone) lru_entry;
 } NvmeZone;
 
 typedef struct NvmeNamespace {
@@ -101,6 +103,9 @@ typedef struct NvmeNamespace {
         struct {
             uint32_t open;
             uint32_t active;
+
+            QTAILQ_HEAD(, NvmeZone) lru_open;
+            QTAILQ_HEAD(, NvmeZone) lru_active;
         } resources;
     } zns;
 } NvmeNamespace;
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 9584fbb3f62d..26c9f846417a 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -225,6 +225,9 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
     ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
         ns->params.zns.mor + 1 : ns->zns.num_zones;
 
+    QTAILQ_INIT(&ns->zns.resources.lru_open);
+    QTAILQ_INIT(&ns->zns.resources.lru_active);
+
     for (int i = 0; i < ns->zns.num_zones; i++) {
         NvmeZone *zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
@@ -248,6 +251,8 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
 
             if (ns->zns.resources.active) {
                 ns->zns.resources.active--;
+                QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone,
+                                   lru_entry);
                 continue;
             }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc5b119e3f35..34093f33ad1a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1209,12 +1209,61 @@ static inline void nvme_zone_reset_wp(NvmeZone *zone)
     zone->wp_staging = nvme_zslba(zone);
 }
 
-static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
-                                    NvmeZoneState to)
+static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
+                                    NvmeZone *zone, NvmeZoneState to,
+                                    NvmeRequest *req);
+
+static uint16_t nvme_zrm_release_open(NvmeCtrl *n, NvmeNamespace *ns,
+                                      NvmeRequest *req)
+{
+    NvmeZone *candidate;
+    NvmeZoneState zs;
+    uint16_t status;
+
+    trace_pci_nvme_zone_zrm_release_open(nvme_cid(req), ns->params.nsid);
+
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_open, lru_entry) {
+        zs = nvme_zs(candidate);
+
+        trace_pci_nvme_zone_zrm_candidate(nvme_cid(req), ns->params.nsid,
+                                          nvme_zslba(candidate),
+                                          nvme_wp(candidate), zs);
+
+        /* skip explicitly opened zones */
+        if (zs == NVME_ZS_ZSEO) {
+            continue;
+        }
+
+        /* the zone cannot be closed if it is currently writing */
+        if (candidate->wp_staging != nvme_wp(candidate)) {
+            continue;
+        }
+
+        status = nvme_zrm_transition(n, ns, candidate, NVME_ZS_ZSC, req);
+        if (status) {
+            return status;
+        }
+
+        if (nvme_zns_commit_zone(ns, candidate) < 0) {
+            return NVME_INTERNAL_DEV_ERROR;
+        }
+
+        return NVME_SUCCESS;
+    }
+
+    return NVME_TOO_MANY_OPEN_ZONES;
+}
+
+static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
+                                    NvmeZone *zone, NvmeZoneState to,
+                                    NvmeRequest *req)
 {
     NvmeZoneState from = nvme_zs(zone);
+    uint16_t status;
+
+    trace_pci_nvme_zone_zrm_transition(nvme_cid(req), ns->params.nsid,
+                                       nvme_zslba(zone), nvme_zs(zone), to);
 
-    /* fast path */
     if (from == to) {
         return NVME_SUCCESS;
     }
@@ -1229,25 +1278,32 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
         case NVME_ZS_ZSC:
             if (!ns->zns.resources.active) {
+                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
                 return NVME_TOO_MANY_ACTIVE_ZONES;
             }
 
             ns->zns.resources.active--;
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
             break;
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.active) {
+                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
                 return NVME_TOO_MANY_ACTIVE_ZONES;
             }
 
             if (!ns->zns.resources.open) {
-                return NVME_TOO_MANY_OPEN_ZONES;
+                status = nvme_zrm_release_open(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.active--;
             ns->zns.resources.open--;
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
             break;
 
@@ -1276,11 +1332,15 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
             ns->zns.resources.active++;
+            ns->zns.resources.open++;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_open, zone, lru_entry);
 
-            /* fallthrough */
+            break;
 
         case NVME_ZS_ZSC:
             ns->zns.resources.open++;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_open, zone, lru_entry);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
             break;
 
@@ -1305,16 +1365,22 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
             ns->zns.resources.active++;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_active, zone, lru_entry);
 
             break;
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.open) {
-                return NVME_TOO_MANY_OPEN_ZONES;
+                status = nvme_zrm_release_open(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.open--;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_active, zone, lru_entry);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
             break;
 
@@ -1338,6 +1404,9 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     case NVME_ZS_ZSF:
         switch (to) {
+        case NVME_ZS_ZSF:
+            return NVME_SUCCESS;
+
         case NVME_ZS_ZSE:
             nvme_zone_reset_wp(zone);
 
@@ -1376,7 +1445,9 @@ static void nvme_zns_advance_wp(NvmeRequest *req)
     wp += nlb;
     zone->zd->wp = cpu_to_le64(wp);
     if (wp == nvme_zslba(zone) + nvme_zcap(zone)) {
-        nvme_zrm_transition(req->ns, zone, NVME_ZS_ZSF);
+        NvmeCtrl *n = nvme_ctrl(req);
+
+        nvme_zrm_transition(n, req->ns, zone, NVME_ZS_ZSF, req);
         if (nvme_zns_commit_zone(req->ns, zone) < 0) {
             req->status = NVME_INTERNAL_DEV_ERROR;
         }
@@ -1433,6 +1504,7 @@ static void nvme_rw_cb(void *opaque, int ret)
             uint64_t slba = le64_to_cpu(rw->slba);
 
             NvmeZone *zone = nvme_ns_get_zone(ns, slba);
+            NvmeCtrl *n = nvme_ctrl(req);
 
             /*
              * Transition the zone to read-only on write fault and offline
@@ -1441,7 +1513,7 @@ static void nvme_rw_cb(void *opaque, int ret)
             NvmeZoneState zs = status == NVME_WRITE_FAULT ?
                 NVME_ZS_ZSRO : NVME_ZS_ZSO;
 
-            nvme_zrm_transition(ns, zone, zs);
+            nvme_zrm_transition(n, ns, zone, zs, req);
             if (nvme_zns_commit_zone(ns, zone) < 0) {
                 req->status = NVME_INTERNAL_DEV_ERROR;
             }
@@ -1535,7 +1607,7 @@ static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
         break;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, req);
     if (status) {
         return status;
     }
@@ -1560,7 +1632,7 @@ static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
         return NVME_SUCCESS;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSF);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req);
     if (status) {
         return status;
     }
@@ -1585,7 +1657,7 @@ static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
         return NVME_SUCCESS;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSEO);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSEO, req);
     if (status) {
         return status;
     }
@@ -1621,7 +1693,7 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
             return NVME_INTERNAL_DEV_ERROR;
         }
 
-        nvme_zrm_transition(ns, zone, NVME_ZS_ZSE);
+        nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSE, req);
         if (nvme_zns_commit_zone(ns, zone) < 0) {
             return NVME_INTERNAL_DEV_ERROR;
         }
@@ -1652,7 +1724,7 @@ static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
             return NVME_INTERNAL_DEV_ERROR;
         }
 
-        nvme_zrm_transition(ns, zone, NVME_ZS_ZSO);
+        nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSO, req);
         if (nvme_zns_commit_zone(ns, zone) < 0) {
             return NVME_INTERNAL_DEV_ERROR;
         }
@@ -1696,7 +1768,7 @@ static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
         return status;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, req);
     if (status) {
         return status;
     }
@@ -2122,7 +2194,7 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
             case NVME_ZS_ZSEO:
                 break;
             default:
-                status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSIO, req);
                 if (status) {
                     goto invalid;
                 }
@@ -3348,11 +3420,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         if (nvme_ns_zoned(ns)) {
             for (int i = 0; i < ns->zns.num_zones; i++) {
                 NvmeZone *zone = &ns->zns.zones[i];
-
                 switch (nvme_zs(zone)) {
                 case NVME_ZS_ZSIO:
                 case NVME_ZS_ZSEO:
-                    nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+                    nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, NULL);
                     nvme_zns_commit_zone(ns, zone);
                     break;
                 default:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 929409b79b41..18f7b24ef5e9 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -88,6 +88,9 @@ pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
 pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
 pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "sqid %"PRIu16" new_tail %"PRIu16""
+pci_nvme_zone_zrm_transition(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t from, uint8_t to) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" from 0x%"PRIx8" to 0x%"PRIx8""
+pci_nvme_zone_zrm_candidate(uint16_t cid, uint32_t nsid, uint64_t zslba, uint64_t wp, uint8_t zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" wp 0x%"PRIx64" zc 0x%"PRIx8""
+pci_nvme_zone_zrm_release_open(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
@@ -115,6 +118,8 @@ pci_nvme_err_zone_is_read_only(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0
 pci_nvme_err_zone_invalid_write(uint16_t cid, uint64_t slba, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" wp 0x%"PRIx64""
 pci_nvme_err_zone_boundary(uint16_t cid, uint64_t slba, uint32_t nlb, uint64_t zcap) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" zcap 0x%"PRIx64""
 pci_nvme_err_zone_pending_writes(uint16_t cid, uint64_t zslba, uint64_t wp, uint64_t wp_staging) "cid %"PRIu16" zslba 0x%"PRIx64" wp 0x%"PRIx64" wp_staging 0x%"PRIx64""
+pci_nvme_err_too_many_active_zones(uint16_t cid) "cid %"PRIu16""
+pci_nvme_err_too_many_open_zones(uint16_t cid) "cid %"PRIu16""
 pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
-- 
2.28.0


