Received: from eggs.gnu.org ([2001:4830:134:3::10]:55334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gITG9-0004He-IJ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gITG3-0003Dn-7U
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:48:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gITG1-0003Bo-8t
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:48:37 -0400
Date: Fri, 2 Nov 2018 14:48:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181102064829.GB21032@magic>
References: <20181101183705.5422-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181101183705.5422-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian
 Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 11/01 19:37, Philippe Mathieu-Daud=E9 wrote:
> The Debian Sid repository is not garanteed to be stable, as his
> 'unstable' name suggest :)
> To allow quick testing, packages are pushed various time a day,
> which my be annoying when trying to use it for stable development
> (which is not recommended, but Sid provides edge packages we use
> for testing).
>=20
> Debian provides repositories snapshots which are suitable for our
> use. Pick a recent date that works. When required, update to newer
> releases will be easy.
>=20
> This fixes current issues with this image:
>=20
>   $ make docker-image-debian-sid
>   [...]
>   The following packages have unmet dependencies:
>    build-essential : Depends: dpkg-dev (>=3D 1.17.11) but it is not goi=
ng to be installed
>    git : Depends: perl but it is not going to be installed
>          Depends: liberror-perl but it is not going to be installed
>    pkg-config : Depends: libdpkg-perl but it is not going to be install=
ed
>    texinfo : Depends: perl (>=3D 5.26.2-6) but it is not going to be in=
stalled
>              Depends: libtext-unidecode-perl but it is not going to be =
installed
>              Depends: libxml-libxml-perl but it is not going to be inst=
alled
>   E: Unable to correct problems, you have held broken packages.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-sid.docker | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> index 9a3d168705..4e4cda0ba5 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -13,6 +13,10 @@
> =20
>  FROM debian:sid-slim
> =20
> +# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> +ENV DEBIAN_SNAPSHOT_DATE "20181030"
> +RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNA=
PSHOT_DATE} \2%" /etc/apt/sources.list
> +
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> =20
> --=20
> 2.17.2
>=20

Queued, thanks!

Fam
