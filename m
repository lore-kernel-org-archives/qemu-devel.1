Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0K8-000359-Cj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0K5-0004a2-CT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:56:32 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0K5-0004Zg-5J
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:56:29 -0400
Received: by mail-wr0-x243.google.com with SMTP id c24so16376588wra.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:56:28 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:56:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725135625.GH23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-2-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-2-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] qtest: Avoid passing raw strings
 through hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:18PM +0200, Markus Armbruster wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> The next patch will add __attribute__((__format__)) to hmp(), which
> in turn causes gcc to warn about non-literal format strings.  Rather
> than risk an arbitrary string containing % being mis-handled, always
> pass variable strings along with a %s format.  It also makes it
> easier to prove correctness locally, rather than auditing all the
> source strings.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20170720214008.28494-4-eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-hmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd04JAAoJEJykq7OBq3PIrb8H/A0av6Ovbt36cdubL5l2+oKL
2SUVaLUejZ1C6H/Vd46upTZBveafcF0td14Iic3sivPBsy9mrgNIszcEjNhz8/0X
C5VEpGYD32TRKkxbyDVM9V3iuMmpcW/dj8KjbSE8mNwO8lrAGf6YkL8yb2yfHG8T
SdqZZmU0KSM0KooOEMg2EgS88JraRXs4XedLi9tbOxJ0bzmjGrEjkkQMkOaG+WVt
Chu+tVO6luw9n6UIu4gs+RuJO8gJk4fgPISP+T4czoKMY0DbUO8514J2jDrSQYlP
JqilpDDYULCgiomFoa/IioZwV0GInL98xiD4bVcGuVq95UKlT/WqlQ18D163K4s=
=sEYS
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
