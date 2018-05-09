Received: from eggs.gnu.org ([2001:4830:134:3::10]:40389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGDfz-000374-0O
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGDfu-000369-VG
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:13:50 -0400
Date: Wed, 9 May 2018 09:13:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180509011332.GH22503@lemon.usersys.redhat.com>
References: <20180508144358.13530-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180508144358.13530-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Fix trivial typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

On Tue, 05/08 11:43, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index de87341528..ef1a3e62eb 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -46,7 +46,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> =20
>  docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(SRC_PATH)/tests/do=
cker/dockerfiles/debian-apt-fake.sh
> =20
> -# Enforce dependancies for composite images
> +# Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
>  docker-image-debian-amd64: docker-image-debian9
> --=20
> 2.17.0
>=20

Queued, thanks!

Fam
