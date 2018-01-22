Received: from eggs.gnu.org ([2001:4830:134:3::10]:50119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ediCU-0005Ld-ND
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ediCR-0000qo-Kt
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:56:14 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ediCR-0000qT-EP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:56:11 -0500
Received: by mail-pg0-x244.google.com with SMTP id o13so2765886pgs.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 11:56:11 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-2-richard.henderson@linaro.org>
	<CAFEAcA-TfkUUP8C1u_WiPhQj+seMBER-MkcHXBOai4Yt27pCsw@mail.gmail.com>
	<87fu6xk8nf.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3803e94-e04e-e72d-1266-cd6d910b6d73@linaro.org>
Date: Mon, 22 Jan 2018 11:56:07 -0800
MIME-Version: 1.0
In-Reply-To: <87fu6xk8nf.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v10.5 01/20] tcg: Allow multiple word
 entries into the constant pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01/22/2018 11:15 AM, Alex Bennée wrote:
>>>  typedef struct TCGLabelPoolData {
>>>      struct TCGLabelPoolData *next;
>>> -    tcg_target_ulong data;
>>>      tcg_insn_unit *label;
>>> -    intptr_t addend;
>>> -    int type;
>>> +    int addend  : 32;
>>> +    int rtype   : 16;
>>> +    int nlong   : 16;
>>> +    tcg_target_ulong data[];
>>>  } TCGLabelPoolData;
>>>
>>
>> Seems a bit odd to use bitfields for 32 and 16 bit values, but whatever.
>> (My default reaction to bitfields is "be suspicious" :-))
> 
> I'm guessing this is the same reason as the softfloat re-factor. By
> manually forcing stuff into a bitfield the compiler does a better job of
> passing multiple structure elements in a single register?
> 
> It would be nice if the compiler could spot this itself though.

You're probably right that I could just use int16_t etc.


r~
