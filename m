Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BC0221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BC0221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYIC-0002MI-6A
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY8D-0004re-GH; Thu, 24 Sep 2020 16:46:21 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7u-0007o6-6v; Thu, 24 Sep 2020 16:46:17 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id E601D58050C;
 Thu, 24 Sep 2020 16:45:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=mN5ShKu9d3P5r
 pWY9JSKX5DnpusrIBPYR17JFO82ROg=; b=b5FwoGTwKpXr4zMzkhUCaBv3FbnpX
 JbGK2Qc2yQ9v6w7QTFSmMyONxf8J3x7I5Ph5/A0kWM5UDu6MGJmecQu6ws7xhfzh
 xzVlqG3oBEpQbUenz6Hsx4hAOm2nUK0nh2t0vwvSYBAK9aVzXexNrN2wTPMakN4b
 t8UA3ACDaIfAEZFef5rkfZCRIaK700Ubax/fzWdVPayQNUPQgtiahgVN2ipwdwk3
 DZTrR4yKYeZFAApZaLiSnyVH5MDgGJG/l04sqXQWIdMU+f9vDxet0qwrZNDmxaBW
 6fjA9HP0t8KGbJrCmDjGkRKQsJYGRcXRQrJy+vOmotY28w6JEMJvAfNYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=mN5ShKu9d3P5rpWY9JSKX5DnpusrIBPYR17JFO82ROg=; b=miXGApZB
 g5YrNbuQnuAE5EoiD1RgqUiLKzJ1KM9Q/DGw+5xlpLkYDvDv3L+uU7UCyfFBMHzH
 jozihw4JEBVG9Pnq772yo1pB/cuUb0U1Be9pdZGP4S9qztm1fSyjmsqMQAkiuHHT
 oUFoqX7KN9GhCvkMWBp4X6MCQGYZYFK+eLR/0JJ980c88gedeMgCT7zcU/ExQsH8
 dzFkS5ukqY6SMA8NXDs+ABUwd4fuo3mZknYjqDU92xZXuDybrtbpPKzZlZrg3Ydu
 wacurqNnON+V/yRQByeNUDG8qpnzYWAO2W3aRUrVWljCNFchfMsaqi5zfSMttLqe
 MFw7j45oxUVD2Q==
X-ME-Sender: <xms:dAVtX_gdxI5fngfqkmDwXn9fRdtzF69Dnc4K1zm6ODjzBRMe12ha0w>
 <xme:dAVtX8CuA_UwsOt9wAVNQHUH-E9d8QnCdqZFqvQPzIwtFpxyTLjTf1kKMtVgl8pkL
 E-sv5F3Pe02U4vTI_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeevgeetjeefkeegjeffueevjefhjeffheektedvhfehjedtteehtddutdeiteev
 veenucffohhmrghinhepiihnshdrfhhrlhdprhgvshhouhhrtggvshdrrggtthhivhgvpd
 hrvghsohhurhgtvghsrdhophgvnhenucfkphepkedtrdduieejrdelkedrudeltdenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirh
 hrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:dAVtX_E_8jE0cZyG4H6qwZCwArap2vCnj76olj_tZXckcqMAzCcXjQ>
 <xmx:dAVtX8Qrpx6Rl_8OxQYB9bcXbJKQSEOTvZIoG0SoTvoHR1tIMczScA>
 <xmx:dAVtX8x-c8uEO04gRrwWECz_SjFC8iZsSQduYXG5YuUg094gE7RE8A>
 <xmx:dAVtX7oRBh726dD2VKHTZB1I9gH-1fySI4VfLvDSsO6Mx8LJOgm2Aw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 060D93064674;
 Thu, 24 Sep 2020 16:45:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] hw/block/nvme: support reset/finish recommended limits
Date: Thu, 24 Sep 2020 22:45:16 +0200
Message-Id: <20200924204516.1881843-17-its@irrelevant.dk>
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

