Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq24U-00079B-HT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq24P-0007WQ-Gp
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:02:38 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:34563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq24P-0007U1-94
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:02:33 -0400
Received: by mail-pf0-x22e.google.com with SMTP id e1so888091pfk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 12:02:33 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-5-richard.henderson@linaro.org>
	<874lsemj0d.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f18d9635-1ae5-08f0-3856-c2d445e62b99@linaro.org>
Date: Thu, 7 Sep 2017 12:02:29 -0700
MIME-Version: 1.0
In-Reply-To: <874lsemj0d.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/8] tcg: Add operations for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 09/07/2017 12:00 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Nothing uses or implements them yet.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tcg/tcg-opc.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tcg/tcg.h     | 24 ++++++++++++++++
>>  2 files changed, 113 insertions(+)
>>
>> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
>> index 956fb1e9f3..9162125fac 100644
>> --- a/tcg/tcg-opc.h
>> +++ b/tcg/tcg-opc.h
>> @@ -206,6 +206,95 @@ DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
>>
>>  #undef TLADDR_ARGS
>>  #undef DATA64_ARGS
>> +
>> +/* Host integer vector operations.  */
>> +/* These opcodes are required whenever the base vector size is enabled.  */
>> +
>> +DEF(mov_v64, 1, 1, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(mov_v128, 1, 1, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(mov_v256, 1, 1, 0, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(movi_v64, 1, 0, 1, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(movi_v128, 1, 0, 1, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(movi_v256, 1, 0, 1, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(ld_v64, 1, 1, 1, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(ld_v128, 1, 1, 1, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(ld_v256, 1, 1, 1, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(st_v64, 0, 2, 1, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(st_v128, 0, 2, 1, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(st_v256, 0, 2, 1, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(and_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(and_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(and_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(or_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(or_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(or_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(xor_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(xor_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(xor_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(add8_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(add16_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(add32_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +
>> +DEF(add8_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(add16_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(add32_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(add64_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +
>> +DEF(add8_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +DEF(add16_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +DEF(add32_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +DEF(add64_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +DEF(sub8_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(sub16_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +DEF(sub32_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_v64))
>> +
>> +DEF(sub8_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(sub16_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(sub32_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +DEF(sub64_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_v128))
>> +
>> +DEF(sub8_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +DEF(sub16_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +DEF(sub32_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +DEF(sub64_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_v256))
>> +
>> +/* These opcodes are optional.
>> +   All element counts must be supported if any are.  */
>> +
>> +DEF(not_v64, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_v64))
>> +DEF(not_v128, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_v128))
>> +DEF(not_v256, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_v256))
>> +
>> +DEF(andc_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_v64))
>> +DEF(andc_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_v128))
>> +DEF(andc_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_v256))
>> +
>> +DEF(orc_v64, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_v64))
>> +DEF(orc_v128, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_v128))
>> +DEF(orc_v256, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_v256))
>> +
>> +DEF(neg8_v64, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v64))
>> +DEF(neg16_v64, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v64))
>> +DEF(neg32_v64, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v64))
>> +
>> +DEF(neg8_v128, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v128))
>> +DEF(neg16_v128, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v128))
>> +DEF(neg32_v128, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v128))
>> +DEF(neg64_v128, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v128))
>> +
>> +DEF(neg8_v256, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v256))
>> +DEF(neg16_v256, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v256))
>> +DEF(neg32_v256, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v256))
>> +DEF(neg64_v256, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_v256))
>> +
>>  #undef IMPL
>>  #undef IMPL64
>>  #undef DEF
>> diff --git a/tcg/tcg.h b/tcg/tcg.h
>> index 1277caed3d..b9e15da13b 100644
>> --- a/tcg/tcg.h
>> +++ b/tcg/tcg.h
>> @@ -166,6 +166,30 @@ typedef uint64_t TCGRegSet;
>>  #define TCG_TARGET_HAS_rem_i64          0
>>  #endif
>>
>> +#ifndef TCG_TARGET_HAS_v64
>> +#define TCG_TARGET_HAS_v64              0
>> +#define TCG_TARGET_HAS_andc_v64         0
>> +#define TCG_TARGET_HAS_orc_v64          0
>> +#define TCG_TARGET_HAS_not_v64          0
>> +#define TCG_TARGET_HAS_neg_v64          0
>> +#endif
>> +
>> +#ifndef TCG_TARGET_HAS_v128
>> +#define TCG_TARGET_HAS_v128             0
>> +#define TCG_TARGET_HAS_andc_v128        0
>> +#define TCG_TARGET_HAS_orc_v128         0
>> +#define TCG_TARGET_HAS_not_v128         0
>> +#define TCG_TARGET_HAS_neg_v128         0
>> +#endif
>> +
>> +#ifndef TCG_TARGET_HAS_v256
>> +#define TCG_TARGET_HAS_v256             0
>> +#define TCG_TARGET_HAS_andc_v256        0
>> +#define TCG_TARGET_HAS_orc_v256         0
>> +#define TCG_TARGET_HAS_not_v256         0
>> +#define TCG_TARGET_HAS_neg_v256         0
>> +#endif
> 
> Is it possible to use the DEF expanders to avoid manually defining all
> the TCG_TARGET_HAS_op for each vector size?

No.  The preprocessor doesn't work that way.


r~
