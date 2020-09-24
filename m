Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3788C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7671235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7671235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYdg-0006WD-Bh
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY84-0004qO-Or; Thu, 24 Sep 2020 16:46:14 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7s-0007np-7N; Thu, 24 Sep 2020 16:46:07 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6CCA8580514;
 Thu, 24 Sep 2020 16:45:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=TctV81Y8sVtLo
 HMBw7M1QPWdKaHiBqaHlOXgy7pZfIs=; b=DMk32m1BSxNn2qJuI1J6w6IxYV0pY
 uVBoK+eEIZyMXUvFfYYajbESzpzgjZUC77T45xyA3CXOzH0z/QgVUGDse9QjiXlV
 EiXsILxOwYR8VQIxe5PYk0w/JxnburqybHv227/x9er5CUdcD7Rr5jLBezBsTJZc
 I9ZmHEFd6rEO3BDhA1+baRbXbahn+N0mIUX10NgikHsAoj39VWk/4LJZpQcySmCT
 louN6MULFC/JXngS7vO0ez3ttVJx1HzqjwQsgaeUnqv5JVlQD4rY8URAK/TF7MVM
 EYmMyi7CwA0gntPJfxK8rOMUNSDjWMMIJ3PzVEPeXjp2n7KED2YByCALg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=TctV81Y8sVtLoHMBw7M1QPWdKaHiBqaHlOXgy7pZfIs=; b=A0jds+zy
 buG8w2zedcNEmQ7yrdYakgWBnUW0Vs9TWubv97fzSB448iS3dswYVRfOEWks9mK2
 1AB3quNsrE2W2ZRn7ypR9wkskvd2sBIEwPQzKxVxSg5XqEkAztuTLMTkhX6ZGIgE
 G47KMUausr/4IbbzAxR0O7aPQjZqXMjzkb0jabVDKY4Df0cXoNyKk9rKRsd+0tFx
 PNx5jlSr5iXQCpd9gSr/U5Ei+0+8OtPVwhIpqfFmzGtzLVldnBQIX/IeMz7DeKhV
 L0sgSwfSYJdwdjHoYiTJFJ/8a22KpzncItAECQHKsBJOETESRiGvnGxA2qbR+DJQ
 I64sYDDEMGr9tg==
X-ME-Sender: <xms:cQVtX2POxsU72e29GkqFMAmlPLzab8MqZlQWlmEwwuWp104xghWgAw>
 <xme:cQVtX0_uTDg4salBrxKcJFPtCt2XriGSukezKaIvTGvnqzKxVhph3Klk3-Qzh0qke
 zy1gjxs6ty3yBuF-iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedvffffudfghfefffdvvddvtdevhffffffgueffkefggfekjefgheduheetvefg
 heenucffohhmrghinheprhgvshhouhhrtggvshdrohhpvghnpdhrvghsohhurhgtvghsrd
 grtghtihhvvgenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnth
 drughk
X-ME-Proxy: <xmx:cQVtX9TJEEFmhyg2iSdkuMZZC6IlJcphRy2jPS0Zpmwai3Hca2sVDw>
 <xmx:cQVtX2vTzfXPieS8rJoLeu5UM0qFz8MANCyrJC0wljrw-WCstIjYmw>
 <xmx:cQVtX-fqfIHlXLE8hZyskHNu7NtWdVQjfabyD7hrA04YW-bWuSv53A>
 <xmx:cQVtX7HYK-mgkA3kiUeXrJl6B1sb1YPdTDPclCEj-Mo93pJDN1folQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6AA953064682;
 Thu, 24 Sep 2020 16:45:36 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] hw/block/nvme: allow open to close transitions by
 controller
Date: Thu, 24 Sep 2020 22:45:14 +0200
Message-Id: <20200924204516.1881843-15-its@irrelevant.dk>
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

