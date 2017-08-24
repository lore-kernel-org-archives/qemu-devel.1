Received: from eggs.gnu.org ([2001:4830:134:3::10]:50230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dkw5h-0005TV-Fp
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dkw5c-0004nK-Ao
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:38:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dkw5c-0004mq-1t
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:38:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OHa8QB047687
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 13:38:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chyfuy23a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 13:38:41 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 13:38:40 -0400
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
	<30333b41-508d-f9a3-ac2d-4830a7791475@redhat.com>
	<34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
	<ad0ef5a7-c0e0-9e54-a417-858c4b32a80e@redhat.com>
	<c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
	<CAFEAcA-oE=E3ydugLdVnPS2Tquqkou=BEhsB_DALqZxbVD0GDA@mail.gmail.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 13:38:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oE=E3ydugLdVnPS2Tquqkou=BEhsB_DALqZxbVD0GDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e24316e0-3b6f-ef1c-7c4b-66e7b302e5b4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>



On 08/24/2017 12:07 PM, Peter Maydell wrote:
> On 24 August 2017 at 16:53, Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>
>>
>> On 08/24/2017 11:50 AM, Thomas Huth wrote:
>>> True, so that could still be an issue. Looking at the cio.h in the
>>> kernel, they define the struct like this:
>>>
>>> struct ccw1 {
>>>         __u8  cmd_code;
>>>         __u8  flags;
>>>         __u16 count;
>>>         __u32 cda;
>>> } __attribute__ ((packed,aligned(8)));
>>>
>>> So I guess adding the aligned(8) is the right way to go?
>
>> This was my initial fix and it works on my system. But for some reason this
>> fix does not work on my colleague's system. So I am hesitant about
>> submitting this fix
>
> It seems like it ought to be the obvious fix, so I would double
> check that on your colleague's system the change really did
> get recompiled and it's actually using the new version (that
> sort of mistake can be easy to make and very confusing...)
>
> thanks
> -- PMM
>

So after trying again with the fix, it seems to work on my colleague's 
system for most cases. It fails for LDL DASD boot case.... we are still 
investigating it.
