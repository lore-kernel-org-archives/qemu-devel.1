Received: from eggs.gnu.org ([209.51.188.92]:46632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkSol-0003HW-Pt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkSok-0000hj-UF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:00:11 -0500
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-25-kbastian@mail.uni-paderborn.de>
	<16797a6b-1b0b-1f83-1aef-5cc5a8ff90e6@linaro.org>
	<b0269eb1-9fa8-449e-68ee-adbc55d15e18@mail.uni-paderborn.de>
	<555073af-e1f7-34f8-e4fd-c917e810f081@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <9e69c3de-1b87-fc5a-ce8f-e0ba1bdd0d32@mail.uni-paderborn.de>
Date: Fri, 18 Jan 2019 13:00:06 +0100
MIME-Version: 1.0
In-Reply-To: <555073af-e1f7-34f8-e4fd-c917e810f081@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v3 24/35] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org


On 1/11/19 10:00 PM, Richard Henderson wrote:
> On 1/12/19 12:10 AM, Bastian Koppelmann wrote:
>> On 10/31/18 11:18 PM, Richard Henderson wrote:
>>> Surely the shri and sari functions need the same shamt >= TARGET_LONG_BITS
>>> check as slli.  Otherwise RV32 shri should definitely produce an assert in
>>> tcg_gen_shri_tl.
>>>
>>> I did wonder about changing the decode of the shift functions such that only
>>> the top two bits of the imm are reserved for secondary parsing of the shift
>>> type, and the other 10 bits are passed down into trans_foo.  At which point the
>>> TARGET_LONG_BITS check takes care of other illegalities.
>>>
>>> Which means that the parsing for slli and slliw are identical, and also that
>>> for the far future when RV128 is a thing, we don't have to change the parsing.
>>
>> I don't quite understand this. Do you want to have one entry in the decode file
>> for slli and slliw?
>>
>> How is the parsing of slli and slliw identical with this change? As far as I
>> see it, they are different at least in the opcode.
> I meant in the extraction and validation of operands, I think.
> I'm not really sure where else I was going with this.  It has
> been two months and I don't have the decode in front of me.


Okay, I extended the immediate to 10 bits for the next patch round 
(which I send out soon) which should not break anything. I suggest we 
leave this optimization for another patch as this set is already long 
and complex.

Cheers,

Bastian
