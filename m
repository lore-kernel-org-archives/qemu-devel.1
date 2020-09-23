Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800EAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41B2208B6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QFP0DI3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9YU-0006io-Nq
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9O3-0004zE-Ip; Wed, 23 Sep 2020 14:21:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9O1-00087h-0G; Wed, 23 Sep 2020 14:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600886188; x=1632422188;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qi/iVB5mxYaS41B2kxv5wS0js21a8adSbknuqPoXaF0=;
 b=QFP0DI3cz58Cm+nqEeB08NMbTzb7GnKXM8R+wJQveZuRDOujCTFzxq8j
 uAaG3b41U+9TKZ+iGOpbr7d1n3RV/nrP/CEheYbqzMqRLfuYidjf02lT8
 V0jwOjH0QVFDw8oQjsW4McxoQHuNfUrcEwzRRU8Mx4dFCTqYqzKT517pi
 AqrL2X7xzMeI+r/HYUNBIhcF7KZAvwE7fEQ/V9SjjA6kgS2sU9pn8kzMT
 z4Ev0B4fZN9bLVf8RBbxX9eGFwg0VfqJ/P1ROWBUX4hZN1y/ciINmB6O6
 DW4fHUIQ5mZ4DMk8YgagS+tiPYH9Mrth61Ui5rdBqOfh9qgzkL6dFsytA w==;
IronPort-SDR: 72ggEafsmcLFwceI0UUeMDLNJ+7Q5A64eZ5eo3/miKLtqwiN7thfIbefWsuJaFQChWs8cypQeI
 UaYOU8gzsAQBuCWfLTrBg0iIDCnpd8XiDFOiFz1Lj4h9RHmOMczfdaf0q8kkXQcloWFXrqgrDS
 2EngLpQjIG0eeKzWC+oVXOrwPzZ+TQfZBVV0JGJIuLCE9Pj5zGhKeOgSGo/LrdEbmSciUsy7h8
 C4RItlsnKOqVcQf/hc/skKLhwEm82/uVEyqKbq+MsKgah3f/ZOKcu7vlY+MoUTnnfF4Od+p5wn
 0fI=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; d="scan'208";a="251496352"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 02:36:25 +0800
IronPort-SDR: rRPvh5YT4P3r1egoEaYURxwqlyjWCW8OIMmP7IcHyC5QDHhuCvSi6HXy+5vweUDNQsjkseNRep
 paBxI6VUoSWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 11:07:05 -0700
IronPort-SDR: UbgLp49Sn1pjEOtHdGLSNzzrFeh5WgNB/VjUaVOVNETLYd5TqUJsfQuOr5XVZv0Ok0W/kLfHPE
 mYXdgOFUNGUA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2020 11:20:56 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v4 05/14] hw/block/nvme: Add support for Namespace Types
Date: Thu, 24 Sep 2020 03:20:12 +0900
Message-Id: <20200923182021.3724-6-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5287de305=dmitry.fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 14:20:48
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
 hw/block/nvme.c | 204 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 184 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 96cd520feb..e0f885498d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1153,6 +1153,15 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, uint64_t prp1,
+                                         uint64_t prp2, NvmeRequest *req)
+{
+    uint8_t id[NVME_IDENTIFY_DATA_SIZE] = {};
+
+    return nvme_dma_prp(n, id, sizeof(id), prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1165,6 +1174,21 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint64_t prp2 = le64_to_cpu(c->prp2);
+
+    trace_pci_nvme_identify_ctrl_csi(c->csi);
+
+    if (c->csi == NVME_CSI_NVM) {
+        return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -1181,11 +1205,37 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
     }
 
     ns = &n->namespaces[nsid - 1];
+    assert(nsid == ns->nsid);
 
     return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeNamespace *ns;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint64_t prp2 = le64_to_cpu(c->prp2);
+
+    trace_pci_nvme_identify_ns_csi(nsid, c->csi);
+
+    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
+        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ns = &n->namespaces[nsid - 1];
+    assert(nsid == ns->nsid);
+
+    if (c->csi == NVME_CSI_NVM) {
+        return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1225,23 +1275,51 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return ret;
 }
 
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
+    uint32_t min_nsid = le32_to_cpu(c->nsid);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint64_t prp2 = le64_to_cpu(c->prp2);
+    uint32_t *list;
+    uint16_t ret;
+    int i, j = 0;
+
+    trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
+
+    if (c->csi != NVME_CSI_NVM) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    list = g_malloc0(data_len);
+    for (i = 0; i < n->num_namespaces; i++) {
+        if (i < min_nsid) {
+            continue;
+        }
+        list[j++] = cpu_to_le32(i + 1);
+        if (j == data_len / sizeof(uint32_t)) {
+            break;
+        }
+    }
+    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+                       DMA_DIRECTION_FROM_DEVICE, req);
+    g_free(list);
+    return ret;
+}
+
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeNamespace *ns;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
-
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
+    void *buf_ptr;
+    NvmeIdNsDescr *desc;
+    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
+    uint8_t *buf;
+    uint16_t status;
 
     trace_pci_nvme_identify_ns_descr_list(nsid);
 