Add the rrl,rrld,frl and frld device parameters. The frld and rrld
parameters specify the delay in seconds until the device sets the Finish
and Reset Zone Recommended attributes on zones when they are
transitioned to Full or an Opened state respectively. The rrl and frl
parameters specify the number of seconds before the device may perform
an internal operation to "clear" the attributes again.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |  9 +++++
 hw/block/nvme-ns.h    | 18 ++++++++--
 hw/block/nvme.h       |  2 ++
 include/block/nvme.h  |  2 ++
 hw/block/nvme-ns.c    | 79 +++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.c       | 56 ++++++++++++++++++++++++++++--
 hw/block/trace-events |  3 ++
 7 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index a286d9c07025..c2f30cfaaea6 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -41,6 +41,15 @@ nvme-ns Options
      will release active resources when needed by transitioning zones to the
      Full state.
 
+  `zns.{rrld,frld}`; Specifies the Reset and Finish Recommended Limit Delays,
+     that is, the number of seconds until the controller sets the Reset and
+     Finish Zone Recommended attributes on finished and opened zones
+     respectively.
+
+  `zns.{rrl,frl}`; Specifies the Reset and Finish Recommended Limits, that is,
+     the number of seconds until the controller clears the Reset and Finish
+     Zone Recommended attributes on finished and opened zones respectively.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index d9093fdad984..8daf3a90d7f0 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -31,6 +31,10 @@ typedef struct NvmeNamespaceParams {
         uint32_t mar;
         uint32_t mor;
         uint16_t zoc;
+        uint32_t rrl;
+        uint32_t frl;
+        uint32_t rrld;
+        uint32_t frld;
     } zns;
 } NvmeNamespaceParams;
 
@@ -40,9 +44,15 @@ typedef struct NvmeZone {
 
     uint64_t wp_staging;
 
+    struct {
+        int64_t timestamp;
+    } stats;
+
     QTAILQ_ENTRY(NvmeZone) lru_entry;
 } NvmeZone;
 
+typedef QTAILQ_HEAD(, NvmeZone) NvmeZoneList;
+
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
@@ -81,11 +91,15 @@ typedef struct NvmeNamespace {
             uint32_t open;
             uint32_t active;
 
-            QTAILQ_HEAD(, NvmeZone) lru_open;
-            QTAILQ_HEAD(, NvmeZone) lru_active;
+            NvmeZoneList lru_open;
+            NvmeZoneList lru_active;
         } resources;
 
         NvmeChangedZoneList changed_list;
+
+        NvmeZoneList lru_finished;
+        QEMUTimer *timer;
+        int64_t rrl_ns, rrld_ns, frl_ns, frld_ns;
     } zns;
 } NvmeNamespace;
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8cd2d936548e..d840ff2cb97c 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -203,5 +203,7 @@ static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
 }
 
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
+void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                       NvmeRequest *req);
 
 #endif /* HW_NVME_H */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 0948a262b2df..a66da8c46f9e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -894,6 +894,8 @@ typedef struct QEMU_PACKED NvmeChangedZoneList {
 } NvmeChangedZoneList;
 
 #define NVME_ZA_ZFC  (1 << 0)
+#define NVME_ZA_FZR  (1 << 1)
+#define NVME_ZA_RZR  (1 << 2)
 #define NVME_ZA_ZDEV (1 << 7)
 
 #define NVME_ZA_SET(za, attrs)   ((za) |= (attrs))
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 9a9f728d791f..6243458a436c 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -50,6 +50,64 @@ const char *nvme_zs_to_str(NvmeZoneState zs)
     return NULL;
 }
 
