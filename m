Received: from eggs.gnu.org ([209.51.188.92]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFQJ-0001c9-8P
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghFQI-0007kQ-D7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:05:39 -0500
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
	<1540876720-9574-5-git-send-email-liq3ea@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7f05d470-0533-00ee-b0c4-92cd458ce424@redhat.com>
Date: Wed, 9 Jan 2019 16:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <1540876720-9574-5-git-send-email-liq3ea@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Px2lAATbD5FDA7oWBNrWiZI0suVP938lT"
Subject: Re: [Qemu-devel] [PATCH 4/4] nvme: use pci_dev directly in
 nvme_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Px2lAATbD5FDA7oWBNrWiZI0suVP938lT
From: Max Reitz <mreitz@redhat.com>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <7f05d470-0533-00ee-b0c4-92cd458ce424@redhat.com>
Subject: Re: [PATCH 4/4] nvme: use pci_dev directly in nvme_realize
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
 <1540876720-9574-5-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-5-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.18 06:18, Li Qiang wrote:
> There is no need to make another reference.
>=20
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Px2lAATbD5FDA7oWBNrWiZI0suVP938lT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2DboACgkQ9AfbAGHV
z0CJZQgAlocJd5Z4LWncGQ50+J5pEWBtjud9wRgkH5QFjwyiBllzzu7CDDwMAuvD
8/Weu5apl1Nq3G+rkhUqwOGsVExDUO71fUjYt96qgSUROCqkexhO+mTfLIOwHEoS
WGmwu4H6SY/Yc/ArnGr3mhv07dpAajRVLk8EYL/np4NWeH93wleTxB+0a1rObbfC
BBx1HbQXsJcypJi8ODxniNUKU5MAYwvvGd8ECJ8KX9M2kRg5jJpeyUutF/S32qqJ
IXCfBo2TNRQHvt3bNcS29qq3YG+yqjAvncPANGXCt4jTTXF1Xbw9xNHv9Xfti/4+
/+/RtN9XWdrrvSD1TS7n0t2xR77oHw==
=Dz8P
-----END PGP SIGNATURE-----

--Px2lAATbD5FDA7oWBNrWiZI0suVP938lT--
