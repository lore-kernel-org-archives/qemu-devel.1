Received: from eggs.gnu.org ([2001:4830:134:3::10]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnlrH-0000bH-DF
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnlrG-0000c5-H2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:24:11 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::11]:14612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fnlrF-0000bP-Ul
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:24:10 -0400
Date: Thu, 9 Aug 2018 16:24:03 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180809162403.32c53c50.olaf@aepfle.de>
In-Reply-To: <20180809141403.11296-1-olaf@aepfle.de>
References: <20180809141403.11296-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/mFNAkw6OHM2zWek72+HPnA7";
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
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

--Sig_/mFNAkw6OHM2zWek72+HPnA7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu,  9 Aug 2018 16:14:03 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> The codepaths behind qemu_ram_ptr_length can return NULL.

While that might be a bug by itself, the question is why in that case no me=
mset(buf, 0xff, l) is done?

Olaf

--Sig_/mFNAkw6OHM2zWek72+HPnA7
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW2xOgwAKCRBdQqD6ppg2
fodbAJ9Q1v0wYcnVndtqCTDKxcPzzlQxngCg4pv7zjIbVbGPnsJ7TM/+9UL2ujE=
=BxxK
-----END PGP SIGNATURE-----

--Sig_/mFNAkw6OHM2zWek72+HPnA7--
