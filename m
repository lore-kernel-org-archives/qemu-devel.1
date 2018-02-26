Received: from eggs.gnu.org ([2001:4830:134:3::10]:54473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqF2U-0007I9-Rh
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqF2Q-00082X-Su
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:25:42 -0500
References: <20180223173657.29125-1-david@redhat.com>
	<afa4789f-8377-f033-00c8-35821a872178@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <19e19b72-ac67-8210-345b-41431f7d2075@redhat.com>
Date: Mon, 26 Feb 2018 10:25:19 +0100
MIME-Version: 1.0
In-Reply-To: <afa4789f-8377-f033-00c8-35821a872178@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] numa: s390x has no NUMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 26.02.2018 10:20, Christian Borntraeger wrote:
> 
> 
> On 02/23/2018 06:36 PM, David Hildenbrand wrote:
>> Right now it is possible to crash QEMU for s390x by providing e.g.
>>     -numa node,nodeid=0,cpus=0-1
>>
>> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
>> indicator whether NUMA is supported by a machine type. We don't
>> implement NUMA on s390x (and that concept also doesn't really exist).
>> We need mc->cpu_index_to_instance_props for query-cpus.
> 
> Looks like we assert because of 
> machine->possible_cpus == 0.
> 
> Later during boot this is created in s390_possible_cpu_arch_ids. (via 
> s390_init_cpus). What we (in the future) actually could provide is a 
> cpu topology.
> 
> So something like this also fixes the bug

Yes, but I decided to not go this way because we don't support NUMA as
of now. -numa has to bail out (just as it did before I implemented
proper query-cpus support).

What you propose is something for future support - one we have cpu
topology information exposed.


-- 

Thanks,

David / dhildenb
