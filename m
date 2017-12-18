Received: from eggs.gnu.org ([2001:4830:134:3::10]:55090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR2Cm-00063X-Ed
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR2CZ-0002bF-Gx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:40:08 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR2CY-0002aC-T4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:39:55 -0500
Received: by mail-qk0-x244.google.com with SMTP id 8so19977346qkj.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:39:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
	<20171215170732.31125-8-richard.henderson@linaro.org>
	<13ac2e8e-cd5d-9ce1-cad3-9c16f041e1bd@amsat.org>
	<c9038f49-5972-289c-949a-0365f8cbc032@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd4cb704-10e0-0005-25f2-59fdf6993340@amsat.org>
Date: Mon, 18 Dec 2017 17:39:51 -0300
MIME-Version: 1.0
In-Reply-To: <c9038f49-5972-289c-949a-0365f8cbc032@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/7] tcg: Allow 6 arguments to TCG helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 12/18/2017 04:20 PM, Richard Henderson wrote:
> On 12/15/2017 10:06 AM, Philippe Mathieu-Daudé wrote:
>>> @@ -305,14 +305,16 @@ static const int tcg_target_call_iarg_regs[] = {
>>>      TCG_REG_R4,
>>>  #endif
>>>      TCG_REG_R5,
>>> +    TCG_REG_R6,
>>>  #if TCG_TARGET_REG_BITS == 32
>>>      /* 32 bit hosts need 2 * MAX_OPC_PARAM_IARGS registers. */
>>> -    TCG_REG_R6,
>>>      TCG_REG_R7,
>>
>> I think now TCG_REG_R8 belongs here...
>>
>>>  #if TCG_TARGET_NB_REGS >= 16
>>>      TCG_REG_R8,
>>
>> ^ not here.
> 
> Why?  Unless TCG_TARGET_NB_REGS >= 16, TCG_REG_R8 doesn't exist.

Oh I see, my bad :)
