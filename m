Received: from eggs.gnu.org ([2001:4830:134:3::10]:34189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gL3Qc-0000lJ-Sx
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gL3QY-0005zE-RX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:50:14 -0500
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com
	([104.47.37.108]:59904
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gL3QY-0005y6-I7
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:50:10 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 9 Nov 2018 09:50:06 +0000
Message-ID: <BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541616663.git.noring@nocrew.org>,
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>,
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/mips: Fix decoding mechanism
 of special R5900 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: Re: [PATCH v2 4/6] target/mips: Fix decoding mechanism of specia=
l R5900 opcodes
>=20
> Hi Aleksandar,
>=20
> > Fredrik, do you know by any chance if a document exists that would just=
ify
> > inclusion of non-R5900 DMULT, DMULTU, DDIV, DDIVU in R5900 executables =
by
> > gcc for R5900? Is it included by cross-gcc or by native gcc, or by both=
?
> >
> > I think gcc folks must have had a good reason for that, some kind of
> > design - it can't be 'I really like/miss this instruction, let's includ=
e
> > it...'
>=20
> The R5900 reports itself as MIPS III ...

This is very unclear. What do you mean by this? How does R5900 do that? I c=
an't find any trace of such intentions in R5900 docs.

> ... and DMULT, DMULTU, DDIV and DDIVU
> are part of the MIPS III ISA. They are emulated in user mode to support
> generic MIPS III programs.

Pure MIPS III executables should not be a concern of the R5900 emulation, b=
ut R5900 executables.

Could you please provide a document that would justify inclusion of these n=
on-R5900 instruction in an R5900 emulation?

Thanks,
Aleksandar
