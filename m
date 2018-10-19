Received: from eggs.gnu.org ([2001:4830:134:3::10]:33243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDYep-0002EJ-Kk
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDYek-0000sj-SA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:33:55 -0400
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com
	([104.47.36.117]:65264
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gDYek-0000im-Do
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:33:50 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 19 Oct 2018 17:33:42 +0000
Message-ID: <BN6PR2201MB1251A64564A3B7F337F94DA1C6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1539428198.git.noring@nocrew.org>
	<BN6PR2201MB125158347C995B4CC764BCDBC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<40c175ec-9f64-0f05-f63d-b3d00d0705cc@vivier.eu>
In-Reply-To: <40c175ec-9f64-0f05-f63d-b3d00d0705cc@vivier.eu>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Laurent Vivier <laurent@vivier.eu>, Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Friday, October 19, 2018 3:28 PM
> Subject: Re: [Qemu-devel] [PATCH v7 0/7] target/mips: Limited support for=
 the R5900
>=20
> Le 15/10/2018 =E0 14:16, Aleksandar Markovic a =E9crit :
> >> From: Fredrik Noring <noring@nocrew.org>
> >> Sent: Saturday, October 13, 2018 1:09 PM
> >> To: Aleksandar Markovic; Maciej W. Rozycki; Philippe Mathieu-Daud=E9
> >> Cc: Richard Henderson; Aurelien Jarno; Petar Jovanovic; Peter Maydell;=
 J=FCrgen Urban; > > qemu-devel@nongnu.org
> >> Subject: [PATCH v7 0/7] target/mips: Limited support for the R5900
> >>
> >> The primary purpose of these changes is to support programs compiled
> >> by GCC for the R5900 target and thereby run R5900 Linux distributions,
> >> for example Gentoo.
> >>
> >
> > Hello, Fredrik.
> >
> > Your series is getting better and better with each version, which is ve=
ry good. For a change,
> > I don't have any objection about the title. :) Patch 7 will be integrat=
ed shortly in the MIPS
> > queue, you don't need to worry about it. With this series you are not o=
nly supporting your=20
> > prime use case, but you are introducing a new instruction set to QEMU. =
Try to step back and get
> > wider perspective. No matter how limited the support for the new ISA is=
, its introduction to
> > QEMU must have following elements:
> >
> > (1) Definition of basic preprocessor constants for the new ISA.
> > (2) All opcodes for the ISA.
> > (3) Basic decoding engine for new instructions.
> >
> > Your patch 1 adresses 1). However, there are no patches for (2) and (3)=
 in this series. Let > me walk though the details on how to implement (2) a=
nd (3).
> >
> > (2) All opcodes for the ISA.
>=20
> As Fredrik only wants to use R5900 gentoo userland binaries using qemu
> linux-user mode, does he really need to implement all the opcodes of the
> ISA?
>

It should be clear from my previous mail, but this is what I meant by (2) a=
nd (3):

(2) A list of all R5900 instructions not covered by MIPS III/IV, in the for=
m of '#defines' or enum elements, logically clustered.

(3) A set of functions (in my estimation, around a dozen of them is needed)=
, each containing a switch statement with cases for individual instructions=
, each case containing only "TODO" comment and raising EXCP_RI. Of course, =
all such function should be interconnected and integrated with the rest of =
MIPS code according to the R5900 doc.

In my view, it is really a stretch that this is 'very time consuming'. True=
, it does require focus and meticulousness.

My impression is that Fridrik understood my guidance correctly. Fridrik, pl=
ease let me know if you need clarification of any kind.

Sincerely,
Aleksandar


> Most of the architectures have started with only the userland
> instruction set, and the privileged instruction set was added once this
> part was validated (see the risu project
> https://wiki.linaro.org/PeterMaydell/Risu). It was really helpful for me
> to add the m680x0 processor emulation in QEMU by this way (I've added
> FPU and MMU later)
>=20
> It can be a lot of work to add all the opcodes for the ISA, and be very
> time consuming, and Fredrik has only test case for the opcode he has
> implemented, the rest of the ISA will not be tested, or will need more
> work from him.
>=20
> So perhaps a not fully implemented R5900 ISA (with big WARNINGs in the
> code, and perhaps assert()?) would be better than nothing at all?
>=20
> Thanks,
> Laurent
>=20
>=20
>=20
