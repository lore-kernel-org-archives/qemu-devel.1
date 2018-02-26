Received: from eggs.gnu.org ([2001:4830:134:3::10]:50332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqGdP-0001Un-Rb
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqGdK-0006aK-R5
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:07:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54464
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eqGdK-0006a6-Jj
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:07:50 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1QB7A0Y115219
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 06:07:49 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gcerpwykw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 06:07:49 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 26 Feb 2018 11:07:47 -0000
References: <20180223173657.29125-1-david@redhat.com>
	<20180226111953.1e9bc50c.cohuck@redhat.com>
	<f8266a54-7b02-020b-b742-f7b81ed987ab@redhat.com>
	<20180226113503.6ecfa712.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 26 Feb 2018 12:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180226113503.6ecfa712.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ee712e2c-9506-c6df-4516-8b11ccf18fc7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] numa: s390x has no NUMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 02/26/2018 11:35 AM, Cornelia Huck wrote:
> On Mon, 26 Feb 2018 11:28:26 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 26.02.2018 11:19, Cornelia Huck wrote:
>>> On Fri, 23 Feb 2018 18:36:57 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> Right now it is possible to crash QEMU for s390x by providing e.g.
>>>>     -numa node,nodeid=0,cpus=0-1
>>>>
>>>> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
>>>> indicator whether NUMA is supported by a machine type. We don't
>>>> implement NUMA on s390x (and that concept also doesn't really exist).
>>>> We need mc->cpu_index_to_instance_props for query-cpus.  
>>>
>>> Is existence of cpu_index_to_instance_probs the correct indicator for
>>> numa, then?
>>>
>>> OTOH, your patch is straightforward...  
>>
>> Maybe it is get_default_cpu_node_id as Christian discovered?
> 
> Yes, that seems like a better candidate for checking.

Agreed. 
As everybody else calls possible_cpu_arch_ids  in cpu_index_to_props
I am asking myself if we should do that as well anyway?
