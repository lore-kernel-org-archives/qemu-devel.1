Received: from eggs.gnu.org ([2001:4830:134:3::10]:48686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMzmN-0001hY-Op
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMzmJ-0007Os-8c
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:16:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMzmI-0007OT-W7
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:16:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB7HEm10027159
	for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 12:16:04 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eq85hdu78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 12:16:03 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 7 Dec 2017 17:16:01 -0000
References: <20171128134648.21530-1-cohuck@redhat.com>
	<20171205085906.GA3894@lagrange>
	<20171207173418.7c70e5e9.cohuck@redhat.com>
	<786c5a2c-d61e-cfa1-c3b7-f36c69ec3a75@linux.vnet.ibm.com>
	<20171207180650.68cc909e.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 7 Dec 2017 18:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171207180650.68cc909e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <95059339-fac0-ee39-2e68-4ff5bc793893@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] s390x: cut down on unattached
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pmorel@linux.vnet.ibm.com, Bjoern Walk <bwalk@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 12/07/2017 06:06 PM, Cornelia Huck wrote:
> On Thu, 7 Dec 2017 18:01:46 +0100
[..]
>>>> Regarding the discussion about whether the QOM tree is API and what
>>>> exploiters like libvirt should do, Halil asked me to chip in.
>>>>
>>>> This patch is fine from libvirt perspective. I did a quick smoke test
>>>> and you can have a
>>>>
>>>>     Tested-by: Bjoern Walk <bwalk@linux.vnet.ibm.com>
>>>>
>>>> for what it's worth.  
>>>
>>> Thanks for checking.
>>>   
>>>>
>>>> In general, I kind of agree with Halil. Unless somewhere in QEMU it is
>>>> documented that the QOM tree is not guaranteed to be stable for
>>>> exploiters, I'd consider is part of the API. libvirt does use at least
>>>> some hardcoded paths, most of the time for CPUs in /machine/unattached,
>>>> so if that relation would change, things break. However, there is also
>>>> code to traverse the QOM tree recursively and find a path for a given
>>>> type(?) name. If this is the preferred way, we probably should change
>>>> this in libvirt to be safe.  
>>>
>>> OK, with that in mind and as we're now adding a property to check on
>>> the css bridge, I vote for including patch 1 now (having a fixed
>>> location under /machine looks saner that having to
>>> check /machine/unattached/device[<n>], which might not be stable).
>>>
>>> Patch 2 needs more discussion, as I'm not sure whether what I'm doing
>>> is the correct way to go about this (and other machines are in the same
>>> situation). Not sure whether it is worth trying to attach the zpci
>>> devices somewhere.
>>>   
>>
>> I think, if it's kind of API, then fixing sooner is better than fixing
>> later.
>>
>> I also agree that patch 1 should be higher priority.
>>
>> Before we do patch 1 I would like having agreed and documented whether
>> this is API or not.
>>
>> If we decide it's an API, I think we should consider deprecating
>> the current interface, but keep it working for two releases or
>> so. I think nothing speaks against introducing a link form unattached
>> in patch 1 (but I have not tried yet).
> 
> No, just no. That's completely overengineered.
> 

Which part is totally overengineered? Having it clear what is API and
what not? Having this documented? Or caring about our deprecation
policy (if it's API)?
