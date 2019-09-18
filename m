Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76852C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E47C218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E47C218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAX2H-0001KJ-Dj
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAWtV-0000fL-4J
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAWtT-0003QA-F1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:09:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iAWtT-0003Mt-5s
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:09:03 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MAxPb-1iLqcw0NFh-00BIcN; Wed, 18 Sep 2019 12:08:31 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pierre Muller <pierre@freepascal.org>
References: <1615bbe5-3033-3b76-5cfb-52e343dc4d67@freepascal.org>
 <ae7415a9-54be-14de-9590-f9ff6ef025c4@redhat.com>
 <ddb842e7-dd48-1e74-20db-dea75de0552d@freepascal.org>
 <874l1a0vtl.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <032bed6f-d9fd-9061-d0c5-670c45953bf5@vivier.eu>
Date: Wed, 18 Sep 2019 12:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l1a0vtl.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T+aJuKz5JVbnqoSVCUBmquA0++MqNlzXS1yf0Fh+gEp0z+F3z8z
 bCBqpExhG29VsdNwrPFja22cWAQ78CJfJe0L5swLam9ZCHS5ZQ6oCoRwSp0shC9GfvAFbzp
 vGEkzilb0MN3mAOknPluKrwE4Qvidx8BYSktfPhf30g4dijk3s6TBlynX1y7Ip9OeZkGCYP
 7haniYpxaS0QcyfU94udg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q0n+9ukmBFM=:8bbMpdlGWlNwvU5TFHKu1w
 ihYLE/aexxnUm6BlcXghwvIA1h9uWdB4IVLVANSsxHC+8Ai4Apa0h1QDJehpNzOmEjJ+4EO50
 CL/sZo4ScOIwribDAD0HBfqrROB4oFHS7OWUYYbon5eJRCkxy+LG95mPTmkDMQNqbfFEiq9iA
 5K8V5GH4/Nzt+cU3Aqv6UEdKnlGSimoUUt/O+h1Sw5m6bTGUwp5y4+OtSsrHD2+1tc0qVFp7+
 fOr5ItGiKJ20udzp7lnr/xue2K5dPbUezhdUzwiIvhoZTCp7UaeJ9lUStYBPnHjHMNMZUqi4O
 5PoS+7vjHIToOUIBjb82kc2NtnkF+cz1lUDg+yUkCpPe+wJ9Qc0We55vuJsuitqseN673z+UG
 uMyy7Zx1u88q+gqazGWGuYkDFm5NxSqyrSW+TBQbgGdznjrwyF3G30xTDNv2ipKMyKo1Rlwgm
 +o6cOdT2lB6E79hUB9CdTBZWoN+YVh80oz5sAh3tQXjENHXQsxHe40ahI0iSRMtRmXZ8Y5n+k
 fdPticKlF0O8apJGYUdphHRGkTPxHdhw0pWq1paEhgHNwiddiKppS0ZGsIPpdtosvpiN4UAD0
 qNoPvxObsbXiEUP1B3ULpVyH4Yx/doxWoRSPa5rAEoyQxpp6FIH1WY8GFy7wUnf290ur3REu3
 P007fwgsVqNN99cTpHocr4GJyDrquIzpn55k5Mh/kMwISLfChOmNtytrpGgcNvytij3VcGfYH
 qCIlfKUzFHhjrNzMQeRDyeEFY/FrdybkPdBp5igQKcFEjcX3fYvX8PdNZxitq7lnM1WyoFbW2
 ZaFNOS8ojTDL8bpEDK9BhN2P/uJxn15Oo3PhV5/prMR3z8yUJf6qgqvtkBqauRezyOEIE7JaH
 8KZi4zzIXNjbfuviAQ9oPG45GbmpZ8sMNMgiOO5cE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH] * include/fpu/softfloat.h
 (floatx80_invalid_encoding): Handle m68k specific infinity pattern.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/09/2019 à 11:59, Alex Bennée a écrit :
