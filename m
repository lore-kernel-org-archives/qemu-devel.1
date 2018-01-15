Received: from eggs.gnu.org ([2001:4830:134:3::10]:53755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb7by-0006f9-4L
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb7bu-0007nD-9G
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:27:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb7bu-0007ms-2R
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:27:46 -0500
Date: Mon, 15 Jan 2018 16:27:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115162728.GS8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115143500.22631-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/8] docker: add the Fedora 27 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Mon, Jan 15, 2018 at 11:34:57AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> straight copy on Fedora 25 base.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/fedora27.docker | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora27.docker
>=20
> diff --git a/tests/docker/dockerfiles/fedora27.docker b/tests/docker/do=
ckerfiles/fedora27.docker
> new file mode 100644
> index 0000000000..7cba4dcc2c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora27.docker
> @@ -0,0 +1,18 @@
> +FROM fedora:27
> +ENV PACKAGES \
> +    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 host=
name \
> +    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \

Perhaps SDL2 here too

> +    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> +    nettle-devel \
> +    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-c=
onfig \
> +    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-li=
btasn1 \

Is there a reason we have both GTK2 and GTK3 installed ? We've deprecated=
 GTK2
and configure will pick GTK3 by default. IIUC there's no way to override
that in the docker builds to force GTK2, so it can possibly be dropped.

> +    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 =
\
> +    mingw32-bzip2 \
> +    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-c=
onfig \
> +    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-li=
btasn1 \

Repeated here.

> +    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 =
\
> +    mingw64-bzip2
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt
> +ENV FEATURES mingw clang pyyaml

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
