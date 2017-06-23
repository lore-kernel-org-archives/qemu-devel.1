Received: from eggs.gnu.org ([2001:4830:134:3::10]:53193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dOCKN-0001bC-F2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 20:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dOCKM-0001aL-LM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 20:19:59 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:55638)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dOCKM-0001aF-Eo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 20:19:58 -0400
Date: Fri, 23 Jun 2017 02:19:55 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170623001955.2g6iqiqg2qkhcbus@var.youpi.perso.aquilenet.fr>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622124204.19407-13-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/31] slirp: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>

Marc-Andr=C3=A9 Lureau, on jeu. 22 juin 2017 14:41:45 +0200, wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied to my tree, thanks!

> ---
>  slirp/ip6.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/slirp/ip6.h b/slirp/ip6.h
> index 0908855f0f..b1bea43b3c 100644
> --- a/slirp/ip6.h
> +++ b/slirp/ip6.h
> @@ -57,9 +57,9 @@ static inline bool in6_equal_mach(const struct in6_ad=
dr *a,
>                                    const struct in6_addr *b,
>                                    int prefix_len)
>  {
> -    if (memcmp(&(a->s6_addr[(prefix_len + 7) / 8]),
> -               &(b->s6_addr[(prefix_len + 7) / 8]),
> -               16 - (prefix_len + 7) / 8) !=3D 0) {
> +    if (memcmp(&(a->s6_addr[DIV_ROUND_UP(prefix_len, 8)]),
> +               &(b->s6_addr[DIV_ROUND_UP(prefix_len, 8)]),
> +               16 - DIV_ROUND_UP(prefix_len, 8)) !=3D 0) {
>          return 0;
>      }
> =20
> --=20
> 2.13.1.395.gf7b71de06
>=20

--=20
Samuel
<D> N: j'aime bien Cut d'un truc enorme... ca montre de quel cote de l'ec=
ran sont les gonades :)))
 -+- #ens-mim et la peufeupeu -+-
