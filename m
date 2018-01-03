Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWZCe-0005sB-Qm
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWZCc-0004X0-Pw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:54:52 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWZCc-0004WG-J7
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:54:50 -0500
Received: by mail-oi0-x229.google.com with SMTP id j14so213272oih.3
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 18:54:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180103024112.GA25758@localhost.localdomain>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
	<20180103024112.GA25758@localhost.localdomain>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 3 Jan 2018 15:54:48 +1300
Message-ID: <CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Jan 3, 2018 at 3:41 PM, Fam Zheng <famz@redhat.com> wrote:

> On Wed, 01/03 15:00, Michael Clark wrote:
> > So it's essentially one error, the single line case pattern for
> > table-driven decode which flags for long lines and asks to separate break
> > onto its own line.
> >
> > We have actually reduced the readability of other parts of the code to
> > conform to this specific rule. In fact I spent a day and a half with
> > checkpatch, but it didn't seem to make sense for the disassembler.
> >
> > The question is should one blindly comply with the rule for
> > machine-generated tables. Editing the code manually introduces the
> > potential for human error. I can, if needed, modify the disassembler
> > generator to output code with the required verbosity.
>
> Thanks for taking a look! Practically, consistency with the rest of the
> code and
> human judgements (comments, explanation in replies etc.) often override the
> checkpatch complaints. Checkpatch is not always right.


Thanks.

Here is a run with [PATCH v1 04/21] removed to make the checkpatch output
more readable. checkpatch is (perhaps incorrectly) flagging a request for
space in a case value that is synthesised from a macro. Case values usually
don't have space between the value and the colon. It's possibly because the
case value is constructed from a macro and contains parenthesis. The other
issue is consistency with existing source in scripts/qemu-binfmt-conf.sh as
previously noted.


$ mv outgoing/v1-0004-RISC-V-Disassembler.patch
outgoing/v1-0004-RISC-V-Disassembler.patch.off
$ ./scripts/checkpatch.pl outgoing/*.patch
total: 0 errors, 0 warnings, 16 lines checked

outgoing/v1-0001-RISC-V-Maintainers.patch has no obvious style problems and
is ready for submission.
total: 0 errors, 0 warnings, 8 lines checked

outgoing/v1-0002-RISC-V-ELF-Machine-Definition.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 1112 lines checked

outgoing/v1-0003-RISC-V-CPU-Core-Definition.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 1279 lines checked

outgoing/v1-0005-RISC-V-CPU-Helpers.patch has no obvious style problems and
is ready for submission.
total: 0 errors, 0 warnings, 616 lines checked

outgoing/v1-0006-RISC-V-FPU-Support.patch has no obvious style problems and
is ready for submission.
total: 0 errors, 0 warnings, 59 lines checked

outgoing/v1-0007-RISC-V-GDB-Stub.patch has no obvious style problems and is
ready for submission.
ERROR: spaces required around that ':' (ctx:VxE)
#669: FILE: target/riscv/translate.c:257:
+    CASE_OP_32_64(OPC_RISC_ADD):
                                ^

ERROR: spaces required around that ':' (ctx:VxE)
#672: FILE: target/riscv/translate.c:260:
+    CASE_OP_32_64(OPC_RISC_SUB):
                                ^

ERROR: spaces required around that ':' (ctx:VxE)
#726: FILE: target/riscv/translate.c:314:
+    CASE_OP_32_64(OPC_RISC_MUL):
                                ^

total: 3 errors, 0 warnings, 2409 lines checked

outgoing/v1-0008-RISC-V-TCG-Code-Generation.patch has style problems,
please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
total: 0 errors, 0 warnings, 451 lines checked

outgoing/v1-0009-RISC-V-Physical-Memory-Protection.patch has no obvious
style problems and is ready for submission.
total: 0 errors, 0 warnings, 1704 lines checked

outgoing/v1-0010-RISC-V-Linux-User-Emulation.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 774 lines checked

outgoing/v1-0011-RISC-V-HTIF-Console.patch has no obvious style problems
and is ready for submission.
total: 0 errors, 0 warnings, 140 lines checked

outgoing/v1-0012-RISC-V-HART-Array.patch has no obvious style problems and
is ready for submission.
total: 0 errors, 0 warnings, 368 lines checked

outgoing/v1-0013-SiFive-RISC-V-CLINT-Block.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 649 lines checked

outgoing/v1-0014-SiFive-RISC-V-PLIC-Block.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 539 lines checked

outgoing/v1-0015-RISC-V-Spike-Machines.patch has no obvious style problems
and is ready for submission.
total: 0 errors, 0 warnings, 437 lines checked

outgoing/v1-0016-RISC-V-VirtIO-Machine.patch has no obvious style problems
and is ready for submission.
total: 0 errors, 0 warnings, 258 lines checked

outgoing/v1-0017-SiFive-RISC-V-UART-Device.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 150 lines checked

outgoing/v1-0018-SiFive-RISC-V-PRCI-Block.patch has no obvious style
problems and is ready for submission.
total: 0 errors, 0 warnings, 311 lines checked

outgoing/v1-0019-SiFive-Freedom-E300-RISC-V-Machine.patch has no obvious
style problems and is ready for submission.
total: 0 errors, 0 warnings, 407 lines checked

outgoing/v1-0020-SiFive-Freedom-U500-RISC-V-Machine.patch has no obvious
style problems and is ready for submission.
WARNING: line over 80 characters
#246: FILE: scripts/qemu-binfmt-conf.sh:99:
+riscv32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'

ERROR: line over 90 characters
#247: FILE: scripts/qemu-binfmt-conf.sh:100:
+riscv32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'

WARNING: line over 80 characters
#250: FILE: scripts/qemu-binfmt-conf.sh:103:
+riscv64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'

ERROR: line over 90 characters
#251: FILE: scripts/qemu-binfmt-conf.sh:104:
+riscv64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'

total: 2 errors, 2 warnings, 151 lines checked

outgoing/v1-0021-RISC-V-Build-Infrastructure.patch has style problems,
please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
