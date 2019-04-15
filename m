Received: from eggs.gnu.org ([209.51.188.92]:56056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Lv-00068s-2V
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Lu-0005CL-1D
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:21:02 -0400
References: <20190415155452.5115-1-kwolf@redhat.com>
	<20190415155452.5115-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <110a72ca-eab8-9879-868d-47416c29a404@redhat.com>
Date: Mon, 15 Apr 2019 11:20:57 -0500
MIME-Version: 1.0
In-Reply-To: <20190415155452.5115-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uPfJV2PYgYYCRkkkYiaTa9npM6dBsc0SL"
Subject: Re: [Qemu-devel] [PATCH 3/4] qcow2: Add errp to preallocate_co()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uPfJV2PYgYYCRkkkYiaTa9npM6dBsc0SL
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <110a72ca-eab8-9879-868d-47416c29a404@redhat.com>
Subject: Re: [PATCH 3/4] qcow2: Add errp to preallocate_co()
References: <20190415155452.5115-1-kwolf@redhat.com>
 <20190415155452.5115-4-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:54 AM, Kevin Wolf wrote:
> We'll add a bdrv_co_truncate() call in the next patch which can return
> an Error that we don't want to discard. So add an errp parameter to
> preallocate_co().
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uPfJV2PYgYYCRkkkYiaTa9npM6dBsc0SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0r2kACgkQp6FrSiUn
Q2ozeAgAh3biQhs4LnSt79eobttIx/gJf8bRlna/i+uyJr+DTPAr9WEQT+a+EYiF
CrNXeau3Xc9yNA7MGCHu3rOo5OsVk3FnPTEGUZnUc1SMf6prjrpP6kBhG+rlYWV2
TPsCvXyHKue6xLZPG107jTuDDWM4lhHF5xxpnSw2yybwZn9AOI01azTIkxMXbR7K
JwufCzjibPnfzDjr0EjLlBg3JERMIDgWZEWKpNHnboG/qJjIKDt9EuAsyU5huDQj
4SjNBX0ulqai5zMPJ8lgO0V1zDeDLGe0dfDdgtnaGPRSesZFCaQSn0iqthElMRfO
UYZr8xCVf0VOV+D3w9Si62AtWjjyoA==
=VYFn
-----END PGP SIGNATURE-----

--uPfJV2PYgYYCRkkkYiaTa9npM6dBsc0SL--
