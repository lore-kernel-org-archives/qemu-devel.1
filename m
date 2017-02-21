Received: from eggs.gnu.org ([2001:4830:134:3::10]:42308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgDQ3-0008F8-2e
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgDQ1-0003pC-A8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:36:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgDQ1-0003p1-2T
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:36:01 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7BC4624D3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 16:36:00 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6b669f6-2da9-f007-890b-208660d4bf2c@redhat.com>
Date: Tue, 21 Feb 2017 10:35:58 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nlehl3GkkRp1RRTpOKs17AJd7PWGA5WUt"
Subject: Re: [Qemu-devel] [PATCH 08/14] tests: Don't check qobject_type()
 before qobject_to_qlist()
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
--nlehl3GkkRp1RRTpOKs17AJd7PWGA5WUt
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d6b669f6-2da9-f007-890b-208660d4bf2c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/14] tests: Don't check qobject_type()
 before qobject_to_qlist()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> qobject_to_qlist(obj) returns NULL when obj isn't a QList.  Check
> that instead of qobject_type(obj) =3D=3D QTYPE_QLIST.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-output-visitor.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nlehl3GkkRp1RRTpOKs17AJd7PWGA5WUt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGxuAAoJEKeha0olJ0NqOvYH/jV+qpIbR2oH8Zm7h34KFnKK
1z02LQQMq4i1M3qMpOLUG2ZgNp6fJ0pKufafZ1yTSqJFMiuwvkSkZ+E2wct9w7QT
JI4y27Uk4vraZN44grN5URgHaS5goAEOSt0RDnB2v7QQeEA4C7McV2Ytc0vDMLD6
amjDR/uCv/ac4sIS02AgaXJYZKaVKJi/wD+Z67uJyJWU16kThRVg/7WMO7Ep3UNG
LEEpfj0QntsoYMraJRmK+ObJN3lSsdRO0jrNc0W2jv4/PfjsJY0wQDNGuqoAdXYn
gQEjXaSEU3+NYwClsmWPoSReeTkRZ2qEf+y9S8TQQcyCWvJ7vvJoD1QWf4jwogE=
=4skm
-----END PGP SIGNATURE-----

--nlehl3GkkRp1RRTpOKs17AJd7PWGA5WUt--
