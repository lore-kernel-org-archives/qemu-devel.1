Received: from eggs.gnu.org ([209.51.188.92]:54742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddI-0003GQ-Qe
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddF-0007k0-AI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:02:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLddF-0007i3-0t
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:01:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id c13so6683285pgt.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 18:01:55 -0700 (PDT)
Date: Tue, 30 Apr 2019 18:01:53 -0700 (PDT)
In-Reply-To: <357d260b-4baf-aea8-c332-f77ce2a3e9b2@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-4cf09562-97fc-4e60-8a96-62aa58a9e038@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/8] target/riscv: Merge argument
 decode for RVC shifti
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Thu, 25 Apr 2019 09:50:41 PDT (-0700), richard.henderson@linaro.org wrote:
> On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
>>>  # *** RV64C Standard Extension (Quadrant 2) ***
>>> -c_slli            000 .  .....  ..... 10 @c_shift2
>>> +slli              000 .  .....  ..... 10 @c_shift2
>>
>> This is another one where rd=0 is illegal in the compressed ISA, but again we
>> don't appear to handle these correctly before the cleanups.
>
> I see "HINT, rd=0" in the 2.2 documentation for this case.

Looks like you're right -- I was assuming the "rd != 0" to mean that it was an
illegal instruction, but I just confirmed with Andrew that it's legal.  In this
case (and probably the others I mentioned), I think QEMU is correct already.
