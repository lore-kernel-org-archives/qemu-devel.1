Received: from eggs.gnu.org ([2001:4830:134:3::10]:40261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnOMn-0005WM-Vt
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnOMi-0000XD-3R
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnOMh-0000Wr-TK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:14:32 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-10-david@redhat.com>
	<b4b6fab8-605d-2ffd-67ca-46830f4e9fa0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d79e78ed-d510-e0c0-f961-bf26752455f4@redhat.com>
Date: Thu, 31 Aug 2017 14:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <b4b6fab8-605d-2ffd-67ca-46830f4e9fa0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/11] target/s390x:
 tcg_s390_program_interrupt() will never return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 22:45, Thomas Huth wrote:
> On 30.08.2017 19:05, David Hildenbrand wrote:
>> The assert should hold in both scenarios.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/interrupt.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
>> index 058e219fe5..79bab5e2f3 100644
>> --- a/target/s390x/interrupt.c
>> +++ b/target/s390x/interrupt.c
>> @@ -32,9 +32,8 @@ static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
>>  #ifdef CONFIG_TCG
>>      trigger_pgm_exception(env, code, ilen);
>>      cpu_loop_exit(CPU(s390_env_get_cpu(env)));
>> -#else
>> -    g_assert_not_reached();
>>  #endif
>> +    g_assert_not_reached();
>>  }
> 
> Not sure if this really makes sense ... cpu_loop_exit() is already
> marked with QEMU_NORETURN, so a know-it-all new version of GCC might
> complain one day if there's other code after this call. I'd better keep
> it the way it is.

Good point, I'll drop this patch. Thanks!

> 
>  Thomas
> 


-- 

Thanks,

David
