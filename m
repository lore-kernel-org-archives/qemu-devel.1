Received: from eggs.gnu.org ([209.51.188.92]:58197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUka-0001oc-75
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUkZ-0002Z0-Fp
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:28:56 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-8-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <036be248-8d88-cd62-6337-209e14a8cdc0@redhat.com>
Date: Wed, 6 Feb 2019 15:28:51 -0600
MIME-Version: 1.0
In-Reply-To: <20190206195551.28893-8-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XAtuT4Ql3TMRRpBgAyERGyupqwrydYNBq"
Subject: Re: [Qemu-devel] [PATCH v3 7/8] iotests: Test internal option typing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAtuT4Ql3TMRRpBgAyERGyupqwrydYNBq
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <036be248-8d88-cd62-6337-209e14a8cdc0@redhat.com>
Subject: Re: [PATCH v3 7/8] iotests: Test internal option typing
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-8-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:55 PM, Max Reitz wrote:
> It would be nice if qemu used the correct types for blockdev options
> internally, even if the user specified string values (either through
> -drive or by being not so nice and using json:{} with string values).
> This patch adds a test verifying that fact.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/089     | 25 +++++++++++++++++++++++++
>  tests/qemu-iotests/089.out |  9 +++++++++
>  2 files changed, 34 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XAtuT4Ql3TMRRpBgAyERGyupqwrydYNBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbUZMACgkQp6FrSiUn
Q2rWBwf+IXGDhr5odnYMY2TXEXraMjyulqQ964RgkgYS7ahGBhPlIQHwapAhmmTQ
E8OypEeQNAsWvAKiieSIivUCaoxazd8dG1flP1/UsIsB7QDqwpYfxvtdNHoMLnNr
T7yKwRHCXy72ZMmxo7ax8aNS7OovVCZVB1PT7YDyWYZe/YEdqxchet+Fd0wn2KmG
kBEWLlbjwXPWz2hqieLS/QF9d9rwJp9epbKctntym9mI2Ip4NVVSbCHEsjYZdJiC
MzEoFhAxONaTOpyjfp/2WD4oTlIWXxRKlkEryy/R3mTK44FXIhzTYf3lyUAJ3rJc
t/eR+0iz9dWdYXdaLJYOtU4s4Fx/yw==
=1h1l
-----END PGP SIGNATURE-----

--XAtuT4Ql3TMRRpBgAyERGyupqwrydYNBq--
