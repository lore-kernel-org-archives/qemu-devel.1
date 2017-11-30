Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eKNf8-0002Bt-4g
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eKNf3-0006VC-54
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:09:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41576
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eKNf2-0006Un-UH
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:09:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAUC9LHp034768
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:09:46 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ejh1a2t2t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:09:45 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 30 Nov 2017 12:09:43 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
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
	<71ccf8b6-faa6-f4ac-3571-24bb59a0c498@de.ibm.com>
	<20171128150107.4cc88a86.cohuck@redhat.com>
	<13a85f8e-28c2-4780-76ad-361913a93d1b@de.ibm.com>
	<20171128154514.026098dc.cohuck@redhat.com>
	<a7cea411-3dcb-101e-8164-b214445750c2@de.ibm.com>
	<20171130105036.3e0a0e25.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 30 Nov 2017 13:09:40 +0100
MIME-Version: 1.0
In-Reply-To: <20171130105036.3e0a0e25.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <37172833-de25-18b3-a96e-b6642ff92ac3@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 11/30/2017 10:50 AM, Cornelia Huck wrote:
> On Wed, 29 Nov 2017 19:51:23 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 11/28/2017 03:45 PM, Cornelia Huck wrote:
>>> On Tue, 28 Nov 2017 15:17:49 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>   
>>>> On 11/28/2017 03:01 PM, Cornelia Huck wrote:  
>>>>> On Tue, 28 Nov 2017 14:25:08 +0100
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:  
>>>   
>>>>>> What I want now is to enable vfio-ccw for libvirt and Linux guests and for that
>>>>>> we need to lift the restriction of having vfio not in FE.    
>>>>>
>>>>> This, however, worries me. I don't really consider vfio-ccw ready for
>>>>> prime time yet. We still need to figure out path handling at the very
>>>>> least. And I'm still not sure that our non-handling of halt/clear won't
>>>>> cause major issues with e.g. a storage server error recovery.
>>>>>
>>>>> Can we flag vfio-ccw as experimental or such in libvirt?    
>>>>
>>>> We should have flagged vfio-ccw experimental in QEMU then.
>>>> e.g. by using x-vfio-ccw or whatever.I dont think we can do that
>>>> after the facts.  
>>>
>>> Yes, we should have done that... can't fix that now, unfortunately.
>>>   
>>>>
>>>> I am not that deep into vfio-ccw, but I was under the impression that
>>>> the missing features should not affect the vfio interface that is
>>>> created by libvirt. After all this should just be a "-device vfio-ccw,....."
>>>> statement and some setup steps beforehand (unbind + setup of vfio-ccw)  
>>>
>>> The halt/clear stuff is highly unlikely to influence the configuration
>>> interface. I'm still not too clear about path handling, though. Will we
>>> need different modes (hypervisor managed vs. full passthrough? probably
>>> only passthrough)? What about pgid handling - do we need some kind of
>>> pgid manager? (Keep in mind that you get to set the pgid once. This has
>>> implications for e.g. reserve/release.)
>>>
>>> Also, what about devices other than ECKD DASD? Has there been any
>>> testing? Tapes should be interesting; the other interesting ccw devices
>>> are QDIO-based and I'm not sure we want to spend anything on supporting
>>> those.  
>>
>> DASD is probably the most important thing today, QDIO might never happen
>> (or very late).
> 
> One thing I'd find interesting about tapes is very long running channel
> programs (like rewind) and how they interact with halt/clear. But yes,
> I would think that DASD is the most important one in practice.
> 
>> See my proposal below.
>>
>>>
>>> The interface is probably fine, but I'd like to get an idea about the
>>> path stuff (is the attachment spec that contains the pgid stuff
>>> publicly available, btw.?)
>>>   
>>>>
>>>> If your concern is the serviceability I think it would be valid for a RHEL
>>>> KVM to disable vfio-ccw in the kernel. Maybe we could even provide a config
>>>> for QEMU?  
>>>
>>> It's fine just to turn off vfio-ccw in the kernel.
>>>   
>>>> PS: I learned from the PCI and CCW experience that I do not want
>>>> to upstream kernel/qemu code unless I have a working libvirt code that
>>>> shows that the thing will work.  
>>>
>>> Yes, I understand the wish to verify the interface, and I think it's a
>>> good idea. What I'm worried about is that this might be the precursor
>>> to a push to support it, and I don't think vfio-ccw is ready for that
>>> yet.
>>>   
>> FWIW, libvirt should not care if a device works in all cases or not because 
>> libvirt versions should work with all kind of QEMU/kernel combinations. 
>> Fencing in libvirt that the kernel part is not up to the task is making
>> me feel the same way as you when you see  the css-unrestricted property
>> at a device ;-)
> 
> I'm more worried about the political angle than the technical. If we
> don't get pressure to support this too soon, I don't care that much
> about experimental or not.
> 
>> Having said that, I think that having vfio-ccw support has a value (and it
>> actually works for an unnamed test infrastructure). In addition to that I 
>> am much more likely to actually test this continuously if I have libvirt support.
> 
> Good to hear that it works for a non-Linux guest. Any plans to test
> something like storage server failover?
> 
> [I'd really love to do something about the path handling stuff, but the
> combination of scant documentation and scantier time works against me.]
> 
>>
>>
>> So what about the following: 
>>
>> 1. We will implement the libvirt support with either a or b:
>> a: if we find a solution to our "where to put the property" dispute use that to decide
>> if we can add vfio-ccw
>> b if not: just provide a patch that lifts the restriction without any property.
>> in libvirt blindy assume  that free assignment will work. old QEMUs will complain at
>> startup and  libvirt will print the QEMU error. This is similar to other situations 
>> where libvirt cannot fully bprobe  if the QEMU will work or not. (not having vfio-ccw
>> support in the kernel will certainly allow libvirt to reject this upfront)
> 
> I hope we end up with a solution that works for everyone...
> 
>>
>> 2. at the same time we mark vfio-ccw experimental in the kernel to make clear
>>  that this is still work in progress
> 
> I'm not sure we can do that after the fact, but let's do it if we can.

I think we can change that. Its just a Kconfig dependency.
 
>>
>> 3. (optional) we could even whitelist devices that work in a reasonable fashion (e.g.
>> do not whitelist qdio but whitelist DASD)
> 
> I think it's not quite that easy with vfio-ccw working at the
> subchannel level.
> 
