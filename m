Received: from eggs.gnu.org ([2001:4830:134:3::10]:40635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTajh-0004gs-Hz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaje-0004R8-DW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTaje-0004Qf-3m
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:24:22 -0400
References: <20170707151546.7893-1-berrange@redhat.com>
	<20170707151546.7893-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89e0436f-2b95-b3e4-e372-688e9408178a@redhat.com>
Date: Fri, 7 Jul 2017 16:24:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170707151546.7893-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oIrSoEU2We0Wcl9v2ltA6MAbo3ADSPA7P"
Subject: Re: [Qemu-devel] [PATCH v5 5/5] tests: add functional test
 validating ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oIrSoEU2We0Wcl9v2ltA6MAbo3ADSPA7P
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89e0436f-2b95-b3e4-e372-688e9408178a@redhat.com>
Subject: Re: [PATCH v5 5/5] tests: add functional test validating ipv4/ipv6
 address flag handling
References: <20170707151546.7893-1-berrange@redhat.com>
 <20170707151546.7893-6-berrange@redhat.com>
In-Reply-To: <20170707151546.7893-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:15 AM, Daniel P. Berrange wrote:
> The semantics around handling ipv4=3Don|off & ipv6=3Don|off are quite
> subtle to understand in combination with the various hostname addresses=

> and backend types. Introduce a massive test matrix that launches QEMU
> and validates the ability to connect a client on each protocol as
> appropriate.
>=20
> The test requires that the host has ability to bind to both :: and
> 0.0.0.0, on port 9000. If either protocol is not available, or if
> something is already listening on that port the test will skip.
>=20
> Although it isn't using the QTest APIs, it expects the
> QTEST_QEMU_BINARY env variable to be set.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

The only difference in v5 appears to be the pid-file cleanup that I
mentioned on v4.

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oIrSoEU2We0Wcl9v2ltA6MAbo3ADSPA7P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/wDAAoJEKeha0olJ0NqJdAH/0oMtkUUWoxzcIDZzFJizTNo
mywZFDpdTfZMe5jcIhJ8HHGvWoe/+QyqSXhYY9X7QArv5B2b66TCE+iQpeVYVcpe
V31gk0iE2/LObbaVHNCXuQxz4va+vpipWXtAHVsRzgdPHOfnN/JAwZD0f5NGJiKy
SlAwRv7ZldNl5+QLu4SV6GmoL9dkkS3Vct1sGI/WhweYJJMahN4MzWB/721Oxspa
OMolVc+nwRInbUmndmEeiiKmNu0ZXu6JALI7r51sJyVW6zU4/FuHN6wQfkCRKXTV
qH5lKv0p1k3AlkJphijEV/y14G0DMiatWoH9Sef1mDQaYuXCzDrqNkVzc/wkyCo=
=FtxH
-----END PGP SIGNATURE-----

--oIrSoEU2We0Wcl9v2ltA6MAbo3ADSPA7P--
