Received: from eggs.gnu.org ([209.51.188.92]:41613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gnJgs-0008Pc-Vr
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 03:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gnJgs-0006G9-0I
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 03:51:50 -0500
References: <mhng-a089b75c-29ca-4a50-b64c-e86349ac6190@palmer-si-x1c4>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <69b40819-748e-d555-316a-6ce90e944bde@mail.uni-paderborn.de>
Date: Sat, 26 Jan 2019 09:51:23 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-a089b75c-29ca-4a50-b64c-e86349ac6190@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/35] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, richard.henderson@linaro.org
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On 1/26/19 12:54 AM, Palmer Dabbelt wrote:
> On Tue, 22 Jan 2019 13:38:52 PST (-0800), richard.henderson@linaro.org wrote:
>> On 1/22/19 1:28 AM, Bastian Koppelmann wrote:
>>> Hi,
>>>
>>> this patchset converts the RISC-V decoder to decodetree in four major steps:
>>>
>>> 1) Convert 32-bit instructions to decodetree [Patch 1-16]:
>>>     Many of the gen_* functions are called by the decode functions for 16-bit
>>>     and 32-bit functions. If we move translation code from the gen_*
>>>     functions to the generated trans_* functions of decode-tree, we get a lot of
>>>     duplication. Therefore, we mostly generate calls to the old gen_* function
>>>     which are properly replaced after step 2).
>>>
>>>     Each of the trans_ functions are grouped into files corresponding to their
>>>     ISA extension, e.g. addi which is in RV32I is translated in the file
>>>     'trans_rvi.inc.c'.
>>>
>>> 2) Convert 16-bit instructions to decodetree [Patch 17-19]:
>>>     All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
>>>     we convert the arguments in the 16 bit trans_ function to the arguments of
>>>     the corresponding 32 bit instruction and call the 32 bit trans_ function.
>>>
>>> 3) Remove old manual decoding in gen_* function [Patch 20-30]:
>>>     this move all manual translation code into the trans_* instructions of
>>>     decode tree, such that we can remove the old decode_* functions.
>>>
>>> 4) Simplify RVC by reusing as much as possible from the RVG decoder as suggested
>>>    by Richard. [Patch 31-35]
>>>
>>> full tree available at
>>> https://github.com/bkoppelmann/qemu/tree/riscv-dt-v5
>>>
>>> Cheers,
>>> Bastian
>>>
>>> v4 -> v5:
>>>     - fixed rebase error
>>>     - moved TARGET_LONG_BITS check of shift instructions before rd == 0 check
>>>     - removed extra sign extension of sraiw
>>>     - removed rs2 == 0 special cases in sraw/srlw
>>
>> All looks good to me now.  Thanks for persevering.
> 
> Thanks for reviewing this.
> 
> Bastian: what sort of testing have you done here?  This is a pretty big change,
> and while it's been fairly extensively reviewed I'm just generally paranoid.
> 

I ran riscv-test as well as booting the newest fedora.

Cheers,
Bastian
