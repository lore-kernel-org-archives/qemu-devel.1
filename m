Received: from eggs.gnu.org ([2001:4830:134:3::10]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOk74-0000PP-Ns
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOk71-0007A9-J2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:29:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fOk71-00079b-CP
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:28:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC68D68817
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 13:28:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
Date: Fri, 1 Jun 2018 15:28:56 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3bqRGkCYAu6DhbWw8Au5foL3PKan97ORx"
Subject: [Qemu-devel] Preconfig state reachable without --preconfig given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bqRGkCYAu6DhbWw8Au5foL3PKan97ORx
From: Max Reitz <mreitz@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
Subject: Preconfig state reachable without --preconfig given
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The @preconfig RunState documentation states:

> The state is reachable only if the --preconfig CLI option is used.

However, this is not true:

$ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
QEMU 2.12.50 monitor - type 'help' for more information
(qemu)
HMP not available in preconfig state, use QMP instead

On IRC, Daniel proposed doing the runstate transition immediately after
the command line has been read and no --preconfig option has been found.
 Doing that indeed fixes the issue for me (but I don't know whether
that's the best solution).

Max


--3bqRGkCYAu6DhbWw8Au5foL3PKan97ORx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRShgACgkQ9AfbAGHV
z0DjKQgAw9Jxl/254UhcisX6BfP4QILBSusjnrzpLJuHr/aY9SeNex/cjqOP9uNi
vHFI6YVIsAoD+ZD2tBHYiORlp1wvRdvx+MN5fdnJxBgQ7n7LPE0GTpyPhHbkp2oG
T8B6tvVUaqSNMdlWVRbtZ5s2LOedmvBy/QrttYBpemhbChorj9WJDwYQy/WPauTZ
8eNVN0WDSk/b7PbIO6UZH/dOBPB+VdsqetDVXeW+QF9t7iG8VaOIgBRt4XKY4OVv
RIKl3W9NSaEk+8akk+Rj9ooXSIH5YiN4RtLcVRhuK3bK42ErfEBjWjifv0xZmKT1
4YDur/zin/uzNSvAzeFW1ucceq3GOw==
=kx35
-----END PGP SIGNATURE-----

--3bqRGkCYAu6DhbWw8Au5foL3PKan97ORx--
