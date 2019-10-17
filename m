Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD982ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 20:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9869520872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 20:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9869520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLCOw-0006n2-OL
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 16:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iLCOB-0005zG-BC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iLCO8-0005rM-Pr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iLCO8-0005pn-Gl; Thu, 17 Oct 2019 16:28:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D65018C4287;
 Thu, 17 Oct 2019 20:28:47 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89A641001B35;
 Thu, 17 Oct 2019 20:28:45 +0000 (UTC)
Date: Thu, 17 Oct 2019 14:28:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 3/5] vfio/pci: Respond to KVM irqchip change notifier
Message-ID: <20191017142845.5d4d9121@x1.home>
In-Reply-To: <20191017054218.8876-4-david@gibson.dropbear.id.au>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-4-david@gibson.dropbear.id.au>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 17 Oct 2019 20:28:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 16:42:16 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> VFIO PCI devices already respond to the pci intx routing notifier, in order
> to update kernel irqchip mappings when routing is updated.  However this
> won't handle the case where the irqchip itself is replaced by a different
> model while retaining the same routing.  This case can happen on
> the pseries machine type due to PAPR feature negotiation.
> 
> To handle that case, add a handler for the irqchip change notifier, which
> does much the same thing as the routing notifier, but is unconditional,
> rather than being a no-op when the routing hasn't changed.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/vfio/pci.c | 12 ++++++++++++
>  hw/vfio/pci.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 529ad13908..6aa806baff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -255,6 +255,14 @@ static void vfio_intx_routing_notifier(PCIDevice *pdev)
>      }
>  }
>  
> +static void vfio_irqchip_change(Notifier *notify, void *data)
> +{
> +    VFIOPCIDevice *vdev = container_of(notify, VFIOPCIDevice,
> +                                       irqchip_change_notifier);
> +
> +    vfio_intx_update(vdev, &vdev->intx.route);
> +}
> +
>  static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> @@ -2960,6 +2968,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                                                    vfio_intx_mmap_enable, vdev);
>          pci_device_set_intx_routing_notifier(&vdev->pdev,
>                                               vfio_intx_routing_notifier);
> +        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
> +        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>          ret = vfio_intx_enable(vdev, errp);
>          if (ret) {
>              goto out_teardown;
> @@ -3009,6 +3019,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>  out_teardown:
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);

We can get here without having added the irqchip notifier and I don't
think QLIST_REMOVE is very friendly with gratuitous calls.

>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
>  error:
> @@ -3042,6 +3053,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);

Same here.  Otherwise the approach looks sane to me.  Thanks,

Alex

>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 834a90d646..11324f28ce 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -168,6 +168,8 @@ typedef struct VFIOPCIDevice {
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
>      VFIODisplay *dpy;
> +
> +    Notifier irqchip_change_notifier;
>  } VFIOPCIDevice;
>  
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);


