Received: from eggs.gnu.org ([2001:4830:134:3::10]:57143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFzjx-0003O1-No
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFzjt-0002u3-5F
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:53:17 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:57584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gFzjs-0002tW-UI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:53:13 -0400
References: <mhng-a68ddfc1-c1f3-4c28-97a5-bf5dfc9db931@palmer-si-x1c4>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <a0916ce9-da94-7a38-52d6-61be33e3c67d@mail.uni-paderborn.de>
Date: Fri, 26 Oct 2018 12:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <mhng-a68ddfc1-c1f3-4c28-97a5-bf5dfc9db931@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v2 00/29] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: sagark@eecs.berkeley.edu, richard.henderson@linaro.org, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>


On 10/25/18 12:21 AM, Palmer Dabbelt wrote:
> On Sat, 20 Oct 2018 00:14:22 PDT (-0700), 
> kbastian@mail.uni-paderborn.de wrote:
>> Hi,
>>
>> this patchset converts the RISC-V decoder to decodetree in three 
>> major steps:
>>
>> 1) Convert 32-bit instructions to decodetree [Patch 1-14]:
>>     Many of the gen_* functions are called by the decode functions 
>> for 16-bit
>>     and 32-bit functions. If we move translation code from the gen_*
>>     functions to the generated trans_* functions of decode-tree, we 
>> get a lot of
>>     duplication. Therefore, we mostly generate calls to the old gen_* 
>> function
>>     which are properly replaced after step 2).
>>
>>     Each of the trans_ functions are grouped into files corresponding 
>> to their
>>     ISA extension, e.g. addi which is in RV32I is translated in the file
>>     'trans_rvi.inc.c'.
>>
>> 2) Convert 16-bit instructions to decodetree [Patch 15-17]:
>>     All 16 bit instructions have a direct mapping to a 32 bit 
>> instruction. Thus,
>>     we convert the arguments in the 16 bit trans_ function to the 
>> arguments of
>>     the corresponding 32 bit instruction and call the 32 bit trans_ 
>> function.
>>
>> 3) Remove old manual decoding in gen_* function [Patch 17-28]:
>>     this move all manual translation code into the trans_* 
>> instructions of
>>     decode tree, such that we can remove the old decode_* functions.
>>
>> the full tree can be found here:
>> https://github.com/bkoppelmann/qemu/tree/riscv-dt-v2
>
> Thanks!
>
> I dropped this on top of master and it appears I'm getting a bunch of 
> oops when trying to boot Linux.  They're fairly far into the boot 
> process and may be a mistake on my end, I was just wondering if you'd 
> booted Linux?

Are there non fatal oops in booting Linux? I only checked whether I 
could get a terminal on Fedora Linux.

Cheers,

Bastian
