Received: from eggs.gnu.org ([2001:4830:134:3::10]:47811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGGe-00070P-6V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGGb-0006Vd-2t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:38:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgGGa-0006Ul-St
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:38:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B966A3DE3F
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:38:28 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-12-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0806ec5e-ac80-2caa-5a61-73d211bba6b0@redhat.com>
Date: Tue, 21 Feb 2017 13:38:26 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-12-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WtxfIBW4cK57cvBNcjxjFjvTRSrcEfLtb"
Subject: Re: [Qemu-devel] [PATCH 11/14] tests: Don't check qobject_type()
 before qobject_to_qfloat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WtxfIBW4cK57cvBNcjxjFjvTRSrcEfLtb
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0806ec5e-ac80-2caa-5a61-73d211bba6b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/14] tests: Don't check qobject_type()
 before qobject_to_qfloat()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-12-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> qobject_to_qfloat(obj) returns NULL when obj isn't a QFloat.  Check
> that instead of qobject_type(obj) =3D=3D QTYPE_QFLOAT.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qjson.c                 | 12 ++----------
>  tests/test-qobject-output-visitor.c |  8 ++++----
>  2 files changed, 6 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WtxfIBW4cK57cvBNcjxjFjvTRSrcEfLtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrJcyAAoJEKeha0olJ0NqlJIH/jfRgU190smK9AdxgsamcvIc
Mt9+0mXtqn93Mqum2Mcy2LCbSlnpNr0fONXgdvjBLvUCJtDO9YYa6pXrqjIenTSB
yIIjkhFJZSJzqHB1KriCmFM7zVPaaOkYz1BnY1h2jKAgDRI8iGMXREAStgnqBl+v
Wu9q0jtDja5F1J+VlCywAiuxpUQFVAdTED2c0tSZ4n1VPJBq84EWJxThMRL3s0bQ
CeYwBVOyG+1z2ls5AZAgkS3TNwxqgbb0LeNjs5PaSNTsw45qeB0WcrcahKWfQg6F
6NRvEJfBp8XaItuWmqC1AikkJ5Qi0C8DvtA+lLflco2+HYf2CEttMuXo1dK+psc=
=0hgc
-----END PGP SIGNATURE-----

--WtxfIBW4cK57cvBNcjxjFjvTRSrcEfLtb--
