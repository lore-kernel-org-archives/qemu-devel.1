Received: from eggs.gnu.org ([209.51.188.92]:50131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvgv-0000cN-E8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvgu-0006BC-C6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:18:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:36015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLvgu-0006Ad-2k
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:18:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id v80so4499273pfa.3
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 13:18:55 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-8-richard.henderson@linaro.org>
	<87muk65bat.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <12699c3d-3c5e-33db-ba6f-53f533f8ecf8@linaro.org>
Date: Wed, 1 May 2019 13:18:51 -0700
MIME-Version: 1.0
In-Reply-To: <87muk65bat.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/29] tcg: Support cross-class moves
 without instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/1/19 10:34 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> PowerPC Altivec does not support direct moves between vector registers
>> and general registers.  So when tcg_out_mov fails, we can use the
>> backing memory for the temporary to perform the move.
> 
> I couldn't see where tcg_out_mov fails in this way for ppc, it is still
> abort or pass:
> 
> static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> {
>     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
>     if (ret != arg) {
>         tcg_out32(s, OR | SAB(arg, ret, arg));
>     }
>     return true;
> }
> 
> did a patch get missed somewhere?

No, it's in another patch set that depends on this --
adding host vector support for tcg/ppc/.


r~
