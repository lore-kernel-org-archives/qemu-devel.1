Received: from eggs.gnu.org ([2001:4830:134:3::10]:35600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTyqf-00053i-P2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTyqb-00018k-0k
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:36:57 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTyqa-00018E-T3
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:36:52 -0500
Received: by mail-qt0-x241.google.com with SMTP id n13so4637787qtc.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:36:52 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170118220146.489-1-marex@denx.de>
	<20170118220146.489-2-marex@denx.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <faf70def-be47-cf05-8f90-2ec89253cded@twiddle.net>
Date: Wed, 18 Jan 2017 14:36:47 -0800
MIME-Version: 1.0
In-Reply-To: <20170118220146.489-2-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 1/7] nios2: Add disas entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Alexander Graf <agraf@suse.de>

On 01/18/2017 02:01 PM, Marek Vasut wrote:
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

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
