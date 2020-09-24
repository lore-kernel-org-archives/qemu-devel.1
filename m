Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A184C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC0223899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC0223899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYnp-0004Wn-LR
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY8A-0004rE-HX; Thu, 24 Sep 2020 16:46:20 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7s-0007nz-W5; Thu, 24 Sep 2020 16:46:12 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id E613B580100;
 Thu, 24 Sep 2020 16:45:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=YPMTy5VauD8fw
 3RCtj4eD6/YQHE7icVqOIkeeHteLak=; b=onpnjY6BpC76U77nbqkLp9J+PvaAD
 GBGv8LB421q4LHzu2lxWthW3GuOpaIQfffcMfpk+nnlq4YYvaPcy/EQ+ycA9sYOJ
 eBiGiYFlaqsmCYEnOVhbhy/9HDU6t7OU/nKg1YunIhFieWjWFJFHo482Q9XaC4hg
 lGXRh4cI+bsTMn8/5IN9tcDHdMEOia8+KBKDhBK5qw6EXhnHlzCktp2gotiSx4x2
 e+pDfAtWefdSBPuvuvCMcJcwT9mFUzBPS+YyYcp4+N54RK1Lt4fcTQM1rYL2qR+M
 Br6I59Oe6f6I4PYirCDogncst4asB9KzkBXCBLShRBUe7MO3kq4vCEQUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=YPMTy5VauD8fw3RCtj4eD6/YQHE7icVqOIkeeHteLak=; b=HxpxVMZm
 h0WWe130N9fcAf82A1jgsGm9rTBwIz/y4BY6eyQOTSIrZpbRGDEj5qSbNAcK+Mk3
 5FE3L09X8xuV6bAoKJD4WIxVeJ9TWECW6RcXRhj95Rt8AFDefjjNK/1tPWn8KoG8
 jHvBjcKND5KfySSC3qCmYH8W1AH4HGo17Q63BtSVTIV+0jNJtOUUesQfDfRQ0M9k
 NxbCOr/YiMJylorHMbxv5IilHFb0PruEGlSop9NCP+ryM2xyipOuM/9L4TUhmcyE
 gT0VfxsYUBTePYhpSs3+Ss8MQiYCiKrcSSc7yzridHT8+pK9zOGm605/R/eM2HpW
 467u68t6jxZnLw==
X-ME-Sender: <xms:cgVtX-w5UmuzpdIxJmtE4rMOX4v0uJg6lT8WezF-37YlFuqyvmunhA>
 <xme:cgVtX6TNkudValoB9ohMaKVj2eqAsproR-l4Zq16UDPP0Wek9mML11_dWlw9gIInX
 v0IT6Pzt463CpvFXeU>
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
X-ME-Proxy: <xmx:cgVtXwU_00DcnLyN2vGZ-UBfG-dM6NAUOWLmiaGqEBccmQnJQJbHPA>
 <xmx:cgVtX0i_DxjizPf9bsaMD4D5IUTig35D6AxZDwNwU_AmmjhbHTYXHw>
 <xmx:cgVtXwDmMmeZoB7JEnYuAs6weOWE8zJTNMiUWxbPd29_Zdo-ObJZwQ>
 <xmx:cwVtX_6Nxfdx8rDVbdDrc4mpsUJ9Ao0XMAOpwaP9p_LHPe_CtkllqA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B64FE3064680;
 Thu, 24 Sep 2020 16:45:37 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] hw/block/nvme: support zone active excursions
Date: Thu, 24 Sep 2020 22:45:15 +0200
Message-Id: <20200924204516.1881843-16-its@irrelevant.dk>
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

Allow the controller to release active resources by transitioning zones
to the full state if enabled.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |   5 ++
 hw/block/nvme-ns.h    |   3 +
 include/block/nvme.h  |  30 ++++++--
 hw/block/nvme-ns.c    |   3 +
 hw/block/nvme.c       | 170 ++++++++++++++++++++++++++++++++++++++----
 hw/block/trace-events |   5 +-
 6 files changed, 197 insertions(+), 19 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 921dbce2dc01..a286d9c07025 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -36,6 +36,11 @@ nvme-ns Options
   `zns.mor`; Specifies the number of open resources available. This is a 0s
      based value.
 
+  `zns.zoc`; Specifies Zone Operation Characteristics (ZOC). Only 0x2 is
+     supported, which allows Zone Active Excursions. If enabled, the controller
+     will release active resources when needed by transitioning zones to the
+     Full state.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 1fdcdf706ff6..d9093fdad984 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -30,6 +30,7 @@ typedef struct NvmeNamespaceParams {
         uint8_t  zdes;
         uint32_t mar;
         uint32_t mor;
+        uint16_t zoc;
     } zns;
 } NvmeNamespaceParams;
 
