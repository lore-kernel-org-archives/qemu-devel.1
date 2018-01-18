Received: from eggs.gnu.org ([2001:4830:134:3::10]:39295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ec4Ez-0000Ib-Uj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 02:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ec4Ew-0002Fa-1x
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 02:04:01 -0500
References: <20180117193757.73471-1-borntraeger@de.ibm.com>
	<20180117193757.73471-3-borntraeger@de.ibm.com>
	<47dbb1aa-76ae-eb3b-8060-b67ff3732dd4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a24d0a3c-746e-a76b-8dd5-97e6d5432667@redhat.com>
Date: Thu, 18 Jan 2018 08:03:49 +0100
MIME-Version: 1.0
In-Reply-To: <47dbb1aa-76ae-eb3b-8060-b67ff3732dd4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 17.01.2018 22:12, David Hildenbrand wrote:
> On 17.01.2018 20:37, Christian Borntraeger wrote:
>> We need to handle the bpb control on reset and migration. Normally
>> stfle.82 is transparent (and the normal guest part works without
>> hypervisor activity). To prevent any issues we require full
>> host kernel support for this feature.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu.c              |  1 +
>>  target/s390x/cpu.h              |  1 +
>>  target/s390x/cpu_features.c     |  1 +
>>  target/s390x/cpu_features_def.h |  1 +
>>  target/s390x/gen-features.c     |  1 +
>>  target/s390x/kvm.c              | 14 ++++++++++++++
>>  target/s390x/machine.c          | 17 +++++++++++++++++
>>  7 files changed, 36 insertions(+)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index ae3cee9..1577b2c 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -89,6 +89,7 @@ static void s390_cpu_reset(CPUState *s)
>>      CPUS390XState *env = &cpu->env;
>>  
>>      env->pfault_token = -1UL;
>> +    env->bpbc = 0;
> 
> As this is effectively only 1 bit, I wonder if we should also make that
> clear in QEMU
> 
> bool bpbc, VMSTATE_BOOL ...
> 
> Apart from that, looks sane.

I had the same thought when reading the patch ... apart from that, also
looks good to me.

 Thomas
