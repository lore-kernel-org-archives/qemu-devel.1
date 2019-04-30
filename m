Received: from eggs.gnu.org ([209.51.188.92]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hLU8J-00033U-8V
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hLU8I-00067S-77
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:53:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hLU8H-000677-US
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:53:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id a12so21358387wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190425145420.8888-1-stefanha@redhat.com>
In-Reply-To: <20190425145420.8888-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Apr 2019 16:53:08 +0200
Message-ID: <CAJ+F1CLYjF8SQv0v8c-hfbPcFYgZdg1P-MVeB8nS_AXTy4eMDA@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi

On Thu, Apr 25, 2019 at 4:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> qemu.org hosts git repository mirrors of all submodules.  Update
> .gitmodules to use the mirrors and not the upstream repositories.
>
> Mirroring upstream repositories ensures that QEMU continues to build
> even when upstream repositories are deleted or temporarily offline.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Stefan, do you prepare a pullreq?

> ---
>  .gitmodules | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/.gitmodules b/.gitmodules
> index aa77ce6f50..2857eec763 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -39,19 +39,19 @@
>         url =3D https://git.qemu.org/git/capstone.git
>  [submodule "roms/seabios-hppa"]
>         path =3D roms/seabios-hppa
> -       url =3D https://github.com/hdeller/seabios-hppa.git
> +       url =3D https://git.qemu.org/git/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>         path =3D roms/u-boot-sam460ex
>         url =3D https://git.qemu.org/git/u-boot-sam460ex.git
>  [submodule "tests/fp/berkeley-testfloat-3"]
>         path =3D tests/fp/berkeley-testfloat-3
> -       url =3D https://github.com/cota/berkeley-testfloat-3
> +       url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
>  [submodule "tests/fp/berkeley-softfloat-3"]
>         path =3D tests/fp/berkeley-softfloat-3
> -       url =3D https://github.com/cota/berkeley-softfloat-3
> +       url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
>  [submodule "roms/edk2"]
>         path =3D roms/edk2
> -       url =3D https://github.com/tianocore/edk2.git
> +       url =3D https://git.qemu.org/git/edk2.git
>  [submodule "slirp"]
>         path =3D slirp
> -       url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
> +       url =3D https://git.qemu.org/git/libslirp.git
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
