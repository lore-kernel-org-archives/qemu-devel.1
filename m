Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B42C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D1320848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D1320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfG2-00056U-Bb
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0M-0003Ga-W1; Wed, 14 Oct 2020 07:31:39 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0J-0006a4-FO; Wed, 14 Oct 2020 07:31:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6137458019F;
 Wed, 14 Oct 2020 07:31:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=144eu7RkE36lw
 3ZwDzRsc3TBj9R+Hf7S4VzfbaTfStI=; b=EOdX8XjpKC05+V3SjsjxEARaNk8Kz
 KDmsmECNTFxLwnprb/wowqTDD18aAFPLWJf7qFtPIAW2p4hCNGv8GSOjFGOshJPT
 mNpyaEW5ygvLc++fZZapLbFkKxktg+tVSWPXZUNC56WSixhJXYuRz5Z5+mau4ubS
 lWDWJHfFLciD6s72JU3cXLAIuWKn0hZER6JEtz++crXS2fiiPrQCD/c/K79aBBmY
 251aiCdpSvh8uqJNScWTSp+BFIv7YX0uYIZh+wL/dDMkXruVlhXlWWdTsnY+LZrW
 aMrImUTc1IuyzNGHmAkZUfFhefdnhfXEgWcW7YFLRQDErrZKwKIo1WlFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=144eu7RkE36lw3ZwDzRsc3TBj9R+Hf7S4VzfbaTfStI=; b=m36lFWxi
 7Sd7Q7ebtU7z4ua8NtkSdsEJWuLYL+iPzEpQwSOCdtitFo24ISuOl7CKLqq5tieR
 Cbbpp7oh/oHPZ4x9ZmMnoHP6GNXqNYTC+F/uRnq8axJ0mv4mYfvgnygvPd+sljHP
 dkAj7O1gnKBhUU8lt5tAcyeM3utcq9VSgEHC9Zwlm+tNQn1FvkUuedgKTLmdhBsn
 5qIP4By66Im0JUByBbce2a6EjXAERDxEucXCK2e/C0sqyk+d7UhKEBzJ37Jw4mYM
 4ne2Ws3UzoDFEj0zb0CEdfwLlC7fakQ0LdK5kajiCbxb1CdHqMolezQZ9yBuw+Oj
 DcrqKFeRoAK5+g==
X-ME-Sender: <xms:leGGX7VEXVvYBUwK7UIuGmNT9F4R-SHZcB2jOE0VmL-CnsH2GynsAA>
 <xme:leGGXzn7QkcCKBOwhsfKtOj1kDJbXzVU9QubalCyalSLWEdC5woNC40HXuZvMgPYd
 bY1D2_vQ6hIEfDBW0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepfeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:leGGX3aFJoNtXdurkvdYUALqJVF6nJb-3O_iAhwks7xxxJbJbTbE0g>
 <xmx:leGGX2VD-hRrT2AERjwtNq2EiGgEG2p_2oFXBzrjjGseEjqs_8gVSg>
 <xmx:leGGX1k0e7rhGnT06Z_xKbRrT2W8921WA417wW_U8xZkQcWl_zmzrw>
 <xmx:luGGXzZBqZo5mpr4tXm984Izn-VOZ-jJVIwRA6NA8KfoRPu4dFFhsw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id A83CD3064674;
 Wed, 14 Oct 2020 07:31:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] hw/block/nvme: add the zone management send command
Date: Wed, 14 Oct 2020 13:31:19 +0200
Message-Id: <20201014113122.388849-7-its@irrelevant.dk>
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

Add the Zone Management Send command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       |   2 +
 include/block/nvme.h  |  28 +++
 hw/block/nvme.c       | 384 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/trace-events |  11 ++
 4 files changed, 420 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 523eef0bcad8..658f15bb5fd1 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -28,6 +28,7 @@ typedef struct NvmeRequest {
     struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
+    void                    *opaque;
     NvmeCqe                 cqe;
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
@@ -71,6 +72,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
     case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
     case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
+    case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_ZONE_MGMT_SEND";
     case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_ZONE_MGMT_RECV";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index fdbb3a0d5490..4181d0068edb 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -480,6 +480,7 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
     NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
 };
 
