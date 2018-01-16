Received: from eggs.gnu.org ([2001:4830:134:3::10]:38471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZNI-0006MN-IX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZNH-0005sF-Fc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:06:32 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a8ac19c-6d7c-dee7-174f-ffdee1a1a0d6@redhat.com>
Date: Tue, 16 Jan 2018 16:06:21 -0600
MIME-Version: 1.0
In-Reply-To: <a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PDfoOMsoZ5iwzp4k4QThSw5rPgRNFOxIS"
Subject: Re: [Qemu-devel] [PATCH v2 13/32] qcow2: Add l2_slice_size field to
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PDfoOMsoZ5iwzp4k4QThSw5rPgRNFOxIS
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <9a8ac19c-6d7c-dee7-174f-ffdee1a1a0d6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/32] qcow2: Add l2_slice_size field to
 BDRVQcow2State
References: <cover.1513342045.git.berto@igalia.com>
 <a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
In-Reply-To: <a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> The BDRVQcow2State structure contains an l2_size field, which stores
> the number of 64-bit entries in an L2 table.
>=20
> For efficiency reasons we want to be able to load slices instead of
> full L2 tables, so we need to know how many entries an L2 slice can
> hold.
>=20
> An L2 slice is the portion of an L2 table that is loaded by the qcow2
> cache. At the moment that cache can only load complete tables,
> therefore an L2 slice has the same size as an L2 table (one cluster)
> and l2_size =3D=3D l2_slice_size.
>=20
> Later we'll allow smaller slices, but until then we have to use this
> new l2_slice_size field to make the rest of the code ready for that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 3 +++
>  block/qcow2.h | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index bdac1c156f..c1e4bab391 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -797,6 +797,7 @@ static void read_cache_sizes(BlockDriverState *bs, =
QemuOpts *opts,
>  typedef struct Qcow2ReopenState {
>      Qcow2Cache *l2_table_cache;
>      Qcow2Cache *refcount_block_cache;
> +    int l2_slice_size;

Worth a comment?
/* Number of entries in a slice of the L2 table */

With or without,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PDfoOMsoZ5iwzp4k4QThSw5rPgRNFOxIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlped10ACgkQp6FrSiUn
Q2oBfwf/af/dvuoxmmDRRyvcd6RCVeUt3+ev9P0O7EuGkFoDeGrgL1NWwVowId46
xOUUUMlCOQKHBOzs0skH0RV/9n3YUvxyZ2hWOhHl7hONrzUR+XVcLDNS2U5yMpEd
g4174x/oUYPUj6Z3H9F2h+RzY71fn19GU6+qS6mpnDxiiWuqVB8pF7FYpuRCSMJ6
eEjCHx9QzsuoR7qapJ258bqik7mG2Fh8zTzpSTPZ6iCMdKG/20Lkkt0SyogTDxni
GENzMAXVPAbNvzI9rrX3WWr2E8MUV03AcxoL66KrFlsV2we5nTm41T5KMeNlUOJV
hpzAZK3P4uUNz99fQTPOflLzmOayDw==
=PWy/
-----END PGP SIGNATURE-----

--PDfoOMsoZ5iwzp4k4QThSw5rPgRNFOxIS--
