Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EDC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF09246BB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sOroK9wN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF09246BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ha6-0003Nu-P7
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j8hZ0-000288-AD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j8hYy-0006rU-UY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:38 -0500
Received: from mail-eopbgr770059.outbound.protection.outlook.com
 ([40.107.77.59]:22457 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j8hYy-0006qU-ND
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR/bBsy3374ELSvktiO5MEg7My1e3+44wy8ImHMVH0/XObR876giQZd5IWIqJSLgpOK66cTXLmJxVFBcQW955jbGijNdXpah6VHqDFcY3DSE7HhWQaI3JIu826le6VAlw0VqInsEBEnMJAiSOgzL3m40Wg+zZDTDrqoLmSAFFg0vsjQDDDxbXf3G/NjICBPCBcv4U7gFjqeiMzH0rA6XLNPSQUmnLyY0wtGEaj4KJWnvIttB2OXYsqv16nwutc8P9JxMXbre3KlZYyfUpYzVzusM+qtknmsqBuEYzv95sBiUP5ELLxZYqf2+Akhxq+UWtM8SyMsbIxW7pbfYXEIVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNBRwL9CTkL9jKKR3iWx3Edu8cYyu31VUKZfbgLl3RU=;
 b=BMVP/q0gnXg/cgV7ZZgO7CZnHPldYUVVAYk3b8H24yufBJrW7qWro+BegQ9z1O9HFF9WyJoTRBrdWUBjoYWt//5vpgTUmATtRXeAXii3JNrXGVb11c4Mbqev3/qofaf4UOraxk6ChJIIq9GkXQaNi7+FUTSWIERn384FFyBw1x3ZM/diLCjhiQh2P1TSJf7h4mVE4rO9XMYJoGOdElgJlTerdk9RGbfFMnfV0iDpQ4H8siY6937oWv4kY+5ANrj2YNGkRT5+Yz0vXh3EgIlSld/VnmGvtwCOkGAz0xkyMbGukQLGZdiwtlc8Q91PiDUcNP1V3nx0SrSzwl3mA7YZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=weilnetz.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNBRwL9CTkL9jKKR3iWx3Edu8cYyu31VUKZfbgLl3RU=;
 b=sOroK9wNOGojmokGhPVIt5IzmrbNFYk/q9EiLr133sU/iYanHHl8JU3NqRx2wUsHC23yR1RsAh4JKFbUQqdRoMDLV26wV2hKLuWL5khApGSvmEaQmqH5vT0bWRGLXJ6KUPRvZYAi31J+mzV4+qOOZwkUWiPhf52JLKMtbOYGdLs=
Received: from MN2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:208:e8::28)
 by BYAPR02MB4679.namprd02.prod.outlook.com (2603:10b6:a03:48::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 09:40:31 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::28) by MN2PR20CA0015.outlook.office365.com
 (2603:10b6:208:e8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Mon, 2 Mar 2020 09:40:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.14
 via Frontend Transport; Mon, 2 Mar 2020 09:40:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYs-0006Qa-GC; Mon, 02 Mar 2020 01:40:30 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYn-0003Hj-C1; Mon, 02 Mar 2020 01:40:25 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0229eJtE021069; 
 Mon, 2 Mar 2020 01:40:20 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j8hYg-00036q-Os; Mon, 02 Mar 2020 01:40:18 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 0A6C613C0194; Mon,  2 Mar 2020 15:05:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Gonglei <arei.gonglei@huawei.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: [PATCH 1/3] usb/hcd-xhci: Make dma read/writes hooks pci free
Date: Mon,  2 Mar 2020 15:05:22 +0530
Message-Id: <1583141724-6229-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583141724-6229-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1583141724-6229-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(7416002)(4326008)(6266002)(110136005)(42186006)(316002)(8676002)(36756003)(8936002)(81166006)(81156014)(6636002)(70206006)(5660300002)(2616005)(426003)(2906002)(478600001)(336012)(70586007)(356004)(6666004)(26005)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4679; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695b2b7d-a5bc-4104-d10e-08d7be8dbfda
X-MS-TrafficTypeDiagnostic: BYAPR02MB4679:
X-Microsoft-Antispam-PRVS: <BYAPR02MB46790D171751F16E787A718ACAE70@BYAPR02MB4679.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxL9mf63ml4dgqG0UcsB6jUl7fuZpWHg7cm57oc98XRN0couGgTxAU2vEZUo3dfvDUGjzPvLcWsZnz263Ql8bTWgWMS5cVXAa1rvXfN5UrE3vwS7hW9T5plklK4k9/RjDrsJiXBhpBdHblBamZtE7kVNTnkujKwkPL9SM0lyP6VesDKwuhlCZH/tNPgPgAW+Fnbt/fU0JUk7fJdBG/II+afxgbEUXui5eD9/IMmwYnJmHYo/DdDk9OCFhrvVBRzTKSn2YetxocVEZTLydKZwqFpSoYEvJ0L5bU9QGf8RgfTx7OWdmvNZQgLMLOF8XYoLC4Kbnn9TUBVde4qrZ7g/Fqq2qZnSXPlECeZVgPKxmNUrmaZFhAqT9O+zdkuFIRVth7e4aqmLwE/a9pm/nWM8nSPIXX//vK8CiLr/TrR/FVL9M5oL77KfqR/o48pyjJbj8SCQtCaFzauFypS5gegtJkpfrEn2sX+q07N9EuWr1NLuzaiw6G9QPa/nepAFEBrx
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:40:31.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695b2b7d-a5bc-4104-d10e-08d7be8dbfda
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4679
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.59
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch starts making the hcd-xhci.c pci free, as part of this
restructuring dma read/writes are handled without passing pci object.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/hcd-xhci.c | 23 ++++++++++-------------
 hw/usb/hcd-xhci.h |  3 +++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36..6e88670 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -495,7 +495,7 @@ static inline void xhci_dma_read_u32s(XHCIState *xhci, dma_addr_t addr,
 
     assert((len % sizeof(uint32_t)) == 0);
 
-    pci_dma_read(PCI_DEVICE(xhci), addr, buf, len);
+    dma_memory_read(xhci->as, addr, buf, len);
 
     for (i = 0; i < (len / sizeof(uint32_t)); i++) {
         buf[i] = le32_to_cpu(buf[i]);
@@ -515,7 +515,7 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
     for (i = 0; i < n; i++) {
         tmp[i] = cpu_to_le32(buf[i]);
     }
-    pci_dma_write(PCI_DEVICE(xhci), addr, tmp, len);
+    dma_memory_write(xhci->as, addr, tmp, len);
 }
 
 static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
@@ -644,7 +644,6 @@ static void xhci_die(XHCIState *xhci)
 
 static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
 {
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
     XHCIInterrupter *intr = &xhci->intr[v];
     XHCITRB ev_trb;
     dma_addr_t addr;
@@ -663,7 +662,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
                                ev_trb.status, ev_trb.control);
 
     addr = intr->er_start + TRB_SIZE*intr->er_ep_idx;
-    pci_dma_write(pci_dev, addr, &ev_trb, TRB_SIZE);
+    dma_memory_write(xhci->as, addr, &ev_trb, TRB_SIZE);
 
     intr->er_ep_idx++;
     if (intr->er_ep_idx >= intr->er_size) {
@@ -720,12 +719,11 @@ static void xhci_ring_init(XHCIState *xhci, XHCIRing *ring,
 static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
                                dma_addr_t *addr)
 {
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
     uint32_t link_cnt = 0;
 
     while (1) {
         TRBType type;
-        pci_dma_read(pci_dev, ring->dequeue, trb, TRB_SIZE);
+        dma_memory_read(xhci->as, ring->dequeue, trb, TRB_SIZE);
         trb->addr = ring->dequeue;
         trb->ccs = ring->ccs;
         le64_to_cpus(&trb->parameter);
@@ -762,7 +760,6 @@ static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
 
 static int xhci_ring_chain_length(XHCIState *xhci, const XHCIRing *ring)
 {
-    PCIDevice *pci_dev = PCI_DEVICE(xhci);
     XHCITRB trb;
     int length = 0;
     dma_addr_t dequeue = ring->dequeue;
@@ -773,7 +770,7 @@ static int xhci_ring_chain_length(XHCIState *xhci, const XHCIRing *ring)
 
     while (1) {
         TRBType type;
-        pci_dma_read(pci_dev, dequeue, &trb, TRB_SIZE);
+        dma_memory_read(xhci->as, dequeue, &trb, TRB_SIZE);
         le64_to_cpus(&trb.parameter);
         le32_to_cpus(&trb.status);
         le32_to_cpus(&trb.control);
@@ -828,7 +825,7 @@ static void xhci_er_reset(XHCIState *xhci, int v)
         xhci_die(xhci);
         return;
     }
-    pci_dma_read(PCI_DEVICE(xhci), erstba, &seg, sizeof(seg));
+    dma_memory_read(xhci->as, erstba, &seg, sizeof(seg));
     le32_to_cpus(&seg.addr_low);
     le32_to_cpus(&seg.addr_high);
     le32_to_cpus(&seg.size);
@@ -1440,7 +1437,7 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
     int i;
 
     xfer->int_req = false;
-    pci_dma_sglist_init(&xfer->sgl, PCI_DEVICE(xhci), xfer->trb_count);
+    qemu_sglist_init(&xfer->sgl, DEVICE(xhci), xfer->trb_count, xhci->as);
     for (i = 0; i < xfer->trb_count; i++) {
         XHCITRB *trb = &xfer->trbs[i];
         dma_addr_t addr;
@@ -2101,7 +2098,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
     assert(slotid >= 1 && slotid <= xhci->numslots);
 
     dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
-    poctx = ldq_le_pci_dma(PCI_DEVICE(xhci), dcbaap + 8 * slotid);
+    poctx = ldq_le_dma(xhci->as, dcbaap + 8 * slotid);
     ictx = xhci_mask64(pictx);
     octx = xhci_mask64(poctx);
 
@@ -2439,7 +2436,7 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
     /* TODO: actually implement real values here */
     bw_ctx[0] = 0;
     memset(&bw_ctx[1], 80, xhci->numports); /* 80% */
-    pci_dma_write(PCI_DEVICE(xhci), ctx, bw_ctx, sizeof(bw_ctx));
+    dma_memory_write(xhci->as, ctx, bw_ctx, sizeof(bw_ctx));
 
     return CC_SUCCESS;
 }
@@ -3531,7 +3528,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
             continue;
         }
         slot->ctx =
-            xhci_mask64(ldq_le_pci_dma(pci_dev, dcbaap + 8 * slotid));
+            xhci_mask64(ldq_le_dma(xhci->as, dcbaap + 8 * slotid));
         xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
         slot->uport = xhci_lookup_uport(xhci, slot_ctx);
         if (!slot->uport) {
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 2fad4df..18bed7e 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -22,6 +22,8 @@
 #ifndef HW_USB_HCD_XHCI_H
 #define HW_USB_HCD_XHCI_H
 
+#include "sysemu/dma.h"
+
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
@@ -189,6 +191,7 @@ struct XHCIState {
 
     USBBus bus;
     MemoryRegion mem;
+    AddressSpace *as;
     MemoryRegion mem_cap;
     MemoryRegion mem_oper;
     MemoryRegion mem_runtime;
-- 
2.7.4


