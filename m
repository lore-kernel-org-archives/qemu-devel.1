Received: from eggs.gnu.org ([209.51.188.92]:53599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj1HJ-0002SP-BY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj1HH-00031r-VD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:23:41 -0500
Date: Mon, 14 Jan 2019 13:23:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114132309.14e7e9a0.cohuck@redhat.com>
In-Reply-To: <154724057022.525985.2498693456915341883.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
	<154724057022.525985.2498693456915341883.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/13] qdev: pass an Object * to
 qbus_set_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Fri, 11 Jan 2019 22:02:50 +0100
Greg Kurz <groug@kaod.org> wrote:

> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> 
> Certain devices types, like memory/CPU, are now being handled using a
> hotplug interface provided by a top-level MachineClass. Hotpluggable
> host bridges are another such device where it makes sense to use a
> machine-level hotplug handler. However, unlike those devices,
> host-bridges have a parent bus (the main system bus), and devices with
> a parent bus use a different mechanism for registering their hotplug
> handlers: qbus_set_hotplug_handler(). This interface currently expects
> a handler to be a subclass of DeviceClass, but this is not the case
> for MachineClass, which derives directly from ObjectClass.
> 
> Internally, the interface only requires an ObjectClass, so expose that
> in qbus_set_hotplug_handler().
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/acpi/pcihp.c               |    2 +-
>  hw/acpi/piix4.c               |    2 +-
>  hw/char/virtio-serial-bus.c   |    2 +-
>  hw/core/bus.c                 |   11 ++---------
>  hw/pci/pcie.c                 |    2 +-
>  hw/pci/shpc.c                 |    2 +-
>  hw/ppc/spapr_pci.c            |    2 +-
>  hw/s390x/css-bridge.c         |    2 +-
>  hw/s390x/s390-pci-bus.c       |    6 +++---
>  hw/scsi/virtio-scsi.c         |    2 +-
>  hw/scsi/vmw_pvscsi.c          |    2 +-
>  hw/usb/dev-smartcard-reader.c |    2 +-
>  include/hw/qdev-core.h        |    3 +--
>  13 files changed, 16 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