@@ -593,6 +594,32 @@ enum {
     NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
 };
 
+typedef struct QEMU_PACKED NvmeZoneManagementSendCmd {
+    uint8_t     opcode;
+    uint8_t     flags;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint32_t    rsvd8[4];
+    NvmeCmdDptr dptr;
+    uint64_t    slba;
+    uint32_t    rsvd48;
+    uint8_t     zsa;
+    uint8_t     zsflags;
+    uint16_t    rsvd54;
+    uint32_t    rsvd56[2];
+} NvmeZoneManagementSendCmd;
+
+#define NVME_CMD_ZONE_MGMT_SEND_SELECT_ALL(zsflags) ((zsflags) & 0x1)
+
+typedef enum NvmeZoneManagementSendAction {
+    NVME_CMD_ZONE_MGMT_SEND_CLOSE   = 0x1,
+    NVME_CMD_ZONE_MGMT_SEND_FINISH  = 0x2,
+    NVME_CMD_ZONE_MGMT_SEND_OPEN    = 0x3,
+    NVME_CMD_ZONE_MGMT_SEND_RESET   = 0x4,
+    NVME_CMD_ZONE_MGMT_SEND_OFFLINE = 0x5,
+    NVME_CMD_ZONE_MGMT_SEND_SET_ZDE = 0x10,
+} NvmeZoneManagementSendAction;
+
 typedef struct QEMU_PACKED NvmeZoneManagementRecvCmd {
     uint8_t     opcode;
     uint8_t     flags;
@@ -1206,6 +1233,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdentify) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRwCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementSendCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementRecvCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRangeType) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a92cd02d8955..e02c89b1496b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -163,6 +163,8 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
         .iocs = {
             NVME_EFFECTS_NVM_INITIALIZER,
             [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
+            [NVME_CMD_ZONE_MGMT_SEND] = NVME_EFFECTS_CSUPP |
+                                        NVME_EFFECTS_LBCC,
         },
     },
 };
@@ -1080,6 +1082,12 @@ static uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
     return NVME_SUCCESS;
 }
 