+static void nvme_ns_set_zone_attrs(NvmeCtrl *n, NvmeNamespace *ns,
+                                   NvmeZoneList *zone_list, int64_t delay,
+                                   int64_t limit, int64_t *next_timer,
+                                   uint8_t attr)
+{
+    NvmeZone *zone, *next;
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t timestamp;
+
+    QTAILQ_FOREACH_SAFE(zone, zone_list, lru_entry, next) {
+        timestamp = zone->stats.timestamp;
+        if (now - timestamp < delay) {
+            *next_timer = MIN(*next_timer, timestamp + delay);
+            return;
+        }
+
+        if (now - timestamp < delay + limit) {
+            trace_pci_nvme_ns_set_zone_attr(nvme_zslba(zone), attr);
+            zone->zd->za |= attr;
+            *next_timer = MIN(*next_timer, timestamp + delay + limit);
+        } else {
+            trace_pci_nvme_ns_clear_zone_attr(nvme_zslba(zone), attr);
+            zone->zd->za &= ~attr;
+            QTAILQ_REMOVE(zone_list, zone, lru_entry);
+            QTAILQ_INSERT_TAIL(zone_list, zone, lru_entry);
+
+            zone->stats.timestamp = now;
+            *next_timer = MIN(*next_timer, now + delay);
+        }
+
+        nvme_zone_changed(n, ns, zone, NULL);
+    }
+}
+
+static void nvme_ns_process_timer(void *opaque)
+{
+    NvmeNamespace *ns = opaque;
+    BusState *s = qdev_get_parent_bus(&ns->parent_obj);
+    NvmeCtrl *n = NVME(s->parent);
+    int64_t next_timer = INT64_MAX;
+
+    trace_pci_nvme_ns_process_timer(ns->params.nsid);
+
+    nvme_ns_set_zone_attrs(n, ns, &ns->zns.resources.lru_open, ns->zns.frld_ns,
+                           ns->zns.frl_ns, &next_timer, NVME_ZA_FZR);
+
+    nvme_ns_set_zone_attrs(n, ns, &ns->zns.resources.lru_active,
+                           ns->zns.frld_ns, ns->zns.frl_ns, &next_timer,
+                           NVME_ZA_FZR);
+
+    nvme_ns_set_zone_attrs(n, ns, &ns->zns.lru_finished, ns->zns.rrld_ns,
+                           ns->zns.rrl_ns, &next_timer, NVME_ZA_RZR);
+
+    if (next_timer != INT64_MAX) {
+        timer_mod(ns->zns.timer, next_timer);
+    }
+}
+
 static int nvme_blk_truncate(BlockBackend *blk, size_t len, Error **errp)
 {
     int ret;
@@ -121,6 +179,21 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
 
     id_ns->ncap = ns->zns.num_zones * ns->params.zns.zcap;
 
+    id_ns_zns->rrl = ns->params.zns.rrl;
+    id_ns_zns->frl = ns->params.zns.frl;
+
+    if (ns->params.zns.rrl || ns->params.zns.frl) {
+        ns->zns.rrl_ns = ns->params.zns.rrl * NANOSECONDS_PER_SECOND;
+        ns->zns.rrld_ns = ns->params.zns.rrld * NANOSECONDS_PER_SECOND;
+        ns->zns.frl_ns = ns->params.zns.frl * NANOSECONDS_PER_SECOND;
+        ns->zns.frld_ns = ns->params.zns.frld * NANOSECONDS_PER_SECOND;
+
+        ns->zns.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                     nvme_ns_process_timer, ns);
+
+        QTAILQ_INIT(&ns->zns.lru_finished);
+    }
+
     id_ns_zns->mar = cpu_to_le32(ns->params.zns.mar);
     id_ns_zns->mor = cpu_to_le32(ns->params.zns.mor);
 
@@ -266,6 +339,8 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
                         ns->zns.resources.active--;
                         QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone,
                                            lru_entry);
+                        zone->stats.timestamp =
+                            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
                         continue;
                     }
 
@@ -445,6 +520,10 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
     DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
     DEFINE_PROP_UINT16("zns.zoc", NvmeNamespace, params.zns.zoc, 0),
+    DEFINE_PROP_UINT32("zns.rrl", NvmeNamespace, params.zns.rrl, 0),
+    DEFINE_PROP_UINT32("zns.frl", NvmeNamespace, params.zns.frl, 0),
+    DEFINE_PROP_UINT32("zns.rrld", NvmeNamespace, params.zns.rrld, 0),
+    DEFINE_PROP_UINT32("zns.frld", NvmeNamespace, params.zns.frld, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ecc88e858eee..d472ed240059 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1200,8 +1200,8 @@ static inline void nvme_zone_reset_wp(NvmeZone *zone)
     zone->wp_staging = nvme_zslba(zone);
 }
 
