Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIzCO-00006l-A6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIzCJ-0002nH-Kp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIzCJ-0002n6-CA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:18:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F8A023E6E5
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:18:06 +0000 (UTC)
References: <20170608133906.12737-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <284d815f-2a77-fed4-6e34-a6d7a178aec0@redhat.com>
Date: Thu, 8 Jun 2017 10:18:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ONOvpdkXKSvOubHQqtCLuWH3dR1pCMgHN"
Subject: Re: [Qemu-devel] [PATCH 0/5] Error handling cleanup and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ONOvpdkXKSvOubHQqtCLuWH3dR1pCMgHN
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <284d815f-2a77-fed4-6e34-a6d7a178aec0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Error handling cleanup and fixes
References: <20170608133906.12737-1-ehabkost@redhat.com>
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 08:39 AM, Eduardo Habkost wrote:
> This series fixes and simplifies some of the existing code that
> assigns to *errp directly.
>=20
> Eduardo Habkost (5):
>   xilinx: Fix error handling
>   block: Don't try to set *errp directly
>   websock: Don't try to set *errp directly
>   migration: Don't try to set *errp directly
>   vnc: No need for Error** parameter at vnc_client_io_error()

For 1-4:
Reviewed-by: Eric Blake <eblake@redhat.com>

I'm not sure about 5

>=20
>  ui/vnc.h                |  2 +-
>  block.c                 |  8 +++-----
>  hw/dma/xilinx_axidma.c  |  4 +---
>  hw/net/xilinx_axienet.c |  4 +---
>  io/channel-websock.c    |  4 ++--
>  migration/migration.c   |  2 +-
>  ui/vnc.c                | 13 +++++--------
>  7 files changed, 14 insertions(+), 23 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ONOvpdkXKSvOubHQqtCLuWH3dR1pCMgHN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOWqtAAoJEKeha0olJ0NqxHQH/2QyQXwUNUhFZ2dt2qj4/9B3
kRolW3DcUcOpjPxHA4AbiUtrUCWLnxeDu3LCRRRzIHAo4G75FR/4INOYgT8vQH1i
Y/ST+qZellK2KhLvXAoTCOsmfMVnMqLpZ0/CksPZqJPGU1w4UBUnf+Vg3TBURRfp
fMQC2T2uCxcyaHy1qNImdYx1v8REto3CJ8msHhk5oCTpJ8tYxQ2i2gqHkys5iCKw
trt8oFrn9uP5YlhUr97xk0e6FTunSFaMI+AySaO5Ha1EfWSFGQGw1rDx5jUYI9a0
qGB2SPtBsbSCHU80e3wiKwjVjcvJTyHif+rDAMpsVDfe9b/QZi3+ByQ8OIyTx5Y=
=ys7D
-----END PGP SIGNATURE-----

--ONOvpdkXKSvOubHQqtCLuWH3dR1pCMgHN--
