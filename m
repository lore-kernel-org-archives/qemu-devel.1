Received: from eggs.gnu.org ([2001:4830:134:3::10]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCs0X-0003QB-Sq
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCs0W-0005b6-Sh
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:24:41 -0400
References: <20170522180735.26677-1-mreitz@redhat.com>
	<20170522180735.26677-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a86cc401-4200-b062-8743-61dca104af55@redhat.com>
Date: Mon, 22 May 2017 13:24:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170522180735.26677-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3xhCo3p5sItkqiDp9RwMon3GtrHpjcUHX"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Add test for colon handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xhCo3p5sItkqiDp9RwMon3GtrHpjcUHX
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a86cc401-4200-b062-8743-61dca104af55@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Add test for colon handling
References: <20170522180735.26677-1-mreitz@redhat.com>
 <20170522180735.26677-3-mreitz@redhat.com>
In-Reply-To: <20170522180735.26677-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 01:07 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I apologize for the patch title for sounding a bit squishy. But I like
> it so I won't change it.

That was a mental image I did not need. ;)

> ---
>  tests/qemu-iotests/126     | 76 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/126.out | 16 ++++++++++
>  tests/qemu-iotests/group   |  1 +

What - we really have never used 126?  And as a nice bonus - you won't
have to rebase your patch based on collisions with other new tests.  Sly.=


Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3xhCo3p5sItkqiDp9RwMon3GtrHpjcUHX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyzhAAoJEKeha0olJ0NquVIH/RwQxyA1FO/ApMBYBo9Xsm64
6npRYqzaUoX2e3ltZuqz/kcrwSOBP3g3Sf0K5Fb9LkmQSxx04qbdABtlirllME7E
VB/1pkYDR9DcCp+wqnmrmLklWImki0Qf+Pdt2+Mot7beFQU13ZyLGVGi4jbBAorV
nAcHgv9z5DXII2zu9m8aTAK0/8WklwBoP+V7jX4U+RgsVSpLzhmD7tkk1K+GzqCm
Nyvlff6pzgPt2usVeTXjuVo5fGvPxgRDiJinn6wI0eNsCegCjOT1lumlWsNjJRJM
Bt6HXMYJT3tZUF3ZozyI5rOLiI2CofQGqPDdhvXDKm2bsQfhXCuyg3pIpDF4EI8=
=rCFJ
-----END PGP SIGNATURE-----

--3xhCo3p5sItkqiDp9RwMon3GtrHpjcUHX--
