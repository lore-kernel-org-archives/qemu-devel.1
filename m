Received: from eggs.gnu.org ([2001:4830:134:3::10]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egXku-0004f0-0N
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egXkp-0000du-Da
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:23:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egXkp-0000d5-7A
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:23:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2F8D931B6
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 15:23:21 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ee8a912-15dd-f283-c244-fb2e04c6523e@redhat.com>
Date: Tue, 30 Jan 2018 09:23:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-2-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zftJEBhUNAemjKUNzzexoh8d00D7icxfG"
Subject: Re: [Qemu-devel] [PATCH 01/18] Clean up includes
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
--zftJEBhUNAemjKUNzzexoh8d00D7icxfG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3ee8a912-15dd-f283-c244-fb2e04c6523e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] Clean up includes
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-2-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Clean up includes so that osdep.h is included first and headers
> which it implies are not included manually.
>=20
> This commit was created with scripts/clean-includes, with the change
> to target/s390x/gen-features.c manually reverted, and blank lines
> around deletions collapsed.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/parallels.h                                     |  1 -
>  hw/block/vhost-user-blk.c                             |  1 -
>  hw/ide/sii3112.c                                      |  1 +

Modulo the bogus change here,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--zftJEBhUNAemjKUNzzexoh8d00D7icxfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwjd0ACgkQp6FrSiUn
Q2oVhQf+M7Vn/tmmifp2srTczBEsOVvgIWZ6/O1dmQiJ3UeUwu6RGuUhPmeQTFAN
wV8k1CwoYmLCziietdvo+h9td2kCPl+X4LGpYylC7+ZY2VMFhyffL6GOpW6BymKJ
nzOAvLllIjy/nIWextGvFY+KigUE6jkfXs/NRelN3pgNaoJwtNFXnvP4Y7sP41oe
rl5e9x5CNJrE2mki1MGVmxkf1YRL4mwbtMgzDZglq6SDkCpRw6Y8sLRvgeveYvub
BoGHaNS5+uHC70XhSkonI93OE/EdHSsUTTvzcbTrMfHoW43R+G/PAN6jjV1P3LZe
qOIOzG9ErpzxIkRfnWOQ7vXnOWFAig==
=kpFs
-----END PGP SIGNATURE-----

--zftJEBhUNAemjKUNzzexoh8d00D7icxfG--
