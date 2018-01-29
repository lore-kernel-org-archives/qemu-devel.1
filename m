Received: from eggs.gnu.org ([2001:4830:134:3::10]:39590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egEP4-0003EM-A4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egEP3-0002Du-Dc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:43:38 -0500
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
Date: Mon, 29 Jan 2018 19:43:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180122104100.3674-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cUXZfqwXa7CrRbAqfTfpOqUCbQsxzKKKn"
Subject: Re: [Qemu-devel] [PATCH v2] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cUXZfqwXa7CrRbAqfTfpOqUCbQsxzKKKn
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com,
 mnestratov@virtuozzo.com
Message-ID: <7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
Subject: Re: [PATCH v2] block: maintain persistent disabled bitmaps
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180122104100.3674-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-22 11:41, Vladimir Sementsov-Ogievskiy wrote:
> To maintain load/store disabled bitmap there is new approach:
>=20
>  - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
>  - store enabled bitmaps as "auto" to qcow2
>  - store disabled bitmaps without "auto" flag to qcow2
>  - on qcow2 open load "auto" bitmaps as enabled and others
>    as disabled (except in_use bitmaps)
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---

Thanks, looks very reasonable.  Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--cUXZfqwXa7CrRbAqfTfpOqUCbQsxzKKKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpva0USHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Av8gH/2I9guuQ5iuZuXbDAl/mC1d5vYC/iz4N
hwiVIQn9tSjn0TSHysEYfiMH+15C2DoR3+7pbyUujuT3zd76/VwNyKCWJPEI08SM
rtq2+zFqPsypcB+Sm/SxGxGdOl90Qp5r94ya/PTwAeqRiHRttDrhQ4QhLEPnkCdt
VJNGrxI8xADufAJJsF0eoxxtkzEyhUWgAeDhukqROVTLlYjAS6icjeRd+VndJlg8
ln6QUYDNMiHg0n6yCmeTJiTHeYXdonm4GlSeYZ+CwMKgMcTyMoxjv2bYY9jnL3bn
FgFTh6KFmcg4xYZBwb0e+VRCCmj994kLykoMcOIKvVg+11giV8wR5Co=
=H5J1
-----END PGP SIGNATURE-----

--cUXZfqwXa7CrRbAqfTfpOqUCbQsxzKKKn--
