Received: from eggs.gnu.org ([2001:4830:134:3::10]:40126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw82a-00033D-ST
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw82W-0000pr-Sa
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw82W-0000pZ-MD
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EBB05145D
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:05:31 +0000 (UTC)
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51d06417-c04a-4277-f289-aeb04daf4364@redhat.com>
Date: Thu, 6 Apr 2017 09:05:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wUqf0vGV3In9F3X4Wupwlx3Rv3HR5GaxJ"
Subject: Re: [Qemu-devel] [PATCH 2/5] qdev: Export qdev_hot_removed
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
--wUqf0vGV3In9F3X4Wupwlx3Rv3HR5GaxJ
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <51d06417-c04a-4277-f289-aeb04daf4364@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] qdev: Export qdev_hot_removed
References: <20170406131326.2418-1-quintela@redhat.com>
 <20170406131326.2418-3-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:13 AM, Juan Quintela wrote:
> I need to move qdev_unplug to qdev-monitor in the following patch, and
> it needs access to this variable.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev.c         | 2 +-
>  include/hw/qdev-core.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wUqf0vGV3In9F3X4Wupwlx3Rv3HR5GaxJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5ksqAAoJEKeha0olJ0NqspkIAKbJYr9Blw1Xmq/ulfcQjn81
S/gZglq4ySXYVernyeO4NUELka0OsLmLhnFz1P8ZvNPKTdHOyuPRv6C9MwnA5amH
SqecHdNeFaCEejddY3pmwnlq3qMGxOMAryBVNhGdjekaWhePcZUNhM6iipdedQ4n
0zQBjTsFB5LTBJ4mJHHlIWtZ04jxirKMt9Pfh7ksiuk2vb3jgT+6nMlL8GQkjzuY
vb6DCmVmtSOPg8LMpbrpHOBMsJ9fW+LzLFMO0unuSfDszWxM3uJHyHUH5RmAzva6
uTy38DmFusiJnF1tQVFOCxrGK6Q6nwM0ebBWJVynbgamsR8gXnkOVvKTh/wJlhc=
=fxKS
-----END PGP SIGNATURE-----

--wUqf0vGV3In9F3X4Wupwlx3Rv3HR5GaxJ--
