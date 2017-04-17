Received: from eggs.gnu.org ([2001:4830:134:3::10]:60896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0DEf-0001m0-FW
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0DEb-0002ix-GQ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:26:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0DEb-0002iY-7g
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:26:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D36BB6330D
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:26:51 +0000 (UTC)
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-10-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba199bb0-8946-e6c7-0f42-67d296c24afc@redhat.com>
Date: Mon, 17 Apr 2017 15:26:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170417200041.2451-10-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MdiEKUxg78TGu0BVSL6X3xNm9Cn1AoE92"
Subject: Re: [Qemu-devel] [PATCH 09/19] migration: Create block capabilities
 for shared and enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MdiEKUxg78TGu0BVSL6X3xNm9Cn1AoE92
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <ba199bb0-8946-e6c7-0f42-67d296c24afc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/19] migration: Create block capabilities
 for shared and enable
References: <20170417200041.2451-1-quintela@redhat.com>
 <20170417200041.2451-10-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-10-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 03:00 PM, Juan Quintela wrote:
> This two capabilites were added through the command line.  Notice that

s/This/These/
s/capabilites/capabilities/

> we just created them.  This is just the boilerplate.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  3 +++
>  migration/migration.c         | 36 +++++++++++++++++++++++++++++++++++=
+
>  qapi-schema.json              |  7 ++++++-
>  3 files changed, 45 insertions(+), 1 deletion(-)

I think this is a nice cleanup, even if it is exposing the internal
block migration (the 'migrate -b' stuff) that we really don't like (it
is one of the things causing grief at the 2.9-rc4 stage), because users
should be favoring NBD migration over internal block migration these days=
=2E

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MdiEKUxg78TGu0BVSL6X3xNm9Cn1AoE92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9SUKAAoJEKeha0olJ0Nqrz8H/RAf73+S74pxtIwGxQifCYqn
WF1o1g1mBqSESHzrTdIIVdtcB/OLq5La5JisaLX8hiMGNBWGDnzgu5DzZJkpfjst
40UlSmIup3ADYDpuwLWCXA04jajt0Q/Uuw9qKEgJvRtIR0QcFW+DME8aIUuCrAdD
BP0Wt/1byYsr8e7VNYJpzdhpbLjHn8uCGQDyVcfFZp8CHmjNsHRi0PgVGW/zegeN
9+0u1VdWmKy5tm8OwaUIvAepEr2bvTX+U30jJ/ZAkqcojm9+XyHJ0TiOvGFgQPk/
VmervQV9NrpWLpvAufVCYuKC6ZR1in0h25ZlpUH2Bm1t1dMk3WLltrzlM7gNBQM=
=QVt/
-----END PGP SIGNATURE-----

--MdiEKUxg78TGu0BVSL6X3xNm9Cn1AoE92--
