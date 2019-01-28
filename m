Received: from eggs.gnu.org ([209.51.188.92]:42042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1go7oU-0004bM-2e
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1go7oQ-0002J2-A3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:23:02 -0500
References: <20190123195527.29575-1-david@redhat.com>
	<20190128151833.15532428@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b530ad83-3c05-68ae-c7d2-cb5584849ab3@redhat.com>
Date: Mon, 28 Jan 2019 15:22:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190128151833.15532428@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2 0/9] qdev: Hotplug handler chaining +
 virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 28.01.19 15:18, Igor Mammedov wrote:
> On Wed, 23 Jan 2019 20:55:18 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> This series implements supprt for hotplug handler chaining (proposed
>> by Igor), something that is necessary to turn selected virtio devices into
>> memory devices. Planned devices inlude virtio-mem and virtio-pmem. The
>> current prototype of virtio-pmem is included.
>>
>> The machine hotplug handler can intercept hotplug handler calls
>> to properly prepare/teardown the memory device part of a device. Control
>> is then passed on to the actual bus hotplug handler. So the default hotplug
>> handler is effectively overwritten to make interception possible.
>>
>> It is based on the following patches/series
>> - [PATCH v1] pc: Use hotplug_handler_(plug|unplug|unplug_request)
>> -- Queued by Paolo
>> - [PATCH v3 0/2] s390x/pci: hotplug handler fixes and reworks
>>
>> Patch 1-3 are the preparations for hotplug handler chaining.
> we probably should merge this ones even without pmem patches.

Sounds good to me. I'll do more testing.

> 
>> The remaining patches are a modified prototype of virtio-pmem.
> I'm not sure yet that virtio-pmem should be merged.
> 
> Initial goal for fake pmem was to eliminate page-cache in guest
> so that only host will have it and cached pages could be shared
> between several guest.
> 
> However recently (if I read kernel driver thread right),
> sharing is to be disabled due to security implication and then
> only dropping page cache on one side is left, which could be done
> using existing frontends/backends (disabling caching on host side).
> 

Yes, we should at least wait for the kernel part to settle. Anyhow, I
will base my virtio-mem work on this in a very similar fashion!

Thanks Igor!


-- 

Thanks,

David / dhildenb
