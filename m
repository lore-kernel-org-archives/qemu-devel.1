Received: from eggs.gnu.org ([2001:4830:134:3::10]:58010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f8VEf-0007ld-Q7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f8VEc-0005GG-L5
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:21:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f8VEc-0005FJ-C9
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:21:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3HIHNKG011483
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:21:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hdp2pg66e-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:21:39 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 17 Apr 2018 19:21:37 +0100
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1808b8f3-9cff-c849-d012-b23f29d1c11f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 17 Apr 2018 20:21:31 +0200
MIME-Version: 1.0
In-Reply-To: <1808b8f3-9cff-c849-d012-b23f29d1c11f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <354ba31f-7502-b873-e254-fe3dbfc07b54@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net



On 04/16/2018 05:44 PM, David Hildenbrand wrote:
> 
>>  
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 0cdbc15..0d5b0f7 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] = {
>>      S390_FEAT_ADAPTER_INT_SUPPRESSION,
>>      S390_FEAT_EDAT_2,
>>      S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>> +    S390_FEAT_AP_FACILITIES_TEST,
>> +    S390_FEAT_AP,
>>  };
>>  
> 
> Now I have to ask a very stupid question:
> 
> I heard that the execution controls in the SIE block for AP are one of
> the oldest ones we have around. How can it be that the AP feature cannot
> be used before zEC12?

It was a suggestion from the crypto team due to testability. Nobody has a z196
with the older cards.
