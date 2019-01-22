Received: from eggs.gnu.org ([209.51.188.92]:58029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm3l4-0007Y6-4A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm3l3-0006DR-7j
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:38:58 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gm3l3-0006CL-2I
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:38:57 -0500
Received: by mail-pg1-x541.google.com with SMTP id v28so7081pgk.10
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:38:57 -0800 (PST)
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2153eec6-f25f-4e34-6423-01d76a14815c@linaro.org>
Date: Tue, 22 Jan 2019 13:38:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/22/19 1:28 AM, Bastian Koppelmann wrote:
> Hi,
> 
> this patchset converts the RISC-V decoder to decodetree in four major steps:
> 
> 1) Convert 32-bit instructions to decodetree [Patch 1-16]:
>     Many of the gen_* functions are called by the decode functions for 16-bit
>     and 32-bit functions. If we move translation code from the gen_*
>     functions to the generated trans_* functions of decode-tree, we get a lot of
>     duplication. Therefore, we mostly generate calls to the old gen_* function
>     which are properly replaced after step 2).
> 
>     Each of the trans_ functions are grouped into files corresponding to their
>     ISA extension, e.g. addi which is in RV32I is translated in the file
>     'trans_rvi.inc.c'.
> 
> 2) Convert 16-bit instructions to decodetree [Patch 17-19]:
>     All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
>     we convert the arguments in the 16 bit trans_ function to the arguments of
>     the corresponding 32 bit instruction and call the 32 bit trans_ function.
> 
> 3) Remove old manual decoding in gen_* function [Patch 20-30]:
>     this move all manual translation code into the trans_* instructions of
>     decode tree, such that we can remove the old decode_* functions.
> 
> 4) Simplify RVC by reusing as much as possible from the RVG decoder as suggested
>    by Richard. [Patch 31-35]
> 
> full tree available at
> https://github.com/bkoppelmann/qemu/tree/riscv-dt-v5
> 
> Cheers,
> Bastian
> 
> v4 -> v5:
>     - fixed rebase error
>     - moved TARGET_LONG_BITS check of shift instructions before rd == 0 check
>     - removed extra sign extension of sraiw
>     - removed rs2 == 0 special cases in sraw/srlw

All looks good to me now.  Thanks for persevering.


r~
