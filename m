Received: from eggs.gnu.org ([2001:4830:134:3::10]:39325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqG1Y-0000VW-Cj
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqG1V-0003DQ-73
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:28:48 -0500
References: <20180223173657.29125-1-david@redhat.com>
	<20180226111953.1e9bc50c.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f8266a54-7b02-020b-b742-f7b81ed987ab@redhat.com>
Date: Mon, 26 Feb 2018 11:28:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180226111953.1e9bc50c.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 26.02.2018 11:19, Cornelia Huck wrote:
> On Fri, 23 Feb 2018 18:36:57 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Right now it is possible to crash QEMU for s390x by providing e.g.
>>     -numa node,nodeid=0,cpus=0-1
>>
>> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
>> indicator whether NUMA is supported by a machine type. We don't
>> implement NUMA on s390x (and that concept also doesn't really exist).
>> We need mc->cpu_index_to_instance_props for query-cpus.
> 
> Is existence of cpu_index_to_instance_probs the correct indicator for
> numa, then?
> 
> OTOH, your patch is straightforward...

Maybe it is get_default_cpu_node_id as Christian discovered?


-- 

Thanks,

David / dhildenb
