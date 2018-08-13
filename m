Received: from eggs.gnu.org ([2001:4830:134:3::10]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fpJ9e-0000Ic-Qi
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 16:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fpJ9d-0002nu-SH
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 16:09:30 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::4]:13987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fpJ9d-0002n8-AP
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 16:09:29 -0400
Date: Mon, 13 Aug 2018 22:07:13 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180813215054.7aaf368b.olaf@aepfle.de>
In-Reply-To: <a08c692b-5e62-9469-db63-b4b439e9afc3@redhat.com>
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
	<20180809165549.5c92d5f4.olaf@aepfle.de>
	<dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
	<840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
	<20180810123221.785ae741.olaf@aepfle.de>
	<a08c692b-5e62-9469-db63-b4b439e9afc3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/X=3HCSFX0U=hZ4wzjxX4XyK";
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

--Sig_/X=3HCSFX0U=hZ4wzjxX4XyK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 10 Aug 2018 14:29:28 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> On 10/08/2018 12:32, Olaf Hering wrote:
> > Am Fri, 10 Aug 2018 12:25:09 +0200
> > schrieb Paolo Bonzini <pbonzini@redhat.com>:
> > So you mean that function must not return NULL?
> > Or should the caller check for the result? =20
> Either, but the former would of course be much simpler if possible.

Since other callers already deal with NULL, that one has to cope as well.
And since unavailable memory can not be zero, the memset 0xff is most likel=
y correct as well.

So, for me the patch is good as it is. The write part will get a separate c=
hange in a few days.


Olaf

--Sig_/X=3HCSFX0U=hZ4wzjxX4XyK
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW3Hk8QAKCRBdQqD6ppg2
fphEAKD42E0PeYxE0DTt8Zq/p6+TEtogRACgrv6TNomtDPjm1220I/ppPICiytQ=
=CR/z
-----END PGP SIGNATURE-----

--Sig_/X=3HCSFX0U=hZ4wzjxX4XyK--
