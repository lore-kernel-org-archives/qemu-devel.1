Received: from eggs.gnu.org ([2001:4830:134:3::10]:53508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dq4YD-0004jI-4R
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dq4Y8-0006Ab-Hi
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dq4Y8-0006A9-Bk
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BB2780473
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 21:41:23 +0000 (UTC)
Date: Thu, 7 Sep 2017 17:41:21 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2058771615.10526518.1504820481126.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170907084700.952-1-famz@redhat.com>
References: <20170907084700.952-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move brlapi libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



----- Original Message -----
> baum.o already receives the sdl cflags in its per object variable, do
> the same for brlapi libs to avoid cluttering libs_softmmu.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/Makefile.objs | 1 +
>  configure             | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index 52a8127606..d68e1347f9 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -20,5 +20,6 @@ chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
>  common-obj-y +=3D msmouse.o wctablet.o testdev.o
>  common-obj-$(CONFIG_BRLAPI) +=3D baum.o
>  baum.o-cflags :=3D $(SDL_CFLAGS)
> +baum.o-libs :=3D $(BRLAPI_LIBS)
> =20
>  common-obj-$(CONFIG_SPICE) +=3D spice.o
> diff --git a/configure b/configure
> index fb7e34a901..d718718cfa 100755
> --- a/configure
> +++ b/configure
> @@ -3106,7 +3106,6 @@ int main( void ) { return brlapi__openConnection (N=
ULL,
> NULL, NULL); }
>  EOF
>    if compile_prog "" "$brlapi_libs" ; then
>      brlapi=3Dyes
> -    libs_softmmu=3D"$brlapi_libs $libs_softmmu"
>    else
>      if test "$brlapi" =3D "yes" ; then
>        feature_not_found "brlapi" "Install brlapi devel"
> @@ -5693,6 +5692,7 @@ if test "$curl" =3D "yes" ; then
>  fi
>  if test "$brlapi" =3D "yes" ; then
>    echo "CONFIG_BRLAPI=3Dy" >> $config_host_mak
> +  echo "BRLAPI_LIBS=3D$brlapi_libs" >> $config_host_mak
>  fi
>  if test "$bluez" =3D "yes" ; then
>    echo "CONFIG_BLUEZ=3Dy" >> $config_host_mak
> --
> 2.13.5
>=20
>=20
