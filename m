Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpFtM-0006qY-Ol
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpFtL-0001QP-Ue
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:40:28 -0400
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <715752ed-6a7b-a370-ef62-d030ec89e236@redhat.com>
Date: Mon, 13 Aug 2018 18:40:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180810162658.6562-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QBSjAVo2lFWpiAbkimq0YQWBauszvHKSF"
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QBSjAVo2lFWpiAbkimq0YQWBauszvHKSF
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <715752ed-6a7b-a370-ef62-d030ec89e236@redhat.com>
Subject: Re: [PATCH 1/2] commit: Add top-node/base-node options
References: <20180810162658.6562-1-kwolf@redhat.com>
 <20180810162658.6562-2-kwolf@redhat.com>
In-Reply-To: <20180810162658.6562-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-10 18:26, Kevin Wolf wrote:
> The block-commit QMP command required specifying the top and base nodes=

> of the commit jobs using the file name of that node. While this works
> in simple cases (local files with absolute paths), the file names
> generated for more complicated setups can be hard to predict.
>=20
> This adds two new options top-node and base-node to the command, which
> allow specifying node names instead. They are mutually exclusive with
> the old options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 24 ++++++++++++++++++------
>  blockdev.c           | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 8 deletions(-)

Looks good to me, but you made me a bit cautious with your talk of how
many pitfalls you've encountered on your way to do this change...

Max


--QBSjAVo2lFWpiAbkimq0YQWBauszvHKSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxtHEACgkQ9AfbAGHV
z0AloAf/Q7vKY62bc7gsaYjC3QXskjTbKXWPqDio0wef21T74kY6OX7SFFowkdSD
wVejOnQ/jspquxRR8f2zVKBYmxI/9RHhORvsP3xHo8j6zWH36mZq9y3SwPhevhcU
IDrkPt+RBFh4cDbsLedX9t1W+6TxwqA2zv4pHgOIVMJmR0Rts9LAVpd/yvxu+lp3
tXZagqz7oGfkux4pTTlbFWXECfkIbzju/x4TnFt+2umVxMmF3qS0BMmVwDn3ZCB8
D8lZ0WA3mdC9JSzmz8jUnZbRoy/4vNwjjezRfjO9dWYWpxXGWZaUw1T8ycVc0H1C
dyirPBmFz3+AU8rMU3fnAVAyx4x6HQ==
=H303
-----END PGP SIGNATURE-----

--QBSjAVo2lFWpiAbkimq0YQWBauszvHKSF--
