Received: from eggs.gnu.org ([2001:4830:134:3::10]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSc3-0002xn-Hw
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSc2-0006hj-K2
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:11:03 -0500
References: <20170103170459.27662-1-berrange@redhat.com>
	<20170103170459.27662-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7cbbf068-d865-05f9-2537-cad957e4f9b4@redhat.com>
Date: Tue, 3 Jan 2017 11:10:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170459.27662-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UM8g048xqL79rAuWsHEcq12ErxO8sgcr2"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] iotests: skip 159 & 170 with luks
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UM8g048xqL79rAuWsHEcq12ErxO8sgcr2
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <7cbbf068-d865-05f9-2537-cad957e4f9b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] iotests: skip 159 & 170 with luks
 format
References: <20170103170459.27662-1-berrange@redhat.com>
 <20170103170459.27662-2-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:04 AM, Daniel P. Berrange wrote:
> While the qemu-img dd command does accept --image-opts
> this is not sufficient to make it work with the LUKS
> image yet. This is because bdrv_create() still always
> requires the non-image-opts syntax.
>=20
> Thus we must skip 159/170 with luks for now
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/159 | 2 +-
>  tests/qemu-iotests/170 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UM8g048xqL79rAuWsHEcq12ErxO8sgcr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa9sfAAoJEKeha0olJ0NqIsEH/3u5PXm04ZL5g5XMOaJ+baQ2
dthQ5im2CgUxb+0tznEUdjcxF2FoR4TnbPZ/FbeO3z5lK70TPBePIZZ72uTgiPoA
FI09olXuw31XTRSv3Vlyf0MV6gPrhf9HLR3/f3bPvCXjY9rDIzqG3mMueUzoVcsu
WAGqnDK4eX+Ye04DV1Ru92njD+7uEhEM7YVXJEyxJ/Y2zle/BcB9V5ZFGy2X0i65
eD6tP21r2vOfxgtQnusp31tjARmi8DfswCQi3/JsnavtfyJcbW9qFqGmW9lBm4wH
KbNuPiSC72eVEbKzj/rOy4/PJjJYN74iqnEsX2FOL53iaXKdTv+I2yHh4U4dcdk=
=g/UW
-----END PGP SIGNATURE-----

--UM8g048xqL79rAuWsHEcq12ErxO8sgcr2--
