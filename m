Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDra-0002Xj-Tw
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDDrZ-0002FO-VJ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:17:10 -0500
References: <cover.1510143008.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <468a9b98-06ea-f3d5-d9ad-d62afe260845@redhat.com>
Date: Fri, 10 Nov 2017 19:17:01 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1510143008.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aAQmfUiCwCdlU30R9VJlMLT8CaHhirEcc"
Subject: Re: [Qemu-devel] [PATCH 0/1] qcow2: Check that corrupted images can
 be repaired in iotest 060
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aAQmfUiCwCdlU30R9VJlMLT8CaHhirEcc
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <468a9b98-06ea-f3d5-d9ad-d62afe260845@redhat.com>
Subject: Re: [PATCH 0/1] qcow2: Check that corrupted images can be repaired in
 iotest 060
References: <cover.1510143008.git.berto@igalia.com>
In-Reply-To: <cover.1510143008.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-08 13:13, Alberto Garcia wrote:
> Hi,
>=20
> I sent the 'Misc qcow2 corruption checks' series the other day, and
> Kevin suggested that we check that the corrupted images can be
> repaired using qemu-img.
>=20
> This patch extends the tests that I wrote in order to do just
> that. Since the series is already in Max's branch I decided to write
> this as a follow-up patch, but if you prefer I can resend it instead.
>=20
> Regards,
>=20
> Berto

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--aAQmfUiCwCdlU30R9VJlMLT8CaHhirEcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF7R0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhqYH/3RB0a61y3x5mSm6IaiyLmm4uyDhfLIe
YyFqQzGZHtCezNmhMGEZXCxrp4C9KM49PLKawh49jJgd0xWNgK0TSJGvJScwTc7H
qRJXKpfFzfXaSdayPWsRsyq/zXEt4ZmfIFHnoKhBvQJIdM1DY17AnZ2Ygoa/zHJV
zNwSujc1N0i57QbdPFsvxC8zFUOuOetBMw2WcT/tUB6feCoAZpVOXujhqiB1q7Ez
JN2R4T1cmlAwFnjrIfbdaPTuFs1HVEbO7lB7h3OanG0Ct2njF6Ac3R6VLjay3hjd
Eww6zEQsG23cspTpCHFphq4A/ug8uwcJHCLFyVLwW6ikNzFlSlYoEYc=
=wVAq
-----END PGP SIGNATURE-----

--aAQmfUiCwCdlU30R9VJlMLT8CaHhirEcc--
