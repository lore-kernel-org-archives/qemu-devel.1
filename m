Received: from eggs.gnu.org ([2001:4830:134:3::10]:51665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dmlWU-0003gp-KP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dmlWR-0001bp-A5
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:46:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1dmlWR-0001aw-1I
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:45:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7TIiEnN110514
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 14:45:57 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cna46c6qu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 14:45:57 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 14:45:55 -0400
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
	<00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
	<20170828102214.7aad9112.cohuck@redhat.com>
	<caab4ec1-763a-8dfb-5e88-295a43a41e68@linux.vnet.ibm.com>
	<20170828150653.7cdc8c5a.cohuck@redhat.com>
	<c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
	<c61c8ee1-3bca-41db-33a7-b65186a80d25@de.ibm.com>
	<b5a9ab05-4e3c-66bc-33ce-d953d7f911e2@linux.vnet.ibm.com>
	<20170828160554.45855dfa.cohuck@redhat.com>
	<e3f0c9c1-b576-b9bb-66e2-53c2ef94b91b@linux.vnet.ibm.com>
	<9b9880e4-71fd-4bc5-961b-ab0e2b298f03@linux.vnet.ibm.com>
	<3421f46f-fa82-ac23-b0ac-5a2acce26d41@linux.vnet.ibm.com>
	<20170829140429.08a1731c.cohuck@redhat.com>
	<ffe9c512-4238-7456-27d2-cdc8fa39d8e0@linux.vnet.ibm.com>
	<20170829144533.54891819.cohuck@redhat.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 14:45:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170829144533.54891819.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f2aaa9ff-d98a-b8fe-aff8-f5d931e10643@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, walling@linux.vnet.ibm.com, qemu-devel@nongnu.org



On 08/29/2017 08:45 AM, Cornelia Huck wrote:
> On Tue, 29 Aug 2017 08:39:27 -0400
> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
> 
>> On 08/29/2017 08:04 AM, Cornelia Huck wrote:
>>> On Mon, 28 Aug 2017 10:28:53 -0400
>>> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 08/28/2017 10:19 AM, Halil Pasic wrote:
>>>>>
>>>>>
>>>>> On 08/28/2017 04:15 PM, Farhan Ali wrote:
>>>>>>
>>>>>>
>>>>>> On 08/28/2017 10:05 AM, Cornelia Huck wrote:
>>>>>>>>>> It's the alignment of the CCW which causes the problem.
>>>>>>>>>>
>>>>>>>>>> The exact error message when starting the guest was:
>>>>>>>>>>
>>>>>>>>>> ! No virtio device found !
>>>>>>>>>>
>>>>>>>>>> Since it worked for SCSI and CDL, and failed for LDL disks on that particular system, we are not really sure what caused the failure.
>>>>>>>>>> Debugging it further showed the CCW for LDL disks were not aligned at double word boundary.
>>>>>>> This is really, really odd, as the low-level ccw code is the same for
>>>>>>> any disk type...
>>>>>>>   
>>>>>> Exactly!
>>>>>>   
>>>>>>>>>> Trying the test on a different system with LDL disks worked fine, with the aligned(8) fix.
>>>>>>>>> Do you happen to have an old s390-ccw.img laying around in the test folder? QEMU might pick up
>>>>>>>>> this one (e.g. when calling it without libvirt from the command line).
>>>>>>>>>   
>>>>>>>> I explicitly mention the bios to use with '-bios' option and pick up the
>>>>>>>> latest bios. Without the aligned fix I see the error and with the fix it
>>>>>>>> works fine.
>>>>>>> Wait, so the fix fixes it? Or am I confused now?
>>>>>>>   
>>>>>>
>>>>>> It fixes in my system and one other system we tried on. But fails on a system where this issue was first noticed.
>>>>>
>>>>> This is very confusing. So you have tried -bios on the system
>>>>> where the issue was first noticed and the issue still persists
>>>>> despite of the fixed bios is specified?
>>>>>   
>>>> Yes.
>>>>
>>>> The system where the issue was first noticed, applying the fix for the
>>>> bios, fixes for:
>>>>
>>>> 1) CDL disks
>>>> 2) SCSI disks
>>>>
>>>> But fails for LDL disk.
>>>>
>>>> On my system and one other system, the fix works for all the disk types,
>>>> CDL, SCSI and LDL and fixes the issue.
>>>
>>> Are you using different toolchains on the failing and the working
>>> systems? Does it work when you copy the bios from a working system? >>>
>>> (Clutching at straws here...)
>>>   
>>
>> So yesterday we realized for the failing system, the bios wasn't being
>> built on that system rather it was being built on a different system and
>> being copied over to the failing system. :/

Not sure I understand this.  I thought the bios was being built on the 
system it would be used on, with the source residing on a shared disk 
mounted via NFS.

> 
> Oh dear... the system it was built on hopefully was missing the fix,
> right? (I'm getting a bit paranoid here.)
> 

I was also getting paranoid watching this.  So I did some poking...  It 
looks exactly like Peter suggested last week:

https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04822.html

There were multiple $QEMUSRC directories on this system.  At least one 
2.9.xx version didn't have commit 198c0d1f9df8c4 (and thus wouldn't care 
about the boundary alignment), while others did.  The aligned(8) fix 
described here was not applied universally, resulting in, uh, 
inconsistent results.  Shared systems are fun.  :)

After a little cleanup, the results from that system match what the rest 
of us have seen/expected.

>>
>> Building the bios on the failing system with the fix, resolves the issue
>> and we did not see anymore failures.
>> So I think I can safely say this patch fixes the alignment problem.
> 
> Out of interest, which toolchain are you using? My rebuild is on F26.
> 

F24 on the problematic system, F25 on mine, but this was a red herring.

  - Eric
