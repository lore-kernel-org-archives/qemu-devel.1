Received: from eggs.gnu.org ([2001:4830:134:3::10]:47660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQgM0-0006fF-9b
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQgLw-0000VB-1U
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:47:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQgLv-0000Uz-PO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:47:51 -0400
References: <cover.1498761179.git.alistair.francis@xilinx.com>
	<0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4847d815-ea6c-3d36-eecf-586dc4067913@redhat.com>
Date: Thu, 29 Jun 2017 15:47:48 -0500
MIME-Version: 1.0
In-Reply-To: <0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oA3I8XOEvooQNhe2ETS14LUdtQrvcUJGL"
Subject: Re: [Qemu-devel] [RFC v2 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oA3I8XOEvooQNhe2ETS14LUdtQrvcUJGL
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net
Message-ID: <4847d815-ea6c-3d36-eecf-586dc4067913@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 2/3] qemu-error: Implement a more generic
 error reporting
References: <cover.1498761179.git.alistair.francis@xilinx.com>
 <0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
In-Reply-To: <0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 02:42 PM, Alistair Francis wrote:
> This patch removes the exisinting error_vreport() function and replaces=
 it

s/exisinting/existing/

> with a more generic vreport() function that takes an enum describing th=
e
> information to be reported.
>=20
> As part of this change a report() function is added as well with the
> same capability.
>=20
> To maintain full compatibility the original error_report() function is
> maintained and no changes to the way errors are printed have been made.=

>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>=20

> -void error_vreport(const char *fmt, va_list ap)
> +void vreport(report_types type, const char *fmt, va_list ap)
>  {
>      GTimeVal tv;
>      gchar *timestr;
> =20
> +    switch (type) {
> +    case ERROR:
> +        /* To maintin compatibility we don't add anything here */

s/maintin/maintain/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oA3I8XOEvooQNhe2ETS14LUdtQrvcUJGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVWd0AAoJEKeha0olJ0NqIJcH/i6oGXmAyyuCkRh58sN4yeQg
5QLoWlQEAhbSREikNpy6B7s5InACWgT+hcCooO5+lCe1B288hw5XvXhpH2tslNdC
RQ/8p5OJENjYZDtrh++aCMMCdc9HupBEa60wr5u1Yl7hg+x0Ss6DsFPDtDy+mH2j
GcwhAFXVaSQ1CVyq+CV6qTHweZ5GnApvTda3hrgTRpDdltsRTVxToxonSfvCABJx
lbLh2iofoRADZLB9/39OlEXST/EOxRJN1XW9COkIKhLvfNIFWneyFokY7Zf377ec
IwcoEuvChOn7kI4V3TaGzwT2J2Zgthy3Wsisc3ukN+xPDuXbzdt4i9Wsb0szrO4=
=ZaYh
-----END PGP SIGNATURE-----

--oA3I8XOEvooQNhe2ETS14LUdtQrvcUJGL--
