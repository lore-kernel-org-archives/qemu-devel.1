Received: from eggs.gnu.org ([2001:4830:134:3::10]:34190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv6z-0001Ig-WA
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 21:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv2M-00024B-UT
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 21:00:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1frv2M-00023m-Po
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 21:00:46 -0400
Date: Tue, 21 Aug 2018 09:00:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180821010044.GK10682@lemon.usersys.redhat.com>
References: <20180818030337.22271-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180818030337.22271-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Clean dangling tarball files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Sat, 08/18 00:03, Philippe Mathieu-Daud=E9 wrote:
> When a container fails, it leaves a dangling tarball which name is
> based on a timestamp. Further uses of make won't clean those files,
> neither calling the 'docker-clean' target.
>=20
> Use the .DELETE_ON_ERROR built-in target to let make remove those
> temporary tarballs in case of failure.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index d3101afecd..6e03235ab9 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -25,6 +25,7 @@ IMAGES ?=3D %
>  CUR_TIME :=3D $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
>  DOCKER_SRC_COPY :=3D $(BUILD_DIR)/docker-src.$(CUR_TIME)
> =20
> +.DELETE_ON_ERROR: $(DOCKER_SRC_COPY)
>  $(DOCKER_SRC_COPY):
>  	@mkdir $@
>  	$(if $(SRC_ARCHIVE), \
> --=20
> 2.18.0
>=20

Queued, thanks.

Fam
