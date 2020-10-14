Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E66EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498D020725
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498D020725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSf44-0005LB-Th
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0M-0003FO-6H; Wed, 14 Oct 2020 07:31:38 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0H-0006YK-9m; Wed, 14 Oct 2020 07:31:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id E2A7558019C;
 Wed, 14 Oct 2020 07:31:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=s7t3rxjys261A
 GOuBiOCoiffbBpDl8O9uL9vf5lg78I=; b=RhVDOIkhv2pleDCZywS7Xm9/I3a6z
 nE9ErM514mnuFlHE+IsueZpDbkQNaQI+vNLl4QjfPlW0Z8vPkN6RPlmCjk2JZ0ar
 2UnkiaWsYo6W8dlHWOhfal76kLtH0hahflO05SmHNkHjWXB2a2czQon6pqaiSWrh
 KOgyG4FtLX6fG12rJUjsKhnoF8EDrI5QhsMIzsX2DAMwl3iEUIzUhVsmwJtSc8RD
 ZbTRyTI6zj8AgL5JaKiyFQ5bDAj+AGeVfEaxI6LDlaWo+t0DGMhdVbcecWsaHcrM
 yx4mlD7GfKLkcEoroURsm0oWKxb1e8u+0pDEz5Zhgln959h3cKUGDk/2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=s7t3rxjys261AGOuBiOCoiffbBpDl8O9uL9vf5lg78I=; b=V6oJtwJQ
 F5nS+g5QMRTe5gTXCNKHAJ4io9GsrsIXdiQXvr8OUYVRdEo+cBVoAF/bxEGWiU4L
 AZCSqskwdRBqQDM+jjMDfwLdyurhHMd3e2ABdr1vFG81GJ0otgF/LStm4jH0930D
 7a70dfs4/Xhab8odNZZc25UY5mF42cZxaTLJmyppoye96t3u4l1HodMSaxvnNZI3
 sF3UxTixXopW7UqEfCZF+C7CX1ceCmLYbyi+V09atNx2q65/CuGZmwl92TFdGxZD
 UN1mhZqMFlLFN1NZbKrgTy6ohMD00FI7q0IhOpJ6uiK1j6LNDDy/YRUw8gBECphg
 9sRw8YBgbFXq0w==
X-ME-Sender: <xms:k-GGX4C7tyZKBJnGMZJu23MnVQ-UC76GICRcZbYP5GBTINgvu4Q4XA>
 <xme:k-GGX6jxpbDfCtLN7O_jmLaSkVQfaWikJiNkQkGMkobyeLcVg28MOG7sZ7n5XXp0u
 tg8OWEVwnwj3YWgCoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:k-GGX7ksBbx8joD54dvgcMDQmaiFi8aQMGcYvTu5B_JEPg19aandbg>
 <xmx:k-GGX-ys0aEuXexir0uq8kLZw319QVvgQoRh96W-WUabcKvJpUmvJQ>
 <xmx:k-GGX9RsdpUNaHSpAYk6WrrF2CLHQo-CHVXzVX7SjGWEjXIcvlIVoQ>
 <xmx:k-GGX8EAi-V15CE4j-Vq5KjalrbwbFJP6NyckG2JcxS6Z0Llro_ktw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id DC2353064674;
 Wed, 14 Oct 2020 07:31:29 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] hw/block/nvme: add basic read/write for zoned
 namespaces
Date: Wed, 14 Oct 2020 13:31:17 +0200
Message-Id: <20201014113122.388849-5-its@irrelevant.dk>
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

This adds basic read and write for zoned namespaces.

