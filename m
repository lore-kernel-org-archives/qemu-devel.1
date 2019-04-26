Received: from eggs.gnu.org ([209.51.188.92]:55889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyvw-0004o5-8G
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyvu-0001kt-FX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:22:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37530
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJyvu-0001gV-9u
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:22:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QBH7Qv115604
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:22:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s40yk85ga-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:22:20 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:22:19 +0100
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
	<f0984d7f-9a9e-49fd-1466-0b2d1fa8a058@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 26 Apr 2019 13:22:13 +0200
MIME-Version: 1.0
In-Reply-To: <f0984d7f-9a9e-49fd-1466-0b2d1fa8a058@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d21da570-fe54-00ae-0ad5-e2b226e042c3@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/10] s390x/cpumodel: wire up 8561 and
 8562 as gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>



On 26.04.19 13:21, David Hildenbrand wrote:
> On 26.04.19 13:10, Christian Borntraeger wrote:
>> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
>> the cpu id as base name. Later on we can provide aliases with the proper
>> name.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu_models.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index d683635eb5..dd6415103f 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -83,6 +83,8 @@ static S390CPUDef s390_cpu_defs[] = {
>>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"),
>> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"),
>>  };
>>  
>>  #define QEMU_MAX_CPU_TYPE 0x2827
>>
> 
> Can you fixup the comment at the beginning of the definitions, stating
> that base features of new HW are no longer a superset?

Will do.