Allow the controller to release open resources by transitioning
implicitly and explicitly opened zones to closed. This is done using a
naive "least recently opened" strategy.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    |   5 +++
 hw/block/nvme-ns.c    |   5 +++
 hw/block/nvme.c       | 102 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   5 +++
 4 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index f520ffa89c98..1fdcdf706ff6 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -38,6 +38,8 @@ typedef struct NvmeZone {
     uint8_t            *zde;
 
     uint64_t wp_staging;
+
+    QTAILQ_ENTRY(NvmeZone) lru_entry;
 } NvmeZone;
 
 typedef struct NvmeNamespace {
@@ -77,6 +79,9 @@ typedef struct NvmeNamespace {
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
index 588fe7a1f018..547090282660 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -126,6 +126,9 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
         ns->params.zns.mar + 1 : ns->zns.num_zones;
     ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
         ns->params.zns.mor + 1 : ns->zns.num_zones;
+
+    QTAILQ_INIT(&ns->zns.resources.lru_open);
+    QTAILQ_INIT(&ns->zns.resources.lru_active);
 }
 
 static void nvme_ns_init(NvmeNamespace *ns)
@@ -259,6 +262,8 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
 
                     if (ns->zns.resources.active) {
                         ns->zns.resources.active--;
+                        QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone,
+                                           lru_entry);
                         continue;
                     }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 79732b8a8574..a43a593ab89e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1192,12 +1192,61 @@ static inline void nvme_zone_reset_wp(NvmeZone *zone)
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
@@ -1212,25 +1261,32 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
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
 
@@ -1259,11 +1315,15 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
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
 
@@ -1288,16 +1348,22 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
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
 
@@ -1321,6 +1387,9 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     case NVME_ZS_ZSF:
         switch (to) {
+        case NVME_ZS_ZSF:
+            return NVME_SUCCESS;
+
         case NVME_ZS_ZSE:
             nvme_zone_reset_wp(zone);
 
@@ -1359,7 +1428,9 @@ static void nvme_zns_advance_wp(NvmeRequest *req)
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
@@ -1416,6 +1487,7 @@ static void nvme_rw_cb(void *opaque, int ret)
             uint64_t slba = le64_to_cpu(rw->slba);
 
             NvmeZone *zone = nvme_ns_get_zone(ns, slba);
+            NvmeCtrl *n = nvme_ctrl(req);
 
             /*
              * Transition the zone to read-only on write fault and offline
@@ -1424,7 +1496,7 @@ static void nvme_rw_cb(void *opaque, int ret)
             NvmeZoneState zs = status == NVME_WRITE_FAULT ?
                 NVME_ZS_ZSRO : NVME_ZS_ZSO;
 
-            nvme_zrm_transition(ns, zone, zs);
+            nvme_zrm_transition(n, ns, zone, zs, req);
             if (nvme_zns_commit_zone(ns, zone) < 0) {
                 req->status = NVME_INTERNAL_DEV_ERROR;
             }
@@ -1518,7 +1590,7 @@ static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
         break;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, req);
     if (status) {
         return status;
     }
@@ -1543,7 +1615,7 @@ static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
         return NVME_SUCCESS;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSF);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req);
     if (status) {
         return status;
     }
@@ -1568,7 +1640,7 @@ static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
         return NVME_SUCCESS;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSEO);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSEO, req);
     if (status) {
         return status;
     }
@@ -1604,7 +1676,7 @@ static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
             return NVME_INTERNAL_DEV_ERROR;
         }
 
-        nvme_zrm_transition(ns, zone, NVME_ZS_ZSE);
+        nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSE, req);
         if (nvme_zns_commit_zone(ns, zone) < 0) {
             return NVME_INTERNAL_DEV_ERROR;
         }
@@ -1635,7 +1707,7 @@ static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
             return NVME_INTERNAL_DEV_ERROR;
         }
 
-        nvme_zrm_transition(ns, zone, NVME_ZS_ZSO);
+        nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSO, req);
         if (nvme_zns_commit_zone(ns, zone) < 0) {
             return NVME_INTERNAL_DEV_ERROR;
         }
@@ -1679,7 +1751,7 @@ static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
         return status;
     }
 
-    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSC, req);
     if (status) {
         return status;
     }
@@ -2094,7 +2166,7 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
             case NVME_ZS_ZSEO:
                 break;
             default:
-                status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                status = nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSIO, req);
                 if (status) {
                     goto invalid;
                 }
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


