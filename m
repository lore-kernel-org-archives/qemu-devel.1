Received: from eggs.gnu.org ([209.51.188.92]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswrf-0006az-Vp
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswre-0007si-6o
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:42:15 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gswre-0007rI-0j
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:42:14 -0500
Received: by mail-ot1-x342.google.com with SMTP id k98so14453021otk.3
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 13:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<CAFEAcA-P_vVy8dbti83Afm6CMNZBmr5FUzMeztCwp=NRXwn5qw@mail.gmail.com>
	<20190210213839.vfocl3mv2ivgz5h2@function>
In-Reply-To: <20190210213839.vfocl3mv2ivgz5h2@function>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Feb 2019 21:42:02 +0000
Message-ID: <CAFEAcA9Cn3Yj1JvqPv7J95enhK6nMwcqD1FYHyzjFg=4J2608A@mail.gmail.com>
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
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, 10 Feb 2019 at 21:38, Samuel Thibault <samuel.thibault@gnu.org> wro=
te:
>
> Hello,
>
> Peter Maydell, le dim. 10 f=C3=A9vr. 2019 21:35:37 +0000, a ecrit:
> > On Fri, 8 Feb 2019 at 20:58, <marcandre.lureau@redhat.com> wrote:
> > > As discussed earlier in "[PATCH for-3.2 00/41] RFC: slirp: make it
> > > again a standalone project" and other threads, it would be useful to
> > > make slirp a separate project (the submodule approach was discarded)
> > > for various projects to share.
> >
> > > The following patches add meson build system (if necessary for older
> > > distros, autotools could be added - however I believe python & ninja
> > > are generally available on the QEMU supported platforms)
> >
> > Do you really need to make QEMU add an extra build dependency
> > just to use a different build system?
>
> AIUI, this patches series is meant for the slirp repository, not the
> QEMU repository. I.e. just to show how it'll look like, until a project
> it settled somewhere and the discussion can happen there.

Yes, but we're going to be pulling it in as a submodule,
so a split out libslirp in its own repository with extra
build dependencies is harder to work with than one without.

thanks
-- PMM
