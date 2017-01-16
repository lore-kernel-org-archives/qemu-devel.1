Received: from eggs.gnu.org ([2001:4830:134:3::10]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTEva-0007Yf-4X
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTEvV-0000NG-7S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:34:58 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTEvV-0000Mx-1W
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:34:53 -0500
References: <20161231132226.9595-1-marex@denx.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <eb6384ac-e109-46c2-cd17-8a105efb78de@denx.de>
Date: Mon, 16 Jan 2017 22:34:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161231132226.9595-1-marex@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 1/7] nios2: Add disas entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Richard Henderson <rth@twiddle.net>

On 12/31/2016 02:22 PM, Marek Vasut wrote:
> Add nios2 disassembler support. This patch is composed from binutils files
> from commit "Opcodes and assembler support for Nios II R2". The files from
> binutils used in this patch are:
> 
>     include/opcode/nios2.h
>     include/opcode/nios2r1.h
>     include/opcode/nios2r2.h
>     opcodes/nios2-opc.c
>     opcodes/nios2-dis.c
> 
> Checkpatch says total: 114 errors, 0 warnings, 3609 lines checked , which
> is caused by a different coding style in those files. These warnings and
> errors are not addressed To let these files be easily synchronized between
> binutils and qemu.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>

[...]

Bump ? All the review comments I received have been addressed, so can
this series be applied now ?

-- 
Best regards,
Marek Vasut
