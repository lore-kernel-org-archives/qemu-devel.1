Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkeI-0005ta-SR
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkeF-0008Vn-MJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:28:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdkeF-0008Vd-G5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:28:31 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4E384DAF7
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 21:28:31 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fe3098f-6e5a-b052-478b-710542253854@redhat.com>
Date: Tue, 14 Feb 2017 15:28:29 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O8Jd3C4SN8BQB0wfbAEnWO40lCOPJw2SO"
Subject: Re: [Qemu-devel] [PATCH 04/24] tests/test-cutils: Clean up
 qemu_strtoul() result checks
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
--O8Jd3C4SN8BQB0wfbAEnWO40lCOPJw2SO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8fe3098f-6e5a-b052-478b-710542253854@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/24] tests/test-cutils: Clean up
 qemu_strtoul() result checks
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Use unsigned comparisons to check the result of qemu_strtoul() and
> strtoull().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 60 ++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>=20

No real difference except when the test fails (better printed result if
the number being printed exceeds the max signed counterpart value), but
never hurts to be more precise.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--O8Jd3C4SN8BQB0wfbAEnWO40lCOPJw2SO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3Z9AAoJEKeha0olJ0NqQGYH/jqUZ9tPBwW27tCgBa9xMG8g
vBNKqBoXqe3GA0BN6+CzScD58dhzfFR3WnMPU9NtQKEdj9DYkHUKBR27vZ7V2qVj
11IZLwuAD/odB+H/D/eMHzpzazCQXw8r3b+cG2pwazrEqAztG1zrbetnxoUXmofz
vjIbBR1NkXFJ7Mh4dshsOMMsBnTResXUXC2DFb6Y+Vf6OYRiNiHXLY0n03hwrViI
fdDuVsS88I8JsG52PChKJTpvrKY1RqKZ3lcxx5K2Sjk7ka3WRcpUGpfPOUlqsdAg
0EPe4jXgHJ21ooBX5879qJCom1CclOlfKmLS1dY/CbUHUA8JApFiY4eEjMb7K4A=
=37dm
-----END PGP SIGNATURE-----

--O8Jd3C4SN8BQB0wfbAEnWO40lCOPJw2SO--
