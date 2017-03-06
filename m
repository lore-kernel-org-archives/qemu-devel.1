Received: from eggs.gnu.org ([2001:4830:134:3::10]:40802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckz2q-0004ev-2c
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckz2p-0001j8-0q
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:15:47 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97f89010-f6e0-4ee2-62a5-2fb8d3760c67@redhat.com>
Date: Mon, 6 Mar 2017 14:15:38 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PFaFVHOaDTvTnaDBiJanv8im3iADjUGUG"
Subject: Re: [Qemu-devel] [PATCH 04/10] mirror: Fix error path for dirty
 bitmap creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PFaFVHOaDTvTnaDBiJanv8im3iADjUGUG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <97f89010-f6e0-4ee2-62a5-2fb8d3760c67@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] mirror: Fix error path for dirty
 bitmap creation
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> mirror_top_bs must be removed from the graph again when creating the
> dirty bitmap fails.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 001b5f0..f24dc51 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1197,10 +1197,7 @@ static void mirror_start_job(const char *job_id,=
 BlockDriverState *bs,
> =20
>      s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, NULL=
, errp);
>      if (!s->dirty_bitmap) {
> -        g_free(s->replaces);
> -        blk_unref(s->target);
> -        block_job_unref(&s->common);
> -        return;
> +        goto fail;
>      }
> =20
>      /* Required permissions are already taken with blk_new() */
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PFaFVHOaDTvTnaDBiJanv8im3iADjUGUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcNqAAoJEKeha0olJ0NqVmcH/1TX/fwnOAxEHwwftBxH5vWK
C8J1rnBSFVDF1abdWLbbPpGAlc51/zI21CiOqfU1qhGiD3B1PqDU575k6DXmU5iR
NY3pfkdog46LVTgTjb2eAtfNKN+12XR0CaMZ9FRMvNaf0Uk7u85mGsVer/XUvm9W
y791sfmPYtS7414ozz8qMZpJ9liiczo3IUhToF/XSJ56wKfnmF6vncodNsKt4hhA
r/UUrvuBJsBf9SR0BsB2u81piH9mMC3tRZYAu71noaNowIzaYAT2pfirAOo1Nrdr
9H9Xp9jGAQtAPRd0r1Nud0/Sx4QI+pZU2HtBMchmDhVFXExFYC5RT1c/RMiMZpw=
=kVBj
-----END PGP SIGNATURE-----

--PFaFVHOaDTvTnaDBiJanv8im3iADjUGUG--
