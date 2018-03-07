Received: from eggs.gnu.org ([2001:4830:134:3::10]:47784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1etc7X-0007BX-EU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1etc7S-0003Gx-GW
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:40:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1etc7S-0003Gh-7F
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:40:46 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27GeYPM071217
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 11:40:44 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gjkd216yc-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 11:40:39 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 16:40:18 -0000
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
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 17:40:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180307154151.4e51b2fb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <47414709-fa95-5cbe-4513-82433a69e881@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 07/03/2018 15:41, Cornelia Huck wrote:
> On Wed, 7 Mar 2018 11:09:46 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> What I mean is the reverse implication
>>
>> ECA_APIE =3D> ap=3Don
>>
>> But you can have ap =3D on and ECA_APIE =3D off
>> This is interception or emulation.
>>
>> and the second thing is that we need two QEMU cpu features
>> AP : guest API to say we provide AP instructions to the guest (what ev=
er
>> we do to provide it)
>> ECA_APIE : kernel will setup the SIE with interpretation
>>
>> other said:
>> if( !ap)
>>   =C2=A0=C2=A0=C2=A0 return -ENODEVICE
>> if(ECA_API)
>>   =C2=A0=C2=A0=C2=A0 set_interpretation()
>> else
>>   =C2=A0=C2=A0=C2=A0 set_interception()
> This discussion is giving me a headache, so let's take a step back and
> figure out what is needed/wanted/possible.
>
> * straight passthrough of tuples, SIE doing the heavy lifting
>    -> what this patchset is doing, and should be fine, even regarding
>       nesting
>
> * remapping of tuples, SIE doing most of the work

Currently the SIE do not allow remapping.
Only interception can allow remapping.

> (IIRC it's possible
>    to only intercept for a subset of instructions?)

More than possible: some AP instructions, when existing, are always=20
intercepted and some
other are intercepted based on a specific condition and on STFLE bits=20
but for them
SIE Execution control bit is ignored.

However, we do not use these instructions in this patch series.

>    -> that's where it gets complicated, and IIUC we can't have any mixe=
d
>       straight/remap setups, and we may have issues regarding nesting

We do not have issues regarding nesting, we can not nest
a guest doing SIE interpretation inside another doing interception.
It is an architectural design, not an issue.

To guaranty this, the architecture provide Effective Execution Control,
EEC.

The handling of ECA28 for guests execution is combined into a
single description, the EECA, when operating at guest level 2
the EECA.28 is the logical AND of the guest level 1 ECA.28 and the
guest level 2 ECA.28

When using vSIE we need to propagate this handling.

>    Question: How important is that use case? Can we drop it and make ou=
r
>    lives much easier?

AFAIK, and as long as my information is up to date, we can not close the=20
door to interception.

In other word, we need to separate the CPU feature defining "if AP=20
instructions are available"
from the QEMU property defining "How we provide the instructions".

ECA28 obviously belongs to the "how" and not to the "if".



>
> * full emulation (which would be the only option for tcg, obviously)
>    -> even if it were doable, I doubt it would be very useful
>    It would be great if we could have a design that would also
>    accommodate this (and I have rooted for that in the past), but the
>    more I hear about the issues here, the more I doubt whether this is
>    something we should spend time on.
>
> Another question: Can some of the use cases be serviced via
> virtio-crypto as well (clear key)? Would that in combination with
> straight passthrough be enough?
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
