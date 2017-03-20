Received: from eggs.gnu.org ([2001:4830:134:3::10]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpud8-0006qV-Fe
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpud3-0003ns-83
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:33:36 -0400
Date: Mon, 20 Mar 2017 10:33:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320103320.GD17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 03/16] block: Add
 PreallocMode to blk_truncate()
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


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:32PM +0100, Max Reitz wrote:
> blk_truncate() itself will pass that value to bdrv_truncate(), and all
> callers of blk_truncate() just set the parameter to PREALLOC_MODE_OFF
> for now.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/sysemu/block-backend.h | 3 ++-
>  block/block-backend.c          | 5 +++--
>  block/commit.c                 | 4 ++--
>  block/mirror.c                 | 3 ++-
>  block/parallels.c              | 2 +-
>  block/qcow.c                   | 2 +-
>  block/qcow2.c                  | 4 ++--
>  block/qed.c                    | 2 +-
>  block/vdi.c                    | 3 ++-
>  block/vhdx.c                   | 5 +++--
>  block/vmdk.c                   | 7 ++++---
>  block/vpc.c                    | 2 +-
>  blockdev.c                     | 2 +-
>  qemu-img.c                     | 2 +-
>  qemu-io-cmds.c                 | 2 +-
>  15 files changed, 27 insertions(+), 21 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz6/wAAoJEJykq7OBq3PI0kEH/34C2vYrJ26xsmchiK82S0gT
CNoNXxbyi4nazs5tdOcp5UAN0Nlyl7HMlowxZvXEDZiUg0baZSTLcOhh+L9d/vup
lKGq6xHLYFt13zupDjfSRLZerUjXGOTTAPH19tLtsjaQX/xEFmJEYBLOnYC6lGTs
IG1Svlhdr1OCRDxBBTGU71lUSRvJxDnSGqoPA68RteadwmkIUaym+ikNZ+77CbUo
22ayuL7pydgFfw1ZrnWOYfkuFKdWlEV8Amfe5gJwXd4EVBHoX2o6P5F+FqOwTB81
c99kNA9Ss3nkcp7SjAru5GGNeXbExrMOHabNYeXA2DxWlw5TR5BZLqCrpRnUIas=
=L5dN
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
