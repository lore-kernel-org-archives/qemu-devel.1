Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZ36-00071m-PG
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 14:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZ35-00035q-NV
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 14:52:36 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b617906d-8790-4597-e886-b09aae92cbf4@redhat.com>
Date: Sat, 28 Jan 2017 20:52:25 +0100
MIME-Version: 1.0
In-Reply-To: <20161220191523.5779-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qhcSCsoNGUFAwC2qKRrogvsmjb6gOA7Pd"
Subject: Re: [Qemu-devel] [PATCH v4 1/7] qcow2: Assert that cluster
 operations are aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qhcSCsoNGUFAwC2qKRrogvsmjb6gOA7Pd
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <b617906d-8790-4597-e886-b09aae92cbf4@redhat.com>
Subject: Re: [PATCH v4 1/7] qcow2: Assert that cluster operations are aligned
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-2-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-2-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.12.2016 20:15, Eric Blake wrote:
> qcow2_discard_clusters() is set up to silently ignore sub-cluster
> head or tail on unaligned requests.  However, it is easy to audit
> the various callers: qcow2_snapshot_create() has always passed
> aligned data since the call was introduced in 1ebf561;
> qcow2_co_pdiscard() has passed aligned clusters since commit
> ecdbead taught the block layer the preferred discard alignment (the
> block layer can still pass sub-cluster values, but those are
> handled directly in qcow2_co_pdiscard()); and qcow2_make_empty()
> was fixed to pass aligned clusters in commit a3e1505.  Replace
> rounding with assertions to hold us to the tighter contract,
> eliminating the now-impossible case of an early exit for a
> sub-cluster request.
>=20
> qcow2_zero_clusters() has always been called with cluster-aligned
> arguments from its lone caller qcow2_co_pwrite_zeroes() (like
> qcow2_co_pdiscard(), the caller takes care of sub-cluster requests
> from the block layer; and qcow2_zero_clusters() would have
> misbehaved on unaligned requests), but it deserves the same
> assertion for symmetry.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v4: new patch
> ---
>  block/qcow2-cluster.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qhcSCsoNGUFAwC2qKRrogvsmjb6gOA7Pd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliM9nkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmJQIAJXLnl9YDT62Bf9omAY1O79yCRCks5gH
l4f5lk2Ny6LWo+SLXgD/ztI1zFX1hWtbuzD2yxHWRmg0UeE+OULqGbPR3HsbUJb0
yA88qxWqGba3R2NUr4Mw4mUp7vzk0XtmvjYkaGf54VLpPZVDrnQuFfCZT4+t3b+Z
cpaifT4CNVjupuGWxGIHg1mEfg1itg5igw0gUcTPQCZq261gNDTMLyCN3G00KUHa
d1CTwDDfztSRf02oTZWfcsiv/18cBB4vC6jK1pPazBe2Ti/o86p5X0s3SyPA4yay
7K+b+Xs5kP23UUJ38pts6gN3uzgxnUIsFB7d4lyALvxgXYi0pIrs050=
=kyb3
-----END PGP SIGNATURE-----

--qhcSCsoNGUFAwC2qKRrogvsmjb6gOA7Pd--
