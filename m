Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dlGB6-0003Mn-Kf
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dlGB1-0006NA-GT
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:05:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dlGB0-0006Lr-Pc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:05:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7PF4eD5021444
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:05:34 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cjkus202t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:05:34 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 25 Aug 2017 09:05:33 -0600
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 11:05:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170825160408.2775c8b5.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, farman@linux.vnet.ibm.com, walling@linux.vnet.ibm.com



On 08/25/2017 10:04 AM, Cornelia Huck wrote:
> On Fri, 25 Aug 2017 09:24:46 -0400
> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>
>> The commit 198c0d1f9df8c4 s390x/css: check ccw address validity
>> exposes an alignment issue in ccw bios.
>>
>> According to PoP the CCW must be doubleword aligned. Let's fix
>> this in the bios.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  pc-bios/s390-ccw/cio.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
>> index f5b4549..55eaeee 100644
>> --- a/pc-bios/s390-ccw/cio.h
>> +++ b/pc-bios/s390-ccw/cio.h
>> @@ -133,7 +133,7 @@ struct ccw1 {
>>      __u8 flags;
>>      __u16 count;
>>      __u32 cda;
>> -} __attribute__ ((packed));
>> +} __attribute__ ((packed, aligned(8)));
>>
>>  #define CCW_FLAG_DC              0x80
>>  #define CCW_FLAG_CC              0x40
>
> Currently testing.
>
> This looks obviously right, but did you figure out what the (probably
> unrelated) other failure was?
>

That is still under investigation, for some reason it only fails for an 
LDL DASD and it works for SCSIs and CDL DASD.
