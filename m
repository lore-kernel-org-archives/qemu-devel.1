Received: from eggs.gnu.org ([2001:4830:134:3::10]:60189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebvPL-00080K-E6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebvPG-0004N6-Gj
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:38:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36374
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ebvPG-0004Mc-C0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:38:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HLXt9B134321
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:38:01 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fjabm3jre-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:38:00 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 21:37:58 -0000
References: <20180117193757.73471-1-borntraeger@de.ibm.com>
	<20180117193757.73471-4-borntraeger@de.ibm.com>
	<e1579c11-9a30-7035-16f6-ad047108260c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 22:37:54 +0100
MIME-Version: 1.0
In-Reply-To: <e1579c11-9a30-7035-16f6-ad047108260c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7cc4f08f-2d40-1a1a-0e52-71cb310c3c0a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/kvm: provide stfle.81
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 01/17/2018 10:13 PM, David Hildenbrand wrote:
> On 17.01.2018 20:37, Christian Borntraeger wrote:
>> stfle.81 (ppa15) is a transparent facility that can be passed to the
>> guest without the need to implement hypervisor support. As this feature
>> can be provided by firmware we add it to all full models.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu_features.c     | 1 +
>>  target/s390x/cpu_features_def.h | 1 +
>>  target/s390x/gen-features.c     | 1 +
>>  3 files changed, 3 insertions(+)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 5d1c210..1550ab0 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
>>      FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
>>      FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
>> +    FEAT_INIT("ppa15", S390_FEAT_TYPE_STFL, 81, "PPA15 is installed"),
>>      FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
>>      FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
>>      FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
>> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
>> index 4487cfd..4d93087 100644
>> --- a/target/s390x/cpu_features_def.h
>> +++ b/target/s390x/cpu_features_def.h
>> @@ -80,6 +80,7 @@ typedef enum {
>>      S390_FEAT_MSA_EXT_4,
>>      S390_FEAT_EDAT_2,
>>      S390_FEAT_DFP_PACKED_CONVERSION,
>> +    S390_FEAT_PPA15,
>>      S390_FEAT_BPB,
>>      S390_FEAT_VECTOR,
>>      S390_FEAT_INSTRUCTION_EXEC_PROT,
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 95ee870..50bd3f4 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -357,6 +357,7 @@ static uint16_t full_GEN7_GA1[] = {
>>      S390_FEAT_SIE_GPERE,
>>      S390_FEAT_SIE_IB,
>>      S390_FEAT_SIE_CEI,
>> +    S390_FEAT_PPA15,
>>      S390_FEAT_BPB,
> 

> Is the order in this list still correct?

Is the order in this array important as well? It seems to work fine. At least PPA15 is correctly
ordered vs BPB.
