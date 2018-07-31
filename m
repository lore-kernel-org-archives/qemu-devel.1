Received: from eggs.gnu.org ([2001:4830:134:3::10]:54994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkRjE-0005xA-U8
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkRj9-0001aB-JB
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:18:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34008
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fkRj9-0001ZU-Bl
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:18:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VA9FMm090955
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:18:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kjm67cgn2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:18:02 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 31 Jul 2018 11:18:00 +0100
References: <20180731090448.36662-1-borntraeger@de.ibm.com>
	<20180731090448.36662-3-borntraeger@de.ibm.com>
	<20180731113723.65473b77.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 12:17:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180731113723.65473b77.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <5a9f98e9-9617-7ef0-f5c5-1c60945fb9e7@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: add etoken facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>



On 07/31/2018 11:37 AM, Cornelia Huck wrote:
> On Tue, 31 Jul 2018 11:04:48 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Provide the etoken facility. We need to handle cpu model, migration and
>> clear reset.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/cpu.h              |  3 +++
>>  target/s390x/cpu_features.c     |  3 ++-
>>  target/s390x/cpu_features_def.h |  3 ++-
>>  target/s390x/gen-features.c     |  3 ++-
>>  target/s390x/kvm.c              | 11 +++++++++++
>>  target/s390x/machine.c          | 20 +++++++++++++++++++-
>>  6 files changed, 39 insertions(+), 4 deletions(-)
> 
>> @@ -106,6 +106,7 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
>>      FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
>>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
>> +    FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "etoken facility"),
> 
> Don't facilities usually start with a capital letter?

Yes, we should make it Etoken.
> 
>>  
>>      /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
>>      FEAT_INIT("gsls", S390_FEAT_TYPE_SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility"),
> 
