Received: from eggs.gnu.org ([2001:4830:134:3::10]:55129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6yM-0008Ag-IN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6yJ-0002MV-FQ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:41:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dx6yJ-0002M9-93
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:41:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R7OVvZ007841
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:41:28 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d865x4wuc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:41:27 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 08:41:26 +0100
References: <20170926180522.68482-1-borntraeger@de.ibm.com>
	<67c13b99-2d44-666b-9328-05917d0fc0dc@redhat.com>
	<20170927093959.3f61dd36.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 09:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170927093959.3f61dd36.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b8704df5-9c1d-1aed-2adf-f783a66a5eeb@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodel: remove ais from z14
 default model-> also for 2.10.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>



On 09/27/2017 09:39 AM, Cornelia Huck wrote:
> On Tue, 26 Sep 2017 20:26:31 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 26.09.2017 20:05, Christian Borntraeger wrote:
>>> We disabled ais for 2.10 lets also remove it from the z14 default model.
>>>
>>> Fixes: 3f2d07b3b01e  s390x/ais: for 2.10 stable: disable ais facility
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  target/s390x/gen-features.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>>> index c8dc104..68e6c31 100644
>>> --- a/target/s390x/gen-features.c
>>> +++ b/target/s390x/gen-features.c
>>> @@ -527,7 +527,6 @@ static uint16_t default_GEN13_GA1[] = {
>>>  #define default_GEN13_GA2 EmptyFeat
>>>  
>>>  static uint16_t default_GEN14_GA1[] = {
>>> -    S390_FEAT_ADAPTER_INT_SUPPRESSION,
>>>      S390_FEAT_INSTRUCTION_EXEC_PROT,
>>>      S390_FEAT_GUARDED_STORAGE,
>>>      S390_FEAT_VECTOR_PACKED_DECIMAL,
>>>   
>>
>> Yes, this has to go into stable, otherwise the migration safe stable
>> model would be changed.
>>
>> Apart from that, this looks just fine.
> 
> So, this should go into stable only, as the patches currently on the
> list will fix this properly for 2.11, right?

No this also has to go into 2.11 (otherwise the default model for z14 would differ)
so maybe change the subject when applying.
