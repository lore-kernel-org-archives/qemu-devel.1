Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1flZPf-0005zH-Ua
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1flZPb-00012V-Jk
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:42:35 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com
	([40.107.70.133]:5664
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1flZPb-00010X-4w
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:42:31 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 12:42:26 +0000
Message-ID: <DM6PR08MB48730D24D589AB253601B432D4230@DM6PR08MB4873.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<153323295241.18020.13773493968733946892@502c9da6d61e>
In-Reply-To: <153323295241.18020.13773493968733946892@502c9da6d61e>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/77] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "stefan.markovic@rt-rk.com" <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, Paul Burton <pburton@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>


Hi,

This series seems to have some coding style problems.

Yes, we are aware of those issues:

1. "Does MAINTAINERS need an update" warning for several patches: The answe=
r is there is no need to update MAINTAINERS file. These warnings will persi=
st in any version of this series. We will not fix any patch. Please ignore =
these warnings.

2. "Lines longer than 80 characters" warning in patch 77/77: Because of the=
 nature of the file affected by this patch, those lines longer than 80 char=
acters needs to exist. We will not fix any patch. Please ignore these warni=
ngs.

Regards,
Stefan


________________________________
From: no-reply@patchew.org <no-reply@patchew.org>
Sent: Thursday, August 2, 2018 8:02:34 PM
To: stefan.markovic@rt-rk.com
Cc: famz@redhat.com; qemu-devel@nongnu.org; Paul Burton; Stefan Markovic; r=
iku.voipio@iki.fi; richard.henderson@linaro.org; laurent@vivier.eu; Aleksan=
dar Rikalo; philippe.mathieu.daude@gmail.com; Aleksandar Markovic; Petar Jo=
vanovic; aurelien@aurel32.net
Subject: Re: [Qemu-devel] [PATCH v6 00/77] Add nanoMIPS support to QEMU

Hi,

This series seems to have some coding style problems. See output below for
more information:

Type: series
Message-id: 1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com
Subject: [Qemu-devel] [PATCH v6 00/77] Add nanoMIPS support to QEMU

=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
#!/bin/bash

BASE=3Dbase
n=3D1
total=3D$(git log --oneline $BASE.. | wc -l)
failed=3D0

git config --local diff.renamelimit 0
git config --local diff.renames True
git config --local diff.algorithm histogram

commits=3D"$(git log --format=3D%H --reverse $BASE..)"
for c in $commits; do
    echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
    if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailback =
-; then
        failed=3D1
        echo
    fi
    n=3D$((n+1))
done

