Received: from eggs.gnu.org ([2001:4830:134:3::10]:57804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuExN-0005B0-MB
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuExM-0005qh-SM
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:41:13 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-8-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b5e9012-e1b3-0198-7372-9172bc1d414c@redhat.com>
Date: Mon, 27 Aug 2018 12:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5SvYq0GmUcYQ7vBGBy2Sn3gHMwxxqVizt"
Subject: Re: [Qemu-devel] [PATCH v2 7/9] block/backup: make function
 variables consistently named
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5SvYq0GmUcYQ7vBGBy2Sn3gHMwxxqVizt
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <9b5e9012-e1b3-0198-7372-9172bc1d414c@redhat.com>
Subject: Re: [PATCH v2 7/9] block/backup: make function variables consistently
 named
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-8-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Rename opaque_job to job to be consistent with other job implementation=
s.
> Rename 'job', the BackupBlockJob object, to 's' to also be consistent.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c | 62 +++++++++++++++++++++++++++++---------------------=
--------
>  1 file changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5SvYq0GmUcYQ7vBGBy2Sn3gHMwxxqVizt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD1T0ACgkQ9AfbAGHV
z0DSAwgAkE2O+3DXg27s4Tc0Qu3vX6JK+keL6nHiMo0Wz42S7UtkzsPk2OvSX5dH
E+6mgpZVkbmMUFAD8HYP0efh++CGVpXITD/AFCWOKpY+6Y8S3wivJ/p4+xpDNC2q
Xb1jpXgrnG0qWqBjegCFoscUcew89/zNcIxwDUxhQzdMfEFJc2lTGjHLQ4y1v/FB
58wIHarAXlWQDgjBKHTzi2EP7mZXogwvUg5c5OUTFqaZMfG5WTgt8il4bDax2pni
N1eerGRDjV9C+gMI2FyfLuUe0PwmUlgZlxYNow0CWVGZqpckhykXI9BpL7YNMGWg
EM2kUsU//2az580915dMW1RCTRdM7A==
=3gcD
-----END PGP SIGNATURE-----

--5SvYq0GmUcYQ7vBGBy2Sn3gHMwxxqVizt--
