Received: from eggs.gnu.org ([2001:4830:134:3::10]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fo4ic-0007Qw-Ii
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fo4ib-0004zE-Pd
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:32:30 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::3]:25312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fo4ib-0004xb-8E
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:32:29 -0400
Date: Fri, 10 Aug 2018 12:32:21 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180810123221.785ae741.olaf@aepfle.de>
In-Reply-To: <840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
	<20180809165549.5c92d5f4.olaf@aepfle.de>
	<dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
	<840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/apsAM8LnJ/2DCrRmJ9qezef";
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
Cc: Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

--Sig_/apsAM8LnJ/2DCrRmJ9qezef
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 10 Aug 2018 12:25:09 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> There are many more callers of qemu_ram_ptr_length, and none of them chec=
k the result.

So you mean that function must not return NULL?
Or should the caller check for the result?

Olaf

--Sig_/apsAM8LnJ/2DCrRmJ9qezef
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW21ptQAKCRBdQqD6ppg2
fnfdAKDHuCHqGn+Y4J22VAb3YUQUWa/TuACg5104fTHv8f9ok8+u20D18qxlgFg=
=yDHu
-----END PGP SIGNATURE-----

--Sig_/apsAM8LnJ/2DCrRmJ9qezef--
