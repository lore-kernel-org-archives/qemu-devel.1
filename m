Received: from eggs.gnu.org ([209.51.188.92]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvfFy-000790-7G
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvfFx-000720-CJ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:30:34 -0500
Date: Mon, 18 Feb 2019 10:30:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190218103021.3b6e922e.cohuck@redhat.com>
In-Reply-To: <20190218092202.26683-4-david@redhat.com>
References: <20190218092202.26683-1-david@redhat.com>
	<20190218092202.26683-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/6] tests/device-plug: Add a simple PCI
 unplug request test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 18 Feb 2019 10:21:59 +0100
David Hildenbrand <david@redhat.com> wrote:

> The issue with testing asynchronous unplug requests it that they usually
> require a running guest to handle the request. However, to test if
> unplug of PCI devices works, we can apply a nice little trick on some
> architectures:
> 
> On system reset, x86 ACPI, s390x and spapr will perform the unplug,
> resulting in the device of interest to get deleted and a DEVICE_DELETED
> event getting sent.
> 
> On s390x, we still get a warning
>     qemu-system-s390x: -device virtio-mouse-pci,id=dev0:
>     warning: Plugging a PCI/zPCI device without the 'zpci' CPU feature
>     enabled; the guest will not be able to see/use this device
> 
> This will be fixed soon, when we enable the zpci CPU feature always
> (Conny already has a patch for this queued).

Let's see which series makes it into mainline first ;)

> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/Makefile.include   |  4 ++
>  tests/device-plug-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 tests/device-plug-test.c

Looks sane at a glance.

Acked-by: Cornelia Huck <cohuck@redhat.com>
