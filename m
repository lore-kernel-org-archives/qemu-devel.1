Received: from eggs.gnu.org ([2001:4830:134:3::10]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCV5-000193-Mp
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCV2-0006Sj-Jg
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:37:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1clCV2-0006SL-Aq
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:37:48 -0500
Date: Tue, 7 Mar 2017 18:37:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170307103744.GA6117@lemon.lan>
References: <20170306112848.659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170306112848.659-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker/dockerfiles/debian-s390-cross:
 include clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, 03/06 11:28, Alex Benn=E9e wrote:
> It's a silly little limitation on Shippable that is looks for clang
> in the container even though we won't use it. The arm/aarch64 cross
> builds inherit this from debian.docker but as we needed to use
> debian-testing for this we add it here. We also collapse the update
> step into one RUN line to remove and intermediate layer of the docker
> build.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests=
/docker/dockerfiles/debian-s390x-cross.docker
> index bbb21ed088..3a687feda0 100644
> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" =
>> /etc/apt/sources.list
>  RUN dpkg --add-architecture s390x
> =20
>  # Grab the updated list of packages
> -RUN apt update
> -RUN apt dist-upgrade -yy
> +RUN apt update && apt dist-upgrade -yy
> +RUN apt install -yy build-essential clang
>  RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
>  RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
> =20
> --=20
> 2.11.0
>=20

Looks sane. Is this for 2.9?

Fam
