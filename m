Received: from eggs.gnu.org ([2001:4830:134:3::10]:58676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsrQQ-0001IC-No
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsrQL-00033s-P0
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:16:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dsrQL-00033E-GF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:16:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8FEG9Ht142728
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:16:51 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d0drygnqh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:16:51 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 15 Sep 2017 15:16:48 +0100
References: <20170915101406.27823-1-cohuck@redhat.com>
	<20170915101406.27823-2-cohuck@redhat.com>
	<37791e7b-c096-3e88-4121-4f1739615367@redhat.com>
	<20170915150705.359a5356.cohuck@redhat.com>
	<cdd8e227-c7c6-2753-5ae7-b667d6e63280@redhat.com>
	<20170915152229.3a955efa.cohuck@redhat.com>
	<17bff893-985b-96eb-8677-0a32a918b607@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 15 Sep 2017 16:16:46 +0200
MIME-Version: 1.0
In-Reply-To: <17bff893-985b-96eb-8677-0a32a918b607@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <adee6520-ceac-aeb5-1ca0-68ecb32208bc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] s390x/ccw: create s390 phb for
 compat reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com



On 09/15/2017 03:37 PM, David Hildenbrand wrote:
> On 15.09.2017 15:22, Cornelia Huck wrote:
>> On Fri, 15 Sep 2017 15:09:02 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 15.09.2017 15:07, Cornelia Huck wrote:
>>>> On Fri, 15 Sep 2017 13:57:40 +0200
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>   
>>>>> As an alternative, simply
>>>>>
>>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>>> index 0f28ebd162..0f22efc3b6 100644
>>>>> --- a/target/s390x/cpu_models.c
>>>>> +++ b/target/s390x/cpu_models.c
>>>>> @@ -195,6 +195,8 @@ bool s390_has_feat(S390Feat feat)
>>>>>                  return true;
>>>>>              }
>>>>>          }
>>>>> +        if (feat == S390_FEAT_ZPCI)
>>>>> +            return true;  
>>>>
>>>> Move that out of the CONFIG_KVM #ifdef?
>>>>   
>>>
>>> Should not make a difference I think, cpu models are not shielded off
>>> for TCG I think (maybe we should fix that, but doesn't look that easy -
>>> they have no host model which would allow cpu->model = NULL).
>>
>> It just looks odd to have it inside the define...
> 
> sure, you can then also just move it into kvm_enable() next to the other
> ones.
> 
>>
>>>
>>>> (Also, we still have the issue with pci support :/ - depend on
>>>> pci_available?)  
>>>
>>> hm ....
>>
>> Should we maybe disallow compat machines if CONFIG_PCI is off, and
>> think about something for the 2.11 machine? Otherwise, I cannot see
>> that end well :/
> 
> If they required PCI, than that is the only way to do it.
> 
>>
>> But I'll just draw up a v2 for now.
>>

Sorry for not contributing anything here. I don't have the whole
thing in my head, so I can't quite follow without digging into this.

I don't think I will be able to join today -- maybe I could have a
look next week .

Halil 

> 
> 
