Received: from eggs.gnu.org ([2001:4830:134:3::10]:53953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHr3H-000545-P6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHr37-0008Gt-M9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:00:55 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHr37-0007vH-9g
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:00:45 -0400
Received: by mail-qk1-x744.google.com with SMTP id o125so6284766qkf.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:00:18 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA8MMfS6cFiitqxKT6JG6u6qU9T6kcL_Qq+vXrCgKg2JEg@mail.gmail.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
	<CAFEAcA9czM5qCtj3F_QAhS8dP7yQog-9eD8dGP0qaSeOZ_hang@mail.gmail.com>
	<154093302393.20054.12233984835977061096@sif>
	<CAFEAcA8MMfS6cFiitqxKT6JG6u6qU9T6kcL_Qq+vXrCgKg2JEg@mail.gmail.com>
Message-ID: <154099439644.20054.8620840628824531466@sif>
Date: Wed, 31 Oct 2018 08:59:56 -0500
Subject: Re: [Qemu-devel] [PULL 00/24] qemu-ga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Quoting Peter Maydell (2018-10-31 08:23:40)
> On 30 October 2018 at 20:57, Michael Roth <mdroth@linux.vnet.ibm.com> wro=
te:
> > Sorry for the breakage. Static is indeed useful for qemu-ga, but libudev
> > isn't a hard dependency for qemu-ga so we can get away with simply
> > disabling libudev for static builds. Would the following (squashed into
> > patch 04/24) be acceptable? This fixes static qemu-ga builds for me for
> > both Ubuntu 18.04 and FC27. I'll go ahead submit a v2 shortly since it
> > may be late for you:
> >
> > --- a/configure
> > +++ b/configure
> > @@ -5608,7 +5608,7 @@ fi
> >  ##########################################
> >  # Do we have libudev
> >  if test "$libudev" !=3D "no" ; then
> > -  if $pkg_config libudev; then
> > +  if $pkg_config libudev && test "$static" !=3D "yes"; then
> >      if test "$static" !=3D "yes"; then
> =

> Now you've ruled out 'static' in the outer if, this
> inner if can never be false...

Argh, sorry, I'd meant to remove the inner test when I squashed it in. v3
incoming...

> =

> >        libudev=3D"yes"
> >        libudev_libs=3D$($pkg_config --libs libudev)
> =

> thanks
> -- PMM
>=20
