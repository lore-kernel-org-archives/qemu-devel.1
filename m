Received: from eggs.gnu.org ([2001:4830:134:3::10]:53178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdl8-0006QH-FC
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdl7-0002Ln-OL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:47:34 -0400
Date: Tue, 16 May 2017 15:47:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516144719.GI8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/18] throttle-groups: protect throttled
 requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:41:59PM +0200, Paolo Bonzini wrote:
> Another possibility is to use tg->lock, which we're holding anyway in
> both schedule_next_request and throttle_group_co_io_limits_intercept.
> This would require open-coding the CoQueue however, so I've chosen this
> alternative.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: rename CoMutex [Fam]
>=20
>  block/block-backend.c          |  1 +
>  block/throttle-groups.c        | 12 ++++++++++--
>  include/sysemu/block-backend.h |  7 ++-----
>  3 files changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxD3AAoJEJykq7OBq3PI1U8H/jLIIHrgs/xx4DwmZByhTw41
IYWhLl4bV8UL8ayE7oj+1S4iohWSy5hxXgZ9SgQNhqfnOcsVskw1TPqcRq8pY8e2
ZQGSJjbdURBudobR7qpyHAo4lEGyZJJdtesb/Fj9s4c8ZJL7Wrgb0BxrzLFZJeMD
HhXlfSJXl8Xc30Z3yZXc1p+BQynhURG8yD0SA/R8NbICchlmlNM2yxqfLxyVdzr2
5jc+P7TyXXIntaLPoRBl2+c8wu+qkBifcY/2SRjV998RHUU8uIzMXtI5sgE5AgyN
kt/r0Vz+Itg1jnMofKzdCT2bfEUIE/Z13T0JCjVoEGqN42BtZvksVMtWtSDXiew=
=gyx/
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
