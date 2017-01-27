Received: from eggs.gnu.org ([2001:4830:134:3::10]:41831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cX7RN-00081Z-71
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cX7RK-0000UA-17
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:23:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cX7RJ-0000U2-OR
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:23:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECA133DBD8
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 14:23:45 +0000 (UTC)
References: <20170127100029.11356-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fb695b9-1ac2-964f-984c-c32f04ae5e90@redhat.com>
Date: Fri, 27 Jan 2017 08:23:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170127100029.11356-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fVvJBTbnwx1X3TPbKvbJjL9H5HSMNuNUw"
Subject: Re: [Qemu-devel] [PATCH 0/4] block/gluster: cleanups for
 GlfsPreopened
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fVvJBTbnwx1X3TPbKvbJjL9H5HSMNuNUw
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Message-ID: <1fb695b9-1ac2-964f-984c-c32f04ae5e90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block/gluster: cleanups for
 GlfsPreopened
References: <20170127100029.11356-1-stefanha@redhat.com>
In-Reply-To: <20170127100029.11356-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2017 04:00 AM, Stefan Hajnoczi wrote:
> Code added in commit 6349c15410361d3fe52c9beee309954d606f8ccd ("block/g=
luster:
> memory usage: use one glfs instance per volume") does not follow conven=
tions
> and violates QEMU coding style.  Although any single issue in isolation=
 is not
> worth patching, there are several of these and I think it's worth resol=
ving
> them together in one sweep.
>=20
> Stefan Hajnoczi (4):
>   block/gluster: fix wrong indent in glfs_find_preopened()
>   block/gluster: drop intermediate ListElement struct
>   block/gluster: use conventional names for GlfsPreopened functions
>   block/gluster: add missing QLIST_HEAD_INITIALIZER()

For the series,
Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  block/gluster.c | 66 +++++++++++++++++++++++++++----------------------=
--------
>  1 file changed, 31 insertions(+), 35 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fVvJBTbnwx1X3TPbKvbJjL9H5HSMNuNUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYi1fsAAoJEKeha0olJ0NqVPcIAIozpQxrhFnP91BVaeRg9GXL
VM1+1uhee97ndceZ9/d38ZM9aKPZuJsnlBXR9mvBWEIfpEzz7SR61UhYB5J/LmwE
qwMTp3rOtHEaLx2sWE7Oglph9AiTWKgfsymb4dgWMtFA1h2aLzAS7qY0mrz1YVY0
xEHUcyXLlUNaoEpLua/+5D4X6f4VlQPA5ZAovdL8e1qT4AKNGt6F3NyZIaqjq3gc
H9k4t5w9uOW1ss3ZOZ3QNf9SCaMBYZ9aaXHxu5TZmUqDa20CzBm9NPh07SveuUN9
snIGd9tpQDM7Q/2KEjIx2ZdWqKt8muAher8A08gm2Rs/cj66VFhp5drk+DkloBY=
=+1gw
-----END PGP SIGNATURE-----

--fVvJBTbnwx1X3TPbKvbJjL9H5HSMNuNUw--
