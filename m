Received: from eggs.gnu.org ([2001:4830:134:3::10]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw86u-0006Xp-CJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw86q-0002dq-BC
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:10:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw86q-0002dU-5v
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:10:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B8B88E3F1
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:09:59 +0000 (UTC)
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-6-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81d0d9af-2fec-b0cd-cece-6e7ea62c7cba@redhat.com>
Date: Thu, 6 Apr 2017 09:09:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-6-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WF7b0jQsbpfoP1bAJOIk2T6HHmVd6lwlp"
Subject: Re: [Qemu-devel] [PATCH 5/5] ram: Remove migration_bitmap_extend()
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
--WF7b0jQsbpfoP1bAJOIk2T6HHmVd6lwlp
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <81d0d9af-2fec-b0cd-cece-6e7ea62c7cba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] ram: Remove migration_bitmap_extend()
References: <20170406131326.2418-1-quintela@redhat.com>
 <20170406131326.2418-6-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:13 AM, Juan Quintela wrote:
> We have disabled memory hotplug, so we don't need to handle
> migration_bitamp there.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  exec.c                  |  1 -
>  include/exec/ram_addr.h |  2 --
>  migration/ram.c         | 34 ----------------------------------
>  3 files changed, 37 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WF7b0jQsbpfoP1bAJOIk2T6HHmVd6lwlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kw0AAoJEKeha0olJ0Nqzo8IAJ7da0oQCu34EUS64mwoVFmU
e0iE7mtHx+oOhjM3hqPdTA7Y4v4VyrzUw1BfzBH/lC1ZEMJ4YTPY+HJnUQ6BGXvW
5jjiWxVmZW17Ifd8akf1xLuLxgDqBNwIzTC+sAOgbevt9WkDM5eBoNJhMIadLPoA
A7BEKp5XDJJeZsiawOy93K16BgG4XMLPScgxN/7nu8euVpUYp1Nu6sqFCNfE0qqN
AtxS7pdwaUl8FnZ53MxLdsqPSW6gHXQcNgUpZaKtbY5zlxAbxFO2BCD6huGE4uzV
Fnx2ex5lUm0rYicRyJiUg7ZN+Ai92olcw3d7yzG6xHtIVPQsKROOWizWvvTSA/w=
=QTIU
-----END PGP SIGNATURE-----

--WF7b0jQsbpfoP1bAJOIk2T6HHmVd6lwlp--
