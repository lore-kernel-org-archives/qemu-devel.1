Received: from eggs.gnu.org ([208.118.235.92]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gf3Rn-0002CF-U6
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gf3Rj-00084F-Qh
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:54:07 -0500
Received: from mail-eopbgr770105.outbound.protection.outlook.com
	([40.107.77.105]:33190
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gf3Rj-00083o-KS
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:54:03 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 3 Jan 2019 13:54:00 +0000
Message-ID: <CY4PR2201MB1254EB86A14A1044848EAF55C68D0@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL v2 00/44] MIPS pull request for December
 2018 - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Thursday, January 3, 2019 2:23 PM
> Subject: Re: [PULL v2 00/44] MIPS pull request for December 2018 - v2
>=20
> On Mon, 31 Dec 2018 at 14:56, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> >
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606=
fdea:
> >
> >   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' =
into staging > (2018-12-22 11:25:31 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/AMarkovic/qemu tags/mips-queue-dec-2018-v2
> >
> > for you to fetch changes up to 96446398f47b70cf0998412314730709570e08c5=
:
> >
> >   tests/tcg: mips: Test R5900 three-operand MADDU1 (2018-12-31 15:47:28=
 +0100)
> >
> > ----------------------------------------------------------------
> >
> > MIPS queue for December 2018 - v2
> >
> >
> >   - this queue contains various amendments to MIPS code
> >   - there are three checkpatch warnings that should be ingnored
> >     in given circumstances
> >   - most of the patches are not yet visible/noticeable to the end
> >     user, just a single note related to Paul's patch will be added
> >     to ChangeLog
> >
> > v1->v2:
> >
> >   - added three patches that were meanwhile tested better
> >
>=20
> Hi; I'm afraid this doesn't build on all my test hosts:
>=20
> target/mips/translate.c: In function =91gen_mxu_Q8MAX_Q8MIN=92:
> target/mips/translate.c:25092:9: error: =91for=92 loop initial
> declarations are only allowed in C99 mode
>          for (int i =3D 2; i >=3D 0; i--) {
>          ^
> target/mips/translate.c:25092:9: note: use option -std=3Dc99 or
> -std=3Dgnu99 to compile your code
> target/mips/translate.c:25129:9: error: =91for=92 loop initial
> declarations are only allowed in C99 mode
>          for (int i =3D 2; i >=3D 0; i--) {
>          ^
>=20
> (This probably only shows up on builds with older versions
> of gcc which don't default to c99.)
>=20
> We don't use variable-declaration-in-for-loop.
>=20
> thanks
> -- PMM

OK. Sorry. I am going to send v3 of the pull request updated
only with corrections for these two build errors today.

Happy holidays!

Aleksandar
