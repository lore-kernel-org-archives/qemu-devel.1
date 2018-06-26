Received: from eggs.gnu.org ([2001:4830:134:3::10]:38508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoeH-0002c6-11
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoeD-000267-SW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:08:48 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXoeD-00023S-Lm
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:08:45 -0400
Received: by mail-pl0-x242.google.com with SMTP id s24-v6so8607062plq.6
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:08:45 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-8-richard.henderson@linaro.org>
	<CAFEAcA-n1fcCk9LfgZPnphHpft+iYXH3t1+2-7RtdmjH2jRksw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <295286d3-603d-ff13-e2e8-76d4d92ffde6@linaro.org>
Date: Tue, 26 Jun 2018 07:08:41 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-n1fcCk9LfgZPnphHpft+iYXH3t1+2-7RtdmjH2jRksw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/35] target/arm: Implement SVE FP
 Multiply-Add Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/25/2018 08:32 AM, Peter Maydell wrote:
>> +# SVE floating-point multiply-accumulate writing addend
>> +FMLA_zpzzz      01100101 .. 1 ..... 000 ... ..... .....         @rda_pg_rn_rm
>> +FMLS_zpzzz      01100101 .. 1 ..... 001 ... ..... .....         @rda_pg_rn_rm
>> +FNMLA_zpzzz     01100101 .. 1 ..... 010 ... ..... .....         @rda_pg_rn_rm
>> +FNMLS_zpzzz     01100101 .. 1 ..... 011 ... ..... .....         @rda_pg_rn_rm
>> +
>> +# SVE floating-point multiply-accumulate writing multiplicand
>> +# FMAD, FMSB, FNMAD, FNMS
>> +FMLA_zpzzz      01100101 .. 1 ..... 100 ... ..... .....         @rdn_pg_rm_ra
>> +FMLS_zpzzz      01100101 .. 1 ..... 101 ... ..... .....         @rdn_pg_rm_ra
>> +FNMLA_zpzzz     01100101 .. 1 ..... 110 ... ..... .....         @rdn_pg_rm_ra
>> +FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra
> It's not clear to me how we can implement both of these groups
> with the same functions. Some commentary might help.

Note the different decode: @rda_pg_rn_rm vs @rdn_pg_rm_ra.
The same sets of arguments are filled in from different fields
in the instruction.


r~
