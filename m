Received: from eggs.gnu.org ([2001:4830:134:3::10]:38226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdlyX-0007r4-FU
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdlyU-0008OE-Fz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdlyU-0008Nj-9o
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:53:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B7E73D94F
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:53:30 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-12-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2866efe-40be-8338-8e02-4e1f7faf5264@redhat.com>
Date: Tue, 14 Feb 2017 16:53:27 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-12-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CHWmQX7OteteahGVVn2muFx5HcpWV6Cvn"
Subject: Re: [Qemu-devel] [PATCH 11/24] tests/test-cutils: Cover
 qemu_strtosz() invalid input
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
--CHWmQX7OteteahGVVn2muFx5HcpWV6Cvn
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a2866efe-40be-8338-8e02-4e1f7faf5264@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/24] tests/test-cutils: Cover
 qemu_strtosz() invalid input
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-12-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20

Perhaps you could also add a test of "-".  Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CHWmQX7OteteahGVVn2muFx5HcpWV6Cvn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo4pnAAoJEKeha0olJ0NqocMH/j0pUp5lhqdGxXyXh/RS3V79
4dvxpMeQbCbnMX23hvjp4YHSt66tGjoIdDiVh2vnwxJLSoW81Dtgh2yo1RdvjNH0
EcnAVvEZq2rmhJJbSC7PRTvfnqYy7JTd+y3cZd86962xG0yfD1ZQGz3lNmCyjJJA
stR5Pc06n5DLEM+Dz8tWF2prZi6fRM8ib6pavc6K/ND+3O8CR/WDq49moJEtpn8v
IAehId7I1Zkderv/i+HbrneaSBYutN9N/YoHTqlEaB1c3SrB0Kqj0WG279yOx9dD
ExRpP6ZAGYJYVaGDW/5iZZV9A4JCStPoD1WQsG82LcG4XOF7PYcfu0XO/E19fhg=
=t0lY
-----END PGP SIGNATURE-----

--CHWmQX7OteteahGVVn2muFx5HcpWV6Cvn--
