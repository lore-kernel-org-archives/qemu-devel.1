Received: from eggs.gnu.org ([209.51.188.92]:40266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufJY-000841-Io
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufJX-0005te-N9
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:22:08 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3ec671c-8c02-25e2-dfa1-9f5086bb7c21@redhat.com>
Date: Fri, 15 Feb 2019 16:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190215133005.15955-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] tests/device-plug: Add a simple PCI
 unplug request test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 15/02/2019 14.30, David Hildenbrand wrote:
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
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/Makefile.include   |  4 ++
>  tests/device-plug-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 tests/device-plug-test.c

Reviewed-by: Thomas Huth <thuth@redhat.com>

BTW, have you spotted the qpci_unplug_acpi_device_test() in libqos
already? Might be interesting for these kinds of tests, too - we use it
in a couple of other tests already, though, so I'm not sure if we need
additional tests with that...
