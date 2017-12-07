Received: from eggs.gnu.org ([2001:4830:134:3::10]:51787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN40U-0004Qz-Rt
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN40U-00071C-10
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:47:02 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-6-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48bfb298-4e7f-b9e8-4290-fa180943e651@redhat.com>
Date: Thu, 7 Dec 2017 15:46:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-6-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eMAqt36n5GNXlXV5XRN6nBn5dP0UuxCGc"
Subject: Re: [Qemu-devel] [PATCH v2 5/9] block: don't keep AioContext
 acquired after internal_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eMAqt36n5GNXlXV5XRN6nBn5dP0UuxCGc
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <48bfb298-4e7f-b9e8-4290-fa180943e651@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/9] block: don't keep AioContext acquired
 after internal_snapshot_prepare()
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-6-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockdev.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eMAqt36n5GNXlXV5XRN6nBn5dP0UuxCGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloptsoACgkQp6FrSiUn
Q2owVwf9EcCbJKWmAbKy+Er1QkoW1cghtVNywNQNJSu9NzlvATDXKFn/scMTf57y
qBljQeW0w09V6yabsdo9lryNcGS7PXVZjWi378XsNhvWziNWpjzcTjb5d8dYUD9U
DwAxmHsE+Bt6JYg4vyORLe8iQIt43UMpAiuVOJBH9t0BQKZ/YwrlthcppotBem2C
g0PUzhIwUyalwcf/tiZz3MQptbnJM4dAUPbh76rtwf85zIni+5zc720u7fGJCWl6
3FmqJblYLWsTG3t3sfu01U3ROKRMVGqhpbowEafzY1KiJJ9cTOxGCrv5MYh6P/ae
3SU8DmF71FcVUQ95e30diN8VuHroOw==
=pZoH
-----END PGP SIGNATURE-----

--eMAqt36n5GNXlXV5XRN6nBn5dP0UuxCGc--
