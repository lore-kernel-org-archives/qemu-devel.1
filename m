Received: from eggs.gnu.org ([2001:4830:134:3::10]:49550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKmP-00085K-UD
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKmP-0000cx-4f
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:20:49 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-3-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1acfa089-2c00-3dfb-c1a2-ef1f5ad9345e@redhat.com>
Date: Fri, 9 Jun 2017 16:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <1497009003-25794-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xtC0dtVRliapGhb65J1L9I9sihsDD4aEn"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] qemu-iotests: Allow
 starting new qemu after cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xtC0dtVRliapGhb65J1L9I9sihsDD4aEn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <1acfa089-2c00-3dfb-c1a2-ef1f5ad9345e@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/3] qemu-iotests: Allow starting new qemu
 after cleanup
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497009003-25794-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-09 13:50, Kevin Wolf wrote:
> After _cleanup_qemu(), test cases should be able to start the next qemu=

> process and call _cleanup_qemu() for that one as well. For this to work=

> cleanly, we need to improve the cleanup so that the second invocation
> doesn't try to kill the qemu instances from the first invocation a
> second time (which would result in error messages).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xtC0dtVRliapGhb65J1L9I9sihsDD4aEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOq63EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMWZ
B/9OYD0gsZBgjqI2ycpxfHKp6RrSXbf7T1FijjcMkXKPZvoZrdFOcZBDaVICGgq+
K0tfINaD8eA6W6d4B3Fcx4EOf5uGGkA/G8P8oWs66o4nDOOPeqslfTximLbaTtHV
Ea8c336moyiW8VB2PwodpRHQjNt1Sk2ovwN5ANiVckUFvM8CwWTTDaaEcDZ8jk1f
CKTuVZXsVVETLN30rJV5+zo+kAqUDNI2LtHRBDlY9BGLZzfjXa3nFwhdAJs9Mzy1
vE7VpudJ0oXiiyTwCngpB8H3akHjk60jH2cnQENBW43CgznIs/u0K0A33zjpxvJW
cFhePGZ7VuvLkd3JRCoevy0M
=h7R1
-----END PGP SIGNATURE-----

--xtC0dtVRliapGhb65J1L9I9sihsDD4aEn--
