Received: from eggs.gnu.org ([2001:4830:134:3::10]:57874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJcCY-0001CO-Ff
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJcCV-0000MR-Qn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:33:46 -0500
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-11-david@redhat.com>
	<20181105113159.78c714e1@bahia.lan>
From: David Hildenbrand <david@redhat.com>
Message-ID: <650cbff1-f3b8-1bb9-1e79-30a8a5f1c94e@redhat.com>
Date: Mon, 5 Nov 2018 11:33:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181105113159.78c714e1@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 10/10] spapr_pci: perform
 unplug via the hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 05.11.18 11:31, Greg Kurz wrote:
> On Mon,  5 Nov 2018 11:20:44 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Introduce and use the "unplug" callback.
>>
>> This is a preparation for multi-stage hotplug handlers, whereby the bus
>> hotplug handler is overwritten by the machine hotplug handler. This handler
>> will then pass control to the bus hotplug handler. So to get this running
>> cleanly, we also have to make sure to go via the hotplug handler chain when
>> actually unplugging a device after an unplug request. Lookup the hotplug
>> handler and call "unplug".
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

BTW, sorry for dropping you RB! (realized it just now)

-- 

Thanks,

David / dhildenb
