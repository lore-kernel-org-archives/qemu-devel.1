Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8540AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F872068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F872068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asm.pp.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZwcY-0000jR-Fx
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bsdasm@gmail.com>) id 1iZwbJ-00008N-3b
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bsdasm@gmail.com>) id 1iZwbG-00069D-I8
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:39:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bsdasm@gmail.com>) id 1iZwbG-000600-Bj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:39:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so18942895otk.12
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 04:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tH54vR3iTV4YMr4MtDHBodme86IwJmzB+hLkR7d7X6I=;
 b=cLM6GJm4XjPiAOUPVHCNBSvfyMhAbnjr66imvhZzEyAu2O+fN9mfXwieEpcAXkY/Ig
 s1CjOyrTZeChDws2HE+OB4ZFSdULEYpqK3GaZWzHLf3cOo6gIiY7tboOBCHtBEtqqPeB
 zC85kemmHLYj0CssVx9qYfemfia2SQwt4MUY6UjwVVmxY/7wofFK4g8A0654rxlL8sX2
 qu74GIl48JczaIrbVTwbTrQSKxw66lo6+CwXeoqPadz+60XlrNTvF7MmRy6yQU3T+EcR
 OF7lYkI/u8XSvmHKRx1hmjEOvhadS5rfpvoqpuovLO/MWVVFMsX8W1ZzhE0mGdmStGa1
 cc8g==
X-Gm-Message-State: APjAAAVByapQDfQ1nvSFn4ypL/T5fxoWjt6fQ4HL3eFgQLcqeeJFh7G9
 /PWenXdMgs7ECHb2XLl6OnmwWAbVlphF67ucxTo=
X-Google-Smtp-Source: APXvYqxJ65XyRJymNv+BSZbnfVvjA4OPHDnz2yISHeIDN4OQbWcyEIVx2zuuQAm3zyXWqNceujq8tJ+4c2ocXFPG2Uk=
X-Received: by 2002:a05:6830:1512:: with SMTP id
 k18mr3375804otp.123.1574858354965; 
 Wed, 27 Nov 2019 04:39:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
 <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
 <20191121140502.GX439743@stefanha-x1.localdomain>
In-Reply-To: <20191121140502.GX439743@stefanha-x1.localdomain>
From: ASM <asm@asm.pp.ru>
Date: Wed, 27 Nov 2019 15:39:03 +0300
Message-ID: <CAMmAVbW5a+v_dJ6NM3erwouOqpXyTzL36_W566SL1KuPFPFSEw@mail.gmail.com>
Subject: Re: PCI memory sync question (kvm,dpdk,e1000,packet stalled)
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dmitry.fleytman@gmail.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan, thanks for answering.

When the packet is received, e1000 writes it to memory directrly
without any RCU.
The address of memory for writing is set by the driver from dpdk driver.
Driver writes to RDBA (RDBAH,RDBAL) base address of ring.

It turns out that MMIO RCU (mentioned from e1000_mmio_setup) does not
protect, and can't protect the ring descriptors.
The area for protection may be any area of operational memory. And it
becomes famous when writing to registers RDBA by driver.
(see datasheet 82574 GbE Controller "7.1.8 Receive Descriptor Queue Structure")

How can this memory be protected? As I understand it, the e1000 should
track the record in RDBA and enable memory protection in this region.
But how to do it right?

Source code qemu:
hw/net/e1000.c:954 (version master)

 954         base = rx_desc_base(s) + sizeof(desc) * s->mac_reg[RDH];
