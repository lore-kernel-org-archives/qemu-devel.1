Received: from eggs.gnu.org ([2001:4830:134:3::10]:54229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPVc4-000495-Mt
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPVbz-0000Tt-Nj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:07:40 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPVbz-0000Tl-J0
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:07:35 -0400
Received: by mail-qk0-x22f.google.com with SMTP id 16so3589595qkg.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 08:07:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-4-rth@twiddle.net> <8760fiyeps.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9f58c6f8-0b44-410f-918c-57a3f2540c3b@twiddle.net>
Date: Mon, 26 Jun 2017 08:07:25 -0700
MIME-Version: 1.0
In-Reply-To: <8760fiyeps.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/16] tcg: Propagate args to op->args in
 tcg.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net

On 06/26/2017 08:02 AM, Alex Bennée wrote:
>>   #if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
>> -                a = ((target_ulong)args[i * 2 + 1] << 32) | args[i * 2];
>> +                a = deposit64(op->args[i * 2], 32, 32, op->args[i * 2
>>               + 1]);
> 
> It doesn't now but should be assert against us overflowing the args
> buffer here when dealing with encoded data? Or should it have faulted
> when planting the ops?

Statically checked via preprocessor in tcg/tcg-op.h:

#elif TARGET_INSN_START_WORDS == 3
...
#else
# error "Unhandled number of operands to insn_start"
#endif

which maxes out at 6 host arguments, which is less than MAX_OPC_PARAM.


r~
