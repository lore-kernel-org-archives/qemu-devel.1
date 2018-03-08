Received: from eggs.gnu.org ([2001:4830:134:3::10]:57897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1etwAd-0007GG-SU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1etwAZ-00053V-Dp
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:05:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51868
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1etwAZ-00052X-7K
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:05:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w28DsP28017360
	for <qemu-devel@nongnu.org>; Thu, 8 Mar 2018 09:05:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gk676h6gy-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 09:05:17 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 8 Mar 2018 07:05:15 -0700
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
	<c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
	<c0ff3874-e933-e30b-bc37-60abc4732a23@linux.vnet.ibm.com>
	<05cd3b46-1fa6-6cf6-b414-5dfa2af13105@redhat.com>
	<36825fd8-fb91-069a-01d7-520a97c743d9@linux.vnet.ibm.com>
	<20180307154151.4e51b2fb.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 8 Mar 2018 09:05:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180307154151.4e51b2fb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <de4a56d3-b204-066f-0d51-c6a6ade13a8c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 03/07/2018 09:41 AM, Cornelia Huck wrote:
> On Wed, 7 Mar 2018 11:09:46 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> What I mean is the reverse implication
>>
>> ECA_APIE => ap=on
>>
>> But you can have ap = on and ECA_APIE = off
>> This is interception or emulation.
>>
>> and the second thing is that we need two QEMU cpu features
>> AP : guest API to say we provide AP instructions to the guest (what ever
>> we do to provide it)
>> ECA_APIE : kernel will setup the SIE with interpretation
>>
>> other said:
>> if( !ap)
>>       return -ENODEVICE
>> if(ECA_API)
>>       set_interpretation()
>> else
>>       set_interception()
> This discussion is giving me a headache, so let's take a step back and
> figure out what is needed/wanted/possible.
>
> * straight passthrough of tuples, SIE doing the heavy lifting
>    -> what this patchset is doing, and should be fine, even regarding
>       nesting
>
> * remapping of tuples, SIE doing most of the work (IIRC it's possible
>    to only intercept for a subset of instructions?)
Under the current architecture, instructions are either interpreted (with
some instructions being intercepted under specific conditions) or 
intercepted.
Therefore, when remapping tuples, it will be necessary to intercept all
instructions.
>    -> that's where it gets complicated, and IIUC we can't have any mixed
>       straight/remap setups, and we may have issues regarding nesting
As I said above, under the current architecture instructions are either
interpreted (ECA.28 is set) or intercepted (ECA.28 is cleared). 
Consequently,
we can't mix guests that use interpretation with guests that don't.
>    Question: How important is that use case? Can we drop it and make our
>    lives much easier?
We've already had requests.
>
> * full emulation (which would be the only option for tcg, obviously)
>    -> even if it were doable, I doubt it would be very useful
>    It would be great if we could have a design that would also
>    accommodate this (and I have rooted for that in the past), but the
>    more I hear about the issues here, the more I doubt whether this is
>    something we should spend time on.
If I'm not mistaken, the discussions about full emulation centered around
problems related to second level guests (VSIE). It seems possible to
employ full emulation for guest level 1. I'm not in a position to say
whether it would be worth the effort or not.
>
> Another question: Can some of the use cases be serviced via
> virtio-crypto as well (clear key)? Would that in combination with
> straight passthrough be enough?
I don't know enough about virtio-crypto to say.
>