@@ -83,6 +84,8 @@ typedef struct NvmeNamespace {
             QTAILQ_HEAD(, NvmeZone) lru_open;
             QTAILQ_HEAD(, NvmeZone) lru_active;
         } resources;
+
+        NvmeChangedZoneList changed_list;
     } zns;
 } NvmeNamespace;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index d51f397e7ff1..0948a262b2df 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -687,6 +687,7 @@ typedef struct QEMU_PACKED NvmeDsmRange {
 enum NvmeAsyncEventRequest {
     NVME_AER_TYPE_ERROR                     = 0,
     NVME_AER_TYPE_SMART                     = 1,
+    NVME_AER_TYPE_NOTICE                    = 2,
     NVME_AER_TYPE_IO_SPECIFIC               = 6,
     NVME_AER_TYPE_VENDOR_SPECIFIC           = 7,
     NVME_AER_INFO_ERR_INVALID_DB_REGISTER   = 0,
@@ -698,13 +699,15 @@ enum NvmeAsyncEventRequest {
     NVME_AER_INFO_SMART_RELIABILITY         = 0,
     NVME_AER_INFO_SMART_TEMP_THRESH         = 1,
     NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
+    NVME_AER_INFO_NOTICE_ZONE_DESCR_CHANGED = 0xef,
 };
 
 typedef struct QEMU_PACKED NvmeAerResult {
-    uint8_t event_type;
-    uint8_t event_info;
-    uint8_t log_page;
-    uint8_t resv;
+    uint8_t  event_type;
+    uint8_t  event_info;
+    uint8_t  log_page;
+    uint8_t  resv;
+    uint32_t nsid;
 } NvmeAerResult;
 
 typedef struct QEMU_PACKED NvmeCqe {
@@ -882,6 +885,15 @@ typedef struct QEMU_PACKED NvmeZoneDescriptor {
     uint8_t  rsvd32[32];
 } NvmeZoneDescriptor;
 
+#define NVME_CHANGED_ZONE_LIST_MAX_IDS 511
+
+typedef struct QEMU_PACKED NvmeChangedZoneList {
+    uint16_t num_ids;
+    uint8_t  rsvd2[6];
+    uint64_t ids[NVME_CHANGED_ZONE_LIST_MAX_IDS];
+} NvmeChangedZoneList;
+
+#define NVME_ZA_ZFC  (1 << 0)
 #define NVME_ZA_ZDEV (1 << 7)
 
 #define NVME_ZA_SET(za, attrs)   ((za) |= (attrs))
@@ -996,6 +1008,10 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
     uint8_t     vs[1024];
 } NvmeIdCtrl;
 
+enum NvmeIdCtrlOaes {
+    NVME_OAES_ZDCN = 1 << 27,
+};
+
 enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
@@ -1064,6 +1080,7 @@ typedef struct QEMU_PACKED NvmeIdCtrlZns {
 #define NVME_AEC_SMART(aec)         (aec & 0xff)
 #define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
 #define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
+#define NVME_AEC_ZDCN(aec)          ((aec >> 27) & 0x1)
 
 #define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
 #define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
@@ -1231,9 +1248,11 @@ typedef struct QEMU_PACKED NvmeIdNsZns {
     uint8_t     vs[256];
 } NvmeIdNsZns;
 
+#define NVME_ID_NS_ZNS_ZOC_ZAE (1 << 1)
+
 static inline void _nvme_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 8);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
@@ -1258,5 +1277,6 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescriptor) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeChangedZoneList) != 4096);
 }
 #endif
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 547090282660..9a9f728d791f 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -104,6 +104,8 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
     NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
     NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
 
+    id_ns_zns->zoc = cpu_to_le16(ns->params.zns.zoc);
+
     for (int i = 0; i <= id_ns->nlbaf; i++) {
         id_ns_zns->lbafe[i].zsze = ns->params.zns.zsze ?
             ns->params.zns.zsze : cpu_to_le64(pow2ceil(ns->params.zns.zcap));
@@ -442,6 +444,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
     DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
     DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
+    DEFINE_PROP_UINT16("zns.zoc", NvmeNamespace, params.zns.zoc, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a43a593ab89e..ecc88e858eee 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -880,10 +880,11 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.dw0;
+        result = (NvmeAerResult *) &req->cqe.qw0;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
+        result->nsid = event->result.nsid;
         g_free(event);
 
         trace_pci_nvme_aer_post_cqe(result->event_type, result->event_info,
@@ -893,12 +894,14 @@ static void nvme_process_aers(void *opaque)
     }
 }
 
-static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
-                               uint8_t event_info, uint8_t log_page)
+static void nvme_enqueue_event(NvmeCtrl *n, NvmeNamespace *ns,
+                               uint8_t event_type, uint8_t event_info,
+                               uint8_t log_page)
 {
     NvmeAsyncEvent *event;
 
-    trace_pci_nvme_enqueue_event(event_type, event_info, log_page);
+    trace_pci_nvme_enqueue_event(ns ? ns->params.nsid : -1, event_type,
+                                 event_info, log_page);
 
     if (n->aer_queued == n->params.aer_max_queued) {
         trace_pci_nvme_enqueue_event_noqueue(n->aer_queued);
@@ -912,6 +915,11 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
         .log_page   = log_page,
     };
 
+    if (event_info == NVME_AER_INFO_NOTICE_ZONE_DESCR_CHANGED) {
+        assert(ns);
+        event->result.nsid = ns->params.nsid;
+    }
+
     QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
     n->aer_queued++;
 
@@ -1192,10 +1200,54 @@ static inline void nvme_zone_reset_wp(NvmeZone *zone)
     zone->wp_staging = nvme_zslba(zone);
 }
 