A zoned namespace is created by setting the iocs namespace parameter to
0x2 and specifying the zns.zcap parameter (zone capacity) in number of
logical blocks per zone. If a zone size (zns.zsze) is not specified, the
namespace device will set the zone size to be the next power of two and
fit in as many zones as possible on the underlying namespace blockdev.
This behavior is not required by the specification, but ensures that the
device can be initialized by the Linux kernel nvme driver, which
requires a power of two zone size.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |   8 ++
 hw/block/nvme-ns.h    |  80 +++++++++++
 hw/block/nvme.h       |  11 ++
 include/block/nvme.h  |  60 +++++++-
 hw/block/nvme-ns.c    | 116 ++++++++++++++++
 hw/block/nvme.c       | 308 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/trace-events |   7 +
 7 files changed, 585 insertions(+), 5 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 619bd9ce4378..80cb34406255 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -6,6 +6,14 @@ The nvme device (-device nvme) emulates an NVM Express Controller.
   `iocs`; The "I/O Command Set" associated with the namespace. E.g. 0x0 for the
      NVM Command Set (the default), or 0x2 for the Zoned Namespace Command Set.
 
+  `zns.zcap`; If `iocs` is 0x2, this specifies the zone capacity. It is
+     specified in units of logical blocks.
+
+  `zns.zsze`; If `iocs` is 0x2, this specifies the zone size. It is specified
+     in units of the logical blocks. If not specified, the value depends on
+     zns.zcap; if the zone capacity is a power of two, the zone size will be
+     set to that, otherwise it will default to the next power of two.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 5eb135a0b73f..dd311012213e 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -23,8 +23,19 @@ typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     uint8_t  iocs;
     QemuUUID uuid;
+
+    struct {
+        uint64_t zcap;
+        uint64_t zsze;
+    } zns;
 } NvmeNamespaceParams;
 
+typedef struct NvmeZone {
+    NvmeZoneDescriptor *zd;
+
+    uint64_t wp_staging;
+} NvmeZone;
+
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
@@ -38,8 +49,20 @@ typedef struct NvmeNamespace {
     struct {
         uint32_t err_rec;
     } features;
+
+    struct {
+        int num_zones;
+
+        NvmeZone           *zones;
+        NvmeZoneDescriptor *zd;
+    } zns;
 } NvmeNamespace;
 
