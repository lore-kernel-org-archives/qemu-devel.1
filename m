Received: from eggs.gnu.org ([2001:4830:134:3::10]:37011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cggR2-00052e-Re
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cggQy-0007tJ-1X
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:35:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cggQx-0007sB-Pk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:34:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2EE761D03
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 23:34:55 +0000 (UTC)
References: <20170222180423.26571-1-pbonzini@redhat.com>
	<20170222180423.26571-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc6385db-f8b1-41ca-c798-0564941b5618@redhat.com>
Date: Wed, 22 Feb 2017 17:34:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170222180423.26571-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Uqq5HQ0PrCnC82ABN70nSuvm84LFwv0mI"
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uqq5HQ0PrCnC82ABN70nSuvm84LFwv0mI
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <bc6385db-f8b1-41ca-c798-0564941b5618@redhat.com>
Subject: Re: [PATCH 1/3] qom-qobject: introduce object_property_{g,s}et_ptr
References: <20170222180423.26571-1-pbonzini@redhat.com>
 <20170222180423.26571-2-pbonzini@redhat.com>
In-Reply-To: <20170222180423.26571-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 12:04 PM, Paolo Bonzini wrote:
> The functions simplify the handling of QOM properties whose type
> is a QAPI struct.  They go through a QObject just like the other
> functions that access a QOM property through its C type.
>=20
> Like QAPI_CLONE, the functions are wrapped by macros that take a
> QAPI type name and use it to build the name of a visitor function.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qom/qom-qobject.h               |  68 +++++++++++-
>  qom/qom-qobject.c                       |  52 ++++++++++
>  tests/Makefile.include                  |   2 +-
>  tests/check-qom-proplist.c              | 177 ++++++++++++++++++++++++=
+++++++-
>  tests/qapi-schema/qapi-schema-test.json |   8 ++
>  tests/qapi-schema/qapi-schema-test.out  |   6 ++
>  6 files changed, 309 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Uqq5HQ0PrCnC82ABN70nSuvm84LFwv0mI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYriAdAAoJEKeha0olJ0Nq8aoIAJaebo830LeQSbXmcoQf4xJ0
NxW8sRFGNUvhj7CWCcyj/maZxfV1jCqJt8xFlCu9EAbmxpnVWohnZiXugEqh5D9b
9OkNJr6iYWVJeLcoJ+H/C85C1xR7X+C8begIMNSjt1RUL4b+7zElfyR+8dMR/wTL
+T3yvgWdEzw0T0LIza0u5JUNQSK2FrVXmVdWIBam03WioCxQiki4inqjfa/I/gvg
viA9oqBAYJ5Jqu6lY1P4Qc9/ERVIFbazB7+aJ73t0e+Gam8aR5NqFbMolMg6hwOC
gpHU7mYaDCmCKl0Jn3HjHilrgKjjcrxYVJ/s8g39fDf/c78BtaebGfkOTO5xbVk=
=GrdE
-----END PGP SIGNATURE-----

--Uqq5HQ0PrCnC82ABN70nSuvm84LFwv0mI--
