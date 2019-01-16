Received: from eggs.gnu.org ([209.51.188.92]:45902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjqjq-0001z4-Lm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjqjo-00036B-Nh
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:20:34 -0500
Received: from mail-eopbgr700131.outbound.protection.outlook.com
	([40.107.70.131]:50080
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjqjj-0002vI-4j
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:20:30 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 16 Jan 2019 19:20:08 +0000
Message-ID: <BN6PR2201MB1251F33344A686B376174608C6820@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>
	<781155aaf175ea20903c12e26316ea40085457bb.1547403692.git.noring@nocrew.org>
	<BN6PR2201MB12516C7D2E235DA81812DDF0C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20190116153654.GA2918@sx9>
In-Reply-To: <20190116153654.GA2918@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Fredrik Noring <noring@nocrew.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Wednesday, January 16, 2019 4:36 PM
> To: Aleksandar Markovic
> Cc: Aurelien Jarno; Philippe Mathieu-Daud=E9; J=FCrgen Urban; Maciej W. R=
ozycki; > qemu-devel@nongnu.org
> Subject: Re: [PATCH 1/9] target/mips: Require TARGET_MIPS64 for R5900 mul=
timedia instructions
>=20
> Hi Aleksandar,
>=20
> > Sorry, I have to disagree with this.
>=20
> It was, without a doubt, entirely clear that the o32 ABI was going to sta=
y
> in after this MMI patch series. In other words, this series does not impl=
y
> the removal of o32. This is obvious, as discussed previously, since the o=
32
> ABI is currently the main use case for R5900 QEMU and the reason the R590=
0
> was implemented for QEMU to begin with.
>=20

Fredrik,

Modeling a 64-bit processor as a 32-bit one should not be a part of QEMU
upstream.

Thanks for your efforts so far,
Aleksandar

> > Processor model must stay the same, and
> > Linux ABI should not affect, for example, the number and size of proces=
sor
> > registers - just like it is the case in reality.
>=20
> I thought Maciej's reply to you was quite clear on this topic?
>=20
> > QEMU is an independent software tool - it is for example, a compiler-ag=
nostic
> > tool, and the only connection between a compiler and QEMU is the proces=
sor
> > documentation - and this is the reason they work together so well. They=
 shouldn't
> > be "tweaked" and "integrated" to work together - both QEMU and compiler=
 should
> > rely only on the processor specification, and should not know anything =
about the
> > other side.
>=20
> The approach was to implement ABIs and instructions that are actually use=
d,
> and leave unused or optional instructions for later. The reverse, removin=
g
> ABIs in-use (o32) and focusing on unused instructions (MMIs) does not mak=
e
> sense, so I will obviously not do that.
>=20
> > My advice for you is to focus on n32 at the time being.
> >
> > o32 can be implemented with the same 64-bit processor model, but in a m=
uch
> > different way that you attempted some time ago. To avoid waste of our e=
nergy
> > and time, I am suggesting that we finish n32, and think of o32 in futur=
e.
>=20
> The o32 ABI is more important than n32 now, because o32 is in-use and
> ready with Glibc, GCC, GAS and the Linux kernel. n32 is easy to enable
> with a three-line patch, so we can actually use both now.
>=20
> I recommend that we implement limited support for MMIs for n32 and
> eventually system mode, and leave it as unsupported for o32 for the time
> being. [ Perhaps MMIs for o32 could be implemented with 96-bit registers,
> in contrast to the 64-bit registers for n32, but having LW and LQ without
> LD seems strange to me. ]
>=20
> Fredrik
