Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmji-0003hb-G8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmjf-0003w4-ED
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:35:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGmjf-0003v3-4b
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:35:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09CB77AE95
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 13:35:26 +0000 (UTC)
References: <20170601214056.30387-1-quintela@redhat.com>
	<20170601214056.30387-4-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ff0d7ce-425a-3284-43e4-1ac332bccdb2@redhat.com>
Date: Fri, 2 Jun 2017 08:35:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170601214056.30387-4-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dOMESGreaVO8I4N6O8g9t5G985a2UnS5I"
Subject: Re: [Qemu-devel] [PATCH 3/4] ram: Print block stats also in the
 complete case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dOMESGreaVO8I4N6O8g9t5G985a2UnS5I
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <5ff0d7ce-425a-3284-43e4-1ac332bccdb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] ram: Print block stats also in the
 complete case
References: <20170601214056.30387-1-quintela@redhat.com>
 <20170601214056.30387-4-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 04:40 PM, Juan Quintela wrote:
> To make things easier, I just moved it to populate_ram_info().
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dOMESGreaVO8I4N6O8g9t5G985a2UnS5I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMWmbAAoJEKeha0olJ0Nqn8UH/2+Te6jhv9a/DWnn1bmD4U7y
X0Mu4sfiVRtTZtc95u3Yy83Sqbirc+miomF+ATf+94MRCmlMp8JTqa82mZlnrMJh
xQS710tGgYUtYhvBhUx2TUrRZbrssdxaNjGXYkFrKruuRQ25ixzIrfDTy+khG1sJ
8kqF/G8gc4AZqGmL2nmC7xk+e0RvPL7cysKmPtrzp4S71esLsNDvxHYZi5bQokM3
QEc93tRXFeFxkR5FlXt4xhU1TeUE9JamQbB/gvzkY57SDQdMaNTs1N3AYL8OexNG
EUq/fqfrAsAvsDPoNM/yGl6ZY8gEk+fe33EjSTGTcno//vGnsrEMOiT0uMK5BOY=
=5sFr
-----END PGP SIGNATURE-----

--dOMESGreaVO8I4N6O8g9t5G985a2UnS5I--
