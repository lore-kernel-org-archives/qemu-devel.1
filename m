Received: from eggs.gnu.org ([2001:4830:134:3::10]:39323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgW2e-0002rG-V8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgW2e-0007Of-4S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:29:08 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-3-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e602d1e0-eb2f-a815-a97d-bd4471f3a961@redhat.com>
Date: Wed, 22 Feb 2017 13:28:57 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ag4i55MvtlHLq0Hq6LbIL2jGXnftWVox1"
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
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ag4i55MvtlHLq0Hq6LbIL2jGXnftWVox1
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <e602d1e0-eb2f-a815-a97d-bd4471f3a961@redhat.com>
Subject: Re: [PATCH 02/54] qcow2: Use BB for resizing in qcow2_amend_options()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:57, Kevin Wolf wrote:
> In order to able to conver bdrv_truncate() to take a BdrvChild and
> later to correctly check the resize permission here, we need to use a
> BlockBackend for resizing the image.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Ag4i55MvtlHLq0Hq6LbIL2jGXnftWVox1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlithAkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATZAH/jeR5BYPbm/HbTw0APnJCixSz43l3HOW
ep9VBOO0zc6bGe7okl3EOrd76NC9EVoZIvmNbzXCa3z+mHJC4X1MvFFmUSfHoibk
l+tJnPyvppqo9rXX0MWWFBFgQuzraq2jzfgEtgUOwc7fiEp1r1jfINeJYrdl8Boa
HpW0eZoRSTX8GKlBfTZKfs58ne/QyhKBOuDPYp6W06yhvCMT5xUSQdVpQ5Vw3hG0
6QJ+5v2kxr1r2ArQgKpGq/xDs++ykrnwIDiBi92YLKiPc+A94OyEQ3/kQ3WYhgz9
q/tZf+WZEtqhpyTqKgRXpopFwNMRLRHrPFOz5tYYk0bhD5uW6JOkEJ0=
=0UiG
-----END PGP SIGNATURE-----

--Ag4i55MvtlHLq0Hq6LbIL2jGXnftWVox1--
