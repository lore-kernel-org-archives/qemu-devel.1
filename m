Received: from eggs.gnu.org ([209.51.188.92]:50833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEWYQ-0007Nv-0N
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEWYO-0004TT-K0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:03:33 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hEWYO-0004Sf-8E
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:03:32 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so3306657pgh.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 03:03:32 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 11 Apr 2019 12:58:04 +0300
References: <201904110044.38853.randrianasulu@gmail.com>
	<CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
In-Reply-To: <CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201904111258.04551.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Thursday 11 April 2019 12:14:45 Peter Maydell =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> On Wed, 10 Apr 2019 at 22:51, Andrew Randrianasulu
> <randrianasulu@gmail.com> wrote:
> >
> > Please also include this patch in next -rc or final, it fixes 32-bit co=
mpilation:
> >
> > https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
> > ([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)
> >
> > without it I get
> >
> > ui/curses.c: In function 'get_ucs':
> > ui/curses.c:456:25: error: format '%x' expects argument of type 'unsign=
ed int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=3Dformat=
=3D]
> >          fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-=
2: %s\n",
> >
>=20
> Rats, I'd forgotten about that one. What platform does it fail
> to compile on, though? I test on 32-bit Linux and Windows compiles,
> and they work OK.

This is slackware (mix of many versions) + gcc (GCC) 5.5.0.
Probably, this error will not show up if you don't have ncurses-dev package=
s,=20
so configure will NOT enable curses ui ?

>=20
> Also, this will be only a warning, not a compile error, in the
> release build, so we could get away with releasing without
> the patch applied. We'll see if any other rc4 issues come up.
>=20
> thanks
> -- PMM
>=20
