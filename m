Received: from eggs.gnu.org ([2001:4830:134:3::10]:51731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBwyL-0002xS-OB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBwyD-0000lT-L4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gBwyC-0000jV-11
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:07:16 -0400
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1e02eee6-de17-6da9-f7bb-4e12fc0b5cc6@redhat.com>
Date: Mon, 15 Oct 2018 09:07:06 +0200
MIME-Version: 1.0
In-Reply-To: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] archive-source.sh: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Fam Zheng <famz@redhat.com>

On 2018-10-15 08:51, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete `` and
> modern $(); use of `` is only required when using /bin/sh
> on Solaris. It would be nice to convert to using $()
> everywhere, or at least in all bash scripts, as well as in
> all scripts that are known to not be run on Solaris.

FWIW, I think we do not have to worry about Solaris' /bin/sh here
anymore. Somebody tried to compile on Solaris a couple of weeks ago, and
found out that you need a proper POSIX-compliant shell for compiling
QEMU, so /bin/sh can not be used here anymore anyway.

> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  scripts/archive-source.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 4e63774f9a..62bd22578b 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -18,7 +18,7 @@ if test $# -lt 1; then
>      error "Usage: $0 <output tarball>"
>  fi
> =20
> -tar_file=3D`realpath "$1"`
> +tar_file=3D$(realpath "$1")
>  list_file=3D"${tar_file}.list"
>  vroot_dir=3D"${tar_file}.vroot"
> =20
> @@ -34,7 +34,7 @@ if git diff-index --quiet HEAD -- &>/dev/null
>  then
>      HEAD=3DHEAD
>  else
> -    HEAD=3D`git stash create`
> +    HEAD=3D$(git stash create)
>  fi
>  git clone --shared . "$vroot_dir"
>  test $? -ne 0 && error "failed to clone into '$vroot_dir'"
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
