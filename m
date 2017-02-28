Received: from eggs.gnu.org ([2001:4830:134:3::10]:44787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciquY-0006SU-NK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciquV-0001WB-JK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:10:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciquV-0001V4-Db
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:10:23 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A728E15561
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 23:10:23 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-18-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76e45a3e-bd60-bfb8-109c-4bba5033bec1@redhat.com>
Date: Tue, 28 Feb 2017 17:10:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-18-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qtxhud3X32cP6IqKAC1RSv61PvrMJfMHs"
Subject: Re: [Qemu-devel] [PATCH v2 17/30] tests: fix tco-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qtxhud3X32cP6IqKAC1RSv61PvrMJfMHs
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <76e45a3e-bd60-bfb8-109c-4bba5033bec1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/30] tests: fix tco-test leaks
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <20170221141451.28305-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/tco-test.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Qtxhud3X32cP6IqKAC1RSv61PvrMJfMHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgNdAAoJEKeha0olJ0NqoQEH/jVE9ndu4Rql2E1Fb14HGz9e
QWj2T11DME8CEXEmxfpaOxwo1oEnnU0eKeP92AWx2M0tmaT/iq5eK/O4RYjPOJ+N
I7FoY83GbcCBPCNDlt8Izct3qysi2J5OSwWRhWFWQ7ZJObEGKZfsyEeBs49lsDdh
n1veJemyakezxX9lkK9Z4y1DkFEfkac67UgIMmaLY5lOtisq40zoOVVnmqGZo1ni
Rx1sr4nyz/ctJdNaKBTSsr+ETAW1+YlTAAhIIvwCn1C3V8ojnlvZnH3MWvSlvFTA
ViI1CO6r4S5Q5m9ZtFTVpc29vPFpfbYMqlK6Nz8S2hyR51R+ExujQP6JezreMRc=
=Tn7l
-----END PGP SIGNATURE-----

--Qtxhud3X32cP6IqKAC1RSv61PvrMJfMHs--
