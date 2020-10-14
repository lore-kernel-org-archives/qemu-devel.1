Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DA520725
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DA520725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSf5c-0006Q8-D7
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0Q-0003Ik-BR; Wed, 14 Oct 2020 07:31:43 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0N-0006b3-CY; Wed, 14 Oct 2020 07:31:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 59224580310;
 Wed, 14 Oct 2020 07:31:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=krslg3EfnDZ3H
 DoN43dy/RC2FJ5ObbahyFmNhdEArV8=; b=FFhS5kS6SzBVNwxc4FXDDVZ/Nx0ti
 CeYBpxdzbdmWdIOAUB1dBFETfvUW3sPqWTSew7tDxjeJKYma5iicTyLSWElmrRsG
 gOLOeOvcykxlTarsReJmkqxB5mXWhmxLNegxxkyZoqRwYYn049sBPjfcmFNmGNQB
 FZhFJnpB2+VQBkEoCveKgSdkLw62AVWhAEk90Bp4STVKXW0CN0v/ZdqhDP34f1Uk
 pf7Fb4l1TMXjM0fC6KZxI6wOPFlOOAQsc50EGO2RQrzz2V7lPGLHDjiDPXmemkNL
 GGrnnUEcaz8YYZ64pogYSoKyEvj6V4yxPoHHiJy4poWDVlcgoG5S1kupg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=krslg3EfnDZ3HDoN43dy/RC2FJ5ObbahyFmNhdEArV8=; b=TdaP4g/Q
 vOPfaeq2N3O4IYNKW0VUNmfIhtiv2ijgvmN2qnObI8lqQ4gW2y+R2J5++1lXiH+S
 2JmGjYN96s2LswlwpoedvzP7Jow2i7lvlsZcFXuDRAaNiEEMNcGvLyW7YsLLhWhw
 7AMZNuu+VzJv3QwHI/snXCr04VBF1KYp6qQBL94RgC9C+ojX9VAotuajL0GqzQWd
 3cZ0ZyFdFkjQ78xgdTAjjNUxHjMm+ark3P7Cbwe4vk8XrPU8yDEk7kYi/PQH26Fq
 BdyZgxZti7l8aD2mhBGBw0nij13CM7ulOuP9NUJLU9eUKzyQuHdErjYpVwe7QZwx
 8CfXY0ezzoe3jw==
X-ME-Sender: <xms:muGGX-1VgxH4zJ_-reT9cIICJns2hARqfZh3dkv2vKD8sWezwDqW4Q>
 <xme:muGGXxGgkHgYRm4di21wIeFbc-RSOAmG4Xlc4fZS3Gc1VtilL8cO9e_Qq_BYKqHcB
 owyp7Jyp0P7RCz4qo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepvdffffdugffhfeffvddvvddtvefhffffgfeuffekgffgkeejgfehudehteevgfeh
 necuffhomhgrihhnpehrvghsohhurhgtvghsrdhophgvnhdprhgvshhouhhrtggvshdrrg
 gtthhivhgvnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukh
X-ME-Proxy: <xmx:muGGX27Fb4oH3j9p5aCvGWICUNiXDvb16-AsQ_wOKhxRRRPESWpRrA>
 <xmx:muGGX_1PQwfVCBkrgz2LmVmsNb_2ln7GUd9pl3bb15F3VKwCGfJk8Q>
 <xmx:muGGXxEhBvE1O8GJQiwCTkjImWll3ZVRdx4T50dS_GPzAriNsnUrHQ>
 <xmx:muGGX24Q1vM3SoKhz96c_tkoj76zctI9_Q_tGXadygB4F5YhtFUIVw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id CE44A3064610;
 Wed, 14 Oct 2020 07:31:36 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] hw/block/nvme: allow open to close zone transitions by
 controller
