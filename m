Received: from eggs.gnu.org ([2001:4830:134:3::10]:54506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEHsX-0003DG-7J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEHsU-0005Nh-2V
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:18:49 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:38568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEHsT-0005NN-Sv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:18:46 -0400
Received: by mail-pg0-x22f.google.com with SMTP id n9-v6so13597815pgq.5
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 10:18:45 -0700 (PDT)
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-8-richard.henderson@linaro.org>
	<CAFEAcA9iEoMonBRZ8d1005q71bU6CyKEjorHb2towDNUYvmBaQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c916160c-4443-4f2d-d00e-f19c4b0f9ec9@linaro.org>
Date: Thu, 3 May 2018 10:18:41 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9iEoMonBRZ8d1005q71bU6CyKEjorHb2towDNUYvmBaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 7/9] target/arm: Fill in
 disas_ldst_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 05/03/2018 07:14 AM, Peter Maydell wrote:
>> +    /* The tcg atomic primitives are all full barriers.  Therefore we
>> +     * can ignore the Acquire and Release bits of this instruction.
>> +     */
>> +    fn(cpu_reg(s, rt), tcg_rn, tcg_rs, get_mem_index(s),
>> +       s->be_data | size | MO_ALIGN);
> 
> Does this definitely do the arithmetic operation at the datatype
> size and not the _i64 size ? (It makes a difference for example
> with LDEORB if Rs has high bits set: the result should always
> have [31:8] zero.)

Yes.  Also recall that this returns the original data not the result of the
expression.


r~