> 
> Pierre Muller <pierre@freepascal.org> writes:
> 
>>   Hi Thomas,
>>
>>   I tried to use git format-patch -s below,
>> and change the commit message that appears below:
>>
>>
>> muller@gcc123:~/gnu/qemu/qemu$ git format-patch -s a017dc6d43aaa4ffc7be40ae3adee4086be9cec2^
>> 0001-Fix-floatx80_invalid_encoding-function-for-m68k-cpu.patch
>> muller@gcc123:~/gnu/qemu/qemu$ cat
>> 0001-Fix-floatx80_invalid_encoding-function-for-m68k-cpu.patch
> 
> It's best to send the patches directly (i.e. don't include them in a
> larger email). This is because when maintainers apply the email they end
> up with a bunch of additional stuff and the corrupting of subject line.
> 
>> From a017dc6d43aaa4ffc7be40ae3adee4086be9cec2 Mon Sep 17 00:00:00 2001
>> From: Pierre Muller <pierre@freepascal.org>
>> Date: Wed, 18 Sep 2019 08:04:19 +0000
>> Subject: [PATCH]    Fix floatx80_invalid_encoding function for m68k cpu
>>
>>     As m68k accepts different patterns for infinity,
>>     and additional test for valid infinity must be added
>>     for m68k cpu target.
>>
>> Signed-off-by: Pierre Muller <pierre@freepascal.org>
>> ---
>>  include/fpu/softfloat.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>> index ecb8ba0114..dea24384e9 100644
>> --- a/include/fpu/softfloat.h
>> +++ b/include/fpu/softfloat.h
>> @@ -685,10 +685,17 @@ static inline int floatx80_is_any_nan(floatx80 a)
>>  | pseudo-infinities and un-normal numbers. It does not include
>>  | pseudo-denormals, which must still be correctly handled as inputs even
>>  | if they are never generated as outputs.
>> +| As m68k accepts different patterns for infinity, thus an additional test
>> +| for valid infinity value must be added for m68k CPU.
>>  *----------------------------------------------------------------------------*/
>>  static inline bool floatx80_invalid_encoding(floatx80 a)
>>  {
>> +#if defined (TARGET_M68K)
>> +    return ((a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0)
>> +           && (! floatx80_is_infinity(a));
>> +#else
>>      return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
>> +#endif
>>  }
> 
> As most of the test is the same we could rewrite this to:
> 
>  bool invalid = (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
>  #if defined (TARGET_M68K)
>  invalid &= !floatx80_is_infinity(a)
>  #endif
>  return invalid;
> 
> The compiler should be able to simplify the logic from there.
> 
> Do we have any test cases that we could add to tests/tcg/m68k?
> 
>>
>>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
> 

I think patch from Pierre doesn't treat all the problem and don't rely 
on any specification.

I proposed a patch years ago that is closer to the hardware behaviour:

/*----------------------------------------------------------------------------
| Return whether the given value is an invalid floatx80 encoding.
| Invalid floatx80 encodings arise when the integer bit is not set, but
| the exponent is not zero. The only times the integer bit is permitted to
| be zero is in subnormal numbers and the value zero.
| This includes what the Intel software developer's manual calls pseudo-NaNs,
| pseudo-infinities and un-normal numbers. It does not include
| pseudo-denormals, which must still be correctly handled as inputs even
| if they are never generated as outputs.
*----------------------------------------------------------------------------*/
static inline bool floatx80_invalid_encoding(floatx80 a)
{
#if defined(TARGET_M68K)
    /*-------------------------------------------------------------------------
    |  M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL
    |  1.6.2 Denormalized Numbers
    |  Since the extended-precision data format has an explicit integer bit,
    |  a number can be formatted with a nonzero exponent, less than the maximum
    |  value, and a zero integer bit.  The IEEE 754 standard does not define a
    |  zero integer bit. Such a number is an unnormalized number. Hardware does
    |  not directly support denormalized and unnormalized numbers, but
    |  implicitly supports them by trapping them as unimplemented data types,
    |  allowing efficient conversion in software.
    *------------------------------------------------------------------------*/
    return 0;
#else
    return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
#endif
}

But in fact I think this kind of number should raise an exception.

I tried to do this in:

https://github.com/vivier/qemu-m68k/commit/5bd7742437a3c770373734add5ab452e8df4e621

but it needs more work and for the moment doesn't fix the problem Pierre is trying to fix.

Thanks,
Laurent

