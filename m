Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A33C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF9C20723
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mnM8DzU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF9C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEaU-00082w-QS
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQ2-00040N-NZ; Sat, 12 Sep 2020 18:54:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQ0-0005VV-55; Sat, 12 Sep 2020 18:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599951291; x=1631487291;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oGpiw/XjGVJV5+zoC8o+kdLyx5GH5YcYXRJCfsY8ndM=;
 b=mnM8DzU+qERUKSIYZT7Lmbun62IYGWXRfivNng5dajIvv5WHAjb9XflR
 9xORzKxRyxQUrS8xRdg74Ne/lldB5f4nO3nWNQGkx+Aqc/UfCqP7MiAOi
 GI1dCipdgk+ydmd81CJSaG5dhcz9AKWbQ9IMomquoqu8MwT+sYSjumUXp
 jIcj+8Gz7CULJGkWj65by3eP7ihzwhyWSDaxL0iYJ/1m2vxlC2pBy/rnJ
 t0uyvzOEaPPPkmTmSHJV2eLT3mnFQSH2l94sV/gHsYcXNBKwOeIa/kxYH
 +U5VcVPwKbxccXPlOxWyUuCRAPop8BAPyB6kZmZwnsFjoHm2PvjUjiN4w g==;
IronPort-SDR: 7Mti2WJg02uLdU4FEix96nVLBGljsMlKT+cidRdQD5+z3Gf/8Jh32imKrNZ5LzV62ZytaMAhQt
 KGMHVDfquNABechQj3VK3w8YU1E/oj1NSQIcHfvN1pxrGUHZ4o88vzEZMjHtHHhgXhEm7BYnGi
 3ljn7S56EebAjEZV5aW37CIBhF4mS1fVzhqkwSDP0TLO0DBp5Fov13HYcs7NrGuVZGRuWBU9lC
 YOQnv5NpAvtE6ZWHHDlbv+a2GrAkGOlOWHjPbOtq7FCLEyb1PUJWyMAKZ+M8W4T+O1jkyQwyfJ
 m6Q=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; d="scan'208";a="256834849"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2020 06:54:50 +0800
IronPort-SDR: sO06Nav3ZesCMJZk/WP+JXbuDJ1IQSrppUDDjaQI78vr2sjs2naG/IMVgI+q6ZMg6uh6a3KaiH
 SZl90C2Tj2kw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 15:41:10 -0700
IronPort-SDR: aRt39J88Yx4SXv1CdsX83GUM/DrlBP7NyDyoLzjNmnyyNSGnUt3StE+JQQBqhd3mzxKwBNKPnH
 pr9Jmcwn+/lg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2020 15:54:49 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 06/15] hw/block/nvme: Add support for Namespace Types
Date: Sun, 13 Sep 2020 07:54:21 +0900
Message-Id: <20200912225430.1772-7-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=517336518=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 18:54:38
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
 hw/block/nvme.c | 208 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 188 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4bd88f4046..004f1c9578 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1153,6 +1153,19 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, uint64_t prp1,
+                                         uint64_t prp2, NvmeRequest *req)
+{
+    uint16_t status;
+
+    status = nvme_map_prp(n, prp1, prp2, NVME_IDENTIFY_DATA_SIZE, req);
+    if (status) {
+        return status;
+    }
+    nvme_fill_data(&req->qsg, &req->iov, 0, 0);
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1165,6 +1178,21 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1181,11 +1209,37 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1225,23 +1279,51 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
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
 
@@ -1250,7 +1332,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1258,12 +1344,44 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1273,12 +1391,20 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1460,6 +1586,9 @@ defaults:
             result |= NVME_INTVC_NOCOALESCING;
         }
 
+        break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = 0;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -1584,6 +1713,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1845,6 +1980,30 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
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
@@ -2255,6 +2414,8 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     n->ns_size = bs_size;
 
+    ns->csi = NVME_CSI_NVM;
+    qemu_uuid_generate(&ns->uuid); /* TODO make UUIDs persistent */
     lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     id_ns->lbaf[lba_index].ds = nvme_ilog2(n->conf.logical_block_size);
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
@@ -2419,7 +2580,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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
@@ -2429,6 +2594,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
+    NvmeNamespace *ns;
     Error *local_err = NULL;
 
     int i;
@@ -2454,8 +2620,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
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


