Received: from eggs.gnu.org ([2001:4830:134:3::10]:37053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMbPf-0002qA-SF
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMbPb-0000Wa-U9
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:15:07 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-4-david@redhat.com>
	<b25586af-43e2-4ad1-f426-cd1de59610ce@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f2b7bb3d-3bf2-3d9e-f7ac-1201c149125f@redhat.com>
Date: Wed, 6 Dec 2017 16:15:00 +0100
MIME-Version: 1.0
In-Reply-To: <b25586af-43e2-4ad1-f426-cd1de59610ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 3/5] s390x/tcg: implement SET
 CLOCK PROGRAMMABLE FIELD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06.12.2017 16:10, Thomas Huth wrote:
> On 04.12.2017 13:55, David Hildenbrand wrote:
>> Needed for machine check handling inside Linux (when restoring registers).
>>
>> Except for SIGP and machine checks, we don't make use of the register
>> yet. Suficient for now.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> [...]
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index 6d766ce1e7..2c6ab329fb 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -146,6 +146,17 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>>      timer_mod(env->tod_timer, env->tod_basetime + time);
>>  }
>>  
>> +/* Set Tod Programmable Field */
>> +void HELPER(sckpf)(CPUS390XState *env)
>> +{
>> +    uint32_t val = env->regs[0];
>> +
>> +    if (val & 0xffff0000UL) {
> 
> I think you could drop the "UL" suffix here.
> 

Indeed, we should be fine as long as this fits into an int thanks!


-- 

Thanks,

David / dhildenb
