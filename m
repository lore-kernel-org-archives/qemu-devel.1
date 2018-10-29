Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH5l9-0004QD-Ex
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH5l3-0001ot-EV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:31:03 -0400
Received: from mail-by2nam01on0092.outbound.protection.outlook.com
	([104.47.34.92]:17312
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gH5l3-00011Y-0u
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:30:57 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 29 Oct 2018 11:30:12 +0000
Message-ID: <BN6PR2201MB1251104F3707E401744C8448C6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 00/20] target/mips: Add limited support
 for Ingenic's MXU ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jancraig@amazon.com" <jancraig@amazon.com>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH v8 00/20] target/mips: Add limited support for Ingenic's =
MXU ASE
>=20
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> This patch set begins to add MXU ASE instruction support.
>=20

Craig, do you have any comments/suggestions on this series?

Regards,
Aleksandar

> v7->v8:
>=20
>   - corrected several mistakes in MXU ASE overview note
>   - add several clarifying comments
>   - rebased to the latest code
>=20
> v6->v7:
>=20
>   - move MXU_EN check to the main MXU decoding function
>   - amend MXU ASE overview note
>=20
> v5->v6:
>=20
>   - added bit definitions for 'aptn1' and 'eptn2'.
>   - pool04 eliminated, since it is covered by a single instruction.
>   - moved MUL, S32M2I, S32I2M handling out of main MXU switch.
>   - rebased to the latest code (this series applies on top of
>     the current MIPS pull request)
>=20
> v4->v5:
>=20
>   - added full decoding engine for MXU ASE
>   - changes on aptn2, optn2, optn3 are now stand-alone patches
>   - all patches on individual instructions are reworked to fit
>     new decoding engine, and also cosmetically improved
>   - rebased to the latest code
>=20
> Aleksandar Markovic (8):
>   target/mips: Amend MXU instruction opcodes
>   target/mips: Add and integrate MXU decoding engine placeholder
>   target/mips: Add MXU decoding engine
>   target/mips: Add bit encoding for MXU accumulate add/sub 1-bit pattern
>     'aptn1'
>   target/mips: Add bit encoding for MXU execute add/sub pattern 'eptn2'
>   target/mips: Move MUL, S32M2I, S32I2M handling out of main MXU switch
>   target/mips: Move MXU_EN check one level higher
>   target/mips: Amend MXU ASE overview note
>=20
> Craig Janeczek (12):
>   target/mips: Introduce MXU registers
>   target/mips: Define a bit for MXU in insn_flags
>   target/mips: Add bit encoding for MXU accumulate add/sub 2-bit pattern
>     'aptn2'
>   target/mips: Add bit encoding for MXU operand getting pattern 'optn2'
>   target/mips: Add bit encoding for MXU operand getting pattern 'optn3'
>   target/mips: Add emulation of non-MXU MULL within MXU decoding engine
>   target/mips: Add emulation of MXU instructions S32I2M and S32M2I
>   target/mips: Add emulation of MXU instruction S8LDD
>   target/mips: Add emulation of MXU instruction D16MUL
>   target/mips: Add emulation of MXU instruction D16MAC
>   target/mips: Add emulation of MXU instructions Q8MUL and Q8MULSU
>   target/mips: Add emulation of MXU instructions S32LDD and S32LDDR
>=20
>  target/mips/cpu.h       |   10 +
>  target/mips/mips-defs.h |    1 +
>  target/mips/translate.c | 2104 +++++++++++++++++++++++++++++++++++++++++=
+-----
>  3 files changed, 1896 insertions(+), 219 deletions(-)
>=20
> --
> 2.7.4
