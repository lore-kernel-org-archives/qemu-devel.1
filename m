Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb7aB-0005dy-7c
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb7a8-0006bS-1Q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:25:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb7a7-0006b4-Qz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:25:55 -0500
Date: Mon, 15 Jan 2018 16:25:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115162538.GR8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115143500.22631-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/8] docker: add the Ubuntu Trusty base
 image
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

On Mon, Jan 15, 2018 at 11:34:54AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> based on QEMU v2.10 ubuntu.docker (ca853f0c76e3 and 2346b12fc52d)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/ubuntu14.04.docker | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/ubuntu14.04.docker
>=20
> diff --git a/tests/docker/dockerfiles/ubuntu14.04.docker b/tests/docker=
/dockerfiles/ubuntu14.04.docker
> new file mode 100644
> index 0000000000..cd24e759a7
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu14.04.docker
> @@ -0,0 +1,17 @@
> +FROM ubuntu:14.04
> +RUN apt-get update
> +ENV PACKAGES flex bison \
> +    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncur=
sesw5-dev \
> +    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
> +    libspice-protocol-dev libnss3-dev libfdt-dev \
> +    libgtk-3-dev libvte-2.90-dev libsdl1.2-dev libpng12-dev libpixman-=
1-dev \

Perhaps use SDL 2, instead of 1.2 series, since we're deprecating SDL 1.2
in this release...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
