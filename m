Received: from eggs.gnu.org ([2001:4830:134:3::10]:49554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdA62-0006Wm-BB
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 04:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdA5x-0002BP-4c
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 04:03:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdA5x-0002BG-0Q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 04:03:29 -0400
Date: Wed, 11 Jul 2018 16:03:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180711080325.GC1280@lemon.usersys.redhat.com>
References: <20180703153530.9330-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180703153530.9330-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Update debootstrap script after
 Debian migration from Alioth to Salsa
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

On Tue, 07/03 12:35, Philippe Mathieu-Daud=E9 wrote:
> This silents the following warning:
>=20
>   Cloning into './debootstrap.git'...
>   warning: redirecting to https://salsa.debian.org/installer-team/deboo=
tstrap.git/
>=20
> See https://lists.debian.org/debian-devel-announce/2018/01/msg00004.htm=
l
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/debian-bootstrap.pre | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/dock=
er/dockerfiles/debian-bootstrap.pre
> index 7c76dce663..44b18db7a2 100755
> --- a/tests/docker/dockerfiles/debian-bootstrap.pre
> +++ b/tests/docker/dockerfiles/debian-bootstrap.pre
> @@ -53,7 +53,7 @@ if [ -z $DEBOOTSTRAP_DIR ]; then
>          NEED_DEBOOTSTRAP=3Dtrue
>      fi
>      if $NEED_DEBOOTSTRAP; then
> -        DEBOOTSTRAP_SOURCE=3Dhttps://anonscm.debian.org/git/d-i/deboot=
strap.git
> +        DEBOOTSTRAP_SOURCE=3Dhttps://salsa.debian.org/installer-team/d=
ebootstrap.git
>          git clone ${DEBOOTSTRAP_SOURCE} ./debootstrap.git
>          export DEBOOTSTRAP_DIR=3D./debootstrap.git
>          DEBOOTSTRAP=3D./debootstrap.git/debootstrap
> --=20
> 2.18.0
>=20

Queued, thanks.

Fam