exit $failed
=3D=3D=3D TEST SCRIPT END =3D=3D=3D

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
Switched to a new branch 'test'
64eda72870 linux-user: Add nanoMIPS support in scripts/qemu-binfmt-conf.sh
e1a8cee4e5 linux-user: Add nanoMIPS linux user mode configuration support
df0e845f6e linux-user: Add support for statx() syscall for all platforms
32fec98ab2 linux-user: Amend support for sigaction() syscall for nanoMIPS
d4bfe737f2 linux-user: Add cpu_loop.c for nanoMIPS
4e1a987087 linux-user: Add support for nanoMIPS signal trampoline
aab0010a40 linux-user: Add signal.c for nanoMIPS
532eab67e7 linux-user: Add target_elf.h header for nanoMIPS
ddf77d7ac3 linux-user: Add target_structs.h header for nanoMIPS
84769d57a3 linux-user: Add target_cpu.h header for nanoMIPS
1fb20c1a72 linux-user: Add target_syscall.h header for nanoMIPS
d953da1580 linux-user: Add sockbits.h header for nanoMIPS
b0efc906fd linux-user: Add target_fcntl.h header for nanoMIPS
9d02c1e8eb linux-user: Update syscall_defs.h header for nanoMIPS
08fa324773 linux-user: Add termbits.h header for nanoMIPS
4821ebaae2 linux-user: Add target_signal.h header for nanoMIPS
06a0c46995 linux-user: Add syscall numbers for nanoMIPS
73be124213 target/mips: Add definition of nanoMIPS I7200 CPU
dbb82d28a4 gdbstub: Add XML support for GDB for nanoMIPS
186274afc1 gdbstub: Disable handling of nanoMIPS ISA bit in the MIPS gdbstu=
b
7c8e071621 mips_malta: Fix semihosting argument passing for nanoMIPS bare m=
etal
12091e1b6a mips_malta: Setup GT64120 BARs in nanoMIPS bootloader
c6323a3d69 mips_malta: Add basic nanoMIPS boot code for MIPS' Malta
0b61ee6473 elf: Don't check FCR31_NAN2008 bit for nanoMIPS
e8981250f1 elf: Relax MIPS' elf_check_arch() to accept EM_NANOMIPS too
d420a2f219 elf: Add nanoMIPS specific variations in ELF header fields
ed34b57a9c target/mips: Fix ERET/ERETNC behavior related to ADEL exception
b87394bad8 target/mips: Adjust set_pc() for nanoMIPS
e4f7784168 target/mips: Adjust set_hflags_for_handler() for nanoMIPS
2092c88d8f target/mips: Adjust exception_resume_pc() for nanoMIPS
9e4037a9d7 target/mips: Implement CP0 Config1.WR bit functionality
d5283f3176 target/mips: Add updating BadInstr, BadInstrP, BadInstrX for nan=
oMIPS
42416dd9c3 target/mips: Implement emulation of nanoMIPS LLWP/SCWP pair
69c9bcbca8 target/mips: Add handling of branch delay slots for nanoMIPS
e3054474bc target/mips: Add emulation of DSP ASE for nanoMIPS - part 6
a59cf3890e target/mips: Add emulation of DSP ASE for nanoMIPS - part 5
fb3e985dcd target/mips: Add emulation of DSP ASE for nanoMIPS - part 4
6ab266466c target/mips: Add emulation of DSP ASE for nanoMIPS - part 3
04a64ebd5f target/mips: Add emulation of DSP ASE for nanoMIPS - part 2
9a77858051 target/mips: Add emulation of DSP ASE for nanoMIPS - part 1
faaa015779 target/mips: Implement MT ASE support for nanoMIPS
2b4090fbff target/mips: Add emulation of nanoMIPS 32-bit branch instruction=
s
4d8ddca2e1 target/mips: Add emulation of nanoMIPS 32-bit load and store ins=
tructions
c0fd0eea21 target/mips: Implement emulation of nanoMIPS EXTW instruction
f06df895ec target/mips: Implement emulation of nanoMIPS ROTX instruction
4bd3210913 target/mips: Add emulation of misc nanoMIPS instructions (p_lsx)
8860af1984 target/mips: Add emulation of misc nanoMIPS instructions (pool32=
axf)
7600a72911 target/mips: Add emulation of misc nanoMIPS instructions (pool32=
a0)
3a16a5a7c1 target/mips: Add emulation of nanoMIPS FP instructions
5752ef6f96 target/mips: Add emulation of nanoMIPS 48-bit instructions
8416c94b0b target/mips: Add emulation of nanoMIPS instructions MOVE.P and M=
OVE.PREV
5e5735abfd target/mips: Add emulation of some common nanoMIPS 32-bit instru=
ctions
111050a1a4 target/mips: Add emulation of nanoMIPS 16-bit save and restore i=
nstructions
43c3921546 target/mips: Add emulation of nanoMIPS 16-bit logic instructions
701b37e40e target/mips: Add emulation of nanoMIPS 16-bit load and store ins=
tructions
9a3ed3ef5b target/mips: Add emulation of nanoMIPS 16-bit misc instructions
46fbf41e0b target/mips: Add emulation of nanoMIPS 16-bit shift instructions
4e4bb7d89e target/mips: Add emulation of nanoMIPS 16-bit branch instruction=
s
d025bf6095 target/mips: Add emulation of nanoMIPS 16-bit arithmetic instruc=
tions
a8e7c69cde target/mips: Add nanoMIPS decoding and extraction utilities
1a10ec177a target/mips: Add placeholder and invocation of decode_nanomips_o=
pc()
35d6929b49 target/mips: Add nanoMIPS DSP ASE opcodes
b21f9ea00f target/mips: Add nanoMIPS base instruction set opcodes
0c8be110d8 target/mips: Add preprocessor constants for nanoMIPS
3e7d1af77a linux-user: Add preprocessor availability control to some syscal=
ls
286793a63d linux-user: Update MIPS syscall numbers up to kernel 4.18 header=
s
62ca346b44 elf: Add ELF flags for MIPS machine variants
99d6e75f45 elf: Remove duplicate preprocessor constant definition
8a93d61b15 target/mips: Check ELPA flag only in some cases of MFHC0 and MTH=
C0
5dc3e9663e target/mips: Don't update BadVAddr register in Debug Mode
a817c46476 target/mips: Add gen_op_addr_addi()
1978cd96ba target/mips: Add CP0 BadInstrX register
1149b1e3e4 target/mips: Update some CP0 registers bit definitions
f68c083414 target/mips: Fix two instances of shadow variables
06abdd383a target/mips: Mark switch fallthroughs with interpretable comment=
s
a52ac50ccd target/mips: Avoid case statements formulated by ranges
e2d6fa289c MAINTAINERS: Update target/mips maintainer's email addresses

