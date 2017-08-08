Received: from eggs.gnu.org ([2001:4830:134:3::10]:58583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1detU0-0000uQ-1A
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1detTv-0005w2-3j
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1detTu-0005vR-UC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:38:51 -0400
Date: Tue, 8 Aug 2017 09:38:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808013846.GO14780@lemon>
References: <20170807153934.29477-1-alex.bennee@linaro.org>
	<20170807153934.29477-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170807153934.29477-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 v3 1/6] docker: ensure NOUSER for
 travis images
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

On Mon, 08/07 16:39, Alex Benn=E9e wrote:
> While adding the current user is a useful default behaviour for
> creating new images it is not appropriate for Travis which already has
> a default user.

Target docker-travis@travis will not have NOUSER=3D1 automatically, right=
? Is that
a problem?

Fam

>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index aaab1a4208..d7dafdbd27 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -71,6 +71,7 @@ docker-image-debian-ppc64el-cross: docker-image-debia=
n9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-travis: NOUSER=3D1
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
>  $(foreach i,$(DOCKER_IMAGES), \
> --=20
> 2.13.0
>=20
>=20
