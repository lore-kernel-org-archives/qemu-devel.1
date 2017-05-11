Received: from eggs.gnu.org ([2001:4830:134:3::10]:47844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1d8w4t-0008PM-4j
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slyfox@gentoo.org>) id 1d8w4o-0004ch-F9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:56:55 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:40178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slyfox@gentoo.org>) id 1d8w4o-0004cC-7o
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:56:50 -0400
Date: Thu, 11 May 2017 22:56:28 +0100
From: Sergei Trofimovich <slyfox@gentoo.org>
Message-ID: <20170511225628.4cc01a7e@sf>
In-Reply-To: <20170408193322.16631-1-slyfox@gentoo.org>
References: <20170408193322.16631-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/uqxvTZLys29aS0cf8Q3zIu/";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] alpha-user: wire epoll_create, epoll_ctl,
 epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>

--Sig_/uqxvTZLys29aS0cf8Q3zIu/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat,  8 Apr 2017 20:33:22 +0100
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> Noticed when ran GHC on alpha:
>     $ qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp/a
>     qemu: Unsupported syscall: 407
>=20
> linux-user/syscall.c does have 'epoll_create' wiring,
> but under nondeprecated name.
>=20
> Instead of defining both
>     TARGET_NR_sys_epoll_create
> and
>     TARGET_NR_epoll_create
> I've renamed former to later as old name is not used
> anywhere else in qemu.
>=20
> After this change GHC works fine under qemu-alpha:
>     $ ./alpha-linux-user/qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp=
/a
>     ...
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  linux-user/alpha/syscall_nr.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
> index 00e14bb6b3..e848154663 100644
> --- a/linux-user/alpha/syscall_nr.h
> +++ b/linux-user/alpha/syscall_nr.h
> @@ -343,9 +343,9 @@
>  #define TARGET_NR_io_cancel			402
>  #define TARGET_NR_exit_group			405
>  #define TARGET_NR_lookup_dcookie		406
> -#define TARGET_NR_sys_epoll_create		407
> -#define TARGET_NR_sys_epoll_ctl		408
> -#define TARGET_NR_sys_epoll_wait		409
> +#define TARGET_NR_epoll_create			407
> +#define TARGET_NR_epoll_ctl			408
> +#define TARGET_NR_epoll_wait			409
>  #define TARGET_NR_remap_file_pages		410
>  #define TARGET_NR_set_tid_address		411
>  #define TARGET_NR_restart_syscall		412
> --=20
> 2.12.2
>=20

Ping.

--=20

  Sergei

--Sig_/uqxvTZLys29aS0cf8Q3zIu/
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSZKa0VG5avZRlY01hxoe52YR/zqgUCWRTeDAAKCRBxoe52YR/z
qkKwAJ9af+zA47oUB4F2zrnekdzTAPjbLwCff0yHGhkIi/WswzzaZfR2x9RkZcU=
=UuGc
-----END PGP SIGNATURE-----

--Sig_/uqxvTZLys29aS0cf8Q3zIu/--