=3D=3D=3D OUTPUT BEGIN =3D=3D=3D
Checking PATCH 1/77: MAINTAINERS: Update target/mips maintainer's email add=
resses...
Checking PATCH 2/77: target/mips: Avoid case statements formulated by range=
s...
Checking PATCH 3/77: target/mips: Mark switch fallthroughs with interpretab=
le comments...
Checking PATCH 4/77: target/mips: Fix two instances of shadow variables...
Checking PATCH 5/77: target/mips: Update some CP0 registers bit definitions=
...
Checking PATCH 6/77: target/mips: Add CP0 BadInstrX register...
Checking PATCH 7/77: target/mips: Add gen_op_addr_addi()...
Checking PATCH 8/77: target/mips: Don't update BadVAddr register in Debug M=
ode...
Checking PATCH 9/77: target/mips: Check ELPA flag only in some cases of MFH=
C0 and MTHC0...
Checking PATCH 10/77: elf: Remove duplicate preprocessor constant definitio=
n...
Checking PATCH 11/77: elf: Add ELF flags for MIPS machine variants...
Checking PATCH 12/77: linux-user: Update MIPS syscall numbers up to kernel =
4.18 headers...
Checking PATCH 13/77: linux-user: Add preprocessor availability control to =
some syscalls...
Checking PATCH 14/77: target/mips: Add preprocessor constants for nanoMIPS.=
..
Checking PATCH 15/77: target/mips: Add nanoMIPS base instruction set opcode=
s...
Checking PATCH 16/77: target/mips: Add nanoMIPS DSP ASE opcodes...
Checking PATCH 17/77: target/mips: Add placeholder and invocation of decode=
_nanomips_opc()...
Checking PATCH 18/77: target/mips: Add nanoMIPS decoding and extraction uti=
lities...
Checking PATCH 19/77: target/mips: Add emulation of nanoMIPS 16-bit arithme=
tic instructions...
Checking PATCH 20/77: target/mips: Add emulation of nanoMIPS 16-bit branch =
instructions...
Checking PATCH 21/77: target/mips: Add emulation of nanoMIPS 16-bit shift i=
nstructions...
Checking PATCH 22/77: target/mips: Add emulation of nanoMIPS 16-bit misc in=
structions...
Checking PATCH 23/77: target/mips: Add emulation of nanoMIPS 16-bit load an=
d store instructions...
Checking PATCH 24/77: target/mips: Add emulation of nanoMIPS 16-bit logic i=
nstructions...
Checking PATCH 25/77: target/mips: Add emulation of nanoMIPS 16-bit save an=
d restore instructions...
Checking PATCH 26/77: target/mips: Add emulation of some common nanoMIPS 32=
-bit instructions...
Checking PATCH 27/77: target/mips: Add emulation of nanoMIPS instructions M=
OVE.P and MOVE.PREV...
Checking PATCH 28/77: target/mips: Add emulation of nanoMIPS 48-bit instruc=
tions...
Checking PATCH 29/77: target/mips: Add emulation of nanoMIPS FP instruction=
s...
Checking PATCH 30/77: target/mips: Add emulation of misc nanoMIPS instructi=
ons (pool32a0)...
Checking PATCH 31/77: target/mips: Add emulation of misc nanoMIPS instructi=
ons (pool32axf)...
Checking PATCH 32/77: target/mips: Add emulation of misc nanoMIPS instructi=
ons (p_lsx)...
Checking PATCH 33/77: target/mips: Implement emulation of nanoMIPS ROTX ins=
truction...
Checking PATCH 34/77: target/mips: Implement emulation of nanoMIPS EXTW ins=
truction...
Checking PATCH 35/77: target/mips: Add emulation of nanoMIPS 32-bit load an=
d store instructions...
Checking PATCH 36/77: target/mips: Add emulation of nanoMIPS 32-bit branch =
instructions...
Checking PATCH 37/77: target/mips: Implement MT ASE support for nanoMIPS...
Checking PATCH 38/77: target/mips: Add emulation of DSP ASE for nanoMIPS - =
part 1...
Checking PATCH 39/77: target/mips: Add emulation of DSP ASE for nanoMIPS - =
part 2...
Checking PATCH 40/77: target/mips: Add emulation of DSP ASE for nanoMIPS - =
part 3...
Checking PATCH 41/77: target/mips: Add emulation of DSP ASE for nanoMIPS - =
part 4...
Checking PATCH 42/77: target/mips: Add emulation of DSP ASE for nanoMIPS - =
part 5...
Checking PATCH 43/77: target/mips: Add emulation of DSP ASE for nanoMIPS - =
part 6...
Checking PATCH 44/77: target/mips: Add handling of branch delay slots for n=
anoMIPS...
Checking PATCH 45/77: target/mips: Implement emulation of nanoMIPS LLWP/SCW=
P pair...
Checking PATCH 46/77: target/mips: Add updating BadInstr, BadInstrP, BadIns=
trX for nanoMIPS...
Checking PATCH 47/77: target/mips: Implement CP0 Config1.WR bit functionali=
ty...
Checking PATCH 48/77: target/mips: Adjust exception_resume_pc() for nanoMIP=
S...
Checking PATCH 49/77: target/mips: Adjust set_hflags_for_handler() for nano=
MIPS...
Checking PATCH 50/77: target/mips: Adjust set_pc() for nanoMIPS...
Checking PATCH 51/77: target/mips: Fix ERET/ERETNC behavior related to ADEL=
 exception...
