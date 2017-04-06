Received: from eggs.gnu.org ([2001:4830:134:3::10]:54949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwBLJ-0003tx-Hr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwBLI-0006n6-Gv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:37:09 -0400
References: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
	<1491498851-16709-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70705caf-5b17-6001-6d7c-b3b97e0a61c2@redhat.com>
Date: Thu, 6 Apr 2017 12:36:52 -0500
MIME-Version: 1.0
In-Reply-To: <1491498851-16709-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F7MS3in7g42sDbbB3WAmTI9iHrJLqIbFH"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] commit: Set
 commit_top_bs->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F7MS3in7g42sDbbB3WAmTI9iHrJLqIbFH
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <70705caf-5b17-6001-6d7c-b3b97e0a61c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] commit: Set
 commit_top_bs->total_sectors
References: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
 <1491498851-16709-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491498851-16709-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 12:14 PM, Kevin Wolf wrote:
> Like in the mirror filter driver, we also need to set the image size fo=
r
> the commit filter driver. This is less likely to be a problem in
> practice than for the mirror because we're not at the active layer here=
,
> but attaching new parents to a node in the middle of the chain is
> possible, so the size needs to be correct anyway.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/commit.c b/block/commit.c
> index 4c38220..91d2c34 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -335,6 +335,7 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
>      if (commit_top_bs =3D=3D NULL) {
>          goto fail;
>      }
> +    commit_top_bs->total_sectors =3D top->total_sectors;

[I'd really like to change total_sectors to bytes in 2.10 or later, but
that's a much hairier mess to untangle. I've got some patches that I
hope to post soon that at least start the process with regards to
bdrv_is_allocated...]

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--F7MS3in7g42sDbbB3WAmTI9iHrJLqIbFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5ny0AAoJEKeha0olJ0NqSP0H/RqBDP3WpN1xGZXlEKNasUXf
mg9zJXZV2b30GCoKnYFA29WqRK4WqMB+JCr63ez9Lv/noFz/fDBysr/1M3x+zFIq
5u+8pE4X2FAu/H1ENEVni8QDUP/ysmWfyB18i7KjC59eGBrwBrevctNgbQARsEbZ
/mPoqS8cVuajD6tgADys0IPdCRYGjPtH5EEeOD2PAd9vAHvM6J3XE796y8q7hQ6C
trUUY+QD0PVHcCJq0hN6QQ2Vo2TP8ZKE4sa6IXQXQpzs1D73IrpARVwZv7x8CrdI
hlXHvktnng/+Ys5q3Mrg5AzWjrFHJ+8nteWsXYAB65YewBV4eKDy4YxTh1+jtHo=
=vIuP
-----END PGP SIGNATURE-----

--F7MS3in7g42sDbbB3WAmTI9iHrJLqIbFH--
