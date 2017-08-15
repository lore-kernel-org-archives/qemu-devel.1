Received: from eggs.gnu.org ([2001:4830:134:3::10]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhce4-0003hY-8S
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhce3-00045a-Ad
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:16:36 -0400
References: <20170815130740.31229-1-famz@redhat.com>
	<20170815130740.31229-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <badf1cc0-4f2b-994f-e5e8-705c9d1d68db@redhat.com>
Date: Tue, 15 Aug 2017 09:16:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170815130740.31229-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eQshOIDiULuO9vLjp6eQFUjBn03xIMTRn"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 2/4] nbd: Fix order of
 bdrv_set_perm and bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eQshOIDiULuO9vLjp6eQFUjBn03xIMTRn
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com
Message-ID: <badf1cc0-4f2b-994f-e5e8-705c9d1d68db@redhat.com>
Subject: Re: [PATCH for-2.10 v2 2/4] nbd: Fix order of bdrv_set_perm and
 bdrv_invalidate_cache
References: <20170815130740.31229-1-famz@redhat.com>
 <20170815130740.31229-3-famz@redhat.com>
In-Reply-To: <20170815130740.31229-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 08:07 AM, Fam Zheng wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>=20
> The "inactive" state of BDS affects whether the permissions can be
> granted, we must call bdrv_invalidate_cache before bdrv_set_perm to
> support "-incoming defer" case.
>=20
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  nbd/server.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 82a78bf439..b68b6fb535 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1045,11 +1045,22 @@ NBDExport *nbd_export_new(BlockDriverState *bs,=
 off_t dev_offset, off_t size,
>                            bool writethrough, BlockBackend *on_eject_bl=
k,
>                            Error **errp)
>  {
> +    AioContext  *ctx;

Odd spacing; can fix up as maintainer.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eQshOIDiULuO9vLjp6eQFUjBn03xIMTRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTAjQACgkQp6FrSiUn
Q2rCwQf9H1V7bnUUGPC5iIFmOdmokp8TFAJTCrRgZTvNFwbleZo2GoFvTqaqnhz/
c29g1hnOnINXYIRKP3zr1u7lm6caxt/rlRHaCGh3AQYcIx9EAlqypc8SGo1aYhNX
/gaCy/cQnMcWMXq4aypvy2OrUOfAR1ov11AvyqwxMYz6jF8/q6Et9D4g4H1BEfBE
o+iwWhx5ApgaecgM7uLGMLASJMUdruR5kT+Nf/sb55tYQcZ/B/KYj4R/zfypJMxd
g6sBlrw10LlqxgDg/5Mqotx2SUeoumJGNREEfWaIE2rql4hnobo0xPeAG+MEpdq7
q+VeXH10e37BRfPILQtadvKz+/PASA==
=PQML
-----END PGP SIGNATURE-----

--eQshOIDiULuO9vLjp6eQFUjBn03xIMTRn--
