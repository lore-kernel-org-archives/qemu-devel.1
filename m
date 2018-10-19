Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDUE4-0000kf-08
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDUDz-0004Ww-If
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:49:59 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:44394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDUDz-0004QY-8D
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:49:55 -0400
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-16-kbastian@mail.uni-paderborn.de>
	<2ef3b2f4-98da-a423-6e11-6dda5779031c@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <2619969c-866a-5d9a-ff19-800edd1815be@mail.uni-paderborn.de>
Date: Fri, 19 Oct 2018 14:49:52 +0200
MIME-Version: 1.0
In-Reply-To: <2ef3b2f4-98da-a423-6e11-6dda5779031c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 15/28] target/riscv: Convert quadrant 0 of
 RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org


On 10/13/18 8:18 PM, Richard Henderson wrote:
> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>> +# Argument sets:
>> +&cl               rs1 rd
>> +&cl_dw     uimm   rs1 rd
>> +&ciw       nzuimm     rd
>> +&cs               rs1 rs2
>> +&cs_dw     uimm   rs1 rs2
> I guess this is good enough for now.
> What I'd like to see is something like
>
> &i	imm rs1 rd	!extern


That looks so much better. Can you CC me when you send the patches for 
the extern support, so I can implement this for RISC-V?


Cheers,

Bastian
