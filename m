Received: from eggs.gnu.org ([209.51.188.92]:40192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8gb-0006Eb-AY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8gZ-0004Up-9v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:11:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hM8gY-0004Sg-M8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:11:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so1168163oig.9
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190425145420.8888-1-stefanha@redhat.com>
	<20190501162055.GB21155@stefanha-x1.localdomain>
In-Reply-To: <20190501162055.GB21155@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 11:11:14 +0100
Message-ID: <CAFEAcA8Go-8Ux9AGzw5CGiU3wDyAQSrV1HOb0gbZP8+b06-EPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Wed, 1 May 2019 at 17:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Apr 25, 2019 at 03:54:20PM +0100, Stefan Hajnoczi wrote:
> > qemu.org hosts git repository mirrors of all submodules.  Update
> > .gitmodules to use the mirrors and not the upstream repositories.
> >
> > Mirroring upstream repositories ensures that QEMU continues to build
> > even when upstream repositories are deleted or temporarily offline.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  .gitmodules | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Ping?
>
> > diff --git a/.gitmodules b/.gitmodules
> > index aa77ce6f50..2857eec763 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -39,19 +39,19 @@
> >       url =3D https://git.qemu.org/git/capstone.git
> >  [submodule "roms/seabios-hppa"]
> >       path =3D roms/seabios-hppa
> > -     url =3D https://github.com/hdeller/seabios-hppa.git
> > +     url =3D https://git.qemu.org/git/seabios-hppa.git
> >  [submodule "roms/u-boot-sam460ex"]
> >       path =3D roms/u-boot-sam460ex
> >       url =3D https://git.qemu.org/git/u-boot-sam460ex.git
> >  [submodule "tests/fp/berkeley-testfloat-3"]
> >       path =3D tests/fp/berkeley-testfloat-3
> > -     url =3D https://github.com/cota/berkeley-testfloat-3
> > +     url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
> >  [submodule "tests/fp/berkeley-softfloat-3"]
> >       path =3D tests/fp/berkeley-softfloat-3
> > -     url =3D https://github.com/cota/berkeley-softfloat-3
> > +     url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
> >  [submodule "roms/edk2"]
> >       path =3D roms/edk2
> > -     url =3D https://github.com/tianocore/edk2.git
> > +     url =3D https://git.qemu.org/git/edk2.git
> >  [submodule "slirp"]
> >       path =3D slirp
> > -     url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
> > +     url =3D https://git.qemu.org/git/libslirp.git
> > --

This won't apply because currently master's .gitmodules
has no [submodule "slirp"] entry. I was assuming you'd
ping or repost once the slirp changes went in.

thanks
-- PMM
