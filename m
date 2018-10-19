Received: from eggs.gnu.org ([2001:4830:134:3::10]:34654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDUpV-0001Zj-JY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDUpS-0005DT-DT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:28:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDUpS-000582-1w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:28:38 -0400
References: <cover.1539428198.git.noring@nocrew.org>
	<BN6PR2201MB125158347C995B4CC764BCDBC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <40c175ec-9f64-0f05-f63d-b3d00d0705cc@vivier.eu>
Date: Fri, 19 Oct 2018 15:28:15 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB125158347C995B4CC764BCDBC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 0/7] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Le 15/10/2018 à 14:16, Aleksandar Markovic a écrit :
>> From: Fredrik Noring <noring@nocrew.org>
>> Sent: Saturday, October 13, 2018 1:09 PM
>> To: Aleksandar Markovic; Maciej W. Rozycki; Philippe Mathieu-Daudé
>> Cc: Richard Henderson; Aurelien Jarno; Petar Jovanovic; Peter Maydell; Jürgen Urban; > qemu-devel@nongnu.org
>> Subject: [PATCH v7 0/7] target/mips: Limited support for the R5900
>>
>> The primary purpose of these changes is to support programs compiled
>> by GCC for the R5900 target and thereby run R5900 Linux distributions,
>> for example Gentoo.
>>
> 
> Hello, Fredrik.
> 
> Your series is getting better and better with each version, which is very good. For a change, I don't have any objection about the title. :) Patch 7 will be integrated shortly in the MIPS queue, you don't need to worry about it. With this series you are not only supporting your prime use case, but you are introducing a new instruction set to QEMU. Try to step back and get wider perspective. No matter how limited the support for the new ISA is, its introduction to QEMU must have following elements:
> 
> (1) Definition of basic preprocessor constants for the new ISA.
> (2) All opcodes for the ISA.
> (3) Basic decoding engine for new instructions.
> 
> Your patch 1 adresses 1). However, there are no patches for (2) and (3) in this series. Let me walk though the details on how to implement (2) and (3).
> 
> (2) All opcodes for the ISA.

As Fredrik only wants to use R5900 gentoo userland binaries using qemu
linux-user mode, does he really need to implement all the opcodes of the
ISA?

Most of the architectures have started with only the userland
instruction set, and the privileged instruction set was added once this
part was validated (see the risu project
https://wiki.linaro.org/PeterMaydell/Risu). It was really helpful for me
to add the m680x0 processor emulation in QEMU by this way (I've added
FPU and MMU later)

It can be a lot of work to add all the opcodes for the ISA, and be very
time consuming, and Fredrik has only test case for the opcode he has
implemented, the rest of the ISA will not be tested, or will need more
work from him.

So perhaps a not fully implemented R5900 ISA (with big WARNINGs in the
code, and perhaps assert()?) would be better than nothing at all?

Thanks,
Laurent
