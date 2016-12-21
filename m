Received: from eggs.gnu.org ([2001:4830:134:3::10]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJezu-0003kJ-MZ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJezq-0002q0-OO
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:23:50 -0500
Received: from mail-wj0-x22c.google.com ([2a00:1450:400c:c01::22c]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJezq-0002pk-I4
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:23:46 -0500
Received: by mail-wj0-x22c.google.com with SMTP id xy5so199551689wjc.0
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 03:23:44 -0800 (PST)
Date: Wed, 21 Dec 2016 11:23:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161221112342.GE9482@stefanha-x1.localdomain>
References: <CAMxP3BREAp7wm8B8=z0d1qAcG18Pv19UpU7RrSikGBunScNNOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <CAMxP3BREAp7wm8B8=z0d1qAcG18Pv19UpU7RrSikGBunScNNOw@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU -smp paramater: Will multiplue threads and
 cores improve performance?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: qemu-devel@nongnu.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2016 at 04:44:08PM +0800, Bob Chen wrote:
> -smp 16
>=20
> -smp cores=3D4,threads=3D4,sockets=3D1
>=20
>=20
> Which one has better performance? The scenario is guest VMs running on
> cloud server.

It's more complicated than that.

The CPU topology (cores, threads, sockets) can be used by guest kernels
to make scheduling decisions.

If you pin vcpu threads to host cpus and configure the guest with
an accurate CPU topology then you can expect the guest kernel to make
the best decisions.

If you do not pin vcpu threads then you cannot expect any consistent
performance advantage by specifying the CPU topology.

Stefan

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWmY9AAoJEJykq7OBq3PIMagIAJqrPmYnW1I4pC4vCCDcWMaM
eu1vM6XjPefhUKAoLSFq/N0ZgNIzkfLmzGJLz8e120YvzvhYd6LO33ecMpCz74UA
tKxwqpHd7MDofd/Ml5W1Qvzb9WHeAWmAzDIwPpSXhLIEsdwxLqTFj46x1HbJtezP
SHVmyijAnyv+JUG730V7IceFQNUvX9c/5UkRNJ8gqlzChK55HURfKRvG5FAbs6tW
9iDl5zpxxVXlNyDKRkq9/FZLz/ZiNXvMycVN/zWuN9Um4/7WJWaGwv1D9ymxhdYc
BKquVUzSBXmr+8DxR4lUWzvI8xkR1NfbiAzS+mWV1YT+2LgYOLrJf5t+vtosVYc=
=IQSb
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
