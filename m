Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD0220738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tk3JIP3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD0220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo82Q-0007ok-4J
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo81Q-0007Hr-Tv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:13:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo81P-0007OU-4c
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:13:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so2811594wrj.13
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=noF1hTeOV/7ROJ9FLwo3hUUeJ+Tm//6pclDJ08aNVPg=;
 b=tk3JIP3k0p2bprJs4cYq48A95ddd8+e6ayQFeCYX+fJcZx4+aqdpgluPlLfdbpijoi
 fgdWvsv+IPSWT1fEy5S9uVE1d+etFakrYhVs4fDDNVZpran80RqcK1nI38S64ykjz5r1
 6qS7zvkuQobtJ+RJZALjzX68IF7tLmmdMLoOiKBZRdOMSSjpLjMcyghADsIQuzzN1QaH
 Ik106Y92PFvQXknkT2WEOVVv6axAiN9dBEDkdMSH9i7PY0iFIznrZX5DsIVNWOs48jg1
 jPSpZIJkqklaG5/oZSI5cKHivbwED6Thj929NOFcU93DWlUd6/UKFMBUgkhYPEHTd7QC
 b4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=noF1hTeOV/7ROJ9FLwo3hUUeJ+Tm//6pclDJ08aNVPg=;
 b=XRQUsFySMLoM+1FhD++WQ+UEDDSWXnpB1Ucvopu+oSXJVCLPTsVgjuYA9juSagCyx0
 n8kzoYAvbO/PgssIFKwu2IcccUDmS64ZAiYCW9DbRX60tLoWWSlyrgVJG9lULCuf4yoi
 Ka8E0mXurgEuhYHjVxnsp45TeeC+/QMxpbgz18eeBDOIYY0ic2MStUUyi2q8i6zSee6g
 H+Em7pRfmbmqjqhEsv4eZm7oCP60IC4mRpNWPXnIJ0mxytWF1xPhecSOnRXiwxpNEj7P
 G6+li3afkr+ja/KF6UCKDMS/SNNhrz6yuVbahZUGU+V7HDGe6sc04JmiZc4BprFBr85z
 TdeQ==
X-Gm-Message-State: AOAM53040UDBRhDqcFZ8TIzc/9ef0Nuha+zdr1AK5psg8i5RIikxNj+x
 9CVACQQVlWamRqVR89t3OAI2okoN
X-Google-Smtp-Source: ABdhPJy0YdwtZAvuTLqzS9T2j99OyYel+4LX8Kof5IgulOXuD84Cg2Eo1ga3EYv4Cx4mAY8cwoVIjg==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr30352449wro.134.1593015189249; 
 Wed, 24 Jun 2020 09:13:09 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w2sm16621129wrs.77.2020.06.24.09.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 09:13:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] usb/hcd-xhci: Make dma read/writes hooks pci free
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-2-git-send-email-sai.pavan.boddu@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <579ce7c8-04be-ea4c-0cbd-4c63b8ee92d0@amsat.org>
Date: Wed, 24 Jun 2020 18:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593008176-9629-2-git-send-email-sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 4:16 PM, Sai Pavan Boddu wrote:
> This patch starts making the hcd-xhci.c pci free, as part of this
> restructuring dma read/writes are handled without passing pci object.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/usb/hcd-xhci.c | 24 +++++++++++-------------
>  hw/usb/hcd-xhci.h |  3 +++
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index b330e36..fa6ce98 100644
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
> @@ -2101,7 +2098,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
>      assert(slotid >= 1 && slotid <= xhci->numslots);
>  
>      dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
> -    poctx = ldq_le_pci_dma(PCI_DEVICE(xhci), dcbaap + 8 * slotid);
> +    poctx = ldq_le_dma(xhci->as, dcbaap + 8 * slotid);
>      ictx = xhci_mask64(pictx);
>      octx = xhci_mask64(poctx);
>  
> @@ -2439,7 +2436,7 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
>      /* TODO: actually implement real values here */
>      bw_ctx[0] = 0;
>      memset(&bw_ctx[1], 80, xhci->numports); /* 80% */
> -    pci_dma_write(PCI_DEVICE(xhci), ctx, bw_ctx, sizeof(bw_ctx));
> +    dma_memory_write(xhci->as, ctx, bw_ctx, sizeof(bw_ctx));
>  
>      return CC_SUCCESS;
>  }
> @@ -3431,6 +3428,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
>      }
>  
>      usb_xhci_init(xhci);
> +    xhci->as = pci_get_address_space(dev);
>      xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
>  
>      memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
> @@ -3531,7 +3529,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
>              continue;
>          }
>          slot->ctx =
> -            xhci_mask64(ldq_le_pci_dma(pci_dev, dcbaap + 8 * slotid));
> +            xhci_mask64(ldq_le_dma(xhci->as, dcbaap + 8 * slotid));
>          xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
>          slot->uport = xhci_lookup_uport(xhci, slot_ctx);
>          if (!slot->uport) {
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 2fad4df..18bed7e 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -22,6 +22,8 @@
>  #ifndef HW_USB_HCD_XHCI_H
>  #define HW_USB_HCD_XHCI_H
>  
> +#include "sysemu/dma.h"

Not needed because forward-declared in "qemu/typedefs.h".

Moving the inclusion to hw/usb/hcd-xhci.c:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  #define TYPE_XHCI "base-xhci"
>  #define TYPE_NEC_XHCI "nec-usb-xhci"
>  #define TYPE_QEMU_XHCI "qemu-xhci"
> @@ -189,6 +191,7 @@ struct XHCIState {
>  
>      USBBus bus;
>      MemoryRegion mem;
> +    AddressSpace *as;
>      MemoryRegion mem_cap;
>      MemoryRegion mem_oper;
>      MemoryRegion mem_runtime;
> 


