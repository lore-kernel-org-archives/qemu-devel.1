Received: from eggs.gnu.org ([2001:4830:134:3::10]:53965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJTQ-0000jJ-4Q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJTN-0008ON-0N
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:21:24 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLJTM-0008Nv-Qn
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:21:20 -0400
Received: by mail-pf0-x242.google.com with SMTP id y7so48169pfd.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 18:21:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-3-rth@twiddle.net>
	<20170614203741.GC8420@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1c328e8a-147f-198a-3b62-57fe0d9e39f4@twiddle.net>
Date: Wed, 14 Jun 2017 18:21:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170614203741.GC8420@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/alpha: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com

On 06/14/2017 01:37 PM, Emilio G. Cota wrote:
> On Wed, Jun 14, 2017 at 12:48:18 -0700, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
> (snip)
>> @@ -1198,7 +1205,10 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>>               tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
>>               tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
>>               tcg_temp_free(tmp);
>> -            break;
>> +
>> +            /* Allow interrupts to be recognized right away.  */
>> +            tcg_gen_movi_i64(cpu_pc, ctx.pc);
> 
> ctx->pc though

Bah.  I knew I'd fixed that, but it got folded into the s390 patch.


r~
