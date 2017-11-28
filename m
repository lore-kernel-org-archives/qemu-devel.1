Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eJgi1-0004S4-Ow
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eJghx-0005uW-Jy
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:18:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47434
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eJghx-0005tZ-DH
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:17:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASEFsPO062632
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 09:17:56 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eh8mu2tdn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 09:17:55 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 28 Nov 2017 14:17:54 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
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
	<71ccf8b6-faa6-f4ac-3571-24bb59a0c498@de.ibm.com>
	<20171128150107.4cc88a86.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 Nov 2017 15:17:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171128150107.4cc88a86.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <13a85f8e-28c2-4780-76ad-361913a93d1b@de.ibm.com>
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

On 11/28/2017 03:01 PM, Cornelia Huck wrote:
> On Tue, 28 Nov 2017 14:25:08 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 11/28/2017 02:17 PM, Halil Pasic wrote:
> 
>>> In the meanwhile I strongly prefer option 1 (at the ccw devices). I've just
>>> sent a v2, and IMHO it shows the limitations of machine properties very well.  
>>
>> option 1 is still fine with me.
> 
> I still dislike it a lot. Machine properties have their own set of
> problems, but I think devices are really the wrong place for a global
> property.
> 
>>
>>>   
>>>>>
>>>>> Halil, do you see any chance to do this for 2.12? There's plenty of
>>>>> time left, and I don't think it's too hard. If not, we don't have any
>>>>> other option than proposal 3, even though I don't like it a lot.
>>>>>  
>>>
>>> I do think we have enough time to do this right. And of course I'm willing
>>> to do it right. IMHO the 3 options summarized by Connie are not the only
>>> options. But if we go for reworking our QOM composition tree, it will take
>>> a lot of discussion. I'm not sure all the required people have enough spare
>>> time for that.
>>>
>>> Halil  
>>
>> I am actually not sure if we really want to have a "user-definable default css" anytime
>> soon. I think it might really open a can of worms in regard to management tooling.
> 
> Fair enough, there's really no short-term use case.
> 
>> What I want now is to enable vfio-ccw for libvirt and Linux guests and for that
>> we need to lift the restriction of having vfio not in FE.
> 
> This, however, worries me. I don't really consider vfio-ccw ready for
> prime time yet. We still need to figure out path handling at the very
> least. And I'm still not sure that our non-handling of halt/clear won't
> cause major issues with e.g. a storage server error recovery.
> 
> Can we flag vfio-ccw as experimental or such in libvirt?

We should have flagged vfio-ccw experimental in QEMU then.
e.g. by using x-vfio-ccw or whatever.I dont think we can do that
after the facts.

I am not that deep into vfio-ccw, but I was under the impression that
the missing features should not affect the vfio interface that is
created by libvirt. After all this should just be a "-device vfio-ccw,....."
statement and some setup steps beforehand (unbind + setup of vfio-ccw)

If your concern is the serviceability I think it would be valid for a RHEL
KVM to disable vfio-ccw in the kernel. Maybe we could even provide a config
for QEMU?


PS: I learned from the PCI and CCW experience that I do not want
to upstream kernel/qemu code unless I have a working libvirt code that
shows that the thing will work.
