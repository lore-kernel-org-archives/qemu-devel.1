Received: from eggs.gnu.org ([2001:4830:134:3::10]:39957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0oar-0008Ed-NU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0oan-0000rI-NI
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:20:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d0oan-0000qr-EI
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:20:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JCE3uI119166
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 08:20:16 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29x74mj65v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 08:20:15 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 19 Apr 2017 13:20:09 +0100
Date: Wed, 19 Apr 2017 14:20:02 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170418221724.5707-7-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-7-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170419142002.01ba3138.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC v2 6/6] pci: Remove unnecessary PCIBus
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org

On Tue, 18 Apr 2017 19:17:24 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> "phb->bus" is a short expression, there's no need for an extra variable
> just to hold its value.
> 
> Generated using the following Coccinelle patch:
> 
>     @@
>     identifier b;
>     identifier phb;
>     typedef PCIBus;
>     @@
>     -PCIBus *b;
>      ... when != b
>     -b = phb->bus;
>      <...
>     -b
>     +phb->bus
>      ...>
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/alpha/typhoon.c                  | 10 ++++------
>  hw/pci-bridge/pci_expander_bridge.c |  4 +---
>  hw/pci-host/piix.c                  | 26 +++++++++++++-------------
>  hw/pci-host/ppce500.c               |  8 +++-----
>  hw/ppc/ppc4xx_pci.c                 |  4 +---
>  hw/ppc/spapr_pci.c                  |  6 ++----
>  hw/s390x/s390-pci-bus.c             |  6 ++----
>  7 files changed, 26 insertions(+), 38 deletions(-)
> 

> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 5e174e90f4..c2776ba221 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -553,7 +553,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
> 
>  static int s390_pcihost_init(SysBusDevice *dev)
>  {
> -    PCIBus *b;
>      BusState *bus;
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>      S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
> @@ -563,10 +562,9 @@ static int s390_pcihost_init(SysBusDevice *dev)
>      pci_host_bus_init_irqs(phb, NULL, s390_pci_set_irq, s390_pci_map_irq,
>                             NULL, get_system_memory(), get_system_io(), 0, 64,
>                             TYPE_PCI_BUS);
> -    b = phb->bus;
> -    pci_setup_iommu(b, s390_pci_dma_iommu, s);
> +    pci_setup_iommu(phb->bus, s390_pci_dma_iommu, s);
> 
> -    bus = BUS(b);
> +    bus = BUS(phb->bus);

This BusState variable is equally unnecessary, as is it just used in
the line below. But that is outside the scope of that simple coccinelle
patch, so

>      qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
> 
>      s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NULL));

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

for the s390 part.
