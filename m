Received: from eggs.gnu.org ([2001:4830:134:3::10]:41490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gDSs0-0002k2-4K
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gDSrw-0003bX-5P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:23:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gDSrv-0003b1-Mw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:23:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id d2-v6so37044813wro.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:23:03 -0700 (PDT)
References: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
	<20181017094406.4844-3-maozhongyi@cmss.chinamobile.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181017094406.4844-3-maozhongyi@cmss.chinamobile.com>
Date: Fri, 19 Oct 2018 12:23:01 +0100
Message-ID: <875zxynpt6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] debian-bootstrap.pre: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, philmd@redhat.com


Mao Zhongyi <maozhongyi@cmss.chinamobile.com> writes:

> Various shell files contain a mix between obsolete ``
> and modern $(); It would be nice to convert to using $()
> everywhere.
>
> Cc: alex.bennee@linaro.org
> Cc: famz@redhat.com
> Cc: philmd@redhat.com
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  tests/docker/dockerfiles/debian-bootstrap.pre | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker=
/dockerfiles/debian-bootstrap.pre
> index 3b0ef95374..c164778c30 100755
> --- a/tests/docker/dockerfiles/debian-bootstrap.pre
> +++ b/tests/docker/dockerfiles/debian-bootstrap.pre
> @@ -2,7 +2,7 @@
>  #
>  # Simple wrapper for debootstrap, run in the docker build context
>  #
> -FAKEROOT=3D`which fakeroot 2> /dev/null`
> +FAKEROOT=3D$(which fakeroot 2> /dev/null)
>  # debootstrap < 1.0.67 generates empty sources.list, see Debian#732255
>  MIN_DEBOOTSTRAP_VERSION=3D1.0.67
>
> @@ -52,7 +52,7 @@ fi
>
>  if [ -z $DEBOOTSTRAP_DIR ]; then
>      NEED_DEBOOTSTRAP=3Dfalse
> -    DEBOOTSTRAP=3D`which debootstrap 2> /dev/null`
> +    DEBOOTSTRAP=3D$(which debootstrap 2> /dev/null)
>      if [ -z $DEBOOTSTRAP ]; then
>          echo "No debootstrap installed, attempting to install from SCM"
>          NEED_DEBOOTSTRAP=3Dtrue


--
Alex Benn=C3=A9e
