Received: from eggs.gnu.org ([2001:4830:134:3::10]:53143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbB2I-000602-Dv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbB2H-000844-F9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:34:58 -0400
References: <20170728131452.15316-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd3a49de-43db-34b3-65dc-67b8fbc78b1f@redhat.com>
Date: Fri, 28 Jul 2017 14:34:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170728131452.15316-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cnAIOJQVPOUvPE1wIIlg27pDktvPjCJOQ"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/7] qemu-iotests: Fix leaked
 temporary file fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cnAIOJQVPOUvPE1wIIlg27pDktvPjCJOQ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <cd3a49de-43db-34b3-65dc-67b8fbc78b1f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/7] qemu-iotests: Fix leaked
 temporary file fixes
References: <20170728131452.15316-1-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:14 AM, Kevin Wolf wrote:
> This fixes leaked temporary files that are created during successful
> runs of qemu-iotests for qcow2, raw and vmdk. More file leaks exist for=

> failing or interrupted tests, but this is something for another day.
>=20
> Kevin Wolf (7):
>   qemu-iotests/041: Fix leaked scratch images
>   qemu-iotests: Remove blkdebug.conf after tests
>   qemu-iotests/141: Fix image cleanup
>   qemu-iotests/153: Fix leaked scratch images
>   qemu-iotests/162: Fix leaked temporary files
>   qemu-iotests/063: Fix leaked image
>   qemu-iotests/059: Fix leaked image files

All look safe for 2.10.  Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

Although see individual messages for some nits worth fixing.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cnAIOJQVPOUvPE1wIIlg27pDktvPjCJOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7kdkACgkQp6FrSiUn
Q2q8qgf/bSkuVeXgxP/CDG7ECiNlncYkx2OBUUWfoA7Rc0BXB7XXis0qo9DJKe8d
bfcCWjN/+2NW6I7pQDya7yHnvhLphZiS4F30B3u+WGxvZKyIdwlaZMw1KPa9+sjs
yRppxf++HTnQX7hL9CbqhhTfIJc6WQIINb40D64Cwd4tQhMt1P/DOqSC3oBDIASM
sDEhvBZuI7fEM0Mzqmf1+b1bQ1Hc/mIAYLTHBSb8OtBqVHEt2jgHdAGsHBoLmoC3
iYWUQHEMPHTNYzq4RoeqRtVaBUHy0THKN6anW/cBB7mOBKpTp/CYmqsmaATXnyCd
wsgpGOWvqT5167Yvm3+nUS8JKDPLMA==
=Jk1u
-----END PGP SIGNATURE-----

--cnAIOJQVPOUvPE1wIIlg27pDktvPjCJOQ--
