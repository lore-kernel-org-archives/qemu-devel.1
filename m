Received: from eggs.gnu.org ([2001:4830:134:3::10]:53729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDFHZ-0007rb-8H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDFHW-0005oC-1q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:52:37 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDFHV-0005ir-Bb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:52:33 -0400
Received: by mail-pg1-x542.google.com with SMTP id r9-v6so14744219pgv.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:52:27 -0700 (PDT)
References: <20181018182758.18646-1-richard.henderson@linaro.org>
	<20181018182758.18646-4-richard.henderson@linaro.org>
	<20181018202719.GG12691@quinoa.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b0c801d-e119-75ab-01ae-85dc1cbba705@linaro.org>
Date: Thu, 18 Oct 2018 13:52:23 -0700
MIME-Version: 1.0
In-Reply-To: <20181018202719.GG12691@quinoa.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Flush only the TLBs
 affected by TTBR*_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <Aaron@os.amperecomputing.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

On 10/18/18 1:27 PM, Aaron Lindsay wrote:
> On Oct 18 11:27, Richard Henderson wrote:
>> @@ -2761,12 +2763,12 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
>>        .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
>>      { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
>>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
>> -      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
>> +      .access = PL1_RW, .writefn = vmsa_ttbr1_write, .resetvalue = 0,
> 
> It's a little confusing that vmsa_ttbr1_write is used for TTBR0_EL1. Is
> the '1' indicating the EL instead of which TTBR is being used?

Yes.  Perhaps I should have included "_el" in the symbol for clarity.

I expect to add a different function (vmsr_ttbr_el2_write?), for TTBR{0,1}_EL2,
which will also check HCR_EL2.E2H, when I get around to implementing ARMv8.1-VHE.


r~
