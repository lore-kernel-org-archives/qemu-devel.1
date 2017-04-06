Received: from eggs.gnu.org ([2001:4830:134:3::10]:41699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw88J-0007Sf-Cy
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw88F-00030P-Ch
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:11:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw88F-00030A-6L
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:11:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A6787971C
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:11:26 +0000 (UTC)
References: <20170406131408.2524-1-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fcd00dbf-549a-fdc4-3f63-65bbd8c7320d@redhat.com>
Date: Thu, 6 Apr 2017 09:11:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170406131408.2524-1-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KN9rrfRaKVS9IRAHUNebMu8PV86D6P0TM"
Subject: Re: [Qemu-devel] [PATCH v2] Split migration bitmaps by ramblock
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
--KN9rrfRaKVS9IRAHUNebMu8PV86D6P0TM
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <fcd00dbf-549a-fdc4-3f63-65bbd8c7320d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Split migration bitmaps by ramblock
References: <20170406131408.2524-1-quintela@redhat.com>
In-Reply-To: <20170406131408.2524-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:14 AM, Juan Quintela wrote:
> Hi
>=20
> For v2 this is a rebase on top of all the changes that happened in the
> prvious two series.
>=20

>=20
> Please, comment?
>=20
> Later, Juan.
>=20
>=20
> *** BLURB HERE ***
>=20
> Juan Quintela (1):
>   ram: Remove migration_bitmap_extend()

Is this the intended patch?

>=20
>  exec.c                  |  1 -
>  include/exec/ram_addr.h |  2 --
>  migration/ram.c         | 34 ----------------------------------
>  3 files changed, 37 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KN9rrfRaKVS9IRAHUNebMu8PV86D6P0TM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kyNAAoJEKeha0olJ0NqLyIH/iiaxpj923GKgH8NUKv+H1S3
RK5gB/0KdLkNGQ6Ft9AIBPAsWso+NOGnQkg2wUvo0SnbThKTcry2xDH+RdR3azTl
UcjwbS0HI6w/cR91t0hhokwztAnFFsRhGYI8jHFv1LZml+bJ2GZTZfw3MC0paO/5
AWMaWBAEpm4fC75wm+a5WoHw/zNYJQ3dnLFDNUS2aNdITPbtTM8K8wcKEOMnGW12
pJ7usP1diuuTeg7m8eCAp4VLM9RRdgr13B1+A/sdqNW/s/Ima9235FNpntLXtDuT
jy5gbIxodiLI34w2ZrlLd9AM1l5op3/pmEr5b7+s8yx3EU8ToTdYAz4ZS70t5/I=
=bFj5
-----END PGP SIGNATURE-----

--KN9rrfRaKVS9IRAHUNebMu8PV86D6P0TM--
