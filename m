Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1ejQDd-0007UC-Al
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1ejQDc-0008J9-KD
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:57:01 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::6]:9456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1ejQDc-0008Hc-3i
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:57:00 -0500
Date: Wed, 7 Feb 2018 14:56:47 +0100
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180207135642.GA21399@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
Subject: [Qemu-devel] sed invocation for keycodemapdb not portable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

With commit 927128222b ("ui: add keycodemapdb repository as a GIT
submodule") sed is called with -E, which requires a recent sed.
The version of sed shipped with SLE11 is 4.1.5, which does not
understand the option '-E'. As a result xen-4.11 will fail to build.

Is there a way to achive the same result in some other way?

Olaf

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWnsFkQAKCRBdQqD6ppg2
fi0jAKDh5wXAgRkdVFQ6j6FRMW7q6YH0MwCgn/PRLwNCN//MLKoqX7r7qtUVnTU=
=35hE
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
