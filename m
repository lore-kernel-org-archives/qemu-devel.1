Received: from eggs.gnu.org ([2001:4830:134:3::10]:49978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elimT-0006c1-9t
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elimO-00050Y-Mx
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:10:29 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:42549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1elimO-00050I-7x
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:10:24 -0500
Received: by mail-pl0-x22e.google.com with SMTP id 31so1812113ple.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 14:10:24 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-10-git-send-email-mjc@sifive.com>
	<20180213215541.GA1816@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <731db20e-4d86-e288-504c-30c83b56fd33@linaro.org>
Date: Tue, 13 Feb 2018 14:10:20 -0800
MIME-Version: 1.0
In-Reply-To: <20180213215541.GA1816@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/13/2018 01:55 PM, Emilio G. Cota wrote:
> On Thu, Feb 08, 2018 at 14:28:34 +1300, Michael Clark wrote:
>> TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
>> RISC-V code generator has complete coverage for the Base ISA v2.2,
>> Privileged ISA v1.9.1 and Privileged ISA v1.10:
>>
>> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
>> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
>> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> ---
> (snip)
>> +++ b/target/riscv/translate.c
> (snip)
>> +enum {
>> +    BS_NONE     = 0, /* When seen outside of translation while loop, indicates
>> +                     need to exit tb due to end of page. */
>> +    BS_STOP     = 1, /* Need to exit tb for syscall, sret, etc. */
> 
> Are we planning to use BS_STOP in the future? I see it has no setters,
> although we check for it in gen_intermediate_code:

No, but the whole port should be converted to exec/translator.h, which defines
DisasJumpType.  Not something I'm going to require on initial submission until
we've gotten most of the other targets cleaned up.


r~
