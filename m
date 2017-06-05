Received: from eggs.gnu.org ([2001:4830:134:3::10]:52381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1ph-0001BR-4H
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pf-00038h-WE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:49 -0400
Date: Tue, 6 Jun 2017 09:19:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605231946.GB13397@umbus.fritz.box>
References: <1496677461-22320-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hgh6eN/EXvS46552"
Content-Disposition: inline
In-Reply-To: <1496677461-22320-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: check the return value of
 fd_setprop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--hgh6eN/EXvS46552
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 05:44:21PM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/ppc/pnv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 231ed9735b65..89b6801f67b5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -378,8 +378,9 @@ static void powernv_populate_ipmi_bt(ISADevice *d, vo=
id *fdt, int lpc_off)
>      _FDT(node);
>      g_free(name);
> =20
> -    fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs));
> -    fdt_setprop(fdt, node, "compatible", compatible, sizeof(compatible));
> +    _FDT((fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs))));
> +    _FDT((fdt_setprop(fdt, node, "compatible", compatible,
> +                      sizeof(compatible))));
> =20
>      /* Mark it as reserved to avoid Linux trying to claim it */
>      _FDT((fdt_setprop_string(fdt, node, "status", "reserved")));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hgh6eN/EXvS46552
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNecSAAoJEGw4ysog2bOSZDAQAI8y6YH/+zx6GyuG9FrLfVdz
vKyFFqUDRBOrEXy6hQhmIOEXblxdp0iKyXZZrzN/ZmBIrWA8oSfufjTrnKJoefug
/HVG+VQqmPlEG2kiDCGJddA5qN9kLeadLJXBfwSlaoq/SpFbVLioFuo10n/+/7u7
HHDmMTCYBkZjQGV/wz/FgbYIMwe+MLnVlVgpNoZMwWPzWOMCgd/s2/IIIidWRh7W
ngflsDOKdGCfarnNC7jQ1x08+38ywZ7vf8lKgwyjMkHp2oA3sGkRMgyHXapEU8GI
ajG1geS59Xv2gR8POiRggXlu8Zfa6F1LFgZZt8KT4tKi4TXsbhNAb1LrdrEErxlQ
TwhZOwKTWS53Ta+O66Aj4n5cmYzXv05nqE4N7GsGZXgFY+WTFwQzDorC8t9Ma13r
5EW2ZkFt1/sayx9A7WnlgZVO08h1KCBcq9B1HUCcucE+eYy96Onwx1geV0pBINZw
KWE2+/TBge5aRgmhe+Hh9hVPj9lZtgP7+IpatP6QsnCYFMNqdUYa1oE4P6N3yrw9
4/0g+v0DFB0j1BiJ/YesNAkSxoJbts5bHxsS9ArAxA5ukfYbzCDUbBVXCLycL5L/
NTkWB8sb+gyJUui+vSjF8Qr9/EZcCdARDB3PLqP6ziWD2aUp7uL2QVc49hCUQCac
0MMBCuwkLtVas5nAL/ns
=u33+
-----END PGP SIGNATURE-----

--hgh6eN/EXvS46552--
