Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B4C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CEB22245
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="R2UZmbJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CEB22245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYQt-0007NP-Pj
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYHt-0002bM-BI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:19:58 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com
 ([40.107.223.69]:40661 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYHm-0003jV-Jq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:19:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF/nnZdcmHAHvFoaOOfFYJwEvYAMliGfYtQsMo2OH7tMiOFJz3KLs+lzgQzwpCa9QqvnoaojqsEtsFTOa/8dSMX4T0LZhGbWZ3Ue1wXjFNQKkfjRoxpIn0VzJEjnsBkbfenTcAfGZCdjTT9JCTppcSQGmCU181qQ9ae5DNvo5oyfCEHbQ1W3wXGAu7rOG+fUan7xSwrby8rlzE1J+ak4kd25og9o7Uzj7IYDwPSVMarvfewhahim0J2cHs6xuw2lO3JpXjB2yqtYjh08SWuDHdOBKgnACc9h8Zu3sO8zrZI2Z852BTiZ98skSrqwh8ceozZwUC3UkcSsZn9uo0UeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyDlaijrdHqQdvAshZ3nRRYO8Jqh4Ex59aQ6ojxOa6U=;
 b=R4cbW2KpnhljH7ao0+o6AMnYY5nb1XAEOIVfT5eUhkD4kzmPdHhR3bK8f9gaar1/kA256c8xHKHJkMdsf8z71lFFYBr9VuhhAtJHYsEav3I5fmdB7cRIvWfHcifo6vUxyj2xRCVPJyg/2ME5z6a/+bz1DkW6wgOLZPSvTEsqjMFENeWpm7y305W1asnor0l18UNu1Az+GRHWuVsMvAWm5dyZO1ocQ34WsxOLn0yFJq+Zkqr9IYIxryigDtddD3VN0Ty+OYVKX8mN8KgvEaQKP6LNs1XvSAuBj9Mj8u9pLuzjK2L1+z2NTC7ti0/lZktbhjFaDDS/lzVMJKVluy5+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=wdc.com
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyDlaijrdHqQdvAshZ3nRRYO8Jqh4Ex59aQ6ojxOa6U=;
 b=R2UZmbJb9LAHH7/IsN01xLacTQ9modmJsX648tjnkYknzoLat3ZXw9bftT9eooxV8M0ykdh9UCng+c6cm2FDibp+ONS9Ojmm3pU/Z5lFtb+3er7kBB4ft+hI+evUlF97WyvRgkkO1isFteF0dcwj/5xYTyRkdblVBdHUqjCrysc=
Received: from CY4PR13CA0014.namprd13.prod.outlook.com (2603:10b6:903:32::24)
 by BYAPR02MB5861.namprd02.prod.outlook.com (2603:10b6:a03:11f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 14:19:45 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::26) by CY4PR13CA0014.outlook.office365.com
 (2603:10b6:903:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Wed, 16 Sep 2020 14:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not
 signed) header.d=none; wdc.com; dmarc=none action=none header.from=xilinx.com; 
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 14:19:41
 +0000
Received: from [149.199.38.66] (port=43118 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIYHW-0004A0-OY; Wed, 16 Sep 2020 07:19:34 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIYHd-0004pd-C6; Wed, 16 Sep 2020 07:19:41 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GEJekp010155; 
 Wed, 16 Sep 2020 07:19:40 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kIYHb-0004pO-Pl; Wed, 16 Sep 2020 07:19:40 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E197213C0235; Wed, 16 Sep 2020 19:53:22 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v7 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Date: Wed, 16 Sep 2020 19:52:14 +0530
Message-Id: <1600266140-20763-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 833285a9-662f-4475-5e82-08d85a4b8da5
X-MS-TrafficTypeDiagnostic: BYAPR02MB5861:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5861708059281BA636E0960BCA210@BYAPR02MB5861.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZaFddVX/yH7FRaAFvBM53Hc4x0oLl6o7BNaYmk5YQDksCwtT3Km+fMN6djLL3F+pZvEdzjjrth+1+2kyMSRvfNqPHJCfIMLsQXY/lqnSOiFXMepqNYaRm2m2L9SdWF0lsmYh0S6paUUA6z/tFvX2NyvWChcenxIiLPGFA1vVS8egJObUTlHfR/cKHecWRqQtRt2Lfy/JGBL/nOHpbgdCM+Oaei4Nz5l6IZMwmX5XSjHxsPO0hTNLiE/JBq2xRS7ACGWDCRHeF+SADMYDIDUQnm1KDCc1/wE7ICgxtsZRW6Q1FC4DkT7yfw5ZopoCytyuVrgeo7wD23vEkniqjPDF7shYD8cE50krK4SyWGccCyZMp2wj7Eas+VqVMrjZSQhgMAAqM3asCxMd1MJEh3pig==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(39850400004)(136003)(376002)(396003)(46966005)(83380400001)(8676002)(5660300002)(42186006)(47076004)(356005)(2906002)(26005)(82740400003)(54906003)(110136005)(2616005)(107886003)(7416002)(478600001)(6266002)(6636002)(70206006)(316002)(6666004)(82310400003)(70586007)(186003)(336012)(81166007)(8936002)(426003)(36756003)(4326008)(63350400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:19:41.8257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833285a9-662f-4475-5e82-08d85a4b8da5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5861
Received-SPF: pass client-ip=40.107.223.69; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 10:19:48
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
index 2110c03..2570937 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -190,6 +190,7 @@ struct XHCIState {
 
     USBBus bus;
     MemoryRegion mem;
+    AddressSpace *as;
     MemoryRegion mem_cap;
     MemoryRegion mem_oper;
     MemoryRegion mem_runtime;
-- 
2.7.4


