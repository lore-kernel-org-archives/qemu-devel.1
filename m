Received: from eggs.gnu.org ([2001:4830:134:3::10]:37212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fixcK-0008Ky-6d
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fixcH-0001d5-3u
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:56:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fixcG-0001cq-TL
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:56:49 -0400
Date: Fri, 27 Jul 2018 15:56:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180727075644.GC19416@lemon.usersys.redhat.com>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
	<20180718100505.7546-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180718100505.7546-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 01/10] docker: rename docker-amd64 to
 docker-host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Wed, 07/18 11:04, Alex Benn=E9e wrote:
> When building on non-x86 systems the base system will be correct so if
> we avoid too many x86'isms in the install we can still use the image.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  .../dockerfiles/{debian-amd64.docker =3D> debian-host.docker}   | 4 ++=
--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian-host.=
docker} (91%)
>=20
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docke=
r/dockerfiles/debian-host.docker
> similarity index 91%
> rename from tests/docker/dockerfiles/debian-amd64.docker
> rename to tests/docker/dockerfiles/debian-host.docker
> index eb13f06ed1..3605cc4658 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-host.docker
> @@ -30,9 +30,9 @@ RUN cd /usr/src/virglrenderer && ./autogen.sh && ./co=
nfigure --with-glx --disabl
>  # netmap
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        linux-headers-amd64
> +        linux-headers-$(dpkg --print-architecture)
>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
> -RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --k=
ernel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
> +RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --k=
ernel-dir=3D$(ls -d /usr/src/linux-headers-*) && make install

Curious: why isn't this "ls -d linux-headers-*-$(dpkg --print-architectur=
e)", like above?

>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
> =20
>  # gcrypt
> --=20
> 2.17.1
>=20