Date: Wed, 14 Oct 2020 13:31:22 +0200
Message-Id: <20201014113122.388849-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014113122.388849-1-its@irrelevant.dk>
References: <20201014113122.388849-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:31:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Allow the controller to release open resources by transitioning
implicitly and explicitly opened zones to closed. This is done using a
naive "least recently opened" strategy.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    |  5 ++++
 hw/block/nvme-ns.c    |  5 ++++
 hw/block/nvme.c       | 57 ++++++++++++++++++++++++++++++++++++++++---
 hw/block/trace-events |  1 +
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 3d0269eef6f0..5d8523c047d8 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -38,6 +38,8 @@ typedef struct NvmeZone {
     uint8_t            *zde;
 
     uint64_t wp_staging;
+
+    QTAILQ_ENTRY(NvmeZone) lru_entry;
 } NvmeZone;
 
 typedef struct NvmeNamespace {
@@ -64,6 +66,9 @@ typedef struct NvmeNamespace {
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
index a01cc5eeb445..cb8b44a78450 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -135,6 +135,9 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
     ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
         ns->params.zns.mor + 1 : ns->zns.num_zones;
 
+    QTAILQ_INIT(&ns->zns.resources.lru_open);
+    QTAILQ_INIT(&ns->zns.resources.lru_active);
+
     for (int i = 0; i < ns->zns.num_zones; i++) {
         NvmeZone *zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
@@ -158,6 +161,8 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
 
             if (ns->zns.resources.active) {
                 ns->zns.resources.active--;
+                QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone,
+                                   lru_entry);
                 break;
             }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index cc637b3a68e9..1fab9d69261c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1105,11 +1105,47 @@ static inline void nvme_zone_reset_wp(NvmeZone *zone)
     zone->wp_staging = nvme_zslba(zone);
 }
 
+static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
+                                    NvmeZoneState to);
+
+static uint16_t nvme_zrm_release_open(NvmeNamespace *ns)
+{
+    NvmeZone *candidate;
+    NvmeZoneState zs;
+    uint16_t status;
+
+    trace_pci_nvme_zrm_release_open(ns->params.nsid);
+
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_open, lru_entry) {
+        zs = nvme_zs(candidate);
+
+        /* skip explicitly opened zones */
+        if (zs == NVME_ZS_ZSEO) {
+            continue;
+        }
+
+        /* skip zones that have in-flight writes */
+        if (candidate->wp_staging != nvme_wp(candidate)) {
+            continue;
+        }
+
+        status = nvme_zrm_transition(ns, candidate, NVME_ZS_ZSC);
+        if (status) {
+            return status;
+        }
+
+        return NVME_SUCCESS;
+    }
+
+    return NVME_TOO_MANY_OPEN_ZONES;
+}
+
 static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
                                     NvmeZoneState to)
 {
     NvmeZoneState from = nvme_zs(zone);
     NvmeZoneDescriptor *zd = zone->zd;
+    uint16_t status;
 
     trace_pci_nvme_zrm_transition(ns->params.nsid, nvme_zslba(zone), from, to);
 
@@ -1131,6 +1167,7 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
             }
 
             ns->zns.resources.active--;
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
             break;
 
@@ -1141,11 +1178,15 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
             }
 
             if (!ns->zns.resources.open) {
-                return NVME_TOO_MANY_OPEN_ZONES;
+                status = nvme_zrm_release_open(ns);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.active--;
             ns->zns.resources.open--;
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
             break;
 
@@ -1172,11 +1213,15 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
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
 
@@ -1201,16 +1246,22 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
             ns->zns.resources.active++;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_active, zone, lru_entry);
 
             break;
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.open) {
-                return NVME_TOO_MANY_OPEN_ZONES;
+                status = nvme_zrm_release_open(ns);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.open--;
+            QTAILQ_REMOVE(&ns->zns.resources.lru_active, zone, lru_entry);
+            QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
             break;
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 2363412a9375..0064fedf31ae 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -83,6 +83,7 @@ pci_nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
 pci_nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
 pci_nvme_zrm_transition(uint32_t nsid, uint64_t zslba, uint8_t from, uint8_t to) "nsid %"PRIu32" zslba 0x%"PRIx64" from 0x%"PRIx8" to 0x%"PRIx8""
+pci_nvme_zrm_release_open(uint32_t nsid) "nsid %"PRIu32""
 pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
 pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
-- 
2.28.0


