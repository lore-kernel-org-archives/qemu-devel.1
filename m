Received: from eggs.gnu.org ([2001:4830:134:3::10]:54256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO1r1-0004KX-Ko
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO1qy-00080g-VP
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:08:59 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dO1qy-00080O-PA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:08:56 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5763810C163
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 15:08:55 +0200 (CEST)
Date: Thu, 22 Jun 2017 15:08:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170622150850.27a0332d@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170622124204.19407-29-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-29-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/fv_36mYZvG85vmGu=qL18um";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 28/31] 9pfs: replace g_malloc()+memcpy()
 with g_memdup()
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

--Sig_/fv_36mYZvG85vmGu=qL18um
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jun 2017 14:42:01 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> I found these pattern via grepping the source tree. I don't have a
> coccinelle script for it!
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Thanks! Applied to my 9p-next branch at:

https://github.com/gkurz/qemu/commits/9p-next

>  hw/9pfs/9p-synth.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 4b6d4e6a3f..df0a8de08a 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -494,8 +494,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPat=
h *dir_path,
>      }
>  out:
>      /* Copy the node pointer to fid */
> -    target->data =3D g_malloc(sizeof(void *));
> -    memcpy(target->data, &node, sizeof(void *));
> +    target->data =3D g_memdup(&node, sizeof(void *));
>      target->size =3D sizeof(void *);
>      return 0;
>  }


--Sig_/fv_36mYZvG85vmGu=qL18um
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllLwWIACgkQAvw66wEB28La5gCaAon7ekBZi52DjyCgErgSZgoy
D6QAn0rR4Kodc8Ff+QztmIVWq6xBwRbQ
=fp1H
-----END PGP SIGNATURE-----

--Sig_/fv_36mYZvG85vmGu=qL18um--
