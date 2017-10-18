Received: from eggs.gnu.org ([2001:4830:134:3::10]:53468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4gIa-0000e0-JD
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4gIX-0006Cp-HT
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:49:44 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:55997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4gIX-0006CY-48
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:49:41 -0400
Received: by mail-pf0-x22b.google.com with SMTP id 17so3023700pfn.12
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 21:49:40 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-24-richard.henderson@linaro.org>
	<20171018041510.GC13959@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a20f58b0-5396-2444-102e-99fcdf69122a@linaro.org>
Date: Tue, 17 Oct 2017 21:49:36 -0700
MIME-Version: 1.0
In-Reply-To: <20171018041510.GC13959@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 23/50] hack dump tb->flags and tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 10/17/2017 09:15 PM, Emilio G. Cota wrote:
> On Mon, Oct 16, 2017 at 10:25:42 -0700, Richard Henderson wrote:
>> ---
>>  accel/tcg/cpu-exec.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 39ec9508d1..99f1d519c5 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -146,9 +146,9 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
>>      uint8_t *tb_ptr = itb->tc.ptr;
>>  
>>      qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
>> -                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
>> +                           "Trace %p [%d: " TARGET_FMT_lx ", %x, %x] %s\n",
>>                             itb->tc.ptr, cpu->cpu_index, itb->pc,
>> -                           lookup_symbol(itb->pc));
>> +                           itb->flags, itb->cflags, lookup_symbol(itb->pc));
> 
> Given the title, did you indent to submit this patch in the series,
> or it was just a private patch for debugging?

It was supposed to be private.  Oops.


r~