-static void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
-                              NvmeRequest *req)
+void nvme_zone_changed(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone,
+                       NvmeRequest *req)
 {
     uint16_t num_ids = le16_to_cpu(ns->zns.changed_list.num_ids);
 
@@ -1244,6 +1244,7 @@ static void nvme_zone_active_excursion(NvmeCtrl *n, NvmeNamespace *ns,
 
     nvme_zrm_transition(n, ns, zone, NVME_ZS_ZSF, req);
     NVME_ZA_SET(zone->zd->za, NVME_ZA_ZFC);
+    NVME_ZA_CLEAR(zone->zd->za, NVME_ZA_FZR);
 
     nvme_zone_changed(n, ns, zone, req);
 }
@@ -1340,6 +1341,16 @@ out:
     return NVME_SUCCESS;
 }
 
+static void nvme_zone_activate(NvmeNamespace *ns, NvmeZone *zone)
+{
+    zone->stats.timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (ns->params.zns.frld && !timer_pending(ns->zns.timer)) {
+        int64_t next_timer = zone->stats.timestamp + ns->zns.frld_ns;
+        timer_mod(ns->zns.timer, next_timer);
+    }
+}
+
 static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, NvmeZoneState to,
                                     NvmeRequest *req)
@@ -1373,6 +1384,8 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
             ns->zns.resources.active--;
             QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_active, zone, lru_entry);
 
+            nvme_zone_activate(ns, zone);
+
             break;
 
         case NVME_ZS_ZSIO:
@@ -1395,6 +1408,7 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
             ns->zns.resources.open--;
             QTAILQ_INSERT_TAIL(&ns->zns.resources.lru_open, zone, lru_entry);
 
+            nvme_zone_activate(ns, zone);
             break;
 
         default:
@@ -1521,6 +1535,43 @@ static uint16_t nvme_zrm_transition(NvmeCtrl *n, NvmeNamespace *ns,
     }
 
     nvme_zs_set(zone, to);
+
+    if (ns->params.zns.rrld) {
+        switch (to) {
+        case NVME_ZS_ZSRO:
+            /* clock is already ticking if the zone was already full */
+            if (from == NVME_ZS_ZSF) {
+                break;
+            }
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSF:
+            QTAILQ_INSERT_TAIL(&ns->zns.lru_finished, zone, lru_entry);
+
+            zone->stats.timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+            if (!timer_pending(ns->zns.timer)) {
+                int64_t next_timer = zone->stats.timestamp + ns->zns.rrld_ns;
+                timer_mod(ns->zns.timer, next_timer);
+            }
+
+            break;
+
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSO:
+            if (from == NVME_ZS_ZSF) {
+                QTAILQ_REMOVE(&ns->zns.lru_finished, zone, lru_entry);
+                zone->stats.timestamp = 0;
+            }
+
+            break;
+
+        default:
+            break;
+        }
+    }
+
     return NVME_SUCCESS;
 }
 
@@ -1727,6 +1778,7 @@ static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
         return status;
     }
 
+    NVME_ZA_CLEAR(zone->zd->za, NVME_ZA_FZR);
     if (nvme_zns_commit_zone(ns, zone) < 0) {
         return NVME_INTERNAL_DEV_ERROR;
     }
diff --git a/hw/block/trace-events b/hw/block/trace-events
index ebd786b77868..917520b6f4d4 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -94,6 +94,9 @@ pci_nvme_zone_zrm_release_open(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid
 pci_nvme_zone_zrm_release_active(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 pci_nvme_zone_changed(uint16_t cid, uint32_t nsid, uint64_t zslba) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64""
 pci_nvme_zone_active_excursion(uint32_t nsid, uint64_t zslba, const char *zc) "nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_ns_process_timer(uint32_t nsid) "nsid %"PRIu32""
+pci_nvme_ns_set_zone_attr(uint64_t zslba, uint8_t attr) "zslba 0x%"PRIx64" attr 0x%"PRIu8""
+pci_nvme_ns_clear_zone_attr(uint64_t zslba, uint8_t attr) "zslba 0x%"PRIx64" attr 0x%"PRIu8""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
-- 
2.28.0


