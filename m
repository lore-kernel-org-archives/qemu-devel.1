Received: from eggs.gnu.org ([2001:4830:134:3::10]:33025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZEw-0001ss-Ep
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZEv-0000Na-FK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:54:02 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fe43691-cfe4-7545-6c6c-96833545dcab@redhat.com>
Date: Wed, 22 Feb 2017 09:53:53 -0600
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DOGjQhWOS9hDDGF90jMcRQ1Obs7Ce38UR"
Subject: Re: [Qemu-devel] [PATCH 02/54] qcow2: Use BB for resizing in
 qcow2_amend_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DOGjQhWOS9hDDGF90jMcRQ1Obs7Ce38UR
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <7fe43691-cfe4-7545-6c6c-96833545dcab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/54] qcow2: Use BB for resizing in
 qcow2_amend_options()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:57 AM, Kevin Wolf wrote:
> In order to able to conver bdrv_truncate() to take a BdrvChild and

s/conver/convert/

> later to correctly check the resize permission here, we need to use a
> BlockBackend for resizing the image.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DOGjQhWOS9hDDGF90jMcRQ1Obs7Ce38UR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrbQRAAoJEKeha0olJ0NqlaAH/ilwoLv6eFbXEPDsjdl58b9u
gYmnHMRhFC9/fP7dIyKYy2Cr9ul1kPwRwrRdmHb3KHAf1Q5VblYftKBaEED3JeJn
ZvhJiP2hhpqOkP1XB9m/wTEVxjyFaorlj0+QbJunLAruRWJpJKEZjAYtGvMiXK9F
VR5nkAAgDK1Y2mk8hW/npFcT9MHk05QRmfCw0WDL4msgQFJAYi09gMpsm2ZX0Nji
QXdFkqVyTx8O08R6c52YCafMhLuYv1MfvRXLaJZbQpUntm9KbnJXWzYro02d7nAG
lgdJfc/I1hQySt0DZ7deGL8Nm9ncJ6f4j1Zce0/5muMiLkY48I5G2Y2tOJ89nYA=
=7qyf
-----END PGP SIGNATURE-----

--DOGjQhWOS9hDDGF90jMcRQ1Obs7Ce38UR--
