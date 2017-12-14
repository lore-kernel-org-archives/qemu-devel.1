Received: from eggs.gnu.org ([2001:4830:134:3::10]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ePb4y-0007B1-OA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 16:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ePb4s-0001X3-Us
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 16:30:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56948
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ePb4s-0001Wb-Or
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 16:30:02 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBELTOV6070440
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 16:30:00 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2euwvjfnc0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 16:29:59 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 14 Dec 2017 16:29:59 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-3-git-send-email-walling@linux.vnet.ibm.com>
	<20171214184157.21fbe3b8.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 14 Dec 2017 16:29:56 -0500
MIME-Version: 1.0
In-Reply-To: <20171214184157.21fbe3b8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <d8198f85-eaed-c0e3-ba61-349f4bc2e0cc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/5] s390-ccw: ipl structs
 for eckd cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On 12/14/2017 12:41 PM, Cornelia Huck wrote:
> On Mon, 11 Dec 2017 17:19:17 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>
>> ECKD DASDs have different IPL structures for CDL and LDL
>> formats. The current Ipl1 and Ipl2 structs follow the CDL
>> format, so we prepend "EckdCdl" to them. Boot info for LDL
>> has been moved to a new struct: EckdLdlIpl1.
>>
>> Also introduce structs for IPL stages 1 and 1b and for
>> disk geometry.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 24 ++++++++++----------
>>   pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
>>   2 files changed, 53 insertions(+), 26 deletions(-)
>>
>> +    mbr_block_nr =
>> +        eckd_block_num((void *)&(ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr));
> Let me nominate this as "crazy nested struct of the week".
>
> (Just kidding, your patch certainly improves things in general :)


Haha, well I am honored! (Cannot take full credit -- it was quite crazy 
before :)


>
>
>> +typedef struct EckdSeekarg {
>> +    uint16_t pad;
>> +    uint16_t cyl;
>> +    uint16_t head;
>> +    uint8_t sec;
>> +    uint8_t pad2;
>> +} __attribute__ ((packed)) EckdSeekarg;
> Maybe make this EckdSeekArg?
>


I'm pretty sure "Seekarg" is not a word, so your suggestion makes sense.
(plus it reads better imo)


-- 
- Collin L Walling
