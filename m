Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F54C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A95206C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gJazto1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A95206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiGy-0007V9-Jg
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiBJ-00027i-9T
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:18:05 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com
 ([40.107.237.56]:28032 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiBF-0006mb-Fd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:18:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOZDuNUUzDKzoSaLbEiZSYj+z6m7pUrhKpfweoo+Oax88st0pmgnUOEu6imRQa5ONrGzGA8/UERRn6j2004W3qCvvitK9hKCuoYh0RLiKjt+/BF1FcpDbYYh7olauEI20wciDO8zNPJM1A5+7GfoB7B/9zJIVsIqtmh3+QhL9KeZQThzFzh/yzNCvYnOpPG3WHYq67+Scw3aUeFpW9X8v+83PBN1fsv6mcGTB/j8Hqh/RE++vcvmPNcgE/KQXE568+IeqzsgFxQr6zS60Lu6zRSk/wnGf48GuHv5kzNB6OvaY0IhNJSynFW5CJoNFUKpgcxTReLhbuDPGaXdNwZDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5sWvIL72sfzIoNFcGUQAyD6HfZSjsBEkVeiVGXZ3zg=;
 b=ka0cmqo+4fKBOrKD0uIq5FhGeXdnF3zk5LadnCYbVJljPPluQswUKzLhKJfoKVhiIlVxesXp3nUDb+NAMfbiH1d+eXIYRrJLa9S64sDdBATPLxYkuebCaq45q0J5J1/lfiExLx7iwG5W9/XyIt+43oYQyazW/WdM92n+pqrpsAjFrBVrBHrUIPZsXwqGbXi7ThjAaRUk9zV+UyoVjtKg6Sd8gjlVI/5xjeB2GyVcfKAzc0WYWirtj7s6eHPNUfySjmLhVxzgL+kzcW5NtvgtxhEGRiiSJmdIvvXSAcGphaQVTfcYkrsqbq/PHECZ+u4Q4elrjp+AykUDs08KkKn2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5sWvIL72sfzIoNFcGUQAyD6HfZSjsBEkVeiVGXZ3zg=;
 b=gJazto1SreJvFiB+BfYDOuj3qDU97DggFKVeQMtep+rJD9SRDTxclIuGYIKTliPLD7aq0Rl3WfrdmvVKbp36yyBgkyPZl5X7464cSkMZ0tC9wkY5leY/OKYYzyc80HSm6HLwU7OxcgbfUaJ/GkDgyzXb4V3i/HF+dEXmDSf9ZF8=
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by SN6PR02MB5087.namprd02.prod.outlook.com (2603:10b6:805:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 13:17:49 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::8c) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Tue, 22 Sep 2020 13:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 13:17:49
 +0000
Received: from [149.199.38.66] (port=37278 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiAo-0000Ow-LK; Tue, 22 Sep 2020 06:17:34 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiB2-00089v-SA; Tue, 22 Sep 2020 06:17:48 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MDHlF7020846; 
 Tue, 22 Sep 2020 06:17:47 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kKiB1-00089X-AK; Tue, 22 Sep 2020 06:17:47 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5972113C03E9; Tue, 22 Sep 2020 18:51:14 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v8 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Date: Tue, 22 Sep 2020 18:50:31 +0530
Message-Id: <1600780837-8231-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d83198f3-8856-4082-c542-08d85ef9e747
X-MS-TrafficTypeDiagnostic: SN6PR02MB5087:
X-Microsoft-Antispam-PRVS: <SN6PR02MB508739B1AF7B0276AA2A1252CA3B0@SN6PR02MB5087.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWbCU1crpa24c3lhWfIxvMDWXrw2nI7fOomJrM9sfw4nYqauJf7XFZWyOkABlnWtXDfE9XHG6/GBDerOA10K/UDXEf5GUEeLtAIsSUbDIajBsS9oFjK8+LB1lTwLc4FOmgZWS7kzTvt7/9GsZT96fS8HDf+Uwv8kcHMpuWyv4z/3Hz7FKUZtBAEVpU2rUsordzrWstHjcWDSNiz6hUYdHtOTmowB/KlYHw2B0S9TmFbJW1CKqnRKOSs7XA9FlLqcAtdg1Ymv5kvjUEOC3lDtel3WTTzIbZvWun/DfNQwZA97wN+GzWY2wExHUZ1hpp+loMoQJmeIhh4sURQwgmvuYYsKqEAKYjREzGlb8oVC1iZTq7kHReNTdzL9NQO8fFZkJLMv8ehj549pJ0AxTDvzVg==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(6666004)(8936002)(42186006)(70586007)(70206006)(110136005)(316002)(54906003)(6636002)(5660300002)(6266002)(107886003)(36756003)(8676002)(336012)(4326008)(2616005)(478600001)(82310400003)(7416002)(82740400003)(26005)(83380400001)(426003)(47076004)(186003)(81166007)(356005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 13:17:49.2743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83198f3-8856-4082-c542-08d85ef9e747
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5087
Received-SPF: pass client-ip=40.107.237.56; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 09:17:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Sai Pavan Boddu <saipava@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch starts making the hcd-xhci.c pci free, as part of this
restructuring dma read/writes are handled without passing pci object.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/usb/hcd-xhci.c | 24 +++++++++++-------------
 hw/usb/hcd-xhci.h |  1 +
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 46a2186..254cf1e 100644
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
@@ -2104,7 +2101,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
     assert(slotid >= 1 && slotid <= xhci->numslots);
 
     dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
-    poctx = ldq_le_pci_dma(PCI_DEVICE(xhci), dcbaap + 8 * slotid);
+    poctx = ldq_le_dma(xhci->as, dcbaap + 8 * slotid);
     ictx = xhci_mask64(pictx);
     octx = xhci_mask64(poctx);
 
@@ -2442,7 +2439,7 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
     /* TODO: actually implement real values here */
     bw_ctx[0] = 0;
     memset(&bw_ctx[1], 80, xhci->numports); /* 80% */
-    pci_dma_write(PCI_DEVICE(xhci), ctx, bw_ctx, sizeof(bw_ctx));
+    dma_memory_write(xhci->as, ctx, bw_ctx, sizeof(bw_ctx));
 
     return CC_SUCCESS;
 }
@@ -3434,6 +3431,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     usb_xhci_init(xhci);
+    xhci->as = pci_get_address_space(dev);
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
     memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
@@ -3534,7 +3532,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
             continue;
         }
         slot->ctx =
-            xhci_mask64(ldq_le_pci_dma(pci_dev, dcbaap + 8 * slotid));
+            xhci_mask64(ldq_le_dma(xhci->as, dcbaap + 8 * slotid));
         xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
         slot->uport = xhci_lookup_uport(xhci, slot_ctx);
         if (!slot->uport) {
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index c3dfc14..c8a8ae4 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -188,6 +188,7 @@ struct XHCIState {
 
     USBBus bus;
     MemoryRegion mem;
+    AddressSpace *as;
     MemoryRegion mem_cap;
     MemoryRegion mem_oper;
     MemoryRegion mem_runtime;
-- 
2.7.4