+static inline bool nvme_ns_zoned(NvmeNamespace *ns)
+{
+    return ns->iocs == NVME_IOCS_ZONED;
+}
+
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
 {
     if (ns) {
@@ -54,17 +77,34 @@ static inline NvmeIdNsNvm *nvme_ns_id_nvm(NvmeNamespace *ns)
     return ns->id_ns[NVME_IOCS_NVM];
 }
 
+static inline NvmeIdNsZns *nvme_ns_id_zoned(NvmeNamespace *ns)
+{
+    return ns->id_ns[NVME_IOCS_ZONED];
+}
+
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
 {
     NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
     return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
 }
 
+static inline NvmeLBAFE *nvme_ns_lbafe(NvmeNamespace *ns)
+{
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+    NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
+    return &id_ns_zns->lbafe[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
 static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 {
     return nvme_ns_lbaf(ns)->ds;
 }
 
+static inline uint64_t nvme_ns_zsze(NvmeNamespace *ns)
+{
+    return nvme_ns_lbafe(ns)->zsze;
+}
+
 /* calculate the number of LBAs that the namespace can accomodate */
 static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
 {
@@ -77,10 +117,50 @@ static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
     return lba << nvme_ns_lbads(ns);
 }
 
+static inline NvmeZone *nvme_ns_zone(NvmeNamespace *ns, uint64_t lba)
+{
+    int idx = lba / nvme_ns_zsze(ns);
+    if (unlikely(idx >= ns->zns.num_zones)) {
+        return NULL;
+    }
+
+    return &ns->zns.zones[idx];
+}
+
+static inline NvmeZoneState nvme_zs(NvmeZone *zone)
+{
+    return (zone->zd->zs >> 4) & 0xf;
+}
+
+static inline void nvme_zs_set(NvmeZone *zone, NvmeZoneState zs)
+{
+    zone->zd->zs = zs << 4;
+}
+
+static inline uint64_t nvme_zslba(NvmeZone *zone)
+{
+    return le64_to_cpu(zone->zd->zslba);
+}
+
+static inline uint64_t nvme_zcap(NvmeZone *zone)
+{
+    return le64_to_cpu(zone->zd->zcap);
+}
+
+static inline uint64_t nvme_wp(NvmeZone *zone)
+{
+    return le64_to_cpu(zone->zd->wp);
+}
+
 typedef struct NvmeCtrl NvmeCtrl;
 
+const char *nvme_zs_str(NvmeZone *zone);
+const char *nvme_zs_to_str(NvmeZoneState zs);
+
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
 
+void nvme_ns_zns_init_zone_state(NvmeNamespace *ns);
+
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 5c1de0ef16e7..f66ed9ab7eff 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -36,6 +36,17 @@ typedef struct NvmeRequest {
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
+static inline bool nvme_req_is_write(NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE:
+    case NVME_CMD_WRITE_ZEROES:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static inline const char *nvme_adm_opc_str(uint8_t opc)
 {
     switch (opc) {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 443f5c7e8376..cf566032a9fa 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -391,8 +391,9 @@ enum NvmePmrmscMask {
     (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
 
 enum NvmeCommandSet {
-    NVME_IOCS_NVM = 0x0,
-    NVME_IOCS_MAX = 0x1,
+    NVME_IOCS_NVM   = 0x0,
+    NVME_IOCS_ZONED = 0x2,
+    NVME_IOCS_MAX   = 0x3,
 };
 
 enum NvmeSglDescriptorType {
@@ -702,6 +703,12 @@ enum NvmeStatusCodes {
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
+    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
+    NVME_ZONE_IS_FULL           = 0x01b9,
+    NVME_ZONE_IS_READ_ONLY      = 0x01ba,
+    NVME_ZONE_IS_OFFLINE        = 0x01bb,
+    NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_INVALID_ZONE_STATE_TRANSITION = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -778,6 +785,31 @@ enum {
     NVME_EFFECTS_UUID_SEL   = 1 << 19,
 };
 
+typedef enum NvmeZoneType {
+    NVME_ZT_SEQ = 0x2,
+} NvmeZoneType;
+
+typedef enum NvmeZoneState {
+    NVME_ZS_ZSE  = 0x1,
+    NVME_ZS_ZSIO = 0x2,
+    NVME_ZS_ZSEO = 0x3,
+    NVME_ZS_ZSC  = 0x4,
+    NVME_ZS_ZSRO = 0xd,
+    NVME_ZS_ZSF  = 0xe,
+    NVME_ZS_ZSO  = 0xf,
+} NvmeZoneState;
+
+typedef struct QEMU_PACKED NvmeZoneDescriptor {
+    uint8_t  zt;
+    uint8_t  zs;
+    uint8_t  za;
+    uint8_t  rsvd3[5];
+    uint64_t zcap;
+    uint64_t zslba;
+    uint64_t wp;
+    uint8_t  rsvd32[32];
+} NvmeZoneDescriptor;
+
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
     NVME_SMART_TEMPERATURE            = 1 << 1,
@@ -791,6 +823,7 @@ enum NvmeLogIdentifier {
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
     NVME_LOG_EFFECTS        = 0x05,
+    NVME_LOG_CHANGED_ZONE_LIST = 0xbf,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -1097,9 +1130,27 @@ enum NvmeIdNsDps {
     DPS_FIRST_EIGHT = 8,
 };
 
+typedef struct QEMU_PACKED NvmeLBAFE {
+    uint64_t    zsze;
+    uint8_t     zdes;
+    uint8_t     rsvd9[7];
+} NvmeLBAFE;
+
+typedef struct QEMU_PACKED NvmeIdNsZns {
+    uint16_t    zoc;
+    uint16_t    ozcs;
+    uint32_t    mar;
+    uint32_t    mor;
+    uint32_t    rrl;
+    uint32_t    frl;
+    uint8_t     rsvd20[2796];
+    NvmeLBAFE   lbafe[16];
+    uint8_t     rsvd3072[768];
+    uint8_t     vs[256];
+} NvmeIdNsZns;
+
 static inline void _nvme_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
@@ -1116,8 +1167,11 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescriptor) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
 }
 #endif
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 29f5bcce67ea..1a5e99e50578 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -28,6 +28,67 @@
 #include "nvme.h"
 #include "nvme-ns.h"
 
+const char *nvme_zs_str(NvmeZone *zone)
+{
+    return nvme_zs_to_str(nvme_zs(zone));
+}
+
+const char *nvme_zs_to_str(NvmeZoneState zs)
+{
+    switch (zs) {
+    case NVME_ZS_ZSE:  return "ZSE";
+    case NVME_ZS_ZSIO: return "ZSIO";
+    case NVME_ZS_ZSEO: return "ZSEO";
+    case NVME_ZS_ZSC:  return "ZSC";
+    case NVME_ZS_ZSRO: return "ZSRO";
+    case NVME_ZS_ZSF:  return "ZSF";
+    case NVME_ZS_ZSO:  return "ZSO";
+    }
+
+    return NULL;
+}
+
+static void nvme_ns_zns_init_zones(NvmeNamespace *ns)
+{
+    NvmeZone *zone;
+    NvmeZoneDescriptor *zd;
+    uint64_t zslba, zsze = nvme_ns_zsze(ns);
+
+    for (int i = 0; i < ns->zns.num_zones; i++) {
+        zslba = i * zsze;
+
+        zone = &ns->zns.zones[i];
+        zone->zd = &ns->zns.zd[i];
+        zone->wp_staging = zslba;
+
+        zd = zone->zd;
+        zd->zt = NVME_ZT_SEQ;
+        zd->zcap = cpu_to_le64(ns->params.zns.zcap);
+        zd->wp = zd->zslba = cpu_to_le64(zslba);
+
+        nvme_zs_set(zone, NVME_ZS_ZSE);
+    }
+}
+
+static void nvme_ns_init_zoned(NvmeNamespace *ns)
+{
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+    NvmeIdNsZns *id_ns_zns = nvme_ns_id_zoned(ns);
+
+    for (int i = 0; i <= id_ns->nlbaf; i++) {
+        id_ns_zns->lbafe[i].zsze = ns->params.zns.zsze ?
+            cpu_to_le64(ns->params.zns.zsze) :
+            cpu_to_le64(pow2ceil(ns->params.zns.zcap));
+    }
+
+    ns->zns.num_zones = nvme_ns_nlbas(ns) / nvme_ns_zsze(ns);
+    ns->zns.zones = g_malloc0_n(ns->zns.num_zones, sizeof(NvmeZone));
+    ns->zns.zd = g_malloc0_n(ns->zns.num_zones, sizeof(NvmeZoneDescriptor));
+
+    id_ns_zns->mar = 0xffffffff;
+    id_ns_zns->mor = 0xffffffff;
+}
+
 static void nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNsNvm *id_ns;
@@ -47,6 +108,11 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
+    if (nvme_ns_zoned(ns)) {
+        ns->id_ns[NVME_IOCS_ZONED] = g_new0(NvmeIdNsZns, 1);
+        nvme_ns_init_zoned(ns);
+    }
+
     /* no thin provisioning */
     id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
@@ -55,6 +121,36 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->nsfeat |= 0x4;
 }
 
+void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
+{
+    for (int i = 0; i < ns->zns.num_zones; i++) {
+        NvmeZone *zone = &ns->zns.zones[i];
+        zone->zd = &ns->zns.zd[i];
+
+        zone->wp_staging = nvme_wp(zone);
+
+        switch (nvme_zs(zone)) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+            break;
+
+        case NVME_ZS_ZSC:
+            if (nvme_wp(zone) == nvme_zslba(zone)) {
+                nvme_zs_set(zone, NVME_ZS_ZSE);
+            }
+
+            break;
+
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            zone->zd->wp = zone->zd->zslba;
+            nvme_zs_set(zone, NVME_ZS_ZSF);
+        }
+    }
+}
+
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
     if (!blkconf_blocksizes(&ns->blkconf, errp)) {
@@ -90,6 +186,20 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
     switch (ns->params.iocs) {
     case NVME_IOCS_NVM:
         break;
+
+    case NVME_IOCS_ZONED:
+        if (!ns->params.zns.zcap) {
+            error_setg(errp, "zns.zcap must be specified");
+            return -1;
+        }
+
+        if (ns->params.zns.zsze && ns->params.zns.zsze < ns->params.zns.zcap) {
+            error_setg(errp, "zns.zsze cannot be less than zns.zcap");
+            return -1;
+        }
+
+        break;
+
     default:
         error_setg(errp, "unsupported iocs");
         return -1;
@@ -110,6 +220,10 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     nvme_ns_init(ns);
 
+    if (nvme_ns_zoned(ns)) {
+        nvme_ns_zns_init_zones(ns);
+    }
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
@@ -146,6 +260,8 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, NVME_IOCS_NVM),
     DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
+    DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
+    DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c447dc75d5c0..0b8d66c56d3f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -154,6 +154,16 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
             NVME_EFFECTS_NVM_INITIALIZER,
         },
     },
+
+    [NVME_IOCS_ZONED] = {
+        .acs = {
+            NVME_EFFECTS_ADMIN_INITIALIZER,
+        },
+
+        .iocs = {
+            NVME_EFFECTS_NVM_INITIALIZER,
+        },
+    },
 };
 
 static void nvme_process_sq(void *opaque);
@@ -910,6 +920,112 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
     }
 }
 
+static uint16_t nvme_check_zone_readable(NvmeCtrl *n, NvmeRequest *req,
+                                         NvmeZone *zone)
+{
+    NvmeZoneState zs = nvme_zs(zone);
+    uint64_t zslba = nvme_zslba(zone);
+
+    if (zs == NVME_ZS_ZSO) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), zslba,
+                                                  NVME_ZS_ZSO);
+        return NVME_ZONE_IS_OFFLINE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_check_zone_read(NvmeCtrl *n, uint64_t slba, uint32_t nlb,
+                                     NvmeRequest *req, NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t zsze = nvme_ns_zsze(ns);
+    uint16_t status;
+
+    status = nvme_check_zone_readable(n, req, zone);
+    if (status) {
+        return status;
+    }
+
+    if ((slba + nlb) > (zslba + zsze)) {
+        trace_pci_nvme_err_zone_boundary(nvme_cid(req), slba, nlb, zsze);
+        return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_check_zone_writeable(NvmeCtrl *n, NvmeRequest *req,
+                                          NvmeZone *zone)
+{
+    NvmeZoneState zs = nvme_zs(zone);
+    uint64_t zslba = nvme_zslba(zone);
+
+    if (zs == NVME_ZS_ZSO) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), zslba,
+                                                  NVME_ZS_ZSO);
+        return NVME_ZONE_IS_OFFLINE | NVME_DNR;
+    }
+
+    switch (zs) {
+    case NVME_ZS_ZSE:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+        return NVME_SUCCESS;
+    case NVME_ZS_ZSF:
+        trace_pci_nvme_err_zone_is_full(nvme_cid(req), zslba);
+        return NVME_ZONE_IS_FULL | NVME_DNR;
+    case NVME_ZS_ZSRO:
+        trace_pci_nvme_err_zone_is_read_only(nvme_cid(req), zslba);
+        return NVME_ZONE_IS_READ_ONLY | NVME_DNR;
+    default:
+        break;
+    }
+
+    trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req), zslba, zs);
+    return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+}
+
+static uint16_t nvme_check_zone_write(NvmeCtrl *n, uint64_t slba, uint32_t nlb,
+                                      NvmeRequest *req, NvmeZone *zone)
+{
+    uint64_t zslba, wp, zcap;
+    uint16_t status;
+
+    zslba = nvme_zslba(zone);
+    wp = zone->wp_staging;
+    zcap = nvme_zcap(zone);
+
+    status = nvme_check_zone_writeable(n, req, zone);
+    if (status) {
+        return status;
+    }
+
+    if ((wp - zslba) + nlb > zcap) {
+        trace_pci_nvme_err_zone_boundary(nvme_cid(req), slba, nlb, zcap);
+        return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
+    }
+
+    if (slba != wp) {
+        trace_pci_nvme_err_zone_invalid_write(nvme_cid(req), slba, wp);
+        return NVME_ZONE_INVALID_WRITE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static inline uint16_t nvme_check_zone(NvmeCtrl *n, uint64_t slba,
+                                       uint32_t nlb, NvmeRequest *req,
+                                       NvmeZone *zone) {
+    if (nvme_req_is_write(req)) {
+        return nvme_check_zone_write(n, slba, nlb, req, zone);
+    }
+
+    return nvme_check_zone_read(n, slba, nlb, req, zone);
+}
+
 static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 {
     uint8_t mdts = n->params.mdts;
@@ -963,6 +1079,101 @@ static uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
+                                    NvmeZoneState to)
+{
+    NvmeZoneState from = nvme_zs(zone);
+
+    trace_pci_nvme_zrm_transition(ns->params.nsid, nvme_zslba(zone), from, to);
+
+    if (from == to) {
+        return NVME_SUCCESS;
+    }
+
+    switch (from) {
+    case NVME_ZS_ZSE:
+        break;
+
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+        switch (to) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSO:
+        case NVME_ZS_ZSEO:
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSC:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSC:
+        switch (to) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSO:
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSRO:
+        switch (to) {
+        case NVME_ZS_ZSO:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSF:
+        switch (to) {
+        case NVME_ZS_ZSE:
+        case NVME_ZS_ZSO:
+        case NVME_ZS_ZSRO:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSO:
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    }
+
+    nvme_zs_set(zone, to);
+    return NVME_SUCCESS;
+}
+
+static void nvme_zns_advance_wp(NvmeRequest *req)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+    NvmeZone *zone = nvme_ns_zone(req->ns, slba);
+    uint64_t wp = nvme_wp(zone);
+
+    wp += nlb;
+    zone->zd->wp = cpu_to_le64(wp);
+    if (wp == nvme_zslba(zone) + nvme_zcap(zone)) {
+        nvme_zrm_transition(req->ns, zone, NVME_ZS_ZSF);
+    }
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -978,6 +1189,10 @@ static void nvme_rw_cb(void *opaque, int ret)
 
     if (!ret) {
         block_acct_done(stats, acct);
+
+        if (nvme_ns_zoned(ns) && nvme_req_is_write(req)) {
+            nvme_zns_advance_wp(req);
+        }
     } else {
         uint16_t status;
 
@@ -1003,6 +1218,22 @@ static void nvme_rw_cb(void *opaque, int ret)
         error_report_err(local_err);
 
         req->status = status;
+
+        if (nvme_ns_zoned(ns)) {
+            NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+            uint64_t slba = le64_to_cpu(rw->slba);
+
+            NvmeZone *zone = nvme_ns_zone(ns, slba);
+
+            /*
+             * Transition the zone to read-only on write fault and offline
+             * on unrecovered read.
+             */
+            NvmeZoneState zs = status == NVME_WRITE_FAULT ?
+                NVME_ZS_ZSRO : NVME_ZS_ZSO;
+
+            nvme_zrm_transition(ns, zone, zs);
+        }
     }
 
     nvme_enqueue_req_completion(nvme_cq(req), req);
@@ -1032,7 +1263,28 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb,
                                              nvme_ns_id_nvm(ns)->nsze);
-        return status;
+        goto invalid;
+    }
+
+    if (nvme_ns_zoned(ns)) {
+        NvmeZone *zone = nvme_ns_zone(ns, slba);
+        assert(zone);
+
+        status = nvme_check_zone_write(n, slba, nlb, req, zone);
+        if (status) {
+            goto invalid;
+        }
+
+        switch (nvme_zs(zone)) {
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            break;
+        default:
+            nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+            break;
+        }
+
+        zone->wp_staging += nlb;
     }
 
     block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
@@ -1040,12 +1292,18 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     req->aiocb = blk_aio_pwrite_zeroes(req->ns->blkconf.blk, offset, count,
                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(ns->blkconf.blk), BLOCK_ACCT_WRITE);
+    return status;
 }
 
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+    NvmeZone *zone = NULL;
+
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
@@ -1072,6 +1330,16 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (nvme_ns_zoned(ns)) {
+        zone = nvme_ns_zone(ns, slba);
+        assert(zone);
+
+        status = nvme_check_zone(n, slba, nlb, req, zone);
+        if (status) {
+            goto invalid;
+        }
+    }
+
     if (acct == BLOCK_ACCT_READ) {
         if (NVME_ERR_REC_DULBE(ns->features.err_rec)) {
             status = nvme_check_dulbe(ns, slba, nlb);
@@ -1086,6 +1354,21 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (acct == BLOCK_ACCT_WRITE) {
+        if (zone) {
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+                break;
+            default:
+                nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                break;
+            }
+
+            zone->wp_staging += nlb;
+        }
+    }
+
     block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
     if (req->qsg.sg) {
         if (acct == BLOCK_ACCT_WRITE) {
@@ -2306,6 +2589,23 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
 
         nvme_ns_flush(ns);
+
+        if (nvme_ns_zoned(ns)) {
+            for (int i = 0; i < ns->zns.num_zones; i++) {
+                NvmeZone *zone = &ns->zns.zones[i];
+
+                switch (nvme_zs(zone)) {
+                case NVME_ZS_ZSIO:
+                case NVME_ZS_ZSEO:
+                    nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+                    break;
+                default:
+                    continue;
+                }
+            }
+
+            nvme_ns_zns_init_zone_state(ns);
+        }
     }
 
     n->bar.cc = 0;
@@ -2843,7 +3143,8 @@ static void nvme_init_state(NvmeCtrl *n)
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
-    n->iocscs[0] = 1 << NVME_IOCS_NVM;
+    n->iocscs[0] = (1 << NVME_IOCS_NVM) | (1 << NVME_IOCS_ZONED);
+    n->iocscs[1] = 1 << NVME_IOCS_NVM;
     n->features.iocsci = 0;
 }
 
@@ -2994,6 +3295,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint8_t *pci_conf = pci_dev->config;
     char *subnqn;
 
+    n->id_ctrl_iocss[NVME_IOCS_NVM] = g_new0(NvmeIdCtrl, 1);
+    n->id_ctrl_iocss[NVME_IOCS_ZONED] = g_new0(NvmeIdCtrl, 1);
+
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c8181511e077..2ccd53e1a55e 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -71,6 +71,7 @@ pci_nvme_enqueue_event_noqueue(int queued) "queued %d"
 pci_nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
 pci_nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
+pci_nvme_zrm_transition(uint32_t nsid, uint64_t zslba, uint8_t from, uint8_t to) "nsid %"PRIu32" zslba 0x%"PRIx64" from 0x%"PRIx8" to 0x%"PRIx8""
 pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
 pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
@@ -95,6 +96,10 @@ pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
 pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
+pci_nvme_err_zone_is_full(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0x%"PRIx64""
+pci_nvme_err_zone_is_read_only(uint16_t cid, uint64_t slba) "cid %"PRIu16" lba 0x%"PRIx64""
+pci_nvme_err_zone_invalid_write(uint16_t cid, uint64_t slba, uint64_t wp) "cid %"PRIu16" lba 0x%"PRIx64" wp 0x%"PRIx64""
+pci_nvme_err_zone_boundary(uint16_t cid, uint64_t slba, uint32_t nlb, uint64_t zcap) "cid %"PRIu16" lba 0x%"PRIx64" nlb %"PRIu32" zcap 0x%"PRIx64""
 pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
@@ -123,6 +128,8 @@ pci_nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx1
 pci_nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
 pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
 pci_nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
+pci_nvme_err_invalid_zone(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0x%"PRIx64""
+pci_nvme_err_invalid_zone_condition(uint16_t cid, uint64_t zslba, uint8_t condition) "cid %"PRIu16" zslba 0x%"PRIx64" condition 0x%"PRIx8""
 pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
 pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
 pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
-- 
2.28.0


