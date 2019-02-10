Received: from eggs.gnu.org ([209.51.188.92]:59265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gsxGX-0003gz-QK
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gsxGX-0008AX-2G
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:07:57 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gsxGW-00084G-P5
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:07:56 -0500
Received: by mail-ot1-x344.google.com with SMTP id g1so515721otj.11
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 14:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<CAFEAcA-P_vVy8dbti83Afm6CMNZBmr5FUzMeztCwp=NRXwn5qw@mail.gmail.com>
	<20190210213839.vfocl3mv2ivgz5h2@function>
	<CAFEAcA9Cn3Yj1JvqPv7J95enhK6nMwcqD1FYHyzjFg=4J2608A@mail.gmail.com>
	<CAJ+F1CJQiVKrPnwG=hKEcq_4s7HPCjetKn==8qKYGGfV2zohFg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJQiVKrPnwG=hKEcq_4s7HPCjetKn==8qKYGGfV2zohFg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Feb 2019 22:07:38 +0000
Message-ID: <CAFEAcA_odeirvW-SpaGZ9SQt=x3ZS_Eg6UDb4=BEFhEWrXkDxA@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On Sun, 10 Feb 2019 at 22:03, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Why do you think it should be a submodule? That's the approach I
> proposed first, but Daniel suggested to make it immediately a shared
> library if possible.

It needs to be a submodule because you don't have a time
machine to arrange for it to be an available package in
all the stable versions of the distros we support. As
and when it is packaged in the oldest stable versions we
care about, we can drop the submodule, but submodule is where
we need to start. (This is the same as we did with third
party bits of code like pixman.)

I think immediately going for the shared library (as opposed
to static) is a bit of a bold decision also because it is a
hard commitment to API and ABI compatibility, which previously
has been something the slirp code didn't need to care about at all.

> Regarding the build system, if meson/ninja is problematic for some
> distro, we can come up with autotools or plain Make for a while.

I think plain make would be more convenient. Otherwise
everybody building QEMU needs to install a random extra
build tool.

thanks
-- PMM
