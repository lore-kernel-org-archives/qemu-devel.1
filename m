Received: from eggs.gnu.org ([2001:4830:134:3::10]:57798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbk-0004Ce-Fy
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbh-00027r-BP
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:24 -0400
Date: Sat, 1 Jul 2017 17:51:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170701075113.GJ13989@umbus.fritz.box>
References: <149881713243.18888.18140083803237379387.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
In-Reply-To: <149881713243.18888.18140083803237379387.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr: refresh "platform-specific" hcalls
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 12:05:32PM +0200, Greg Kurz wrote:
> We have more of these since the addition of KVMPPC_H_LOGICAL_MEMOP in 201=
2.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
>  include/hw/ppc/spapr.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a66bbac35242..1826cc4fd696 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -377,9 +377,8 @@ struct sPAPRMachineState {
>   * as well.
>   *
>   * We also need some hcalls which are specific to qemu / KVM-on-POWER.
> - * So far we just need one for H_RTAS, but in future we'll need more
> - * for extensions like virtio.  We put those into the 0xf000-0xfffc
> - * range which is reserved by PAPR for "platform-specific" hcalls.
> + * We put those into the 0xf000-0xfffc range which is reserved by PAPR
> + * for "platform-specific" hcalls.
>   */
>  #define KVMPPC_HCALL_BASE       0xf000
>  #define KVMPPC_H_RTAS           (KVMPPC_HCALL_BASE + 0x0)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZV1RxAAoJEGw4ysog2bOSn6cQANScSdoTxBePzT1CwZYweePZ
6NRZxjHNh1XQr0uZtq4aBUO+pvqSS3neapd01ZEG9egGJV4NWmcjwCcKp2jfZkn6
cUuHkUBQBRkNxBu2dH0/urzviIeXPBCaeekeqpz93/K2/Wzjc342ebOTGYaTxQ3B
Hd3BJf9JxvfYAAad67eNTJChuoxeBAwqnp5NjYgkdQk5o67NFTuGKnLLaz7uQJua
wZWdnZ36w3U4OtHJi3GxwCIbmQqvuntE8jndNiw/BLS1KyjDj4b9E5C+MJrJjUVo
yeQpEZwcP78xEwzXeKPKKHYEsLho8mREYBC+doROo1dfs4dwBNN4iHnI5DesIXTk
Nxq9CfHCiiFaltFcTGbP5ea9ouhUc5XWYcop/GQtd55G3KqRqXHZyiSz8uQZX8FJ
YX0IDjgYcJPZNtpBCjdlK+pGRRR0OW/6fECCImniuXYfFF6NwpKU4eqWGjv+vGMS
VpR6HPe53HZ6uICQ/y0hcmhU76zXAr/jFL5+w+DNDGvV/odhwVvglEolktX/I7l+
uyy93hN5bjJPUl3ateR5KOBINRL3X0JzlRwlNP4DQP1gyWTAxPqqExx12H1ccFml
nkCJKfTVT6tLPVlh6qxP7G9MQRcTwJMujoHeH2MsYCliJhiGESpgPUDTEEXW4Yv6
D9Zm0Q9avQIMBlsxfo4s
=untr
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--
