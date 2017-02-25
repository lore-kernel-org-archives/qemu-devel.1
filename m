Received: from eggs.gnu.org ([2001:4830:134:3::10]:55317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chbGO-0003d3-DG
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chbGN-0003RC-MU
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:15:48 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-40-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <510620c0-687a-5965-fea6-213134eb06b3@redhat.com>
Date: Sat, 25 Feb 2017 13:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-40-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7aI498919RadrhXk11pM1hfTxreEjvxAn"
Subject: Re: [Qemu-devel] [PATCH 39/54] block: Fix pending requests check in
 bdrv_append()
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
--7aI498919RadrhXk11pM1hfTxreEjvxAn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <510620c0-687a-5965-fea6-213134eb06b3@redhat.com>
Subject: Re: [PATCH 39/54] block: Fix pending requests check in bdrv_append()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-40-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-40-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> bdrv_append() cares about isolation of the node that it modifies, but
> not about activity in some subtree below it. Instead of using the
> recursive bdrv_requests_pending(), directly check bs->in_flight, which
> considers only the node in question.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7aI498919RadrhXk11pM1hfTxreEjvxAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixdWoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIsIH/1IsbHJhloKSRLicqPggdu+6j7We50HN
tzCAhOcmMDVh2fOBjb6/ZwH1aBBjlFA9hpml6PyTudIIlfHRJG9zj0DiOZ8hNnCi
Jy5tFlT+S6ZZzNpVRlr2+nrX4YylIi+C9R1J+oJ4LMzJFmHwKyMQ2lkwQPwXHuwb
dDk6pZQYUEGsJn18q/Baza6gZUFgTTdVbieRXxQz/fgUYWnNsCsCSni3P221vjd9
XJMhuzPVbZIQVKIgBQKCNhT+1sDLM8FIf5bw4Oa74wtkH3GnlbZQ8VfKMvFNUaP3
6hi+y3cB4wWljYAwWRzrVyZhpDr296xRWJ+/n+aIkzpellJckjoVnUE=
=l5B2
-----END PGP SIGNATURE-----

--7aI498919RadrhXk11pM1hfTxreEjvxAn--