Checking PATCH 52/77: elf: Add nanoMIPS specific variations in ELF header f=
ields...
Checking PATCH 53/77: elf: Relax MIPS' elf_check_arch() to accept EM_NANOMI=
PS too...
Checking PATCH 54/77: elf: Don't check FCR31_NAN2008 bit for nanoMIPS...
Checking PATCH 55/77: mips_malta: Add basic nanoMIPS boot code for MIPS' Ma=
lta...
Checking PATCH 56/77: mips_malta: Setup GT64120 BARs in nanoMIPS bootloader=
...
Checking PATCH 57/77: mips_malta: Fix semihosting argument passing for nano=
MIPS bare metal...
Checking PATCH 58/77: gdbstub: Disable handling of nanoMIPS ISA bit in the =
MIPS gdbstub...
Checking PATCH 59/77: gdbstub: Add XML support for GDB for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#34:
new file mode 100644

total: 0 errors, 1 warnings, 157 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 60/77: target/mips: Add definition of nanoMIPS I7200 CPU...
Checking PATCH 61/77: linux-user: Add syscall numbers for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#16:
new file mode 100644

total: 0 errors, 1 warnings, 275 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 62/77: linux-user: Add target_signal.h header for nanoMIPS..=
.
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#16:
new file mode 100644

