Received: from eggs.gnu.org ([2001:4830:134:3::10]:38838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fT2IC-0004TR-Da
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fT2I8-0000LY-Ek
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40684
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fT2I8-0000L5-8q
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5D9e41u027149
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:42:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jjxcgpjd5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:42:11 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 13 Jun 2018 10:42:09 +0100
References: <20180613081819.147178-1-borntraeger@de.ibm.com>
	<ec5d62ca-4096-470a-74f5-a6679c09cc6d@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Jun 2018 11:42:05 +0200
MIME-Version: 1.0
In-Reply-To: <ec5d62ca-4096-470a-74f5-a6679c09cc6d@redhat.com>
Content-Language: en-US
Message-Id: <9078c90f-af39-7fe7-d723-50aedb58cc14@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodels: add z14 Model ZR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 06/13/2018 11:00 AM, David Hildenbrand wrote:
> On 13.06.2018 10:18, Christian Borntraeger wrote:
>> introduce the new z14 Model ZR1 cpu model. Mostly identical to z14, only
>> the cpu type differs (3906 vs. 3907)
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu_models.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index e10035aaa8..cfdbccf46d 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] = {
>>      CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
>>      CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
>>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>> +    CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>>  };
>>  
>>  #define QEMU_MAX_CPU_TYPE 0x2827
>>
> 
> This is the first time that we have two different EC variants (different
> CPU type) with the same HW gen and GA level .
> 
> Are they really completely equal (esp. the IBC value? that is used for
> model detection) apart from the CPU type?
> 
> check_unavailable_features()/arch_query_cpu_model_comparison() will
> treat both models as equal (meaning one can run on the other).
> 
> arch_query_cpu_model_baseline() might produce a z14ZR1-base when
> baselining e.g. a z14 and a z14ZR1 (don't think this is a problem), as
> s390_find_cpu_def() will always try to walk as far as possible in the
> cpu model definition table.
> 
Yes, we can run z14ZR1 on Z14 and vice versa.


s390_find_cpu_def has this

        /* stop the search if we found the exact model */
        if (def->type == type && def->ec_ga == ec_ga) {
            return def;
        }

So we should always get the best fit, no?