+static void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                              NvmeRequest *req)
+{
+    uint16_t num_ids = le16_to_cpu(ns->zns.changed_list.num_ids);
+
+    trace_pci_nvme_zone_changed(nvme_cid(req), ns->params.nsid,
+                                nvme_zslba(zone));
+
+    if (num_ids < NVME_CHANGED_ZONE_LIST_MAX_IDS) {
+        for (int i = 0; i < num_ids; i++) {
+            if (ns->zns.changed_list.ids[i] == zone->zd->zslba) {
+                goto out;
+            }
+        }
+
+        ns->zns.changed_list.ids[num_ids] = zone->zd->zslba;
+        ns->zns.changed_list.num_ids = cpu_to_le16(num_ids + 1);
+    } else {
+        memset(&ns->zns.changed_list, 0x0, sizeof(NvmeChangedZoneList));
+        ns->zns.changed_list.num_ids = cpu_to_le16(0xffff);
+    }
+
+out:
+    nvme_zns_commit_zone(ns, zone);
+
+    if (NVME_AEC_ZDCN(n->features.async_config)) {
+        nvme_enqueue_event(n, ns, NVME_AER_TYPE_NOTICE,
+                           NVME_AER_INFO_NOTICE_ZONE_DESCR_CHANGED,
+                           NVME_LOG_CHANGED_ZONE_LIST);
+    }
+}
+
 static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, NvmeZoneState to,
                                     NvmeRequest *req);
 
+static void nvme_zone_active_excursion(NvmeCtrl *n, NvmeNamespace *ns,
+                                       NvmeZone *zone, NvmeRequest *req)
+{
+    trace_pci_nvme_zone_active_excursion(ns->params.nsid, nvme_zslba(zone),
+                                         nvme_zs_str(zone));
+
+    nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req);
+    NVME_ZA_SET(zone->zd->za, NVME_ZA_ZFC);
+
+    nvme_zone_changed(n, ns, zone, req);
+}
+
 static uint16_t nvme_zrm_release_open(NvmeCtrl *n, NvmeNamespace *ns,
                                       NvmeRequest *req)
 {
@@ -1237,6 +1289,57 @@ static uint16_t nvme_zrm_release_open(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_TOO_MANY_OPEN_ZONES;
 }
 
+static uint16_t nvme_zrm_release_active(NvmeCtrl *n, NvmeNamespace *ns,
+                                        NvmeRequest *req)
+{
+    NvmeZone *candidate = NULL;
+    NvmeZoneDescriptor *zd;
+    NvmeZoneState zs;
+
+    trace_pci_nvme_zone_zrm_release_active(nvme_cid(req), ns->params.nsid);
+
+    if (ns->params.zns.zoc & NVME_ID_NS_ZNS_ZOC_ZAE) {
+        return NVME_TOO_MANY_ACTIVE_ZONES;
+    }
+
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_active, lru_entry) {
+        zd = candidate->zd;
+        zs = nvme_zs(candidate);
+
+        trace_pci_nvme_zone_zrm_candidate(nvme_cid(req), ns->params.nsid,
+                                          nvme_zslba(candidate),
+                                          nvme_wp(candidate), zs);
+
+        goto out;
+    }
+
+    /*
+     * If all zone resources are tied up on open zones we have to transition
+     * one of those to full.
+     */
+    QTAILQ_FOREACH(candidate, &ns->zns.resources.lru_open, lru_entry) {
+        zd = candidate->zd;
+        zs = nvme_zs(candidate);
+
+        trace_pci_nvme_zone_zrm_candidate(nvme_cid(req), ns->params.nsid,
+                                          nvme_zslba(candidate),
+                                          nvme_wp(candidate), zs);
+
+        /* the zone cannot be finished if it is currently writing */
+        if (candidate->wp_staging != le64_to_cpu(zd->wp)) {
+            continue;
+        }
+
+        break;
+    }
+
+    assert(candidate);
+
+out:
+    nvme_zone_active_excursion(n, ns, candidate, req);
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, NvmeZoneState to,
                                     NvmeRequest *req)
