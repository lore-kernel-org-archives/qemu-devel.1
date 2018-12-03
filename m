Received: from eggs.gnu.org ([2001:4830:134:3::10]:43054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTr6x-00074q-5o
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTr6t-0003ue-Fk
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:30:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gTr6t-0003tn-2H
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:30:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5B1630014D2
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 16:30:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
Date: Mon, 3 Dec 2018 17:30:10 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DaoEdYI6QuwJ5c7lUzXWOULkJyCztyC0m"
Subject: [Qemu-devel] QMP accepts double dict keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DaoEdYI6QuwJ5c7lUzXWOULkJyCztyC0m
From: Max Reitz <mreitz@redhat.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
Subject: QMP accepts double dict keys
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

QMP accepts double keys in dicts without complaining.  The value it is
using is apparently the last one specified:

$ qemu-system-x86_64 -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
"package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
{'execute':'qmp_capabilities'}
{"return": {}}
{'execute':'blockdev-add','arguments':{'driver':'null-co',
 'node-name':'foo','node-name':'bar'}}
{"return": {}}
{'execute':'query-named-block-nodes'}
{"return": [{ [...] "node-name": "bar" [...] }]}

Another test case is iotest 229 which specifies both mode=3Dabsolute-path=
s
and mode=3Dexisting (it wants the latter).

Max


--DaoEdYI6QuwJ5c7lUzXWOULkJyCztyC0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwFWhIACgkQ9AfbAGHV
z0CcHggAjztDiYYf3d6m+bg9VUAYMDQWgZvXCgGEXuITRw1/9nmOSc6d2EAqeNUr
pH3vv/YIjLGKcp3BGb9knyOGcL03zvu5cRygNHgwcH+O2acd1mNYld0AsZvG6tc9
aCdbn3CXu1ft8bMWy9ls+dayULzwUlZEbjYWO+palh4IV2RXXZUftm0jnKDoIG/0
fj6OSvqVwuA1+K8ENZLIlmDx0YwJCZVQDee3dDsCL5pMJ+sYzEOCZ2Hg2YL8FQjR
yfQe/pw7AkDroiG0DKIOFwMikSzKZHX1jbdX09zZqQlhpwSLR28LjLTxpkw0RXhU
siWhIViuhje2Ob0aQ+s+WfPMx/nocw==
=E/Tu
-----END PGP SIGNATURE-----

--DaoEdYI6QuwJ5c7lUzXWOULkJyCztyC0m--
