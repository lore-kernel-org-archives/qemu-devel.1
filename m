Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmK23-0004iA-Of
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmK1y-000329-Qx
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:24:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dmK1y-000323-LL
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:24:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7SDOakr112811
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 09:24:41 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmjmxp0at-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 09:24:39 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 28 Aug 2017 14:24:14 +0100
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
	<00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
	<20170828102214.7aad9112.cohuck@redhat.com>
	<caab4ec1-763a-8dfb-5e88-295a43a41e68@linux.vnet.ibm.com>
	<20170828150653.7cdc8c5a.cohuck@redhat.com>
	<c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 28 Aug 2017 15:24:11 +0200
MIME-Version: 1.0
In-Reply-To: <c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c61c8ee1-3bca-41db-33a7-b65186a80d25@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, pasic@linux.vnet.ibm.com, farman@linux.vnet.ibm.com, walling@linux.vnet.ibm.com




On 08/28/2017 03:18 PM, Farhan Ali wrote:
> 
> 
> On 08/28/2017 09:06 AM, Cornelia Huck wrote:
>> On Mon, 28 Aug 2017 08:56:42 -0400
>> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>
>>> On 08/28/2017 04:22 AM, Cornelia Huck wrote:
>>>> On Fri, 25 Aug 2017 11:05:30 -0400
>>>> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>>>
>>>>> On 08/25/2017 10:04 AM, Cornelia Huck wrote:
>>>>>> On Fri, 25 Aug 2017 09:24:46 -0400
>>>>>> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>>>>>>
>>>>>>> The commit 198c0d1f9df8c4 s390x/css: check ccw address validity
>>>>>>> exposes an alignment issue in ccw bios.
>>>>>>>
>>>>>>> According to PoP the CCW must be doubleword aligned. Let's fix
>>>>>>> this in the bios.
>>>>>>>
>>>>>>> Cc: qemu-stable@nongnu.org
>>>>>>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>>>>>>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>>>> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
>>>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>>> ---
>>>>>>>  pc-bios/s390-ccw/cio.h | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
>>>>>>> index f5b4549..55eaeee 100644
>>>>>>> --- a/pc-bios/s390-ccw/cio.h
>>>>>>> +++ b/pc-bios/s390-ccw/cio.h
>>>>>>> @@ -133,7 +133,7 @@ struct ccw1 {
>>>>>>>      __u8 flags;
>>>>>>>      __u16 count;
>>>>>>>      __u32 cda;
>>>>>>> -} __attribute__ ((packed));
>>>>>>> +} __attribute__ ((packed, aligned(8)));
>>>>>>>
>>>>>>>  #define CCW_FLAG_DC              0x80
>>>>>>>  #define CCW_FLAG_CC              0x40
>>>>>>
>>>>>> Currently testing.
>>>>>>
>>>>>> This looks obviously right, but did you figure out what the (probably
>>>>>> unrelated) other failure was?
>>>>>>
>>>>>
>>>>> That is still under investigation, for some reason it only fails for an
>>>>> LDL DASD and it works for SCSIs and CDL DASD.
>>>>
>>>> Which are the symptoms of the failure? I'd like to understand this
>>>> before I update the (currently working by accident) bios with an
>>>> updated version.
>>>>
>>>> I'll just apply the patch for now.
>>>>
>>>
>>> Well it's seems like the failure for LDL DASD could be a disk setup
>>> failure. We tried the test on a different environment with LDL disks and
>>> everything worked fine with the patch applied.
>>
>> Odd that it breaks after this change, though. Do you get command
>> rejects, or what happens?
>>
> 
> It's the alignment of the CCW which causes the problem.
> 
> The exact error message when starting the guest was:
> 
> ! No virtio device found !
> 
> Since it worked for SCSI and CDL, and failed for LDL disks on that particular system, we are not really sure what caused the failure.
> Debugging it further showed the CCW for LDL disks were not aligned at double word boundary.
> 
> Trying the test on a different system with LDL disks worked fine, with the aligned(8) fix.

Do you happen to have an old s390-ccw.img laying around in the test folder? QEMU might pick up 
this one (e.g. when calling it without libvirt from the command line).