@@ -1261,8 +1364,10 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
 
         case NVME_ZS_ZSC:
             if (!ns->zns.resources.active) {
-                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
-                return NVME_TOO_MANY_ACTIVE_ZONES;
+                status = nvme_zrm_release_active(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             ns->zns.resources.active--;
@@ -1273,8 +1378,10 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
             if (!ns->zns.resources.active) {
-                trace_pci_nvme_err_too_many_active_zones(nvme_cid(req));
-                return NVME_TOO_MANY_ACTIVE_ZONES;
+                status = nvme_zrm_release_active(n, ns, req);
+                if (status) {
+                    return status;
+                }
             }
 
             if (!ns->zns.resources.open) {
@@ -2498,6 +2605,40 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_changed_zone_info(NvmeCtrl *n, uint32_t buf_len,
+                                       uint64_t off, NvmeRequest *req)
+{
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+    NvmeNamespace *ns = nvme_ns(n, nsid);
+    uint32_t trans_len;
+    uint16_t status;
+
+    if (unlikely(!ns)) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_LOG_ID | NVME_DNR;
+    }
+
+    if (off > sizeof(NvmeChangedZoneList)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len = MIN(sizeof(NvmeChangedZoneList) - off, buf_len);
+
+    status = nvme_dma(n, (uint8_t *)&ns->zns.changed_list + off, trans_len,
+                      DMA_DIRECTION_FROM_DEVICE, req);
+    if (status) {
+        return status;
+    }
+
+    memset(&ns->zns.changed_list, 0x0, sizeof(NvmeChangedZoneList));
+    nvme_clear_events(n, NVME_AER_TYPE_NOTICE);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -2543,6 +2684,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_fw_log_info(n, len, off, req);
     case NVME_LOG_EFFECTS:
         return nvme_effects_log(n, len, off, req);
+    case NVME_LOG_CHANGED_ZONE_LIST:
+        return nvme_changed_zone_info(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -3161,7 +3304,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         if (((n->temperature >= n->features.temp_thresh_hi) ||
              (n->temperature <= n->features.temp_thresh_low)) &&
             NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
-            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+            nvme_enqueue_event(n, NULL, NVME_AER_TYPE_SMART,
                                NVME_AER_INFO_SMART_TEMP_THRESH,
                                NVME_LOG_SMART_INFO);
         }
@@ -3725,7 +3868,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
              * fashion.
              */
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -3742,7 +3885,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            qid, new_head);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_VALUE,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -3779,7 +3922,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            " sqid=%"PRIu32", ignoring", qid);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -3796,7 +3939,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
                            qid, new_tail);
 
             if (n->outstanding_aers) {
-                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                nvme_enqueue_event(n, NULL, NVME_AER_TYPE_ERROR,
                                    NVME_AER_INFO_ERR_INVALID_DB_VALUE,
                                    NVME_LOG_ERROR_INFO);
             }
@@ -4095,6 +4238,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->ieee[2] = 0xb3;
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
+    id->oaes = cpu_to_le32(NVME_OAES_ZDCN);
     id->oacs = cpu_to_le16(0);
 
     /*
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 18f7b24ef5e9..ebd786b77868 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -78,7 +78,7 @@ pci_nvme_aer(uint16_t cid) "cid %"PRIu16""
 pci_nvme_aer_aerl_exceeded(void) "aerl exceeded"
 pci_nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
 pci_nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
-pci_nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+pci_nvme_enqueue_event(uint32_t nsid, uint8_t typ, uint8_t info, uint8_t log_page) "nsid 0x%"PRIx32" type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 pci_nvme_enqueue_event_noqueue(int queued) "queued %d"
 pci_nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
 pci_nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
@@ -91,6 +91,9 @@ pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "sqid %"PRIu16" new_
 pci_nvme_zone_zrm_transition(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t from, uint8_t to) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" from 0x%"PRIx8" to 0x%"PRIx8""
 pci_nvme_zone_zrm_candidate(uint16_t cid, uint32_t nsid, uint64_t zslba, uint64_t wp, uint8_t zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" wp 0x%"PRIx64" zc 0x%"PRIx8""
 pci_nvme_zone_zrm_release_open(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_zrm_release_active(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_changed(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
+pci_nvme_zone_active_excursion(uint32_t nsid, uint64_t zslba, const char *zc) "nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
-- 
2.28.0


