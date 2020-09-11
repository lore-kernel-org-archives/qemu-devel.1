Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8732C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDD8221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fiJA+wvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDD8221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdsg-0001Zm-RR
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kGds5-0000zL-Ii
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:53:25 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com
 ([40.107.237.59]:48865 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kGds2-0005An-Uh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KURLsxUz81IbulojpJWpzW/Ty3HhKkK+r9pK6XZtWUXB8C8RjITe2ScjJBtE0bfsW4ZcwrG099d5lTNcX9CgNozLEiChuJgJrJPZS36h6vsUdSgeGsz8aR37Iz3j9seF0HPwAtZhiBuHupzBwCoT1sljogvEYVG7TxJHVapjq606ag8xg4+yQLelkd5OndtSp3YOkBm6aJgyvgNaJrDAHheupcLovOIsRatKOaCf24faNfl+Fo/r75LEHjxGTUPp9BCathOrTAgQxnYQ0/12iLR+4j6gcTbjgb/rPvIjfmMQDTGFeXKGtUIymsOFyVZCd/h2RW5isBuk/dIRCY4+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S82HO4Klqye60CZWA7PEowzIRfXWGqrg2keeI9sdknw=;
 b=dvgu8rnsFJv3oZUtpk6v8Zo7Ldk54+oa/zziA5IxBD9jsm/V+kC87MEWApGlZZmTkvpQVe+wcI/NEktB/uKUzZHBxpIk0tQuN7I6l5SyGq0NsT9bjlpu+suO3N97dYpx1Mqmzr6wC9sHUBPAvSrXVcW8mE50VUa7zg0i1F+eeabiuUpb8QW3OGPd4OYD3unCTkOSA/t6jyQM2c4QvRSKhhK0Do0iiiMvz4RtBfCjy1mOTDNdFMev2qb7ulQfzXJtqXOo87olKT7Ycm0ZSvNMV9ghK6Gz3+/07s8nJYqR1aBU9mBz77q1OTc67H3CgF2NibrH87migMeFTmctjbSiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S82HO4Klqye60CZWA7PEowzIRfXWGqrg2keeI9sdknw=;
 b=fiJA+wvJjgI2k23bdiJrjbx6EVh/PROJ8a7nnwIsJAHZektmlTIZoHa+nTT6vR9WuIGfwA4+hwDXIwayNwwjz6/hzLG17s1junDYHhT0PaEfaK61SSWnXU6mchDAfRjm2cw0TIH9Zdh7as7K8pOnDtFvTfgAAejBlDloZ4/x8KM=
Received: from DM5PR10CA0009.namprd10.prod.outlook.com (2603:10b6:4:2::19) by
 DM6PR02MB6202.namprd02.prod.outlook.com (2603:10b6:5:1f6::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 07:38:19 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::48) by DM5PR10CA0009.outlook.office365.com
 (2603:10b6:4:2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 07:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not
 signed) header.d=none;gmail.com; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 07:38:18
 +0000
Received: from [149.199.38.66] (port=43759 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kGddR-0007YF-HI; Fri, 11 Sep 2020 00:38:17 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kGddR-0002XO-Se; Fri, 11 Sep 2020 00:38:17 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08B7cDMc026289; 
 Fri, 11 Sep 2020 00:38:14 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kGddN-0002WK-8f; Fri, 11 Sep 2020 00:38:13 -0700
Date: Fri, 11 Sep 2020 09:38:07 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v5 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Message-ID: <20200911073807.GP14249@toto>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1599719469-24062-2-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599719469-24062-2-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c8430d2-0536-4d5c-7b93-08d85625a696
X-MS-TrafficTypeDiagnostic: DM6PR02MB6202:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6202BB313013DD8B062CC781C2240@DM6PR02MB6202.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLNeM5Z63caa2Ndr72GXErknl/6jwGdQw580uAOzWpfr4dSWGIBq6YBwOWe+fcNxilXSotK8gmiJ/ah9GbIU++8TJEAq99g9sNnZNZbsxaqBaMRdotHCm5N8N3qdqh49B2irWvnNN1jz20kxSxhrvonussE2XewxAdB9wFnNFRBIXwUYuJPMVkefh6gmXO5nmfabKT6+z/kkqFTrkpXYSUsPXK/VwBpsNVy/LUx4FScLw3v81YBpHycvmqJQsotE4nrdzHJue5j0wdRkEGIvO+/njhQfkDPq7ZF/aUfikCJ7m43yiDvaY0MLcHdBeTiN0791w1HJYlMmSpX87EyRl0g3kLRZLWSVsKTr65BEVeuHdxf8coNzaakn+lWAIdTTOf4kS16kFIAcC5M1GAzPbw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(396003)(39860400002)(346002)(376002)(46966005)(8676002)(186003)(336012)(8936002)(316002)(5660300002)(426003)(26005)(6666004)(63350400001)(478600001)(7416002)(1076003)(70206006)(70586007)(47076004)(4326008)(9786002)(82740400003)(6862004)(9686003)(54906003)(33656002)(2906002)(6636002)(356005)(81166007)(82310400003)(33716001)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 07:38:18.1443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8430d2-0536-4d5c-7b93-08d85625a696
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6202
Received-SPF: pass client-ip=40.107.237.59; envelope-from=edgar@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:53:21
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:01:03PM +0530, Sai Pavan Boddu wrote:
> This patch starts making the hcd-xhci.c pci free, as part of this
> restructuring dma read/writes are handled without passing pci object.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  hw/usb/hcd-xhci.c | 24 +++++++++++-------------
>  hw/usb/hcd-xhci.h |  1 +
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 46a2186..254cf1e 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -495,7 +495,7 @@ static inline void xhci_dma_read_u32s(XHCIState *xhci, dma_addr_t addr,
>  
>      assert((len % sizeof(uint32_t)) == 0);
>  
> -    pci_dma_read(PCI_DEVICE(xhci), addr, buf, len);
> +    dma_memory_read(xhci->as, addr, buf, len);
>  
>      for (i = 0; i < (len / sizeof(uint32_t)); i++) {
>          buf[i] = le32_to_cpu(buf[i]);
> @@ -515,7 +515,7 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
>      for (i = 0; i < n; i++) {
>          tmp[i] = cpu_to_le32(buf[i]);
>      }
> -    pci_dma_write(PCI_DEVICE(xhci), addr, tmp, len);
> +    dma_memory_write(xhci->as, addr, tmp, len);
>  }
>  
>  static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
> @@ -644,7 +644,6 @@ static void xhci_die(XHCIState *xhci)
>  
>  static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(xhci);
>      XHCIInterrupter *intr = &xhci->intr[v];
>      XHCITRB ev_trb;
>      dma_addr_t addr;
> @@ -663,7 +662,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
>                                 ev_trb.status, ev_trb.control);
>  
>      addr = intr->er_start + TRB_SIZE*intr->er_ep_idx;
> -    pci_dma_write(pci_dev, addr, &ev_trb, TRB_SIZE);
> +    dma_memory_write(xhci->as, addr, &ev_trb, TRB_SIZE);
>  
>      intr->er_ep_idx++;
>      if (intr->er_ep_idx >= intr->er_size) {
> @@ -720,12 +719,11 @@ static void xhci_ring_init(XHCIState *xhci, XHCIRing *ring,
>  static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
>                                 dma_addr_t *addr)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(xhci);
>      uint32_t link_cnt = 0;
>  
>      while (1) {
>          TRBType type;
> -        pci_dma_read(pci_dev, ring->dequeue, trb, TRB_SIZE);
> +        dma_memory_read(xhci->as, ring->dequeue, trb, TRB_SIZE);
>          trb->addr = ring->dequeue;
>          trb->ccs = ring->ccs;
>          le64_to_cpus(&trb->parameter);
> @@ -762,7 +760,6 @@ static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
>  
>  static int xhci_ring_chain_length(XHCIState *xhci, const XHCIRing *ring)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(xhci);
>      XHCITRB trb;
>      int length = 0;
>      dma_addr_t dequeue = ring->dequeue;
> @@ -773,7 +770,7 @@ static int xhci_ring_chain_length(XHCIState *xhci, const XHCIRing *ring)
>  
>      while (1) {
>          TRBType type;
> -        pci_dma_read(pci_dev, dequeue, &trb, TRB_SIZE);
> +        dma_memory_read(xhci->as, dequeue, &trb, TRB_SIZE);
>          le64_to_cpus(&trb.parameter);
>          le32_to_cpus(&trb.status);
>          le32_to_cpus(&trb.control);
> @@ -828,7 +825,7 @@ static void xhci_er_reset(XHCIState *xhci, int v)
>          xhci_die(xhci);
>          return;
>      }
> -    pci_dma_read(PCI_DEVICE(xhci), erstba, &seg, sizeof(seg));
> +    dma_memory_read(xhci->as, erstba, &seg, sizeof(seg));
>      le32_to_cpus(&seg.addr_low);
>      le32_to_cpus(&seg.addr_high);
>      le32_to_cpus(&seg.size);
> @@ -1440,7 +1437,7 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
>      int i;
>  
>      xfer->int_req = false;
> -    pci_dma_sglist_init(&xfer->sgl, PCI_DEVICE(xhci), xfer->trb_count);
> +    qemu_sglist_init(&xfer->sgl, DEVICE(xhci), xfer->trb_count, xhci->as);
>      for (i = 0; i < xfer->trb_count; i++) {
>          XHCITRB *trb = &xfer->trbs[i];
>          dma_addr_t addr;
> @@ -2104,7 +2101,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
>      assert(slotid >= 1 && slotid <= xhci->numslots);
>  
>      dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
> -    poctx = ldq_le_pci_dma(PCI_DEVICE(xhci), dcbaap + 8 * slotid);
> +    poctx = ldq_le_dma(xhci->as, dcbaap + 8 * slotid);
>      ictx = xhci_mask64(pictx);
>      octx = xhci_mask64(poctx);
>  
> @@ -2442,7 +2439,7 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
>      /* TODO: actually implement real values here */
>      bw_ctx[0] = 0;
>      memset(&bw_ctx[1], 80, xhci->numports); /* 80% */
> -    pci_dma_write(PCI_DEVICE(xhci), ctx, bw_ctx, sizeof(bw_ctx));
> +    dma_memory_write(xhci->as, ctx, bw_ctx, sizeof(bw_ctx));
>  
>      return CC_SUCCESS;
>  }
> @@ -3434,6 +3431,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
>      }
>  
>      usb_xhci_init(xhci);
> +    xhci->as = pci_get_address_space(dev);
>      xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
>  
>      memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
> @@ -3534,7 +3532,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
>              continue;
>          }
>          slot->ctx =
> -            xhci_mask64(ldq_le_pci_dma(pci_dev, dcbaap + 8 * slotid));
> +            xhci_mask64(ldq_le_dma(xhci->as, dcbaap + 8 * slotid));
>          xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
>          slot->uport = xhci_lookup_uport(xhci, slot_ctx);
>          if (!slot->uport) {
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 946af51..2cd4f70 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -189,6 +189,7 @@ struct XHCIState {
>  
>      USBBus bus;
>      MemoryRegion mem;
> +    AddressSpace *as;
>      MemoryRegion mem_cap;
>      MemoryRegion mem_oper;
>      MemoryRegion mem_runtime;
> -- 
> 2.7.4
> 

