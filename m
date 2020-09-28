Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DBEC4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C0722262
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q5Chr0KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C0722262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj3P-0008Tb-42
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj14-0006eA-3f; Sun, 27 Sep 2020 22:35:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj11-0003Li-Bg; Sun, 27 Sep 2020 22:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260547; x=1632796547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t2Qxx4najmz146ohxIowPpGXNgaSx6iVZjiHXOTR+tk=;
 b=Q5Chr0KK3+XK25KY6NLtB1jPBJRJeohgpyXwaAvgzR46WWYV3tNuX8ff
 wxkcNzKE1yIWUSU2BsZv10kHUpJL9C5NR+zsYsWl95RJXmOClUJFqiQaa
 twoPpgaom79JDGQnwdjg+hs/Xn8EAjiRtl25okcpr4wcooTJCISlxGToV
 dWVLLDpmz/mMCBkEAXW1hhPMKMbZG/DljZtHTvA1Yx41tMGl1mZxOhOBn
 3ahUnNrX5fmzKOE7o6C76oXgh162KRIJZkU8yPQ/A5RURdVVGyMtOenAl
 1K1Y2PU7IivBHUbjGl1O4zU33a7SZaZbLFYWBwtKnzd/gE4qJSZLUDbBF Q==;
IronPort-SDR: I8Elb/UX9NL8v8aHay2YHmHj2jOVNGWhvyoYunIYJLMNly9oi6622K2JeQet8bVseJduGYqFxZ
 9W/nPPFpNN5ZljjL90ip75rdigom5U5lGZhXx1NlOl3h/oB/3EWfiJgHlLYBfCq/iV3ohaUNQn
 x/z3EnGjUjIBzVS+PiXET24GW3z1RiejtFP4nMT86nnhoGsr5GjJaFY4TH49CzSUr5+mvkF1Ti
 2t7wyr+cgYANgrk1pfMN5zM7Y/NtkLfIlcUWXVz+ZFLH+dn0zOGqIriX7w0Fc6bNXD2d7Gf6zV
 MN4=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125237"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:45 +0800
IronPort-SDR: q1lxyNLdPyiU5Ini4Ch6mkRKqRQLrnrWH8dwN23NAYUj+CadZAazM2QV0HpTUjLloA+IsPRJBh
 a/iU9W5h9cTQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:41 -0700
IronPort-SDR: 5oVHSBpFJYjWdZ6vNDuuF/EvtBdUMEgN7kxtF3PZHPnD0M/Yjo2/ofsouUkhfXZx/wDu5zKv6k
 ZJRHgQQNIsDQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:44 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Date: Mon, 28 Sep 2020 11:35:19 +0900
Message-Id: <20200928023528.15260-6-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niklas Cassel <niklas.cassel@wdc.com>

Namespace Types introduce a new command set, "I/O Command Sets",
that allows the host to retrieve the command sets associated with
a namespace. Introduce support for the command set and enable
detection for the NVM Command Set.

The new workflows for identify commands rely heavily on zero-filled
identify structs. E.g., certain CNS commands are defined to return
a zero-filled identify struct when an inactive namespace NSID
is supplied.

Add a helper function in order to avoid code duplication when
reporting zero-filled identify structures.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.c |   3 +
 hw/block/nvme.c    | 210 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 175 insertions(+), 38 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index bbd7879492..31b7f986c3 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -40,6 +40,9 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
+    ns->params.csi = NVME_CSI_NVM;
+    qemu_uuid_generate(&ns->params.uuid); /* TODO make UUIDs persistent */
+
     /* no thin provisioning */
     id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 29fa005fa2..4ec1ddc90a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1495,6 +1495,13 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint8_t id[NVME_IDENTIFY_DATA_SIZE] = {};
+
+    return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_pci_nvme_identify_ctrl();
@@ -1503,11 +1510,23 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+
+    trace_pci_nvme_identify_ctrl_csi(c->csi);
+
+    if (c->csi == NVME_CSI_NVM) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    NvmeIdNs *id_ns, inactive = { 0 };
     uint32_t nsid = le32_to_cpu(c->nsid);
 
     trace_pci_nvme_identify_ns(nsid);
@@ -1518,23 +1537,46 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 
     ns = nvme_ns(n, nsid);
     if (unlikely(!ns)) {
-        id_ns = &inactive;
-    } else {
-        id_ns = &ns->id_ns;
+        return nvme_rpt_empty_id_struct(n, req);
     }
 
-    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
+    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+
+    trace_pci_nvme_identify_ns_csi(nsid, c->csi);
+
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
+    if (c->csi == NVME_CSI_NVM) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
-    uint32_t *list;
-    uint16_t ret;
-    int j = 0;
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+    uint32_t *list_ptr = (uint32_t *)list;
+    int i, j = 0;
 
     trace_pci_nvme_identify_nslist(min_nsid);
 
@@ -1548,48 +1590,76 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    list = g_malloc0(data_len);
-    for (int i = 1; i <= n->num_namespaces; i++) {
-        if (i <= min_nsid || !nvme_ns(n, i)) {
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
             continue;
         }
-        list[j++] = cpu_to_le32(i);
+        if (ns->params.nsid < min_nsid) {
+            continue;
+        }
+        list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
         }
     }
