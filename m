Received: from eggs.gnu.org ([2001:4830:134:3::10]:35401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRDpO-0000Q1-1b
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRDpL-0007KD-En
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:37:02 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-7-david@redhat.com>
	<20180608105655.01fa8fb0@redhat.com>
	<73659780-557a-1439-f389-831c1c0ad852@redhat.com>
	<20180608113522.5d69661a@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <25b45436-a34e-7d76-d607-0ce54c77a6d5@redhat.com>
Date: Fri, 8 Jun 2018 11:36:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180608113522.5d69661a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/8] spapr: handle pc-dimm unplug via
 hotplug handler chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 08.06.2018 11:35, Igor Mammedov wrote:
> On Fri, 8 Jun 2018 11:02:23 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.06.2018 10:56, Igor Mammedov wrote:
>>> On Thu,  7 Jun 2018 18:52:16 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
>>>> unplug memory devices (which a pc-dimm is) later.  
>>> Perhaps something like following would be better:
>>>
>>> Factor out memory unplug into separate function from spapr_lmb_release().
>>> Then use generic hotplug_handler_unplug() to trigger memory unplug,
>>> which would call spapr_machine_device_unplug() -> spapr_memory_unplug()
>>> in the end .
>>> This way unplug operation is not buried in lmb internals and located
>>> in the same place like in other targets, following similar
>>> logic/call chain across targets.  
>>
>> Can this be an addon patch? Sounds like factoring out more and moving more.
> I've suggested ^^^ it as this patch description instead of the current one
> that doesn't really makes the sense on it's own.

Okay, I was definitely misreading your comment :) Will change.


-- 

Thanks,

David / dhildenb
