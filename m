Received: from eggs.gnu.org ([2001:4830:134:3::10]:36740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqjf2-0003Kd-BX
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqjez-0002HZ-7X
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:03:00 -0400
Date: Wed, 22 Mar 2017 17:02:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170322170243.GE16717@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-5-mreitz@redhat.com>
	<20170320112900.GN17887@stefanha-x1.localdomain>
	<ee54e17a-a2dc-ca8a-ebe2-ebda8a283245@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <ee54e17a-a2dc-ca8a-ebe2-ebda8a283245@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 14/16] block/qcow2:
 falloc/full preallocating growth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 04:15:59PM +0100, Max Reitz wrote:
> On 20.03.2017 12:29, Stefan Hajnoczi wrote:
> > On Mon, Mar 13, 2017 at 10:41:15PM +0100, Max Reitz wrote:
> >> Implement the preallocation modes falloc and full for growing qcow2
> >> images.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/qcow2.c | 36 +++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 35 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index 80fb815b15..b6b08d70da 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> >> @@ -2604,7 +2604,9 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset,
> >>      int64_t new_l1_size;
> >>      int ret;
> >> =20
> >> -    if (prealloc !=3D PREALLOC_MODE_OFF && prealloc !=3D PREALLOC_MOD=
E_METADATA) {
> >> +    if (prealloc !=3D PREALLOC_MODE_OFF && prealloc !=3D PREALLOC_MOD=
E_METADATA &&
> >> +        prealloc !=3D PREALLOC_MODE_FALLOC && prealloc !=3D PREALLOC_=
MODE_FULL)
> >=20
> > Now all cases are covered so this if statement can be dropped.  If you
> > are worried about new preallocation modes being added in the future then
> > the error_setg() can be moved into the switch statement's default case.
>=20
> No, because the switch comes after we have already grown the L1 table.
> That wouldn't be so nice.

Oops :)

Stefan

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0q4zAAoJEJykq7OBq3PI7NQH/R6rlR2tUkOcerkNwNJHkbO0
QVS6urWDcsuE/KjCaBqjg7VLyN9VWO5uY9A3q6w9n0OWsvbbwE0E1DY/h/0QWXYo
n+e/whL2fY3kCJVGump2EwxFVzu8vIO/gfVwc33g0qck+OaCK6qJyihnP1+GNpRA
hfJLkVONA7QDRPJUG+LkAjTNyHLJWPgQyJQWKWyX5wGPBf8PLRJGNyD6v25WPS/D
GfgvPrclu7qA0mEpoWihEjH5KYp7tYHhAhoPSBUxwgUWBzd/NPG/aiwROlY5JBeg
Aq0n9xlBhs1kVmRumt1K7diEiEbSDrpcn+mFOEUDI7UTK1pbJoZwWSUHZq6MEmE=
=WEmn
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
