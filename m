Received: from eggs.gnu.org ([2001:4830:134:3::10]:44221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs4eg-0008V2-JG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs4ed-0003Xy-DU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:16:58 -0400
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com
	([104.47.32.106]:5472
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fs4ed-0003XW-5y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:16:55 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 21 Aug 2018 11:16:51 +0000
Message-ID: <BN7PR08MB4868B2764BC9C958CD336A7DC6310@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 00/46] Add nanoMIPS support - core
 functionality and system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Dimitrije Nikolic <dnikolic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 20, 2018 8:16 PM
>=20
> Subject: [PATCH v11 00/46] Add nanoMIPS support - core functionality and =
system mode
>=20
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20

Hello,

I feel the patches in this series should be submitted in a pull request. Pl=
ease let me know if you think otherwise.

The code review produced several significant improvements:

- LLWP/SCWP implementation is now up-to-date and correct
- nanoMIPS branches handling reimplemented
- removed all connections between nanoMIPS and M16 flag

All three improvements were initiated by Richard, to whom I say special tha=
nks.

Aleksandar Markovic

> v10->v11:
>=20
>   - all user-mode patches removed (separate series will be
>       created for them)
>   - added capability to implement availability control via CP0
>       Config3 and Config5 bits
>   - refactored accordingly availability control via XNP and MT
>   - added availability control via NMS
>   - fix for wrong mode switch to M16 now in a separate patch
>   - moderate cleanup of disassembler code
>   - rebased to the latest code
>=20
> v9->v10:
>=20
>   - first 15 patches removed since they are applied now to the
>     main tree
>   - completely removed connections to and dependance on
>       MIPS_HFLAG_M16 in nanoMIPS code
>   - completed reworking of nanoMIPS branch handling
>   - some fixes and improvements in DSP ASE patches
>   - other fixes and improvements that originate from code reviews
>   - rebased to the latest code
>=20
> v8->v9:
>=20
>   - reoganized (moved/squashed) patches so that clang build bisect
>      works (as the result, number of patches dropped from 87 to 84)
>   - re-examined and reworked 32-bit nanoMIPS branch instructions
>   - minor improvements in commit messages
>   - rebased to the latest code
>=20
> v7->v8:
>=20
>   - the series is slightly reorganized so that:
>       - patches 1-19 are fixes and improvements that are not
>       dependent on the existence of nanoMIPS (even though most
>       of them are logicaly connected to (and necessary for)
>       nanoMIPS support) - they fix and improve pre-nanoMIPS code
>       - patches 20-65 introduce core nanoMIPS functionality, but
>       do not contain any dependence on or reference to nanoMIPS
>       Linux ABI
>       - patches 66-87 mostly deal with Linux user mode-related
>       nanoMIPS functionality, therefore dependent on nanoMIPS
>       Linux ABI
>   - the series will probably be split into three (corresponding
>       to the organization mentioned above) in near future
>   - added support for availability control via bit config XNP
>   - fixed availabitily control for LLWP/SCWP
>   - added support for availability control via bit config MT
>   - fixed availabitily control for pre-nanoMIPS MT ASE
>   - fixed availabitily control for nanoMIPS MT ASE
>   - completely removed case-statements defined by integer range
>       from translate.c
>   - patch on nanoMIPS specifics in ELF headers split into two
>   - patch on GT64120-related functionality in nanoMIPS bootloader
>       updated with comments and reorganizes with respect to
>       endianness
>   - replaced one instance of shift/mask with extract32()
>   - fixed one instance of missing default case in decoding engine
>   - removed several instances of unnecessary default case in
>     decoding engine
>   - minor tweaks related to variable scope and naming
>   - fixed several spelling mistakes in commit messages
>   - rebased to the latest code
>=20
> v6->v7:
>=20
>   - found a better place for MIPS_ARCH in elf.h
>   - improved patch for LLWP and SCWP
>   - fixed missing availability control, alignment, usage
>     of extract32() in DSP patches
>   - added disassembler support for microMIPS and nanoMIPS
>   - removed unnecessary addition of one empty line in the
>     patch on WR bit
>   - improved statx() syscall translation
>   - improved nanoMIPS items in binfmt script
>   - amended pre-nanoMIPS items in qemu-doc.texi
>   - added nanoMIPS items in qemu-doc.texi
>   - changed slightly patch order to be logicaly more
>     comprehensive
>   - rebased to the latest code
>   - NOTE: there will be some sheckpatch.pl errors and warning
>     for this series; however, we think those are flase positives
>     in these particular circumstances - therefore we will not
>     change any patch related to these checkpatch.pl messages
>=20
> v5->v6:
>=20
>   - used names offset and imm instead of rd and rs when
>     appropriate
>   - used gen_op_addr_addi when appropriate in one more place
>   - avoided usage of tcg_temp_local_new
>   - avoided unnecessary sign extension related to addr_add
>   - fixed unprotected storing to cpu_gpr[0]
>   - removed some unnecessary testing for ISA_NANOMIPS
>   - updated patch for LLWP and SCWP
>   - extract32 inserted instead of shift/mask in DSP patches
>   - removed useless casts from DSP patches
>   - reorganized functions to eliminated duplicated loading of
>     gpr values into tcg variables in DSP patches
>   - check Config1.WR bit for Watch registers only when using
>     in runtime
>   - removed duplicated check for bad address in PC register
>   - added support for statx system call
>   - updated script qemu-binfmt-conf.sh for nanoMIPS
>   - rebased to the latest code
>=20
> v4->v5:
>=20
>   - merged series "Mips maintenance and misc fixes and improvements"
>     and this one for easier handling (there are build dependencies)
>   - eliminated shadow variables from translate.c
>   - replaced shift/mask combination with extract32()
>   - added new function gen_op_addr_addi()
>   - added patch for LLWP and SCWP
>   - added "fall through" comments at appropriate places
>   - eliminated micromips flag from I7200 definition
>   - numerous other enhancements originating from reviewer's
>     comments
>   - some of the patches split into two or more for easier
>     handling and review
>   - rebased to the latest code
>=20
> v3->v4:
>=20
>   - added support for nanoMIPS user mode functionality and
>     configuration
>   - DSP patch split into three for easier review and handling
>   - corrected indentation in all decoding engine patches
>   - shift/mask replaced with equivalent extract32() in some
>     patches
>   - added missing default cases in some patches
>   - refactored invocation logic aroung decode_nanomips_opc()
>   - improved comments before decode_gpr_XXX() utilities
>   - all four decode_gpr_XXX() are now in a single patch
>   - two patches on updating BadInstr and related registers
>     are now merged, and execution logic improved
>   - minor formatting corrections
>   - rebased to the latest code
>=20
> v2->v3:
>=20
>   - added support for nanoMIPS-specifics in ELF headers
>   - added support for CP0 Config0.WR bit
>   - updated I7200 definition
>   - improved indentation of some switch statements
>   - slight reorganization of patches (splitting, order)
>   - rebased to the latest code
>=20
> v1->v2:
>=20
>   - added DSP ASE support
>   - added MT ASE support
>   - added GDB XML support
>   - order of patches changed
>   - commit messages and patch title improved across the board
>   - obsolete email addresses for authors and cosigners replaced
>     with the right ones
>   - some functions renamed to reflect better the documentation
>   - some macros renamed to reflect better their nanoMIPS nature
>   - streamlined formatting
>   - some of other reviewer's comments addressed, but the majority
>     was not; this is because the focus of this version was on
>     completing the functionality as much as possible; remaining
>     comments will be addressed in the subsequent versions of this
>     series
