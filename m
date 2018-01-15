Received: from eggs.gnu.org ([2001:4830:134:3::10]:53782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eb6Fe-0003av-0D
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eb6FZ-0001eD-Qf
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:00:42 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eb6FZ-0001dj-K5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:00:37 -0500
Received: by mail-wr0-x242.google.com with SMTP id 36so12026864wrh.1
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 07:00:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180115142533.24585-1-berrange@redhat.com>
References: <20180115142533.24585-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jan 2018 16:00:34 +0100
Message-ID: <CAJ+F1CL2of9g3A84mLCkkwMdPPQMP3zVH-5iuAUXY89BUMENSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui: deprecate use of SDL 1.2 in favour of
 2.0 series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Jan 15, 2018 at 3:25 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> The SDL 2.0 release was made in Aug, 2013:
>
>   https://www.libsdl.org/release/
>
> That will soon be 4 + 1/2 years ago, which is enough time to consider
> the 2.0 series widely supported.
>
> Thus we deprecate the SDL 1.2 support, which will allow us to delete it
> in the last release of 2018. By this time, SDL 2.0 will be more than 5
> years old.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  configure     | 6 ++++++
>  qemu-doc.texi | 7 +++++++
>  ui/sdl.c      | 3 +++
>  3 files changed, 16 insertions(+)
>
> diff --git a/configure b/configure
> index b272a0336b..dc2615a0cb 100755
> --- a/configure
> +++ b/configure
> @@ -5635,6 +5635,12 @@ if test "$gtkabi" =3D "2.0"; then
>      echo "WARNING: future releases. Please switch to using GTK 3.0"
>  fi
>
> +if test "$sdlabi" =3D "1.2"; then
> +    echo
> +    echo "WARNING: Use of SDL 1.2 is deprecated and will be removed in"
> +    echo "WARNING: future releases. Please switch to using SDL 2.0"
> +fi
> +
>  if test "$supported_cpu" =3D "no"; then
>      echo
>      echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELE=
ASES!"
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 3e9eb819a6..3d2b3ff1ea 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2596,6 +2596,13 @@ and 3.x series APIs. Support for the GTK 2.x build=
s will be
>  discontinued, so maintainers should switch to using GTK 3.x,
>  which is the default.
>
> +@subsection SDL 1.2
> +
> +Previously QEMU has supported building against both SDL 1.2
> +and 2.0 series APIs. Support for the SDL 1.2 builds will be
> +discontinued, so maintainers should switch to using SDL 2.0,
> +which is the default.
> +
>  @section System emulator command line arguments
>
>  @subsection -tdf (since 1.3.0)
> diff --git a/ui/sdl.c b/ui/sdl.c
> index 7b71a9ac58..8a93054fd4 100644
> --- a/ui/sdl.c
> +++ b/ui/sdl.c
> @@ -963,6 +963,9 @@ void sdl_display_init(DisplayState *ds, int full_scre=
en, int no_frame)
>              exit(1);
>      }
>
> +    g_printerr("Running QEMU with SDL 1.2 is deprecated, and will be rem=
oved\n"
> +               "in a future release. Please switch to SDL 2.0 instead\n"=
);
> +
>      if (no_frame)
>          gui_noframe =3D 1;
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