@@ -1250,7 +1328,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    memset(list, 0x0, sizeof(list));
+    ns = &n->namespaces[nsid - 1];
+    assert(nsid == ns->nsid);
+
+    buf = g_malloc0(data_len);
+    buf_ptr = buf;
 
     /*
      * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
@@ -1258,12 +1340,44 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
      * Namespace Identification Descriptor. Add a very basic Namespace UUID
      * here.
      */
-    ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
-    ns_descrs->uuid.hdr.nidl = NVME_NIDL_UUID;
-    stl_be_p(&ns_descrs->uuid.v, nsid);
+    desc = buf_ptr;
+    desc->nidt = NVME_NIDT_UUID;
+    desc->nidl = NVME_NIDL_UUID;
+    buf_ptr += sizeof(*desc);
+    memcpy(buf_ptr, ns->uuid.data, NVME_NIDL_UUID);
+    buf_ptr += NVME_NIDL_UUID;
 
-    return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    desc = buf_ptr;
+    desc->nidt = NVME_NIDT_CSI;
+    desc->nidl = NVME_NIDL_CSI;
+    buf_ptr += sizeof(*desc);
+    *(uint8_t *)buf_ptr = NVME_CSI_NVM;
+
+    status = nvme_dma_prp(n, buf, data_len, prp1, prp2,
+                          DMA_DIRECTION_FROM_DEVICE, req);
+    g_free(buf);
+    return status;
+}
+
+static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint64_t prp2 = le64_to_cpu(c->prp2);
+    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
+    uint32_t *list;
+    uint8_t *ptr;
+    uint16_t status;
+
+    trace_pci_nvme_identify_cmd_set();
+
+    list = g_malloc0(data_len);
+    ptr = (uint8_t *)list;
+    NVME_SET_CSI(*ptr, NVME_CSI_NVM);
+    status = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+                          DMA_DIRECTION_FROM_DEVICE, req);
+    g_free(list);
+    return status;
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
@@ -1273,12 +1387,20 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1460,6 +1582,9 @@ defaults:
             result |= NVME_INTVC_NOCOALESCING;
         }
 
+        break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = 0;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -1584,6 +1709,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1845,6 +1976,30 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
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
@@ -2255,6 +2410,8 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     n->ns_size = bs_size;
 
+    ns->csi = NVME_CSI_NVM;
+    qemu_uuid_generate(&ns->uuid); /* TODO make UUIDs persistent */
     lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     id_ns->lbaf[lba_index].ds = 31 - clz32(n->conf.logical_block_size);
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
@@ -2419,7 +2576,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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
@@ -2429,6 +2590,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
+    NvmeNamespace *ns;
     Error *local_err = NULL;
 
     int i;
@@ -2454,8 +2616,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
     nvme_init_ctrl(n, pci_dev);
 
-    for (i = 0; i < n->num_namespaces; i++) {
-        nvme_init_namespace(n, &n->namespaces[i], &local_err);
+    ns = n->namespaces;
+    for (i = 0; i < n->num_namespaces; i++, ns++) {
+        ns->nsid = i + 1;
+        nvme_init_namespace(n, ns, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
-- 
2.21.0


