Received: from eggs.gnu.org ([2001:4830:134:3::10]:49097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWP2i-0006qf-2w
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWP2h-0002Zr-6A
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:59:24 -0500
References: <20170103160556.9895-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eaccdf05-6575-0304-7f96-fa38853498dd@redhat.com>
Date: Wed, 25 Jan 2017 15:59:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170103160556.9895-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NSjv3w8of0l0t6It6sXjXNsUlhXTQqPJS"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: record separate timings per
 format, protocol pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NSjv3w8of0l0t6It6sXjXNsUlhXTQqPJS
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <eaccdf05-6575-0304-7f96-fa38853498dd@redhat.com>
Subject: Re: [PATCH v2] iotests: record separate timings per format,protocol
 pair
References: <20170103160556.9895-1-berrange@redhat.com>
In-Reply-To: <20170103160556.9895-1-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 17:05, Daniel P. Berrange wrote:
> The 'check' program records timings for each test that
> is run. These timings are only valid, however, for a
> particular format/protocol combination. So if frequently
> running 'check' with a variety of different formats or
> protocols, the times printed can be very misleading.
>=20
> Instead of having a single 'check.time' file, maintain
> multiple 'check.time-$IMGPROTO-$IMGFMT' files.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> Changed in v2:
>=20
>  - Use a separate file per format/protocol, instead of
>    throwing away data each time format/protocol changes
>    between runs (Eric)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--NSjv3w8of0l0t6It6sXjXNsUlhXTQqPJS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliIvUESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHzoH/1IQEA43sz6O86Bvu6QRInA1VVdGlf+D
xFl6qBbymtxIuvhKufqQy1aUBN+w/KFeyrEXduZX0ACv0ri52Q/TkwtEDzAAv13h
Vqqe4gXCuKXhFfEZ+Zlsgc7SiXTvwEgJorAXUwRYGKG67ltviORPRhFKWACXrO37
eZO1tX6xbWIUBoz/3vnM9ws4+02q+HTk1MnOJE7v+Iwse8stwzeQGz9goJP9f1D4
tiSUkCKq6AbjY2JP/Ep+6Ed1wvs8L43j1hyhiUCPmxUzPzk2DP2ql6WAPcVi1duE
Dfi5ohe2Ub/lERIQIMAyhCaEVZGEp9aUViXxScQLzCdI5moX4oZ9X8s=
=0MgZ
-----END PGP SIGNATURE-----

--NSjv3w8of0l0t6It6sXjXNsUlhXTQqPJS--
