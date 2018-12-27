Received: from eggs.gnu.org ([208.118.235.92]:39870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gcTk2-00005y-PU
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gcTk1-0005BI-DI
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:22:18 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:46361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gcTk1-00058V-8T
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:22:17 -0500
Received: by mail-oi1-x234.google.com with SMTP id x202so14850255oif.13
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 03:22:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87imzpa4gx.fsf@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
	<CAL1e-=hfFv1TsG_viYi6-0z0qN8GnTP-70ZLMrDMmLVz9iBWQA@mail.gmail.com>
	<87imzpa4gx.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 27 Dec 2018 12:22:14 +0100
Message-ID: <CAL1e-=hyKFR=9PHSnNdqFd=XFo2PoQK7qVrtM9GNM3V47V=2Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/13] tests/tcg/mips: enable
 mips32-dsp/mips32-dspr2/mipsr5900 linux-user (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "shorne@gmail.com" <shorne@gmail.com>, "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "michael@walle.cc" <michael@walle.cc>, Stefan Markovic <smarkovic@wavecomp.com>

HI, Alex, just a heads up that I plan to submit directory and file
reorganization of tests/tcg/mips mini patch series today or tomorrow.
Aleksandar

On Wednesday, December 19, 2018, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

>
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>
> > On Dec 10, 2018 4:29 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wr=
ote:
> >>
> >> Convert the existing tests to use our common cross build
> >> infrastructure.
> >>
> >> [WIP: mips32r2 disabled to avoid name clash]
> >> [WIP: mipsr5900 disabled due to clashing build flags]
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  tests/tcg/mips/Makefile.target       |  15 ++-
> >>  tests/tcg/mips/mips32-dsp/Makefile   | 166 +++++---------------------=
-
> >>  tests/tcg/mips/mips32-dspr2/Makefile |  83 +++-----------
> >>  tests/tcg/mips/mipsr5900/Makefile    |  40 +++----
> >>  4 files changed, 75 insertions(+), 229 deletions(-)
> >>
> >
> > Alex,
> >
> > How about reorganizing directories in tests/tcg/mips altogether, and ma=
ke
> > it less confusing, and easier for future developers to approach an work
> on?
> >
> > Let's say like this:
> >
> > tests/tcg/mips
> >     user
> >         isa
> >             r5900
> >         ase
> >             dsp
> >             dsp_r2
> >     system
> >         isa   =E3=80=8Afor now empty=E3=80=8B
> >         ase
> >             dsp
> >             dsp_r2
>
> Yeah sounds like a plan. I'm going to do the same with cris (bare and
> libc).
>
> >
> > Thanks,
> > Aleksandar
>
>
> --
> Alex Benn=C3=A9e
>
