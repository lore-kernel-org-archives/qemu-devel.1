Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D0DC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE47206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE47206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38233 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvN8-0002ZE-W2
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 10:59:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQvLF-0001HP-1Q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQvIN-0008LF-8c
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hQvIL-0008FJ-52
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:54:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BBFD7A163;
	Wed, 15 May 2019 14:54:00 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB60060E39;
	Wed, 15 May 2019 14:53:59 +0000 (UTC)
Date: Wed, 15 May 2019 08:53:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190515085359.1f94c81f@x1.home>
In-Reply-To: <9e0c77b53b1507e4a2aab2f6296cc7c716864ad3.camel@redhat.com>
References: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
	<c707e882-e194-355a-d96c-bfb00a8db247@redhat.com>
	<CAKXe6SKetRL1uEww7wZeOCU5d8t+qrDDjzk3uBsQuhiQzt5S6w@mail.gmail.com>
	<20190515074616.3d6e6b32@x1.home>
	<9e0c77b53b1507e4a2aab2f6296cc7c716864ad3.camel@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 15 May 2019 14:54:00 +0000 (UTC)
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
Cc: Auger Eric <eric.auger@redhat.com>, Li Qiang <liq3ea@gmail.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 May 2019 17:27:52 +0300
Maxim Levitsky <mlevitsk@redhat.com> wrote:

> Hi!
> 
> Let me add my 0.2 cents to this discussion by sharing my summary of INTx emulation in VFIO:
> 
> COMMON:
> * real interrupt is signaled in the kernel
> * vfio-pci kernel interrupt hanlder (vfio_intx_handler), masks the INTx flag
> * vfio-pci kernel interrupt handler triggers an eventfd, if the interrupt is not virtually intx masked
>   (an eventfd which was registred for VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER)
> 
> 
> KERNEL INTERRUPT CONTROLLER CASE:
> 
> * the vfio-pci eventfd is listened by the kvm (set by KVM_IRQFD ioctl), and delivered to guest ioapic
>   (the setup is done by qemu in vfio_intx_enable_kvm, the same eventfd is given to vfio-pci and to kvm)
> * when guest writes eoi, an 'resamplefd' is (which is registered by vfio_intx_enable_kvm too)
>   is triggered.
>   the vfio_intx_enable_kvm tells the vfio pci module (VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK)
>   to listen to that 'resamplefd' and unmask the interrupt
>   (here too, a same eventfd is given to kvm and to vfio-pci, but here the kvm signals it, and vfio-pci listens to it).
> 
> 
> USERSPACE QEMU CASE:
> 
>   (only happens in short period while vfio_intx_enable is running and before it calles the vfio_intx_enable_kvm)
>   (or when vfio_intx_enable_kvm fails)
> 
> * the vfio-pci eventfd is listened by the qemu (vfio_intx_interrupt)
> * the vfio_intx_interrupt (in qemu)
> 	* masks the interrupt using kernel vfio interface
> 	* unmaps all the device bars and sets a timer to map them again
> 	* sends the interrupt down the qemu stack till it is reinjected to the guest 
> * any bar access now goes to qemu via EPT fault (vfio_region_read/vfio_region_write)
> * the bar access 
> 	* triggers (vfio_eoi->vfio_intx_eoi) which unmasks (using vfio-pci) the interrupt
>   	  the idea is that first few bar accesses should ack the interrupt and thus avoid flood
>   	  but some interrupts could still happen (one per bar access)

Full points :)  Thanks,

Alex

