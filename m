Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED573C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D832072E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PlvNbetk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D832072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6N2-0004CO-SY
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jo6MC-0002t5-Fb
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:26:32 -0400
Received: from mail-eopbgr690047.outbound.protection.outlook.com
 ([40.107.69.47]:44541 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jo6M9-0003TP-DA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5H1y56TzUhs2wmcTcMfeELAI7P61G+RRoPHuRK2S7GWuwFmMQvUq3Abp8xOHn0bv22vScpWyBzBqyQ70KUYhu+0JiKfqM4NbnFbx+Wviwml/iNulFv6mxBfo2JWfwKw/k7swzVVVgZCZQC4MVyFW9B6Bk4EdS3/YM6uaGxvUIeNOmKG0IittHsLIOY0+q/OH+OhDCxqjLaM1gIfq3xu5xImMv4RGtGaUpEGmKPrUzE7Nvcl4Rc43EbfnSYHQ0OAVKg5o+Pzf60LN64BXLVnLWRjAW29aIOyu2HZmKRYVOLtvZtFv2fBXYCjhZ2OAVkj/gUWwzcOwJHV+SbkrYUQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw2cpqgPXTafzX/Nk5jFNgvUekUUu0pc8d+MmlJL7bY=;
 b=cfca6kco4503ttdG04w1nytnjjHaQh7J0K5T0XY2lSewRXQNfs/C1LTUY3LicZYbwP3FzVyLsofJbYQO61p8jXjIVrZBuOBEpztZghOJpGYrXJtLBgPGYKW8VtkYpmCv6N5JtENwvIuycjWq6zQNJpKKT+fAf36zZtqP6aUPRNK+4dHNw7bOR009a64YVbaMcv/VVMA7lxET2H3/j1MmN2FPYhNhB7J6ngeZI+1lFaum6vA4EM9U15q0JZ/sN6sIe6G+j/exLBxcosuVIEX9JWaWDBHBLguHAL/ikwrEikXpkIhtOsHvAVAJD2s303WWmPsTBaV9EXAT5rEd+3RPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw2cpqgPXTafzX/Nk5jFNgvUekUUu0pc8d+MmlJL7bY=;
 b=PlvNbetkOmYVGVxGOPJbYatfvjYX8TCQAFE8fIm7pEPOoVQcT4olKGAOCf+Cmj1l1bdTYLjM2zeB2I20tTo3nm133aaO56jRm021aSUoWhZB/oGuGQzixy5ddojIY1TiCAcDBtrxAUvB4y2Uho7rZNrqMUlvRdyLSj4+RUjIbcw=
Received: from CY4PR22CA0026.namprd22.prod.outlook.com (2603:10b6:903:ed::12)
 by MW2PR02MB3689.namprd02.prod.outlook.com (2603:10b6:907:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 14:26:25 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ed:cafe::39) by CY4PR22CA0026.outlook.office365.com
 (2603:10b6:903:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Wed, 24 Jun 2020 14:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:26:25
 +0000
Received: from [149.199.38.66] (port=43408 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jo6Kt-0001Yr-2f; Wed, 24 Jun 2020 07:25:11 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jo6M5-0000KK-0v; Wed, 24 Jun 2020 07:26:25 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05OEQOsh017900; 
 Wed, 24 Jun 2020 07:26:24 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jo6M3-0000K9-Lg; Wed, 24 Jun 2020 07:26:24 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 7AE3913C6068; Wed, 24 Jun 2020 19:46:21 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/3] usb/hcd-xhci: Make dma read/writes hooks pci free
Date: Wed, 24 Jun 2020 19:46:14 +0530
Message-Id: <1593008176-9629-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(396003)(376002)(346002)(46966005)(426003)(478600001)(26005)(8676002)(2906002)(8936002)(336012)(4326008)(186003)(2616005)(6266002)(7416002)(42186006)(5660300002)(47076004)(36756003)(316002)(110136005)(70206006)(54906003)(70586007)(82740400003)(356005)(82310400002)(81166007)(6666004)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 94c4e36f-73e1-499a-3902-08d8184a9370
X-MS-TrafficTypeDiagnostic: MW2PR02MB3689:
X-Microsoft-Antispam-PRVS: <MW2PR02MB3689438C58C60DF09E8DAA77CA950@MW2PR02MB3689.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pM939L8v59hWt0YagjOk9aC1DmhPfhoaHH2q/ddviM8+CuxktkpP2xJdYqoh17yCyWSM1YMeW+2KIjTNWkK1yydWbnc4XnBsNJtwd22i8d/TtTpKiyn+jGj1Fs16Jc29JYwY02KGNs+sfCxFvpphQ13C13uKWJIlDyGivw2W1vegD/a3znjECD8ABXfV+cTQK/iOdaKZB+zcrB2D85Pk16GXSDQrA41WFyJNjzMbkFQVPuqPkYPKYb5Ur1Pf1X+9Og2Fo4IMLLq7p3l+079l4KcVZ6D/uQPWKIFiGXxC2yaNPFuUZ56Y6Go5Aw2yt1EChGDnizAcUAwpTyXbbyNb+mZoMdqjOUkoR+94plZZJ7gzBGX+fs5wSgLQ/o0fd8koPexHNosVJZPQh87NJnohmw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:26:25.3007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c4e36f-73e1-499a-3902-08d8184a9370
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3689
Received-SPF: pass client-ip=40.107.69.47; envelope-from=saipava@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 10:26:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch starts making the hcd-xhci.c pci free, as part of this
restructuring dma read/writes are handled without passing pci object.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/hcd-xhci.c | 24 +++++++++++-------------
 hw/usb/hcd-xhci.h |  3 +++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36..fa6ce98 100644
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
@@ -3431,6 +3428,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     usb_xhci_init(xhci);
+    xhci->as = pci_get_address_space(dev);
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
     memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
@@ -3531,7 +3529,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
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


