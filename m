Received: from eggs.gnu.org ([2001:4830:134:3::10]:49737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cf7LL-00066P-I3
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 10:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cf7LG-00075G-OS
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 10:54:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cf7LG-00074t-Ig
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 10:54:34 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA85581222
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 15:54:33 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b8d038b-bf53-ff2c-f776-feda8560fac6@redhat.com>
Date: Sat, 18 Feb 2017 09:54:31 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4OT6G9dBLVE5CpapgnfvSpw8wrLb3bqBF"
Subject: Re: [Qemu-devel] [PATCH 04/14] check-qjson: Simplify around
 compare_litqobj_to_qobj()
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
--4OT6G9dBLVE5CpapgnfvSpw8wrLb3bqBF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3b8d038b-bf53-ff2c-f776-feda8560fac6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] check-qjson: Simplify around
 compare_litqobj_to_qobj()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Make compare_litqobj_to_qobj() cope with null, and drop non-null
> assertions from callers.
>=20
> compare_litqobj_to_qobj() already checks the QType matches; drop the
> redundant assertions from callers.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qjson.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)

Wow - impressive diffstat.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4OT6G9dBLVE5CpapgnfvSpw8wrLb3bqBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYqG43AAoJEKeha0olJ0Nq3RkIAKQEmTkK9PO+M4LC6rblU/gH
3Bbdk8UmfY+s8cdhUZK/3tzYjv7dcK6O9kfvF+eatsCfss4wNsMPjVhkPp6y7m7O
tt/lCIkVZDaEFzub1vzqeTruau2x3p0idkSbUMDV4EVNYAIrkuhSuGD4M4skNMhJ
ROKskkLN/QiCRYYCcSRyBBE2rWIaEct5RylhtH6beKA1RIbXP1P4q1IiorOanQiK
DnvYQa3kpqIM0eHGLrSw1MZd7y9oUbHEnW7C2DiSsdawEB0/vHo/fQS+5TMlWd0n
AIMfIwLIseJHsxlcblALflc0yYIiJ5SSaV43mFuj7yVy3nHHJ4/4yDeYrkYE7rE=
=qmtb
-----END PGP SIGNATURE-----

--4OT6G9dBLVE5CpapgnfvSpw8wrLb3bqBF--