total: 0 errors, 1 warnings, 22 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 63/77: linux-user: Add termbits.h header for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#30:
new file mode 100644

total: 0 errors, 1 warnings, 11 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 64/77: linux-user: Update syscall_defs.h header for nanoMIPS=
...
Checking PATCH 65/77: linux-user: Add target_fcntl.h header for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#14:
new file mode 100644

total: 0 errors, 1 warnings, 38 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 66/77: linux-user: Add sockbits.h header for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#14:
new file mode 100644

total: 0 errors, 1 warnings, 1 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 67/77: linux-user: Add target_syscall.h header for nanoMIPS.=
..
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#14:
new file mode 100644

total: 0 errors, 1 warnings, 30 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 68/77: linux-user: Add target_cpu.h header for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#14:
new file mode 100644

total: 0 errors, 1 warnings, 21 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 69/77: linux-user: Add target_structs.h header for nanoMIPS.=
..
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#15:
new file mode 100644

total: 0 errors, 1 warnings, 1 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 70/77: linux-user: Add target_elf.h header for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#15:
new file mode 100644

total: 0 errors, 1 warnings, 14 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 71/77: linux-user: Add signal.c for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#113:
new file mode 100644

total: 0 errors, 1 warnings, 84 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 72/77: linux-user: Add support for nanoMIPS signal trampolin=
e...
Checking PATCH 73/77: linux-user: Add cpu_loop.c for nanoMIPS...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#54:
new file mode 100644

total: 0 errors, 1 warnings, 33 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 74/77: linux-user: Amend support for sigaction() syscall for=
 nanoMIPS...
Checking PATCH 75/77: linux-user: Add support for statx() syscall for all p=
latforms...
WARNING: architecture specific defines should be avoided
#36: FILE: linux-user/syscall.c:10032:
+#if defined(__NR_statx)

WARNING: architecture specific defines should be avoided
#49: FILE: linux-user/syscall.c:10045:
+#if defined(__NR_statx)

total: 0 errors, 2 warnings, 154 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 76/77: linux-user: Add nanoMIPS linux user mode configuratio=
n support...
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#60:
new file mode 100644

total: 0 errors, 1 warnings, 38 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 77/77: linux-user: Add nanoMIPS support in scripts/qemu-binf=
mt-conf.sh...
WARNING: line over 80 characters
#30: FILE: scripts/qemu-binfmt-conf.sh:79:
+nanomips_magic=3D'\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x02\x00\xf9\x00'

ERROR: line over 90 characters
#31: FILE: scripts/qemu-binfmt-conf.sh:80:
+nanomips_mask=3D'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\=
xff\xff\xff\xff\xff\xff'

WARNING: line over 80 characters
#34: FILE: scripts/qemu-binfmt-conf.sh:83:
+nanomipseb_magic=3D'\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x02\x00\xf9'

ERROR: line over 90 characters
#35: FILE: scripts/qemu-binfmt-conf.sh:84:
+nanomipseb_mask=3D'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xf=
f\xff\xff\xff\xff\xff\xff'

total: 2 errors, 2 warnings, 30 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

=3D=3D=3D OUTPUT END =3D=3D=3D

Test command exited with code: 1


---
Email generated automatically by Patchew [http://patchew.org/].
Please send your feedback to patchew-devel@redhat.com
