Received: from eggs.gnu.org ([2001:4830:134:3::10]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLhRU-0001Z0-UM
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLhRU-0004kO-2d
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:57:01 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLhRT-0004k6-Tz
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:56:59 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so7309026qtg.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 19:56:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-3-rth@twiddle.net> <87vanxmyac.fsf@linaro.org>
	<5fd00837-211a-011c-be1c-d5e2e7417d9d@twiddle.net>
	<CAAdtpL61qwKDcpMU6eOZu10GYZBOgN97dRuEA3QbR6aY4aTSfQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a0a0cf0-f6d3-c6bc-2717-fe2b71658882@twiddle.net>
Date: Thu, 15 Jun 2017 19:56:56 -0700
MIME-Version: 1.0
In-Reply-To: <CAAdtpL61qwKDcpMU6eOZu10GYZBOgN97dRuEA3QbR6aY4aTSfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 06/15/2017 02:57 PM, Philippe Mathieu-Daudé wrote:
> Peter cleaned that and improved the doc on ARM:
> https://patchwork.kernel.org/patch/9690993/
> (commit b636649f5a2e108413dd171edaf320f781f57942)
> 
> $ git grep -- singlestep_enabled target|wc -l
> 113
> still confusing...

This is two of the three single step conditions.
Not including the split I describe below.


r~


>>>> -        || ctx->singlestep_enabled || singlestep) {
>>
>>
>> I didn't start testing this global.  It's already there.
>>
>> Further, despite the name similarity these are very different conditions.
>>
>> For ctx->singlestep_enabled we emit a debug exception at the end of every
>> instruction.
>>
>> For singlestep, we must execute only one insn in the TB and further we must
>> return to the main loop after the TB.  Both are required for -singlestep -d
>> cpu to log all that's being requested.
>>
>> One cannot combine the two conditions.
>>
>>
>> r~
>>
