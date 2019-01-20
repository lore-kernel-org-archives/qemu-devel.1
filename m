Received: from eggs.gnu.org ([209.51.188.92]:40622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JuergenUrban@gmx.de>) id 1glHgF-0005jS-HG
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 13:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JuergenUrban@gmx.de>) id 1glHgA-0002vR-QY
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 13:18:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:47641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <JuergenUrban@gmx.de>) id 1glHgA-0002qU-Gb
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 13:18:42 -0500
MIME-Version: 1.0
Message-ID: <trinity-601105da-26dd-4eb7-ad4a-0a03c1b2977a-1548008292325@3c-app-gmx-bs47>
From: =?UTF-8?Q?=22J=C3=BCrgen_Urban=22?= <JuergenUrban@gmx.de>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jan 2019 19:18:12 +0100
In-Reply-To: <BN6PR2201MB1251F33344A686B376174608C6820@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>
	<781155aaf175ea20903c12e26316ea40085457bb.1547403692.git.noring@nocrew.org>
	<BN6PR2201MB12516C7D2E235DA81812DDF0C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190116153654.GA2918@sx9>
	<BN6PR2201MB1251F33344A686B376174608C6820@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] target/mips: Require TARGET_MIPS64 for
 R5900 multimedia instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <f4bug@amsat.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello Aleksandar and Fredrik,

> Gesendet: Mittwoch, 16=2E Januar 2019 um 20:20 Uhr
> Von: "Aleksandar Markovic" <amarkovic@wavecomp=2Ecom>
> An: "Fredrik Noring" <noring@nocrew=2Eorg>
> Cc: "Aurelien Jarno" <aurelien@aurel32=2Enet>, "Philippe Mathieu-Daud=C3=
=A9" <f4bug@amsat=2Eorg>, "J=C3=BCrgen Urban" <JuergenUrban@gmx=2Ede>, "Mac=
iej W=2E Rozycki" <macro@linux-mips=2Eorg>, "qemu-devel@nongnu=2Eorg" <qemu=
-devel@nongnu=2Eorg>
> Betreff: Re: [PATCH 1/9] target/mips: Require TARGET_MIPS64 for R5900 mu=
ltimedia instructions
>
> > From: Fredrik Noring <noring@nocrew=2Eorg>
> > Sent: Wednesday, January 16, 2019 4:36 PM
> > To: Aleksandar Markovic
> > Cc: Aurelien Jarno; Philippe Mathieu-Daud=C3=A9; J=C3=BCrgen Urban; Ma=
ciej W=2E Rozycki; > qemu-devel@nongnu=2Eorg
> > Subject: Re: [PATCH 1/9] target/mips: Require TARGET_MIPS64 for R5900 =
multimedia instructions
> >=20
> > Hi Aleksandar,
> >=20
> > > Sorry, I have to disagree with this=2E
> >=20
> > It was, without a doubt, entirely clear that the o32 ABI was going to =
stay
> > in after this MMI patch series=2E In other words, this series does not=
 imply
> > the removal of o32=2E This is obvious, as discussed previously, since =
the o32
> > ABI is currently the main use case for R5900 QEMU and the reason the R=
5900
> > was implemented for QEMU to begin with=2E
> >=20
>=20
> Fredrik,
>=20
> Modeling a 64-bit processor as a 32-bit one should not be a part of QEMU
> upstream=2E

I tried to find the patch where you have a problem with, but I wasn't able=
=2E I don't see a problem in [PATCH 1/9]=2E So I don't know where the actua=
l problem is coming from=2E

Let me explain how what the actual system was able to do:
PS2 Linux was using 64-Bit and 128-Bit instructions with ABI o32 since the=
 first day it was released=2E The toolchains which I released later was als=
o using the feature that the CPU has 128/64-Bit registers which can be used=
 when ABI o32 was used=2E It is even possible to call Linux ABI n32 syscall=
s from ABI o32 ELF and vice versa=2E I used this feature to get around some=
 problems=2E
The Linux kernel which I released was able to execute MIPS III code (compl=
ete instruction set) on R5900 without any problems as long as the addresses=
 were within 32-Bit range, e=2Eg=2E in ABI n32=2E All missing instructions =
including IEEE794 compliance were handled by the Linux exception handlers=
=2E It was even able to differ between LL/SC and SQ/LQ, although the same i=
nstruction encoding is used=2E
It was possible to execute unmodified MIPS III ELF files without any probl=
em=2E
In order to correctly emulate the real PS2 Linux which I released, QEMU ha=
s to support 64-Bit registers when using ABI o32 and it would need a way to=
 configure whether all MIPS III instructions should be supported or not=2E
I=2Ee=2E QEMU should be able to support ABI o32 with a 64-Bit processor=2E=
 When this is not working there is a problem with the emulation and the pro=
blem is not r5900 related, as ABI o32 code is written in a way that it does=
n't matter whether the CPU is 128-Bit (like R5900), 64-Bit or 32-Bit=2E

Best regards
J=C3=BCrgen Urban

> > > Processor model must stay the same, and
> > > Linux ABI should not affect, for example, the number and size of pro=
cessor
> > > registers - just like it is the case in reality=2E
> >=20
> > I thought Maciej's reply to you was quite clear on this topic?
> >=20
> > > QEMU is an independent software tool - it is for example, a compiler=
-agnostic
> > > tool, and the only connection between a compiler and QEMU is the pro=
cessor
> > > documentation - and this is the reason they work together so well=2E=
 They shouldn't
> > > be "tweaked" and "integrated" to work together - both QEMU and compi=
ler should
> > > rely only on the processor specification, and should not know anythi=
ng about the
> > > other side=2E
> >=20
> > The approach was to implement ABIs and instructions that are actually =
used,
> > and leave unused or optional instructions for later=2E The reverse, re=
moving
> > ABIs in-use (o32) and focusing on unused instructions (MMIs) does not =
make
> > sense, so I will obviously not do that=2E
> >=20
> > > My advice for you is to focus on n32 at the time being=2E
> > >
> > > o32 can be implemented with the same 64-bit processor model, but in =
a much
> > > different way that you attempted some time ago=2E To avoid waste of =
our energy
> > > and time, I am suggesting that we finish n32, and think of o32 in fu=
ture=2E
> >=20
> > The o32 ABI is more important than n32 now, because o32 is in-use and
> > ready with Glibc, GCC, GAS and the Linux kernel=2E n32 is easy to enab=
le
> > with a three-line patch, so we can actually use both now=2E
> >=20
> > I recommend that we implement limited support for MMIs for n32 and
> > eventually system mode, and leave it as unsupported for o32 for the ti=
me
> > being=2E [ Perhaps MMIs for o32 could be implemented with 96-bit regis=
ters,
> > in contrast to the 64-bit registers for n32, but having LW and LQ with=
out
> > LD seems strange to me=2E ]
> >=20
> > Fredrik
>
