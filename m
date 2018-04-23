Received: from eggs.gnu.org ([2001:4830:134:3::10]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAXu9-0007rY-0I
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAXu5-0003kV-1K
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:37:01 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-3-david@redhat.com>
	<20180423032825.GD19804@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a6d6e760-bffe-515d-de78-cc698f7341dc@redhat.com>
Date: Mon, 23 Apr 2018 11:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180423032825.GD19804@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On 23.04.2018 05:28, David Gibson wrote:
> On Fri, Apr 20, 2018 at 02:34:55PM +0200, David Hildenbrand wrote:
>> Let's allow to query the MemoryHotplugState from the machine.
>>
>> This allows us to generically detect if a certain machine has support
>> for memory devices, and to generically manage it (find free address
>> range, plug/unplug a memory region).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> So, we're creating a hook where it seems very likely that the only
> implementationss will be simply to retrieve the right field from the
> machine specific structure.
> 
> So.. should we instead just move the hotplug_memory structure to the
> based MachineState type?

It allows us in patch nr. 3 to report different error messages.

"Not supported" vs. "Not enabled (maxmem)".

We could also handle that via a simple boolean flag inside of the
struct. What do you think?


-- 

Thanks,

David / dhildenb
