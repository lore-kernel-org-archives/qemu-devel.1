Received: from eggs.gnu.org ([209.51.188.92]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1tkp-0000w7-DS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1tkn-0003Nj-99
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:12:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34436
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1tkn-0003NB-2D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:12:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27EBjoD045877
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 09:12:08 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r31vtspup-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:12:05 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 7 Mar 2019 14:11:59 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-10-git-send-email-jjherne@linux.ibm.com>
	<e6f488bd-a83d-c550-857b-f1cacf73eccd@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 7 Mar 2019 09:11:53 -0500
MIME-Version: 1.0
In-Reply-To: <e6f488bd-a83d-c550-857b-f1cacf73eccd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d61d7122-dd44-17b4-f865-fa09cbef9b00@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 09/16] s390-bios: ptr2u32
 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/5/19 2:22 AM, Thomas Huth wrote:
> On 01/03/2019 19.59, Jason J. Herne wrote:
>> Introduce inline functions to convert between pointers and unsigned 32-bit
>> ints. These are used to hide the ugliness required to  avoid compiler
>> warnings.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   pc-bios/s390-ccw/helper.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>   create mode 100644 pc-bios/s390-ccw/helper.h
>>
>> diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
>> new file mode 100644
>> index 0000000..b8bc61b
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/helper.h
>> @@ -0,0 +1,16 @@
>> +#ifndef S390_CCW_HELPER_H
>> +#define S390_CCW_HELPER_H
>> +
>> +/* Avoids compiler warnings when casting a pointer to a u32 */
>> +static inline uint32_t ptr2u32(void *ptr)
>> +{
> 
> Would it make sense to add an IPL_assert(ptr <= 0xffffffff) here?
> 

I'm not sure... I remember something about the bios always having to be below the 2^32 
memory line. But I suppose it doesn't hurt to add the assert anyway. Then, someday, if my 
assumption proves not to be true or someone changes that assumption we are still covered.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
