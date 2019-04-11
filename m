Received: from eggs.gnu.org ([209.51.188.92]:37742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEXS6-0002Jt-On
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEXRz-0000QK-P5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:01:04 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEXRk-00042N-DE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:00:59 -0400
Received: by mail-oi1-x22f.google.com with SMTP id 3so4509783oir.7
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 04:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <201904110044.38853.randrianasulu@gmail.com>
	<CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
	<201904111258.04551.randrianasulu@gmail.com>
In-Reply-To: <201904111258.04551.randrianasulu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 12:00:27 +0100
Message-ID: <CAFEAcA8BuzPkGKkeHH0EgDn08MJuWXbQwiwjuxT1vu5irmw4hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 11 Apr 2019 at 11:03, Andrew Randrianasulu
<randrianasulu@gmail.com> wrote:
>
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 11 April 2019 12:14:45 Peter Maydell =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(=D0=B0):
> > On Wed, 10 Apr 2019 at 22:51, Andrew Randrianasulu
> > <randrianasulu@gmail.com> wrote:
> > >
> > > Please also include this patch in next -rc or final, it fixes 32-bit =
compilation:
> > >
> > > https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
> > > ([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)
> > >
> > > without it I get
> > >
> > > ui/curses.c: In function 'get_ucs':
> > > ui/curses.c:456:25: error: format '%x' expects argument of type 'unsi=
gned int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=3Dform=
at=3D]
> > >          fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UC=
S-2: %s\n",
> > >
> >
> > Rats, I'd forgotten about that one. What platform does it fail
> > to compile on, though? I test on 32-bit Linux and Windows compiles,
> > and they work OK.
>
> This is slackware (mix of many versions) + gcc (GCC) 5.5.0.
> Probably, this error will not show up if you don't have ncurses-dev packa=
ges,
> so configure will NOT enable curses ui ?

It turns out my 32-bit system has libncurses5-dev but not
libncursesw5-dev, so when we added the widechar requirement
it just stopped building the curses UI. I've now fixed that.
On the other hand, I still don't see the error. I think
my gcc/glibc combo must define wchar_t as 'int' anyway
(this is 32-bit arm).

thanks
-- PMM
