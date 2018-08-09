Received: from eggs.gnu.org ([2001:4830:134:3::10]:45623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnm52-00083g-Mv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnm52-0000eZ-1o
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:38:24 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::10]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fnm51-0000co-Fw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:38:23 -0400
Date: Thu, 9 Aug 2018 16:38:16 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180809163816.092a7c8c.olaf@aepfle.de>
In-Reply-To: <30203041-c944-1a12-d983-9735756dc334@redhat.com>
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Y4sW.wG1A5YNPiuQYHrZ4by";
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

--Sig_/Y4sW.wG1A5YNPiuQYHrZ4by
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 9 Aug 2018 16:37:05 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> If no RAM is allocated (i.e. xen_map_cache will return NULL), however,
> the memory should not be registered as RAM with the memory API.  So I
> think the bug is in Xen code.

Someone familiar with that code has to figure that out. A ballooned page wi=
ll trigger that bug.

Olaf

--Sig_/Y4sW.wG1A5YNPiuQYHrZ4by
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW2xR2AAKCRBdQqD6ppg2
fqxlAJ0boZpIhoMwfwk8oDq28rW3eoBNJQCg6koYaRc8LeFsRATDwmQQthtiHWs=
=S6nh
-----END PGP SIGNATURE-----

--Sig_/Y4sW.wG1A5YNPiuQYHrZ4by--
