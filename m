Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E96CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195182068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195182068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY1IB-0003Ka-9b
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 00:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iY1Ft-0001kc-9b
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iY1Fr-0001ac-Hz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:13:16 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:47995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iY1Fr-0001Zd-9H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:13:15 -0500
Received: from player159.ha.ovh.net (unknown [10.109.159.152])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id C47861EC53F
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 06:13:12 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 24E06C4FF72D;
 Fri, 22 Nov 2019 05:12:58 +0000 (UTC)
Date: Fri, 22 Nov 2019 06:12:57 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/5] vfio/pci: Respond to KVM irqchip change notifier
Message-ID: <20191122061257.7633bcdd@bahia.lan>
In-Reply-To: <20191121005607.274347-4-david@gibson.dropbear.id.au>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
 <20191121005607.274347-4-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7955608745321273830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehfedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.171.146
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 11:56:05 +1100
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
>  hw/vfio/pci.c | 23 ++++++++++++++++++-----
>  hw/vfio/pci.h |  1 +
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 521289aa7d..95478c2c55 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -256,6 +256,14 @@ static void vfio_intx_routing_notifier(PCIDevice *pdev)
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
> @@ -2973,16 +2981,18 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                                                    vfio_intx_mmap_enable, vdev);
>          pci_device_set_intx_routing_notifier(&vdev->pdev,
>                                               vfio_intx_routing_notifier);
> +        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
> +        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>          ret = vfio_intx_enable(vdev, errp);
>          if (ret) {
> -            goto out_teardown;
> +            goto out_deregister;
>          }
>      }
>  
>      if (vdev->display != ON_OFF_AUTO_OFF) {
>          ret = vfio_display_probe(vdev, errp);
>          if (ret) {
> -            goto out_teardown;
> +            goto out_deregister;
>          }
>      }
>      if (vdev->enable_ramfb && vdev->dpy == NULL) {
> @@ -2992,11 +3002,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      if (vdev->display_xres || vdev->display_yres) {
>          if (vdev->dpy == NULL) {
>              error_setg(errp, "xres and yres properties require display=on");
> -            goto out_teardown;
> +            goto out_deregister;
>          }
>          if (vdev->dpy->edid_regs == NULL) {
>              error_setg(errp, "xres and yres properties need edid support");
> -            goto out_teardown;
> +            goto out_deregister;
>          }
>      }
>  

After this change, we end up with:

    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                  vfio_intx_mmap_enable, vdev);
        pci_device_set_intx_routing_notifier(&vdev->pdev,
                                             vfio_intx_routing_notifier);
        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
        ret = vfio_intx_enable(vdev, errp);
        if (ret) {
            goto out_deregister;
        }
    }

    if (vdev->display != ON_OFF_AUTO_OFF) {
        ret = vfio_display_probe(vdev, errp);
        if (ret) {
            goto out_deregister;
        }
    }
    if (vdev->enable_ramfb && vdev->dpy == NULL) {
        error_setg(errp, "ramfb=on requires display=on");
        goto out_teardown;
             ^^^^^^^^^^^^

This should be out_deregister.

The enable_ramfb property belongs to the nohotplug variant. It
means QEMU is going to terminate and we probably don't really
care to leak notifiers, but this still looks weird and fragile,
if enable_ramfb ever becomes usable by hotpluggable devices
one day.

    }
    if (vdev->display_xres || vdev->display_yres) {
        if (vdev->dpy == NULL) {
            error_setg(errp, "xres and yres properties require display=on");
            goto out_deregister;
        }
        if (vdev->dpy->edid_regs == NULL) {
            error_setg(errp, "xres and yres properties need edid support");
            goto out_deregister;
        }
    }


> @@ -3020,8 +3030,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>      return;
>  
> -out_teardown:
> +out_deregister:
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
>  error:
> @@ -3064,6 +3076,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b329d50338..35626cd63e 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -169,6 +169,7 @@ typedef struct VFIOPCIDevice {
>      bool enable_ramfb;
>      VFIODisplay *dpy;
>      Error *migration_blocker;
> +    Notifier irqchip_change_notifier;
>  } VFIOPCIDevice;
>  
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);


