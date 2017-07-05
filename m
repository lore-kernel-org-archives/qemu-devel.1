Received: from eggs.gnu.org ([2001:4830:134:3::10]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSgsF-0000De-Kj
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSgsC-0007S2-G8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:45:31 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSgsC-0007Qd-A7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:45:28 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7E83B826D7
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 11:45:26 +0200 (CEST)
Date: Wed, 5 Jul 2017 11:45:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170705114522.43bc88e1@bahia.lan>
In-Reply-To: <20170704220346.29244-29-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-29-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/E/U3uXRBJfFiQ=_oFShuZEE";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 28/35] 9p: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/E/U3uXRBJfFiQ=_oFShuZEE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Jul 2017 00:03:39 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index d1cfeaf10e..935a6c9a3c 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -312,21 +312,24 @@ typedef struct V9fsGetlock
>  extern int open_fd_hw;
>  extern int total_open_fd;
> =20
> -static inline void v9fs_path_write_lock(V9fsState *s)
> +static inline void coroutine_fn
> +v9fs_path_write_lock(V9fsState *s)
>  {
>      if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
>          qemu_co_rwlock_wrlock(&s->rename_lock);
>      }
>  }
> =20
> -static inline void v9fs_path_read_lock(V9fsState *s)
> +static inline void coroutine_fn
> +v9fs_path_read_lock(V9fsState *s)
>  {
>      if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
>          qemu_co_rwlock_rdlock(&s->rename_lock);
>      }
>  }
> =20
> -static inline void v9fs_path_unlock(V9fsState *s)
> +static inline void coroutine_fn
> +v9fs_path_unlock(V9fsState *s)
>  {
>      if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
>          qemu_co_rwlock_unlock(&s->rename_lock);


--Sig_/E/U3uXRBJfFiQ=_oFShuZEE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllctTIACgkQAvw66wEB28LqPQCfSHQywGaU0kLjBDn4bfdKH4AN
kMMAoJuihpeV3DsBVHcC9L8iJuIt2EGJ
=1yFW
-----END PGP SIGNATURE-----

--Sig_/E/U3uXRBJfFiQ=_oFShuZEE--
