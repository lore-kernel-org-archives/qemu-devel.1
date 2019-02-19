Received: from eggs.gnu.org ([209.51.188.92]:38974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw02P-00049c-MX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw02O-0004aw-UE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:41:57 -0500
References: <20190218092202.26683-1-david@redhat.com>
	<20190219025851.GO9345@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <247e2e86-c740-170e-8844-0ec96f6bcecf@redhat.com>
Date: Tue, 19 Feb 2019 08:41:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190219025851.GO9345@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] tests: Add device unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 19.02.19 03:58, David Gibson wrote:
> On Mon, Feb 18, 2019 at 10:21:56AM +0100, David Hildenbrand wrote:
>> This is a set of tests to test basic device unplugging functionality for
>> - some PCI implementations
>> - CCW devices on s390x
>> - spapr memory and cpu core devices
>>
>> I plaed with ACPI CPU unplug but getting that to run with qtest is more
>> involved. (remove devices on reset, trick cpu-hotplug-legacy property,
>> somehow create cpu hotplug state objects ...). Well we no have at least
>> one unplug test for DIMMs and one for CPUs.
> 
> I believe we were talking about merging this via the ppc tree, so I've
> merged it into ppc-for-4.0 (with Connie's acks).
> 
> If I was mistaken about that, let me know and I'll pull them out
> before I send my next pull request.

That's also how I understood it :)

Thanks David!

-- 

Thanks,

David / dhildenb
