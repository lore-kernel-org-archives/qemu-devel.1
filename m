Received: from eggs.gnu.org ([209.51.188.92]:54184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gveoI-000393-Hs
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvef3-00029C-91
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:52:27 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-4-david@redhat.com>
	<c3ec671c-8c02-25e2-dfa1-9f5086bb7c21@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fb000af4-b831-ca39-1d90-07641b5dfc46@redhat.com>
Date: Mon, 18 Feb 2019 09:42:14 +0100
MIME-Version: 1.0
In-Reply-To: <c3ec671c-8c02-25e2-dfa1-9f5086bb7c21@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 15.02.19 16:21, Thomas Huth wrote:
> On 15/02/2019 14.30, David Hildenbrand wrote:
>> The issue with testing asynchronous unplug requests it that they usually
>> require a running guest to handle the request. However, to test if
>> unplug of PCI devices works, we can apply a nice little trick on some
>> architectures:
>>
>> On system reset, x86 ACPI, s390x and spapr will perform the unplug,
>> resulting in the device of interest to get deleted and a DEVICE_DELETED
>> event getting sent.
>>
>> On s390x, we still get a warning
>>     qemu-system-s390x: -device virtio-mouse-pci,id=dev0:
>>     warning: Plugging a PCI/zPCI device without the 'zpci' CPU feature
>>     enabled; the guest will not be able to see/use this device
>>
>> This will be fixed soon, when we enable the zpci CPU feature always
>> (Conny already has a patch for this queued).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  tests/Makefile.include   |  4 ++
>>  tests/device-plug-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 97 insertions(+)
>>  create mode 100644 tests/device-plug-test.c
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> BTW, have you spotted the qpci_unplug_acpi_device_test() in libqos
> already? Might be interesting for these kinds of tests, too - we use it
> in a couple of other tests already, though, so I'm not sure if we need
> additional tests with that...
> 

Cool, no I haven't! It's PCI only, something similar for CPU/memory
unplug on x86 would be interesting. I might be looking into that in the
future.

-- 

Thanks,

David / dhildenb
