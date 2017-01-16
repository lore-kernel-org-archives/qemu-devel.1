Received: from eggs.gnu.org ([2001:4830:134:3::10]:60209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFAY-0003Az-Bb
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFAU-0005Cv-DQ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:50:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:50213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cTFAU-0005Cq-6J
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:50:22 -0500
References: <20161231132226.9595-1-marex@denx.de>
From: Alexander Graf <agraf@suse.de>
Message-ID: <d6dbcffb-7018-3231-8b18-3a80cb96b22c@suse.de>
Date: Mon, 16 Jan 2017 22:50:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161231132226.9595-1-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>



On 31/12/2016 14:22, Marek Vasut wrote:
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
> ---
> V2: Replace the nios2.c with GPL2 licensed version
> V3: Rebase on top of qemu/master

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
