Received: from eggs.gnu.org ([209.51.188.92]:37572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGnx-0003kg-7o
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGnv-0006gA-As
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJGnu-0006aQ-W8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so1938039otk.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190424110041.8175-1-marcandre.lureau@redhat.com>
	<20190424110041.8175-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190424110041.8175-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 13:14:57 +0100
Message-ID: <CAFEAcA-_mX4_sJQ1KxSZbdcR1weANO+8430Y+zSYNBKgezPPLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] build-sys: move slirp as git
 submodule project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <codyprime@gmail.com>

On Wed, 24 Apr 2019 at 12:13, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The slirp project is now hosted on freedesktop at:
> https://gitlab.freedesktop.org/slirp.
>
> The libslirp source was extracted from qemu/slirp filtered through
> clang-format (available in project tree). The qemu slirp directory can
> be swapped by a git submodule.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -52,3 +52,6 @@
>  [submodule "roms/edk2"]
>         path =3D roms/edk2
>         url =3D https://github.com/tianocore/edk2.git
> +[submodule "slirp"]
> +       path =3D slirp
> +       url =3D https://gitlab.freedesktop.org/slirp/libslirp.git

We should prefer to set up a mirror of the git repo
on git.qemu.org and use that, rather than a remote repo.

We also need to do that for the berkeley softfloat
and edk2 repos, I notice.

Stefan or Jeff, could one of you set that up, please?

thanks
-- PMM
