Received: from eggs.gnu.org ([2001:4830:134:3::10]:51437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijKu-0001bP-Um
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijKp-0001a6-5P
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:05:08 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-12-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <93c80e10-e1a0-d8a9-d30e-0ccefed70ae6@redhat.com>
Date: Tue, 28 Feb 2017 16:04:53 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-12-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ejt7BMCnfg5ReVLa3ET0BHlTv2vT0akU3"
Subject: Re: [Qemu-devel] [PATCH v3 11/44] block: Request real permissions
 in bdrv_attach_child()
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
--Ejt7BMCnfg5ReVLa3ET0BHlTv2vT0akU3
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <93c80e10-e1a0-d8a9-d30e-0ccefed70ae6@redhat.com>
Subject: Re: [PATCH v3 11/44] block: Request real permissions in
 bdrv_attach_child()
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-12-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:53, Kevin Wolf wrote:
> Now that all block drivers with children tell us what permissions they
> need from each of their children, bdrv_attach_child() can use this
> information and make the right requirements while trying to attach new
> children.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Ejt7BMCnfg5ReVLa3ET0BHlTv2vT0akU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1kZUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AU5sH/2ZdSUklrjZvlXLEkom/3UWld00/4+Yq
aUET2+yqE1MP656klQI7uSyE31/7c7x4/sPLr3CiNc4aKEnvDQ2/ZGEncjGmKwPe
ZfUJ0xL/WcXG7YCSsocpKr8IoHkgZtR6fyZUsbPKH02VX/iU4ylnaP7jxrOB3yaw
S7fEKWagKrmc5M/asq4rpqiRAvIujh1AUxtxybl9PCiwlt6+VWYpbtO0A/ZMcPsX
Z1xeWL0kKdrP+ZnsrHD9fXKrUgy+PGQSZsKvJdaNDG6KnoGJNGKCb5i4SvI2WedI
3ID9ychFFHrHL7B6tyb9RbiRmSzT1qwHnFFU5+IL2MsUbQoiokzKN2o=
=gHRb
-----END PGP SIGNATURE-----

--Ejt7BMCnfg5ReVLa3ET0BHlTv2vT0akU3--
