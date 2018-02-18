Received: from eggs.gnu.org ([2001:4830:134:3::10]:44973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1enVyP-0004jN-FR
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 15:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1enVyM-0008FQ-6r
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 15:54:13 -0500
Received: from mout.web.de ([212.227.17.12]:56801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1enVyL-00089t-Qa
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 15:54:10 -0500
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb102
	[213.165.67.124]) with ESMTPSA (Nemesis) id 0LlWGZ-1eFXvk0hSJ-00bNSU
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 21:54:07 +0100
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <92b4111d-9151-6f5e-58e3-094cf06011a0@web.de>
Date: Sun, 18 Feb 2018 21:54:03 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="i08tAPkIUEzUfskKUDQuEojXwSedVdzt7"
Subject: [Qemu-devel] e1000e: MSI-X problem with recent Linux drivers
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
--i08tAPkIUEzUfskKUDQuEojXwSedVdzt7
From: Jan Kiszka <jan.kiszka@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <92b4111d-9151-6f5e-58e3-094cf06011a0@web.de>
Subject: e1000e: MSI-X problem with recent Linux drivers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've just noticed that the e1000e model does not work with its recent
Linux kernel driver. This is my test matrix:

Kernel		INTx (IntMode=3D0)	MSI-X
4.4		OK			OK
4.14		OK			no link
master		OK			no link

In MSI-X mode, there are few interrupts arriving:
[...]
 25:          0          0          0          0  IR-PCI-MSI 32768-edge  =
    enp0s2-rx-0
 26:          0          0          0          0  IR-PCI-MSI 32769-edge  =
    enp0s2-tx-0
 27:          0          2          0          0  IR-PCI-MSI 32770-edge  =
    enp0s2

QEMU versions tested without differences: v2.8, v2.9, master.

Any ideas what could go wrong, and where?

Jan


--i08tAPkIUEzUfskKUDQuEojXwSedVdzt7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqJ5+4ACgkQitSsb3rl5xRHXgCglYZ3oPLMu3zJRx3sSYjfeKn8
NacAni7Kobs98W1DdWwoWdrFQU0px97n
=osdg
-----END PGP SIGNATURE-----

--i08tAPkIUEzUfskKUDQuEojXwSedVdzt7--
