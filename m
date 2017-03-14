Received: from eggs.gnu.org ([2001:4830:134:3::10]:55696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnq3P-0004c2-TZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnq3L-00028Y-HA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:16:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnq3K-00027x-Q7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:16:07 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-16-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da1f22b3-3a21-3ee7-25bf-3c9216cd2317@redhat.com>
Date: Tue, 14 Mar 2017 12:16:04 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-16-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qfAc5dWwneNnBslIopOb7wpp4IwP97kdC"
Subject: Re: [Qemu-devel] [PATCH for-2.9 15/47] qapi: Conjure up
 QAPIDoc.ArgSection for undocumented members
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
--qfAc5dWwneNnBslIopOb7wpp4IwP97kdC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <da1f22b3-3a21-3ee7-25bf-3c9216cd2317@redhat.com>
Subject: Re: [PATCH for-2.9 15/47] qapi: Conjure up QAPIDoc.ArgSection for
 undocumented members
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-16-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> qapi2texi.py already conjures up ArgSections for undocumented
> enumeration values, in texi_enum).  Drop that, and conjure them up for

Missing '('?

> all kinds of "arguments" (enumeration values, object and alternate
> type members) in qapi.py instead.
>=20
> Take care to keep generated documentation exactly the same for now.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py      |  5 ++---
>  scripts/qapi2texi.py | 31 ++++++++++++++++---------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qfAc5dWwneNnBslIopOb7wpp4IwP97kdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCVUAAoJEKeha0olJ0NqVKAIAKo/UQxYToJb4hAIrTkp0maS
Dvjl17HPtL7XVfw7+KKbepAt+yk95gY++6byzatCEP0y9cYYkKdFs07pzVYCEXDI
/nIPcBoAHEVFCpz+6ehNEevi17/8UgD+JKJbpFCQINqD62tyQ5wwZlRx2eCpcE/H
+1XLEqiY/IChkuBwFZZIHE+UlNF0WYBtIVNlKM/p1gLAVzTc3WvHUrwSxGlY0kdH
9jgtQPOg+gX0piXsqcH0AU6fw0UdDkxDpXnkKdfeQEkJU+0tCVx3cGkLjmjc3OsZ
sr5/NeT8868xzqu8fxa80CxwI0abV/5Q0IZ1wkmd2IIckRSF/jJGg54tym4ND+c=
=9aFn
-----END PGP SIGNATURE-----

--qfAc5dWwneNnBslIopOb7wpp4IwP97kdC--
