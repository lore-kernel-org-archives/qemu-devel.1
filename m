Received: from eggs.gnu.org ([2001:4830:134:3::10]:59762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWiBs-0004DS-Or
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWiBp-0002cu-LY
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:26:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWiBp-0002cU-FJ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:26:05 -0500
Date: Thu, 26 Jan 2017 19:26:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170126112601.GK6879@lemon>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
	<20170124143346.22240-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170124143346.22240-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] .travis.yml: DEBUG MacOSX build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "open list:-----------------..." <qemu-devel@nongnu.org>

On Tue, 01/24 14:33, Alex Benn=E9e wrote:
> Currently the MacOSX build is failing. Dump some information to help
> with figuring out what has gone wrong.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 9008a796f0..a9ce215f42 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -92,6 +92,7 @@ matrix:
>      - env: CONFIG=3D""
>        os: osx
>        compiler: clang
> +      script: make -j3 || cat qemu-options.texi && false
>      # Plain Trusty System Build
>      - env: CONFIG=3D"--disable-linux-user"
>        sudo: required
> --=20
> 2.11.0
>=20
>=20

Why qemu-options.texi? This looks really ad-hocery, not sure it's useful =
for the
mainline.

Fam
