Received: from eggs.gnu.org ([2001:4830:134:3::10]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebvkb-0007NP-Jv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 17:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebvkX-0001qS-Od
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 17:00:05 -0500
References: <20180117193757.73471-1-borntraeger@de.ibm.com>
	<20180117193757.73471-4-borntraeger@de.ibm.com>
	<e1579c11-9a30-7035-16f6-ad047108260c@redhat.com>
	<7cc4f08f-2d40-1a1a-0e52-71cb310c3c0a@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7aa14ddf-769f-2c79-4ca4-fa4b0aa65347@redhat.com>
Date: Wed, 17 Jan 2018 22:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <7cc4f08f-2d40-1a1a-0e52-71cb310c3c0a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/kvm: provide stfle.81
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 17.01.2018 22:37, Christian Borntraeger wrote:
> 
> 
> On 01/17/2018 10:13 PM, David Hildenbrand wrote:
>> On 17.01.2018 20:37, Christian Borntraeger wrote:
>>> stfle.81 (ppa15) is a transparent facility that can be passed to the
>>> guest without the need to implement hypervisor support. As this feature
>>> can be provided by firmware we add it to all full models.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  target/s390x/cpu_features.c     | 1 +
>>>  target/s390x/cpu_features_def.h | 1 +
>>>  target/s390x/gen-features.c     | 1 +
>>>  3 files changed, 3 insertions(+)
>>>
>>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>>> index 5d1c210..1550ab0 100644
>>> --- a/target/s390x/cpu_features.c
>>> +++ b/target/s390x/cpu_features.c
>>> @@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
>>>      FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
>>>      FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
>>>      FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
>>> +    FEAT_INIT("ppa15", S390_FEAT_TYPE_STFL, 81, "PPA15 is installed"),
>>>      FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
>>>      FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
>>>      FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
>>> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
>>> index 4487cfd..4d93087 100644
>>> --- a/target/s390x/cpu_features_def.h
>>> +++ b/target/s390x/cpu_features_def.h
>>> @@ -80,6 +80,7 @@ typedef enum {
>>>      S390_FEAT_MSA_EXT_4,
>>>      S390_FEAT_EDAT_2,
>>>      S390_FEAT_DFP_PACKED_CONVERSION,
>>> +    S390_FEAT_PPA15,
>>>      S390_FEAT_BPB,
>>>      S390_FEAT_VECTOR,
>>>      S390_FEAT_INSTRUCTION_EXEC_PROT,
>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>>> index 95ee870..50bd3f4 100644
>>> --- a/target/s390x/gen-features.c
>>> +++ b/target/s390x/gen-features.c
>>> @@ -357,6 +357,7 @@ static uint16_t full_GEN7_GA1[] = {
>>>      S390_FEAT_SIE_GPERE,
>>>      S390_FEAT_SIE_IB,
>>>      S390_FEAT_SIE_CEI,
>>> +    S390_FEAT_PPA15,
>>>      S390_FEAT_BPB,
>>
> 
>> Is the order in this list still correct?
> 
> Is the order in this array important as well? It seems to work fine. At least PPA15 is correctly
> ordered vs BPB.
> 

Purely style. (when introducing, I tried to keep features in the same
order as defined in target/s390x/cpu_features_def.h )

So feel free to keep the order (or I'll clean this up again one day).

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
