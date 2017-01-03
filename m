Received: from eggs.gnu.org ([2001:4830:134:3::10]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUR5-0003VU-IH
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUR4-0002vh-Eb
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:07:51 -0500
References: <20170103170459.27662-1-berrange@redhat.com>
	<20170103170459.27662-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf532f94-88b9-5b07-f0bc-9452be411e39@redhat.com>
Date: Tue, 3 Jan 2017 13:07:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170459.27662-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dU9ves155HXviThFqaSjqLP5xOlhVJLEI"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] iotests: reduce PBKDF iterations
 when testing LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dU9ves155HXviThFqaSjqLP5xOlhVJLEI
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <cf532f94-88b9-5b07-f0bc-9452be411e39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] iotests: reduce PBKDF iterations when
 testing LUKS
References: <20170103170459.27662-1-berrange@redhat.com>
 <20170103170459.27662-4-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:04 AM, Daniel P. Berrange wrote:
> By default the PBKDF algorithm used with LUKS is tuned
> based on the number of iterations to produce 1 second
> of running time. This makes running the I/O test with
> the LUKS format orders of magnitude slower than with
> qcow2/raw formats.
>=20
> When creating LUKS images, set the iteration time to
> a 10ms to reduce the time overhead for LUKS, since
> security does not matter in I/O tests.
>=20
> Previsouly a full 'check -luks' would take
>=20
>   $ time ./check -luks
>   Passed all 22 tests
>=20
>   real  23m9.988s
>   user  21m46.223s
>   sys   0m22.841s
>=20
> Now it takes
>=20
>   $ time ./check -luks
>   Passed all 22 tests
>=20
>   real  4m39.235s
>   user  3m29.590s
>   sys   0m24.234s
>=20
> Still slow compared to qcow2/raw, but much improved
> none the less.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dU9ves155HXviThFqaSjqLP5xOlhVJLEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa/Z/AAoJEKeha0olJ0NqUbQH/Ra37KpXJG4JJpqoSXIpyF5l
AaxOpOy2AwhOZ8GpUP0h87twdNPRYNPbAV3MtLS5nd/7lel+NLVTy2DdrvuyZ9Sh
qSytTiL8I8CLaBdNbr3LhRatewFPv6GGfr4Wk6/iMkN2Qg3mNEKJZDR6opgLzdoK
PHBIJg93irF02hJoKKlzaygxq5aQMCyp+oCK0GnINC1CFO9w1dCw94nuYBRXh2db
IsRSgocq7RYBV7y+fpUrhrgDK+CJ5+E+R1PA6P1dDPkDYNLSrgrEgBetbA4WwGpt
ehfby/X4qwUx1BsVnFew9rIkqGSIAkyzCO56JDVhVI3YBs1JjIVrL5GQtdPR4k8=
=pP9/
-----END PGP SIGNATURE-----

--dU9ves155HXviThFqaSjqLP5xOlhVJLEI--
