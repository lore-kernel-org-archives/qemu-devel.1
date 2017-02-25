Received: from eggs.gnu.org ([2001:4830:134:3::10]:49313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdcH-0004L2-3c
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 09:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdcG-0004Pn-ES
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 09:46:33 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-47-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a60f05cf-1a7c-2c91-e51b-4f8ce0a209c9@redhat.com>
Date: Sat, 25 Feb 2017 15:46:21 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-47-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kHHOnxrk2vHEtpqq3kN8tVQtD9pVfdlqi"
Subject: Re: [Qemu-devel] [PATCH 46/54] hmp: Request permissions in qemu-io
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
--kHHOnxrk2vHEtpqq3kN8tVQtD9pVfdlqi
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <a60f05cf-1a7c-2c91-e51b-4f8ce0a209c9@redhat.com>
Subject: Re: [PATCH 46/54] hmp: Request permissions in qemu-io
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-47-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-47-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> The HMP command 'qemu-io' is a bit tricky because it wants to work on
> the original BlockBackend, but additional permissions could be required=
=2E
> The details are explained in a comment in the code, but in summary, jus=
t
> request whatever permissions the current qemu-io command needs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          |  6 ++++++
>  hmp.c                          | 26 +++++++++++++++++++++++++-
>  include/qemu-io.h              |  1 +
>  include/sysemu/block-backend.h |  1 +
>  qemu-io-cmds.c                 | 28 ++++++++++++++++++++++++++++
>  5 files changed, 61 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--kHHOnxrk2vHEtpqq3kN8tVQtD9pVfdlqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixmL4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANIIIAK04gNF8sEKWi914tJ4Wo9fxyKGEB5CG
Gz3SWsPdRzu3NNlAfPU9hbD4OIbeFYFOIfAejr6SJjB3x+LFM7L9BfdPQEZQXI9Z
fnZXeFL8Jjek0bRx8sP1KzNDIKBQDXt0Qi7BcOGwO6UYscLiQLo5v0PavbTCez8w
XGgX6IR+84tUm2drAPko+KZpI9j8bUftt5LYCFnor9MZUYr3LgtDtXgByIy4/SZd
cygguNbGHzpG/371T0nd06wsDXOHajw1gj300OT3F1FQ3ssV7SXMqWzFGakxjtAf
4ZgLiyeB1/gvGV/viAc8v1GDg0je3YV0utxSiRv5lTBzg3jw3k++DoI=
=CNCW
-----END PGP SIGNATURE-----

--kHHOnxrk2vHEtpqq3kN8tVQtD9pVfdlqi--
