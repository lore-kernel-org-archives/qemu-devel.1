Received: from eggs.gnu.org ([208.118.235.92]:41675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehLJc-0002Pq-7r
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehLIX-0003qb-KD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:18:36 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fe709884-2202-75fc-4daa-77bf57b1f55a@redhat.com>
Date: Thu, 1 Feb 2018 21:11:48 +0100
MIME-Version: 1.0
In-Reply-To: <f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eYpdtKvgqlxfGeLUFdQ65XIZzp40eGpAN"
Subject: Re: [Qemu-devel] [PATCH v3 38/39] iotests: Test downgrading an
 image using a small L2 slice size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eYpdtKvgqlxfGeLUFdQ65XIZzp40eGpAN
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <fe709884-2202-75fc-4daa-77bf57b1f55a@redhat.com>
Subject: Re: [PATCH v3 38/39] iotests: Test downgrading an image using a small
 L2 slice size
References: <cover.1516978645.git.berto@igalia.com>
 <f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
In-Reply-To: <f797e0f6c697b2fce069bfafe22ee53f26aebce8.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> expand_zero_clusters_in_l1() is used when downgrading qcow2 images
> from v3 to v2 (compat=3D0.10). This is one of the functions that needed=

> more changes to support L2 slices, so this patch extends iotest 061 to
> test downgrading a qcow2 image using a smaller slice size.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/061     | 16 ++++++++++++
>  tests/qemu-iotests/061.out | 61 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 77 insertions(+)

Well, it would be better if we could just specify this option for all of
the qcow2 tests, but I can see that that's not really feasible...

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eYpdtKvgqlxfGeLUFdQ65XIZzp40eGpAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzdIQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHJgIAI5IR0H6Ci3fm0xpNYdpGLmxzviKMZNT
0IxSd9mKmlOUcmEYp7jj6drqsbrmAx4c8YuJ2R6aKigGZGM69sgXJdqk1FQXE9hr
ydERXJ4nKz7A7DkvXMQW+y5zePkPs0SJR7irIalO51MkSAOMDoN3Ty+LmNWBvBGF
L/F7zlKfJS+WFYeUYBjUqPo+msqVuHXFsHYuNe0KMRQVi8+D6uQsCT7AaUbE/X1h
trY2AP/J7hkjnfYCEP5YzfVv4B5mXo3A+MIr0ffRxUzPnQA1ERi1Yf1nOoGgWFBK
mAAKpP9RIQSbZ78hlGFwesMK8zvttCm9f0MJUYziJksRGt60/YWmW8U=
=Z/ue
-----END PGP SIGNATURE-----

--eYpdtKvgqlxfGeLUFdQ65XIZzp40eGpAN--