+static inline void nvme_zone_reset_wp(NvmeZone *zone)
+{
+    zone->zd->wp = zone->zd->zslba;
+    zone->wp_staging = nvme_zslba(zone);
+}
+
 static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
                                     NvmeZoneState to)
 {
@@ -1100,6 +1108,10 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
     case NVME_ZS_ZSEO:
         switch (to) {
         case NVME_ZS_ZSE:
+            nvme_zone_reset_wp(zone);
+
+            /* fallthrough */
+
         case NVME_ZS_ZSO:
             NVME_ZA_CLEAR_ALL(zd->za);
 
@@ -1120,6 +1132,10 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
     case NVME_ZS_ZSC:
         switch (to) {
         case NVME_ZS_ZSE:
+            nvme_zone_reset_wp(zone);
+
+            /* fallthrough */
+
         case NVME_ZS_ZSO:
             NVME_ZA_CLEAR_ALL(zd->za);
 
@@ -1152,8 +1168,12 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
     case NVME_ZS_ZSF:
         switch (to) {
         case NVME_ZS_ZSE:
+            nvme_zone_reset_wp(zone);
+
+            /* fallthrough */
+
         case NVME_ZS_ZSO:
-            NVME_ZA_CLEAR_ALL(zd->za);
+            NVME_ZA_CLEAR_ALL(zone->zd->za);
 
             /* fallthrough */
 
@@ -1254,6 +1274,354 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
+static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
+                                          NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_close(nvme_cid(req), nvme_nsid(ns),
+                                        nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSC:
+        return NVME_SUCCESS;
+
+    case NVME_ZS_ZSE:
+        /*
+         * The state machine in nvme_zrm_transition allows zones to transition
+         * from ZSE to ZSC. That transition is only valid if done as part Set
+         * Zone Descriptor, so do an early check here.
+         */
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+
+    default:
+        break;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    if (status) {
+        return status;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
+                                           NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_finish(nvme_cid(req), nvme_nsid(ns),
+                                         nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) == NVME_ZS_ZSF) {
+        return NVME_SUCCESS;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSF);
+    if (status) {
+        return status;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
+                                         NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_open(nvme_cid(req), nvme_nsid(ns),
+                                       nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) == NVME_ZS_ZSEO) {
+        return NVME_SUCCESS;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSEO);
+    if (status) {
+        return status;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static void nvme_aio_discard_cb(void *opaque, int ret)
+{
+    NvmeRequest *req = opaque;
+    int *count = req->opaque;
+
+    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
+
+    if (ret) {
+        req->status = NVME_INTERNAL_DEV_ERROR;
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
+                               req->status);
+    }
+
+    if (count && --(*count) > 0) {
+        return;
+    }
+
+    g_free(req->opaque);
+    req->opaque = NULL;
+
+    nvme_enqueue_req_completion(nvme_cq(req), req);
+}
+
+static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
+                                          NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t zcap = nvme_zcap(zone);
+    int *count = req->opaque;
+
+    trace_pci_nvme_zone_mgmt_send_reset(nvme_cid(req), nvme_nsid(ns),
+                                        nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSE:
+        return NVME_SUCCESS;
+
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSF:
+        blk_aio_pdiscard(ns->blkconf.blk, nvme_l2b(ns, zslba),
+                         nvme_l2b(ns, zcap), nvme_aio_discard_cb, req);
+
+        if (count) {
+            (*count)++;
+        }
+
+        nvme_zrm_transition(ns, zone, NVME_ZS_ZSE);
+
+        return NVME_NO_COMPLETE;
+
+    default:
+        break;
+    }
+
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
+                                            NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_offline(nvme_cid(req), nvme_nsid(ns),
+                                          nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSRO:
+        nvme_zrm_transition(ns, zone, NVME_ZS_ZSO);
+
+        /* fallthrough */
+
+    case NVME_ZS_ZSO:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
+                                            NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_set_zde(nvme_cid(req), nvme_nsid(ns),
+                                          nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) != NVME_ZS_ZSE) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req),
+                                                  nvme_zslba(zone),
+                                                  nvme_zs(zone));
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    }
+
+    status = nvme_check_mdts(n, nvme_ns_zdes_bytes(ns));
+    if (status) {
+        return status;
+    }
+
+    status = nvme_dma(n, zone->zde, nvme_ns_zdes_bytes(ns),
+                      DMA_DIRECTION_TO_DEVICE, req);
+    if (status) {
+        return status;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    if (status) {
+        return status;
+    }
+
+    NVME_ZA_SET(zone->zd->za, NVME_ZA_ZDEV);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+    int *countp = NULL;
+    uint16_t status = NVME_SUCCESS;
+
+    trace_pci_nvme_zone_mgmt_send_all(nvme_cid(req), nvme_nsid(ns), send->zsa);
+
+    switch (send->zsa) {
+    case NVME_CMD_ZONE_MGMT_SEND_SET_ZDE:
+        return NVME_INVALID_FIELD | NVME_DNR;
+
+    case NVME_CMD_ZONE_MGMT_SEND_CLOSE:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+                status = nvme_zone_mgmt_send_close(n, req, zone);
+                if (status) {
+                    return status;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_FINISH:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+            case NVME_ZS_ZSC:
+                status = nvme_zone_mgmt_send_finish(n, req, zone);
+                if (status) {
+                    return status;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            if (nvme_zs(zone) == NVME_ZS_ZSC) {
+                status = nvme_zone_mgmt_send_open(n, req, zone);
+                if (status) {
+                    return status;
+                }
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_RESET:
+        countp = g_new0(int, 1);
+        req->opaque = countp;
+
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+            case NVME_ZS_ZSC:
+            case NVME_ZS_ZSF:
+                nvme_zone_mgmt_send_reset(n, req, zone);
+            default:
+                continue;
+            }
+        }
+
+        if (*countp) {
+            return NVME_NO_COMPLETE;
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_OFFLINE:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            if (nvme_zs(zone) == NVME_ZS_ZSRO) {
+                status = nvme_zone_mgmt_send_offline(n, req, zone);
+                if (status) {
+                    return status;
+                }
+            }
+        }
+
+        break;
+    }
+
+    return status;
+}
+
+static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
+    NvmeZoneManagementSendAction zsa = send->zsa;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+    uint64_t zslba = le64_to_cpu(send->slba);
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    trace_pci_nvme_zone_mgmt_send(nvme_cid(req), ns->params.nsid, zslba, zsa,
+                                  send->zsflags);
+
+    if (NVME_CMD_ZONE_MGMT_SEND_SELECT_ALL(send->zsflags)) {
+        return nvme_zone_mgmt_send_all(n, req);
+    }
+
+    zone = nvme_ns_zone(ns, zslba);
+    if (!zone || zslba != nvme_zslba(zone)) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (zsa) {
+    case NVME_CMD_ZONE_MGMT_SEND_CLOSE:
+        return nvme_zone_mgmt_send_close(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_FINISH:
+        return nvme_zone_mgmt_send_finish(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        return nvme_zone_mgmt_send_open(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_RESET:
+        return nvme_zone_mgmt_send_reset(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_OFFLINE:
+        return nvme_zone_mgmt_send_offline(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_SET_ZDE:
+        return nvme_zone_mgmt_send_set_zde(n, req, zone);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeZoneManagementRecvCmd *recv;
@@ -1424,8 +1792,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         case NVME_ZS_ZSEO:
             break;
         default:
-            nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
-            break;
+            status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+            if (status) {
+                goto invalid;
+            }
         }
 
         zone->wp_staging += nlb;
@@ -1505,8 +1875,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
             case NVME_ZS_ZSEO:
                 break;
             default:
-                nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
-                break;
+                status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                if (status) {
+                    goto invalid;
+                }
             }
 
             zone->wp_staging += nlb;
@@ -1571,6 +1943,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, req);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
     case NVME_CMD_ZONE_MGMT_RECV:
         return nvme_zone_mgmt_recv(n, req);
     default:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 546aea3221dc..bc3e10f298d2 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -43,7 +43,17 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opna
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_zone_mgmt_send(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t zsa, uint8_t zsflags) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zsa 0x%"PRIx8" zsflags 0x%"PRIx8""
+pci_nvme_zone_mgmt_send_all(uint16_t cid, uint32_t nsid, uint8_t za) "cid %"PRIu16" nsid %"PRIu32" za 0x%"PRIx8""
+pci_nvme_zone_mgmt_send_close(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_finish(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_open(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_reset(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_reset_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_mgmt_send_offline(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_set_zde(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
 pci_nvme_zone_mgmt_recv(uint16_t cid, uint32_t nsid, uint64_t slba, uint64_t len, uint8_t zra, uint8_t zrasp, uint8_t zrasf) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" len %"PRIu64" zra 0x%"PRIx8" zrasp 0x%"PRIx8" zrasf 0x%"PRIx8""
+pci_nvme_aio_discard_cb(uint16_t cid) "cid %"PRIu16""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
@@ -131,6 +141,7 @@ pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx
 pci_nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
 pci_nvme_err_invalid_zone(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0x%"PRIx64""
 pci_nvme_err_invalid_zone_condition(uint16_t cid, uint64_t zslba, uint8_t condition) "cid %"PRIu16" zslba 0x%"PRIx64" condition 0x%"PRIx8""
+pci_nvme_err_invalid_zslba(uint16_t cid, uint64_t zslba) "cid %"PRIu16" zslba 0x%"PRIx64""
 pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
 pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
 pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
-- 
2.28.0


