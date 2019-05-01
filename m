Received: from eggs.gnu.org ([209.51.188.92]:53460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvst-0007Fe-TL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvss-0005lu-Ny
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:31:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLvss-0005i5-Fc
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:31:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id v80so4512312pfa.3
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 13:31:16 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-7-richard.henderson@linaro.org>
	<87o94m5biw.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4686480-1978-5dcd-b773-a2e48df27300@linaro.org>
Date: Wed, 1 May 2019 13:31:12 -0700
MIME-Version: 1.0
In-Reply-To: <87o94m5biw.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/29] tcg: Return bool success from
 tcg_out_mov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/1/19 10:29 AM, Alex Bennée wrote:
>> +static inline bool tcg_out_mov(TCGContext *s, TCGType type,
>>                                 TCGReg ret, TCGReg arg)
>>  {
>> -    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
>> +    if (ret != arg) {
>> +        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
>> +    }
>> +    return true;
>>  }
> 
> You fix a mov folding here.. either mention in commit message or fix in
> a separate commit. I appreciate the other arches already do this.

Fair enough, I've split this out to a separate commit.
And, using tcg_out_mov_reg(s, COND_AL, reg, arg), which
is perhaps even clearer.


r~