where rx_desc_base -- address RDBAH regs. It address no have RCU protect.
...
955         pci_dma_read(d, base, &desc, sizeof(desc));
...
957         desc.status |= (vlan_status | E1000_RXD_STAT_DD);
...
990         pci_dma_write(d, base, &desc, sizeof(desc));
->
exec.c:
3111 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
3112                                            MemTxAttrs attrs,
3113                                            const uint8_t *buf,
3114                                            hwaddr len, hwaddr addr1,
3115                                            hwaddr l, MemoryRegion *mr)
3116 {
...
3123         if (!memory_access_is_direct(mr, true)) {
(false)
3131         } else {
3132             /* RAM case */
3133             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
3134             memcpy(ptr, buf, l);

where I be seeing weird behavior with KVM due to MMIO write coalescing

3135             invalidate_and_set_dirty(mr, addr1, l);
3136         }
3137

Source code dpdk(e1000): (version dpdk-stable-17.11.9)
drivers/net/e1000/em_rxtx.c:

699 uint16_t
700 eth_em_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
701                 uint16_t nb_pkts)
...
718         rxq = rx_queue
...
722         rx_id = rxq->rx_tail;
723         rx_ring = rxq->rx_ring
...
734                 rxdp = &rx_ring[rx_id];
735                 status = rxdp->status;
736                 if (! (status & E1000_RXD_STAT_DD))
737                         break;
...
807                 rxdp->buffer_addr = dma_addr;
808                 rxdp->status = 0;
where I be seeing weird behavior with KVM due to MMIO write
coalescing


P.S.
> Also, is DPDK accessing the e1000 device from more than 1 vCPU?
 All tests on single virtual CPU.

I created github project for quick reproduction of this error:
https://github.com/BASM/qemu_dpdk_e1000_test

---
Best regards,
Leonid Myravjev

On Thu, 21 Nov 2019 at 17:05, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Nov 20, 2019 at 08:36:32PM +0300, ASM wrote:
> > I trying solve the problem, with packets stopping (e1000,tap,kvm).
> > My studies led to the following:
> > 1. From flatview_write_continue() I see, what e1000 writes the number
> > "7" to the STAT register.
> > 2. The driver from target OS reads STAT register with number "7" and
> > writes to the register the number "0".
> > 3. From flatview_write_continue() (I make edits):
> >             memcpy(ptr, buf, l);
> >             new1=ptr[0xc];
> >             usleep(100);
> >             new2=ptr[0xc];
> >             invalidate_and_set_dirty(mr, addr1, l);
> >             new3=ptr[0xc];
> > printf("Old: %i, new1, %i, new2: %i, new3: %i\n", old,new1,new2,new3);
> >
> > I see what memory in first printf is "7", but after usleep() is "0".
> > Do I understand correctly that this should not be? Or RCU lock
> > suggests the ability to the multiple writers?
> >
> > The problem is that qemu(e1000) writes the number 7, after which
> > target(dpdk driver) reads 7, on the basis of this it writes the number
> > 0, but as a result (extremely rarely), the value STATUS still remains
> > 7. Therefore, packet processing is interrupted. This behavior is
> > observed only on kvm (it is not observed on tcg).
> >
> > Please help with advice or ideas.
>
> Hi Leonid,
> Could you be seeing weird behavior with KVM due to MMIO write
> coalescing?
>
>   static void e1000_mmio_setup(E1000State *d)
>   {
>       int i;
>       const uint32_t excluded_regs[] = {
>           E1000_MDIC, E1000_ICR, E1000_ICS, E1000_IMS,
>           E1000_IMC, E1000_TCTL, E1000_TDT, PNPMMIO_SIZE
>       };
>
>       memory_region_init_io(&d->mmio, OBJECT(d), &e1000_mmio_ops, d,
>                             "e1000-mmio", PNPMMIO_SIZE);
>       memory_region_add_coalescing(&d->mmio, 0, excluded_regs[0]);
>       for (i = 0; excluded_regs[i] != PNPMMIO_SIZE; i++)
>           memory_region_add_coalescing(&d->mmio, excluded_regs[i] + 4,
>                                        excluded_regs[i+1] - excluded_regs[i] - 4);
>       memory_region_init_io(&d->io, OBJECT(d), &e1000_io_ops, d, "e1000-io", IOPORT_SIZE);
>   }
>
> MMIO write coalescing means that QEMU doesn't see the register writes
> immediately.  Instead kvm.ko records them into a ring buffer and QEMU
> processes the ring when the next ioctl(KVM_RUN) exit occurs.
>
> See Linux Documentation/virt/kvm/api.txt "4.116
> KVM_(UN)REGISTER_COALESCED_MMIO" for more details.
>
> I don't really understand your printf debugging explanation.  It would
> help to see the DPDK code and the exact printf() output.
>
> Also, is DPDK accessing the e1000 device from more than 1 vCPU?
>
> Stefan

