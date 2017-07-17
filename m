Received: from eggs.gnu.org ([2001:4830:134:3::10]:51882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXAVH-0001Xj-5M
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXAVD-00036R-QZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:12:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33219
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXAVD-000362-KK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:12:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6HI9F0R082453
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:12:15 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2brpbtg5jc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:12:14 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 17 Jul 2017 12:12:14 -0600
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-38-git-send-email-borntraeger@de.ibm.com>
	<e6bcec43-a424-1964-d025-7e5bd7985e33@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Jul 2017 20:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <e6bcec43-a424-1964-d025-7e5bd7985e33@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <5b206cb2-1a61-abb7-16d1-1fe89b0ef0e8@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 37/40] s390x/kvm: Enable KSS facility for
 nested virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 07/17/2017 07:35 PM, David Hildenbrand wrote:
> On 14.07.2017 12:41, Christian Borntraeger wrote:
>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>
>> If the host supports keyless subset (KSS) then first level
>> guest (G2) should enable KSS facility as well.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/kvm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 8c6cc0a..c773bd6 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2508,6 +2508,7 @@ static int kvm_to_feat[][2] = {
>>      { KVM_S390_VM_CPU_FEAT_CMMA, S390_FEAT_SIE_CMMA },
>>      { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
>>      { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
>> +    { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
>>  };
>>  
>>  static int query_cpu_feat(S390FeatBitmap features)
>>
> 
> This bit is not part of any cpu model, so how is this helpful?
> (AFAIK it will simply be dropped from the host model)

See the new patch for z14. ( i had to defer that part till
todays announcement)
