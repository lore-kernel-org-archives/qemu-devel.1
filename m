Received: from eggs.gnu.org ([2001:4830:134:3::10]:51252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1eng9V-0006Dt-1W
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1eng9Q-0005tB-1C
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:46:21 -0500
Received: from mout.web.de ([212.227.15.4]:42057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1eng9P-0005t3-MB
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:46:15 -0500
Received: from [167.87.1.128] ([95.157.57.47]) by smtp.web.de (mrweb001
	[213.165.67.108]) with ESMTPSA (Nemesis) id 0MeScR-1f8P8M3nJP-00QF3o
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 08:46:14 +0100
From: Jan Kiszka <jan.kiszka@web.de>
References: <92b4111d-9151-6f5e-58e3-094cf06011a0@web.de>
Message-ID: <9a15951e-168c-c8f2-123b-e4bfed37f584@web.de>
Date: Mon, 19 Feb 2018 08:46:09 +0100
MIME-Version: 1.0
In-Reply-To: <92b4111d-9151-6f5e-58e3-094cf06011a0@web.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="buW8YJRwtNjHEoYpypQfoDfeGyrXUH1ym"
Subject: Re: [Qemu-devel] e1000e: MSI-X problem with recent Linux drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--buW8YJRwtNjHEoYpypQfoDfeGyrXUH1ym
From: Jan Kiszka <jan.kiszka@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <9a15951e-168c-c8f2-123b-e4bfed37f584@web.de>
Subject: Re: e1000e: MSI-X problem with recent Linux drivers
References: <92b4111d-9151-6f5e-58e3-094cf06011a0@web.de>
In-Reply-To: <92b4111d-9151-6f5e-58e3-094cf06011a0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-18 21:54, Jan Kiszka wrote:
> Hi,
>=20
> I've just noticed that the e1000e model does not work with its recent
> Linux kernel driver. This is my test matrix:
>=20
> Kernel		INTx (IntMode=3D0)	MSI-X
> 4.4		OK			OK
> 4.14		OK			no link
> master		OK			no link

FWIW: 4.9 (Debian kernel) is fine as well.

>=20
> In MSI-X mode, there are few interrupts arriving:
> [...]
>  25:          0          0          0          0  IR-PCI-MSI 32768-edge=
      enp0s2-rx-0
>  26:          0          0          0          0  IR-PCI-MSI 32769-edge=
      enp0s2-tx-0
>  27:          0          2          0          0  IR-PCI-MSI 32770-edge=
      enp0s2
>=20
> QEMU versions tested without differences: v2.8, v2.9, master.
>=20
> Any ideas what could go wrong, and where?
>=20
> Jan
>=20



--buW8YJRwtNjHEoYpypQfoDfeGyrXUH1ym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqKgMQACgkQitSsb3rl5xQJcQCfS7AUThgFyaK3QkoJMTqBrGBh
W9gAn0qeLtdTDYBNCnTf518u7jNZBN4J
=CagC
-----END PGP SIGNATURE-----

--buW8YJRwtNjHEoYpypQfoDfeGyrXUH1ym--
