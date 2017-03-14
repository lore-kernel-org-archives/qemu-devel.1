Received: from eggs.gnu.org ([2001:4830:134:3::10]:39876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntMS-0003Ga-0N
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntMN-0008Ug-4v
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntMM-0008UF-SI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:47:59 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-36-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0b8a3ac-dae5-799f-1a9f-74ced7877e35@redhat.com>
Date: Tue, 14 Mar 2017 15:47:56 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-36-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m9wo4qP8Erf7E6oRFJo24Sqiux4VU6ehk"
Subject: Re: [Qemu-devel] [PATCH for-2.9 35/47] tests/qapi-schema: Rename
 doc-bad-args to doc-bad-command-arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m9wo4qP8Erf7E6oRFJo24Sqiux4VU6ehk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <f0b8a3ac-dae5-799f-1a9f-74ced7877e35@redhat.com>
Subject: Re: [PATCH for-2.9 35/47] tests/qapi-schema: Rename doc-bad-args to
 doc-bad-command-arg
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-36-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-36-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/Makefile.include                                            | 2 =
+-
>  tests/qapi-schema/doc-bad-args.err                                | 1 =
-
>  tests/qapi-schema/doc-bad-command-arg.err                         | 1 =
+
>  tests/qapi-schema/{doc-bad-args.exit =3D> doc-bad-command-arg.exit} | =
0
>  tests/qapi-schema/{doc-bad-args.json =3D> doc-bad-command-arg.json} | =
0
>  tests/qapi-schema/{doc-bad-args.out =3D> doc-bad-command-arg.out}   | =
0
>  6 files changed, 2 insertions(+), 2 deletions(-)
>  delete mode 100644 tests/qapi-schema/doc-bad-args.err
>  create mode 100644 tests/qapi-schema/doc-bad-command-arg.err
>  rename tests/qapi-schema/{doc-bad-args.exit =3D> doc-bad-command-arg.e=
xit} (100%)
>  rename tests/qapi-schema/{doc-bad-args.json =3D> doc-bad-command-arg.j=
son} (100%)
>  rename tests/qapi-schema/{doc-bad-args.out =3D> doc-bad-command-arg.ou=
t} (100%)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--m9wo4qP8Erf7E6oRFJo24Sqiux4VU6ehk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFb8AAoJEKeha0olJ0Nqm1UIAKVW5b96/dybMmbgY0auNjBQ
PcAjaXW3V4wKLh0r0NSUXmxnWyaQdXeaQRbgbsyfU46Nxyk4lG0cNmhd+skLV4Vh
JS81bd+9OkdBoVTFb1yUBKmjlReioix2avVyi3NqorbfN37ZxBizSnMI8epNIYe2
AQmCtdINyPbDsNptX9rKRXa6vedtRB4rEp8ajG/xj71JaG1gRK+uSCKEmatWJ1QG
eIPg9/oNK01UceC4Zup3WTLyg8nddE081mQodwNpTWDhVPbqjQ5YyZlimikmUMHE
MznTIyo6Ddi14Gz+Pci++VzkUAdMnvXuU3aFjIb00SM0SAaXSPaCXbq0rbZI+G8=
=Vu0F
-----END PGP SIGNATURE-----

--m9wo4qP8Erf7E6oRFJo24Sqiux4VU6ehk--
