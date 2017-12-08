Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI1F-0004k7-VN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI1B-0000Zb-VB
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:44:46 -0500
References: <20171207153141.15523-1-david@redhat.com>
	<20171207153141.15523-4-david@redhat.com>
	<4dd3b2a3-854d-303c-d407-f8625b738a3c@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7e1237a6-37e5-50ff-1e65-d12b8253c842@redhat.com>
Date: Fri, 8 Dec 2017 13:44:37 +0100
MIME-Version: 1.0
In-Reply-To: <4dd3b2a3-854d-303c-d407-f8625b738a3c@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 3/5] s390x/tcg: implement SET
 CLOCK PROGRAMMABLE FIELD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08.12.2017 01:00, Richard Henderson wrote:
> On 12/07/2017 07:31 AM, David Hildenbrand wrote:
>> +DEF_HELPER_FLAGS_1(sckpf, TCG_CALL_NO_RWG, void, env)
> ...
>> +/* Set Tod Programmable Field */
>> +void HELPER(sckpf)(CPUS390XState *env)
>> +{
>> +    uint32_t val = env->regs[0];
>> +
>> +    if (val & 0xffff0000) {
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
>> +    }
>> +    env->todpr = val;
>> +}
> 
> You do read a tcg global -- regs[0].  Either pass in r0 as a parameter or use
> TCG_CALL_NO_WG.
> 
> 

Indeed, I finally understood what the term "global" in this context
means. (global tcg vals defined in translate.c)

> r~
> 


-- 

Thanks,

David / dhildenb
