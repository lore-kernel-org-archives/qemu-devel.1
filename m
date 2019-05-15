Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0239C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38132084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38132084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqyE-000178-HH
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:17:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hQqxH-0000qS-Bz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hQqxG-0007zA-Bm
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:16:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hQqxG-0007rB-5f
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91678C4EC1;
	Wed, 15 May 2019 10:16:07 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 500975C1A3;
	Wed, 15 May 2019 10:16:04 +0000 (UTC)
To: Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	alex.williamson@redhat.com, Qemu Developers <qemu-devel@nongnu.org>
References: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c707e882-e194-355a-d96c-bfb00a8db247@redhat.com>
Date: Wed, 15 May 2019 12:16:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 15 May 2019 10:16:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Question about the vfio device interrupt
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 5/15/19 12:01 PM, Li Qiang wrote:
> Hello Paolo, Alex and all,
> 
> In vfio_intx_enable_kvm(qemu) I see we associate a resamplefd with the
> umask function(vfio_pci_intx_unmask_handler in linux).
> 
>     irq_set = g_malloc0(argsz);
>     irq_set->argsz = argsz;
>     irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK;
>     irq_set->index = VFIO_PCI_INTX_IRQ_INDEX;
>     irq_set->start = 0;
>     irq_set->count = 1;
>     pfd = (int32_t *)&irq_set->data;
> 
>     *pfd = irqfd.resamplefd;
> 
>     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> 
> I know this resamplefd is triggered when the interrupt controller receives
> an EOI and
> then we unmask and re-enabled the VFIO devices' interrupt.
> 
> So I think there  there must be a mask process(so we unmask it later), I
> mean there must a
> call of function vfio_pci_set_intx_mask(in linux).
> 
> What I can't understand is when this process(mask VFIO devices' interrupt)
> occurs?
It is done in the VFIO interrupt handler:
vfio_intx_handler/disable_irq_nosync for VFIO PCI (vfio_pci_intrs.c) or
vfio_automasked_irq_handler (vfio_platform_irq.c) for VFIO PLATFORM .

Thanks

Eric

> I only find a place(vfio_basic_config_write) calls vfio_pci_intx_mask> I think when the guest process the interrupt it may mask this
> interrupt(finally call vfio_pci_set_intx_mask), but I can't find the code
> path related with vfio_basic_config_write.
> 
> 
> Any hints?
> 
> Thanks,
> Li Qiang
> 

