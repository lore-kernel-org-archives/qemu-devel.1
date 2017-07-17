Received: from eggs.gnu.org ([2001:4830:134:3::10]:42638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXEiy-0007Il-Cb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXEiv-0002ji-8r
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dXEiv-0002j1-2w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:42:41 -0400
Date: Tue, 18 Jul 2017 06:42:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717224237.GA2585@lemon>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170717144848.11793-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170717144848.11793-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 03/23] docker: include python-yaml in
 travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, 07/17 15:48, Alex Benn=E9e wrote:
> Although the upstream Travis images don't need this library our
> "travis-lite" scripts are written in python. This allows us to do:
>=20
>   make docker-travis@travis J=3D10
>=20
> and approximate a travis run on their default image.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/travis.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dock=
erfiles/travis.docker
> index e4983ae2d3..a315f66ad9 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -2,5 +2,5 @@ FROM quay.io/travisci/travis-ruby
>  RUN apt-get update
>  RUN apt-get -y build-dep qemu
>  RUN apt-get -y build-dep device-tree-compiler
> -RUN apt-get -y install python2.7 dh-autoreconf
> +RUN apt-get -y install python2.7 python-yaml dh-autoreconf
>  ENV FEATURES pyyaml
> --=20
> 2.13.0
>=20

BTW, is the real travis yaml parser open source?

Reviewed-by: Fam Zheng <famz@redhat.com>
