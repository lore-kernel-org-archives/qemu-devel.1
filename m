Received: from eggs.gnu.org ([2001:4830:134:3::10]:36255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvQ57-00039T-6N
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvQ53-0008Ns-UL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvQ53-0008NA-Ls
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:09:13 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
	<d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
	<20170404145348.GD4536@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b58edec8-b383-5079-77f2-6f194701ce52@redhat.com>
Date: Tue, 4 Apr 2017 17:09:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170404145348.GD4536@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nox70NbbTa359k7XX0x9PNORxN1OdCRb2"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nox70NbbTa359k7XX0x9PNORxN1OdCRb2
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, svc-armband <armband@enea.com>,
 Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Message-ID: <b58edec8-b383-5079-77f2-6f194701ce52@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
 <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
 <20170403081542.GA5036@noname.str.redhat.com>
 <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
 <20170403130041.GD5036@noname.str.redhat.com>
 <20170403135012.GY26598@andariel.pipo.sk>
 <20170404121624.GA4536@noname.str.redhat.com>
 <d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
 <20170404145348.GD4536@noname.str.redhat.com>
In-Reply-To: <20170404145348.GD4536@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/04/2017 16:53, Kevin Wolf wrote:
>> The big question is how this fits into release management.  We have
>> another important regression from the op blocker work and only a week
>> to go before the last rc.  Are we going to delay 2.9 arbitrarily?  Are=

>> we going to shorten the 2.10 development period correspondingly?  (I
>> vote yes and yes, FWIW).
> Which is the other regression?

The assertion failure for snapshot_blkdev with iothreads.

Paolo


--nox70NbbTa359k7XX0x9PNORxN1OdCRb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY47cRAAoJEL/70l94x66D8Y4H/1+1c4P/3Cw6J+dBF6SHhtga
4UO+B6fZuA3S5X1F5kjtXIMGZIABp7lvwqDGQwD8PQud8C2B4P1NgQa1KlhTziqH
mVWr7Qn2SSez0hsX9XyGWKe+/GpQZXGUYHodq5SKx2RC9lFEAlEAuy+vZGLMRz2Y
A+TN8mm6sFzM8ElRsEk/ka3YK31kI6H9L7aQhAUIMV0ZRFB+n9/6BuAb318319OY
+ORWv8yVyAAAT8WubT9ej/SwJshI1piejiUydlpzi2klJy1nIGnvEOempZFTHCVn
OyX4scXFrR8Zrl9Y7a3lpImeNnP3ixOpfzAPl6FC8w2qCyjTEsMzTpiD//pG8+M=
=I8tE
-----END PGP SIGNATURE-----

--nox70NbbTa359k7XX0x9PNORxN1OdCRb2--
