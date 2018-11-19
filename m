Received: from eggs.gnu.org ([2001:4830:134:3::10]:46028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOlxn-0004Hj-6v
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOlxk-0007gy-0f
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:59:51 -0500
Date: Mon, 19 Nov 2018 16:59:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181119165937.076e98f8@redhat.com>
In-Reply-To: <20181105102044.20547-4-david@redhat.com>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/10] s390x/pci: rename hotplug handler
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon,  5 Nov 2018 11:20:37 +0100
David Hildenbrand <david@redhat.com> wrote:

> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/s390x/s390-pci-bus.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e42e1b80d6..e1b14b131b 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -813,8 +813,8 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
>      return true;
>  }
>  
> -static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
> -                                  DeviceState *dev, Error **errp)
> +static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                              Error **errp)
>  {
>      PCIDevice *pdev = NULL;
>      S390PCIBusDevice *pbdev = NULL;
> @@ -923,8 +923,8 @@ static void s390_pcihost_timer_cb(void *opaque)
>      qdev_unplug(DEVICE(pbdev), NULL);
>  }
>  
> -static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
> -                                    DeviceState *dev, Error **errp)
> +static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                Error **errp)
>  {
>      PCIDevice *pci_dev = NULL;
>      PCIBus *bus;
> @@ -1032,8 +1032,8 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
>  
>      dc->reset = s390_pcihost_reset;
>      dc->realize = s390_pcihost_realize;
> -    hc->plug = s390_pcihost_hot_plug;
> -    hc->unplug = s390_pcihost_hot_unplug;
> +    hc->plug = s390_pcihost_plug;
> +    hc->unplug = s390_pcihost_unplug;
>      msi_nonbroken = true;
>  }
>  
