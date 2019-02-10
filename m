Received: from eggs.gnu.org ([209.51.188.92]:58274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsxCe-0001UE-Ai
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsxCd-0004Mp-6S
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:03:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gsxCc-0004E8-Vo
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:03:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id d15so13837091wmb.3
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 14:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<CAFEAcA-P_vVy8dbti83Afm6CMNZBmr5FUzMeztCwp=NRXwn5qw@mail.gmail.com>
	<20190210213839.vfocl3mv2ivgz5h2@function>
	<CAFEAcA9Cn3Yj1JvqPv7J95enhK6nMwcqD1FYHyzjFg=4J2608A@mail.gmail.com>
In-Reply-To: <CAFEAcA9Cn3Yj1JvqPv7J95enhK6nMwcqD1FYHyzjFg=4J2608A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 10 Feb 2019 23:03:33 +0100
Message-ID: <CAJ+F1CJQiVKrPnwG=hKEcq_4s7HPCjetKn==8qKYGGfV2zohFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH slirp 0/5] Make it a standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

Hi

On Sun, Feb 10, 2019 at 10:42 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
> On Sun, 10 Feb 2019 at 21:38, Samuel Thibault <samuel.thibault@gnu.org> w=
rote:
> >
> > Hello,
> >
> > Peter Maydell, le dim. 10 f=C3=A9vr. 2019 21:35:37 +0000, a ecrit:
> > > On Fri, 8 Feb 2019 at 20:58, <marcandre.lureau@redhat.com> wrote:
> > > > As discussed earlier in "[PATCH for-3.2 00/41] RFC: slirp: make it
> > > > again a standalone project" and other threads, it would be useful t=
o
> > > > make slirp a separate project (the submodule approach was discarded=
)
> > > > for various projects to share.
> > >
> > > > The following patches add meson build system (if necessary for olde=
r
> > > > distros, autotools could be added - however I believe python & ninj=
a
> > > > are generally available on the QEMU supported platforms)
> > >
> > > Do you really need to make QEMU add an extra build dependency
> > > just to use a different build system?
> >
> > AIUI, this patches series is meant for the slirp repository, not the
> > QEMU repository. I.e. just to show how it'll look like, until a project
> > it settled somewhere and the discussion can happen there.
>
> Yes, but we're going to be pulling it in as a submodule,
> so a split out libslirp in its own repository with extra
> build dependencies is harder to work with than one without.
>

Why do you think it should be a submodule? That's the approach I
proposed first, but Daniel suggested to make it immediately a shared
library if possible.

Regarding the build system, if meson/ninja is problematic for some
distro, we can come up with autotools or plain Make for a while.



--=20
Marc-Andr=C3=A9 Lureau
