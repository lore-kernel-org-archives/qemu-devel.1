Received: from eggs.gnu.org ([2001:4830:134:3::10]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eJft6-0002o2-47
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eJft0-0003mp-41
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:25:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44472
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eJfsz-0003ma-M1
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:25:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASDO1fA018275
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 08:25:13 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eh8mu03da-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 08:25:12 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 28 Nov 2017 13:25:11 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
	<20171124142758.39d7726f.cohuck@redhat.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
	<39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
	<2933e058-0217-9696-2c52-613da8ba7a1c@linux.vnet.ibm.com>
	<20171127175607.75bd999e.cohuck@redhat.com>
	<c49e91f1-0f8a-8f6c-9784-21aa4623e2cf@linux.vnet.ibm.com>
	<20171128112233.0a1c8c04.cohuck@redhat.com>
	<377c7bcb-403b-ed66-a9fd-07793c27ea5c@linux.vnet.ibm.com>
	<20171128131448.551e16b7.cohuck@redhat.com>
	<1d81d1c1-6f82-0261-51b4-1820a10431e6@de.ibm.com>
	<99906104-4746-6474-554e-ac85bd20106d@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 Nov 2017 14:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <99906104-4746-6474-554e-ac85bd20106d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <71ccf8b6-faa6-f4ac-3571-24bb59a0c498@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 11/28/2017 02:17 PM, Halil Pasic wrote:
> 
> 
> On 11/28/2017 01:24 PM, Christian Borntraeger wrote:
>>
>>
>> On 11/28/2017 01:14 PM, Cornelia Huck wrote:
>>> On Tue, 28 Nov 2017 12:49:04 +0100
>>> Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:
>>>
>>>> On 11/28/2017 11:22 AM, Cornelia Huck wrote:
>>>>> On Tue, 28 Nov 2017 09:53:15 +0100
>>>>> Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:
>>>>>   
>>>>>> On 11/27/2017 05:56 PM, Cornelia Huck wrote:  
>>>>>>> Proposal 2: Export the default cssid as a machine property. If this
>>>>>>> property exists, it also implies that devices can be put into any css
>>>>>>> image (although it makes the most sense to put them into the default
>>>>>>> css image as indicated by the property). Can be made r/w later if it is
>>>>>>> too much for 2.12.  
>>>>>> Just as a side discussion:
>>>>>> I know of qom command query-machines but that does not seem to provide
>>>>>> the information you suggest to use with proposal 2.  
>>>> Sorry, I meant query-command-line-options.
>>>>
>>>>>> What qom command do you suggest to use for the introspection of the
>>>>>> machine options access mode?
>>>>>>  
>>>>>
>>>>> Is qom-get what you are looking for?
>>>>>
>>>>> virsh # qemu-monitor-command vm1 --pretty '{ "execute": "qom-get", "arguments": { "path": "/machine/", "property": "accel"} }'
>>>>> {
>>>>>    "return": "kvm",
>>>>>    "id": "libvirt-18"
>>>>> }
>>>>>   
>>>> How do you find out from returned values that accel is r/o or r/w?
>>>>
>>>
>>> I read some code and it turns out that we aren't really prepared for
>>> any r/o opts... sigh.
>>>
>>> So, proposal 2 is only viable if we make it configurable from the start.
>>
>> I really really dislike option 2.
>> Binding the capability to "assign freely" to a property that is named default css is
>> just wrong. Both capabilities are really independent.
>>
> 
> I fully agree with Christian.
> 
>> I strongly prefer option 3.
>>
> 
> In the meanwhile I strongly prefer option 1 (at the ccw devices). I've just
> sent a v2, and IMHO it shows the limitations of machine properties very well.

option 1 is still fine with me.

> 
>>>
>>> Halil, do you see any chance to do this for 2.12? There's plenty of
>>> time left, and I don't think it's too hard. If not, we don't have any
>>> other option than proposal 3, even though I don't like it a lot.
>>>
> 
> I do think we have enough time to do this right. And of course I'm willing
> to do it right. IMHO the 3 options summarized by Connie are not the only
> options. But if we go for reworking our QOM composition tree, it will take
> a lot of discussion. I'm not sure all the required people have enough spare
> time for that.
> 
> Halil

I am actually not sure if we really want to have a "user-definable default css" anytime
soon. I think it might really open a can of worms in regard to management tooling.

What I want now is to enable vfio-ccw for libvirt and Linux guests and for that
we need to lift the restriction of having vfio not in FE.

What is the use case for allowing to specify a different default CSS today? Unless
we have any usecase this will make things just more complicated for the benefit of what?