-    ret = nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DEVICE,
-                   req);
-    g_free(list);
-    return ret;
+
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
+}
+
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t min_nsid = le32_to_cpu(c->nsid);
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+    uint32_t *list_ptr = (uint32_t *)list;
+    int i, j = 0;
+
+    trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
+
+    if (c->csi != NVME_CSI_NVM) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+        if (ns->params.nsid < min_nsid) {
+            continue;
+        }
+        list_ptr[j++] = cpu_to_le32(ns->params.nsid);
+        if (j == data_len / sizeof(uint32_t)) {
+            break;
+        }
+    }
+
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeNamespace *ns;
     uint32_t nsid = le32_to_cpu(c->nsid);
-    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
-
-    struct data {
-        struct {
-            NvmeIdNsDescr hdr;
-            uint8_t v[16];
-        } uuid;
-    };
-
-    struct data *ns_descrs = (struct data *)list;
+    NvmeIdNsDescr *desc;
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+    void *list_ptr = list;
 
     trace_pci_nvme_identify_ns_descr_list(nsid);
 
-    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
-        return NVME_INVALID_NSID | NVME_DNR;
-    }
-
     if (unlikely(!nvme_ns(n, nsid))) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    memset(list, 0x0, sizeof(list));
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
 
     /*
      * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
@@ -1597,12 +1667,31 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
      * Namespace Identification Descriptor. Add a very basic Namespace UUID
      * here.
      */
-    ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
-    ns_descrs->uuid.hdr.nidl = NVME_NIDL_UUID;
-    stl_be_p(&ns_descrs->uuid.v, nsid);
+    desc = list_ptr;
+    desc->nidt = NVME_NIDT_UUID;
+    desc->nidl = NVME_NIDL_UUID;
+    list_ptr += sizeof(*desc);
+    memcpy(list_ptr, ns->params.uuid.data, NVME_NIDL_UUID);
+    list_ptr += NVME_NIDL_UUID;
 
-    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
-                    DMA_DIRECTION_FROM_DEVICE, req);
+    desc = list_ptr;
+    desc->nidt = NVME_NIDT_CSI;
+    desc->nidl = NVME_NIDL_CSI;
+    list_ptr += sizeof(*desc);
+    *(uint8_t *)list_ptr = NVME_CSI_NVM;
+
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
+}
+
+static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+
+    trace_pci_nvme_identify_cmd_set();
+
+    NVME_SET_CSI(*list, NVME_CSI_NVM);
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
@@ -1612,12 +1701,20 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
         return nvme_identify_ns(n, req);
+    case NVME_ID_CNS_CS_NS:
+        return nvme_identify_ns_csi(n, req);
     case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, req);
+    case NVME_ID_CNS_CS_CTRL:
+        return nvme_identify_ctrl_csi(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
         return nvme_identify_nslist(n, req);
+    case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
+        return nvme_identify_nslist_csi(n, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
+    case NVME_ID_CNS_IO_COMMAND_SET:
+        return nvme_identify_cmd_set(n, req);
     default:
         trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1799,6 +1896,9 @@ defaults:
             result |= NVME_INTVC_NOCOALESCING;
         }
 
+        break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = 0;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -1939,6 +2039,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, req);
+    case NVME_COMMAND_SET_PROFILE:
+        if (dw11 & 0x1ff) {
+            trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
+            return NVME_CMD_SET_CMB_REJECTED | NVME_DNR;
+        }
+        break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -2222,6 +2328,30 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         break;
     case 0x14:  /* CC */
         trace_pci_nvme_mmio_cfg(data & 0xffffffff);
+
+        if (NVME_CC_CSS(data) != NVME_CC_CSS(n->bar.cc)) {
+            if (NVME_CC_EN(n->bar.cc)) {
+                NVME_GUEST_ERR(pci_nvme_err_change_css_when_enabled,
+                               "changing selected command set when enabled");
+            } else {
+                switch (NVME_CC_CSS(data)) {
+                case CSS_NVM_ONLY:
+                    trace_pci_nvme_css_nvm_cset_selected_by_host(data &
+                                                                 0xffffffff);
+                    break;
+                case CSS_CSI:
+                    NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
+                    trace_pci_nvme_css_all_csets_sel_by_host(data & 0xffffffff);
+                    break;
+                case CSS_ADMIN_ONLY:
+                    break;
+                default:
+                    NVME_GUEST_ERR(pci_nvme_ub_unknown_css_value,
+                                   "unknown value in CC.CSS field");
+                }
+            }
+        }
+
         /* Windows first sends data, then sends enable bit */
         if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
             !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
@@ -2810,7 +2940,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
-    NVME_CAP_SET_CSS(n->bar.cap, 1);
+    /*
+     * The device now always supports NS Types, but all commands
+     * that support CSI field will only handle NVM Command Set.
+     */
+    NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
     n->bar.vs = NVME_SPEC_VER;
-- 
2.21.0


