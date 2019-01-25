Received: from eggs.gnu.org ([209.51.188.92]:50718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmxyb-0004Yx-PO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmxmt-000321-9I
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:28:38 -0500
References: <20190123082425.10643-1-david@redhat.com>
	<11e508cf-bff8-71e0-8d25-b54250d3d201@ozlabs.ru>
From: David Hildenbrand <david@redhat.com>
Message-ID: <af5b995d-0db2-e64a-1e7b-de5a8b45b64d@redhat.com>
Date: Fri, 25 Jan 2019 10:28:24 +0100
MIME-Version: 1.0
In-Reply-To: <11e508cf-bff8-71e0-8d25-b54250d3d201@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] spapr/pci: Fix primary bus number for
 PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 24.01.19 03:48, Alexey Kardashevskiy wrote:
> 
> 
> On 23/01/2019 19:24, David Hildenbrand wrote:
>> While looking at the s390x implementation, looks like spapr has a
>> similar BUG when building the topology.
>>
>> The primary bus number corresponds always to the bus number of the
>> bus the bridge is attached to.
>>
>> Right now, if we have two bridges attached to the same bus (e.g. root
>> bus) this is however not the case. The first bridge will have primary
>> bus 0, the second bridge primary bus 1, which is wrong. Fix the assignment.
>>
>> While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
>> Setting it temporarily to that value (as discussed e.g. in [1]), is
>> only relevant for a running system that probes the buses. The value is
>> effectively unused for us just doing a DFS.
> 
> What is DFS?

Depth-first search :)

> 
>>
>> [1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
>>
>> Note: Is hotplug of bridges supported? I can't find where the topology
>> is fixed up when hotplugging a PCI bridge. (e.g. bus numbers assigned
>> and PCI_SUBORDINATE_BUS of path to the root updated). But maybe we are
>> excluding bridges or this is not necessary for some reason.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> 

Thanks!


-- 

Thanks,

David / dhildenb
