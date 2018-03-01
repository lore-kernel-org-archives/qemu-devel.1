Received: from eggs.gnu.org ([2001:4830:134:3::10]:54352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erRaU-00030g-EI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erRaO-00054u-U1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:01:46 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erRaO-00054V-Lg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:01:40 -0500
Received: by mail-pg0-x234.google.com with SMTP id y8so2545279pgr.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:01:40 -0800 (PST)
References: <20180228164816.24110-1-richard.henderson@linaro.org>
	<20180228164816.24110-3-richard.henderson@linaro.org>
	<CAFEAcA_SsRZAsTvUjSYHQcGMUYUDFvr0jdVBdjdczssDmExPgg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7599a4e6-a0bf-961e-6272-a3835b202c15@linaro.org>
Date: Thu, 1 Mar 2018 09:01:35 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_SsRZAsTvUjSYHQcGMUYUDFvr0jdVBdjdczssDmExPgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] decodetree: Propagate return value from
 translate subroutines
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

On 03/01/2018 03:59 AM, Peter Maydell wrote:
> On 28 February 2018 at 16:48, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Allow the translate subroutines to return false for invalid insns.
>>
>> At present we can of course invoke an invalid insn exception from within
>> the translate subroutine, but in the short term this consolidates code.
>> In the long term it would allow the decodetree language to support
>> overlapping patterns for ISA extensions.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Since this makes an ABI change to the translate functions called by the
>> decode function, let's make it now before there are any in-tree users.
>>
>> My SVE branch over-decodes in quite a lot of cases -- e.g. things like
>> the 2-bit size field must be 1-3 for fp operands, and so size==0 is
>> unallocated.  Returning false for these cases allows the actual call
>> to unallocated_encoding to be done in one place instead of hundreds.
>>
>> Longer term, I'm thinking of how to handle decode of overlapping ISA
>> extensions.  One could allow (specific) overlapping patterns and
>> prioritize them in some way (e.g. first in file is first matched).
>> My thought is that trans_insn_a would check a cpu feature bit and
>> return false if not enabled.  Then trans_insn_b would be given its
>> chance to handle the insn.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I'll put this into target-arm.next, unless you'd prefer it to go
> in via some other route.

That's fine.  Thanks!


r~
