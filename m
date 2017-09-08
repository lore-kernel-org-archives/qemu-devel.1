Received: from eggs.gnu.org ([2001:4830:134:3::10]:58939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqHhT-0000qO-ES
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqHhQ-0005mr-79
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:43:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqHhP-0005mI-UL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:43:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88Bhlfn008514
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 07:43:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cun6rfyu8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:43:50 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 12:43:39 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<22830b0b-d05d-22de-271c-f0aa9bca6b64@linux.vnet.ibm.com>
	<20170908124905.52a8de36.cohuck@redhat.com>
	<5a8f76e9-dfb9-9b19-26b9-99734d67efd7@linux.vnet.ibm.com>
	<20170908131917.679e3222.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 8 Sep 2017 13:43:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170908131917.679e3222.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9840ad7f-5c08-d080-f790-6a11fbf0381a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/08/2017 01:19 PM, Cornelia Huck wrote:
> On Fri, 8 Sep 2017 13:03:00 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 09/08/2017 12:49 PM, Cornelia Huck wrote:
>>> On Fri, 8 Sep 2017 12:45:25 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>>>> What do you think, would it make more sense to omit or to keep the testing
>>>> stuff for v2 (I mean patch 5 and the kernel module in the cover letter)?  
>>>
>>> Can you maybe split this out? It makes it easier if you don't have to
>>> go hunt in a cover letter.
>>>   
>>
>> I'm not sure, I know what you mean. Adding an out-of-tree linux kernel module to
>> the qemu tree does not sound right, so I suppose I should not send it as a patch.
>>
>> Splitting out the test device patch (#5) does not sound like a good idea either,
>> because it depends on patches #1 and #4.
>>
>> TL;DR Yes, I would be glad to if you tell me how.
> 
> I'd do a separate "series" with both the kernel and the qemu part,
> stating the dependencies in the cover letter. Patchew will be unhappy,
> but I will be happier :)
> 

I can do that, for me you are definitely more important than Patchew.
The kernel module patch won't apply to the qemu tree so I can make
it a two patch series without being too associal.

>>
>>>>
>>>> You probably haven't found the time to look at have a glance at "s390x/css: drop
>>>> data-check in interpretation" (https://urldefense.proofpoint.com/v2/url?u=http-3A__patchwork.ozlabs.org_patch_810995_&d=DwICAg&c=jf_iaSHvJObTbx-siA1ZOg&r=afpWhmOLStQASenyglRLvnb_ajvdRfgp4RlDrLw42F4&m=hshoLebtV7YUijl44CLPl5gP9F1HrXyCbL85tQhvA1w&s=SjTjqdOybbUj1pGpODNHdUfXBZBZU-iav6j10EEWYfQ&e= ). We
> 
> Unlikely to be of your doing, but wtf happened here?
> 

Exactly that. We are fighting it. Corporate cyber-security policies
are not exactly easy to fight.

>>>> have said it would make some things more straight forward here, and I could
>>>> drop that ugly TODO comment. I think it's quite straight-forward, and I would
>>>> not mind having a decision on it before v2 or putting it as preparation into
>>>> v2. What do you prefer?  
>>>
>>> It is marked for my attention. I don't know whether I find time to look
>>> at it today, but probably early next week.
>>>   
>>
>> OK. Btw, I have a couple of other bug-fixes in the pipe. I think I will just
>> send out a v1 series to get the discussion started (and for now ignore possible
>> merge  conflicts with my patches already on the list).
> 
> Don't worry about merge conflicts, I need to figure them out myself
> anyway :)
> 

OK. Many thanks!

Halil
