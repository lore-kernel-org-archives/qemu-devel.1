Received: from eggs.gnu.org ([2001:4830:134:3::10]:34506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce5Dt-0001gA-Af
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce5Ds-0006Bi-LG
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:26:41 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-15-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a39c0070-a05f-4b29-d2fe-72972ae02f4c@redhat.com>
Date: Wed, 15 Feb 2017 20:26:31 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-15-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nws5G8DoMvQsGw7Oqfl5UIQ3A86r0COuI"
Subject: Re: [Qemu-devel] [RFC PATCH 14/41] block: Add permissions to
 BlockBackend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nws5G8DoMvQsGw7Oqfl5UIQ3A86r0COuI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <a39c0070-a05f-4b29-d2fe-72972ae02f4c@redhat.com>
Subject: Re: [RFC PATCH 14/41] block: Add permissions to BlockBackend
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-15-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> The BlockBackend can now store the permissions that its user requires.
> This is necessary because nodes can be ejected from or inserted into a
> BlockBackend and all of these operations must make sure that the user
> still gets what it requested initially.

"it"?

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          | 27 +++++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  2 ++
>  2 files changed, 29 insertions(+)

(Writing my name under this single word is a bit weird. Thankfully, this
reply now consists of more than just that word.)

Max


--nws5G8DoMvQsGw7Oqfl5UIQ3A86r0COuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikq2cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABS4IAMR37JRRFu3PUFZ4rHCKfGVuWh0ghTFk
QGXsO0hPnVXm678xMWD48xbnN6tBZTGHedBhgFflaqUitiVw4luZnhQd/xgCzPvY
IITp3xjTRRmL5DV4/VRq5ho4ixVNHRazYbAeHm1W6gd1KlJLu++0hU2K/GPigcSJ
C2PnvKbNEn8Hov0SMlfAEtZpuI92UTeKMqXssYK0qGuH3woTC/eGrtxtHTUupnmx
aUVyflir5IV3Tw+Kg6rAmNL2z9JdmZUkNy8Vfrt+2xYmvKgX1h0buOXhhNY1toQS
QBS5vf9WvnQk0bf9MfRo0Wy1nVvtQPNxc8NT2H/+MaUvGTXdhpP5K5s=
=3+Vp
-----END PGP SIGNATURE-----

--nws5G8DoMvQsGw7Oqfl5UIQ3A86r0COuI--
