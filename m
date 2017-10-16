Received: from eggs.gnu.org ([2001:4830:134:3::10]:47302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e44c7-0002Sf-M3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e44c4-0006AK-Iy
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:35:23 -0400
Date: Mon, 16 Oct 2017 12:35:05 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171016123505.GC1918@kos.to>
References: <20170926041420.32673-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926041420.32673-1-carenas@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: remove duplicate break in
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-trivial@nongnu.org

On Mon, Sep 25, 2017 at 09:14:20PM -0700, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
> likely introduced in 3532fa7402cda16f7b95261b0339c58630051f0b
>=20
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Applied to linux-user, thanks

> ---
>  linux-user/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a266..3ef4d1c568 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3131,7 +3131,6 @@ set_timeout:
>          case TARGET_SO_RCVLOWAT:
>  		optname =3D SO_RCVLOWAT;
>  		break;
> -            break;
>          default:
>              goto unimplemented;
>          }
> --=20
> 2.14.1
>=20
