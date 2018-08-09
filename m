Received: from eggs.gnu.org ([2001:4830:134:3::10]:49673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnmLx-0004Ij-O9
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnmLw-0005Ik-MN
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:55:53 -0400
Received: from mo6-p02-ob.smtp.rzone.de ([2a01:238:20a:202:5302::6]:27816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fnmLw-0005Fe-4I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:55:52 -0400
Date: Thu, 9 Aug 2018 16:55:49 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180809165549.5c92d5f4.olaf@aepfle.de>
In-Reply-To: <a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/hXq.7BFscxqIRTCDU/M0tEP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

--Sig_/hXq.7BFscxqIRTCDU/M0tEP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 9 Aug 2018 16:52:22 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> I think the simplest fix is for the map
> cache to set aside a zero page and return it whenever it is asked for a
> ballooned page.

Can qemu actually know if it ran into a ballooned page? I think no.

Olaf

--Sig_/hXq.7BFscxqIRTCDU/M0tEP
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW2xV9QAKCRBdQqD6ppg2
ficyAKDBuqfvDK0HRFNGMSS5UHV/Ae5/dwCg7M0fBj2N7tLj1winckV2O2teb1E=
=9wtV
-----END PGP SIGNATURE-----

--Sig_/hXq.7BFscxqIRTCDU/M0tEP--
