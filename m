Received: from eggs.gnu.org ([2001:4830:134:3::10]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0xn-0004Q6-QY
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0xj-0003r4-0z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:20:35 -0500
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:44301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR0xi-0003p5-JS
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:20:30 -0500
Received: by mail-pl0-x229.google.com with SMTP id n13so5398922plp.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:20:29 -0800 (PST)
References: <20171215170732.31125-1-richard.henderson@linaro.org>
	<20171215170732.31125-8-richard.henderson@linaro.org>
	<13ac2e8e-cd5d-9ce1-cad3-9c16f041e1bd@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9038f49-5972-289c-949a-0365f8cbc032@linaro.org>
Date: Mon, 18 Dec 2017 11:20:25 -0800
MIME-Version: 1.0
In-Reply-To: <13ac2e8e-cd5d-9ce1-cad3-9c16f041e1bd@amsat.org>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 12/15/2017 10:06 AM, Philippe Mathieu-Daudé wrote:
>> @@ -305,14 +305,16 @@ static const int tcg_target_call_iarg_regs[] = {
>>      TCG_REG_R4,
>>  #endif
>>      TCG_REG_R5,
>> +    TCG_REG_R6,
>>  #if TCG_TARGET_REG_BITS == 32
>>      /* 32 bit hosts need 2 * MAX_OPC_PARAM_IARGS registers. */
>> -    TCG_REG_R6,
>>      TCG_REG_R7,
> 
> I think now TCG_REG_R8 belongs here...
> 
>>  #if TCG_TARGET_NB_REGS >= 16
>>      TCG_REG_R8,
> 
> ^ not here.

Why?  Unless TCG_TARGET_NB_REGS >= 16, TCG_REG_R8 doesn't exist.

I'd say this over-configuration of TCI ought to be cleaned up,
but I'd rather remove it entirely.


r~
