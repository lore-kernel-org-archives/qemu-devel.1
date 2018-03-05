Received: from eggs.gnu.org ([2001:4830:134:3::10]:35579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5I-00010B-8u
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5H-0003hx-41
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:36 -0500
Date: Mon, 5 Mar 2018 12:27:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305012755.GC2650@umbus.fritz.box>
References: <20180302214826.1671E7456D8@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <20180302214826.1671E7456D8@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] ppc440_uc: Fix unintialized variable
 warning with older gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 10:43:23PM +0100, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied, and rebased so we don't get bisection breakage.

> ---
>  hw/ppc/ppc440_uc.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 4e2523a..976ab2b 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -1050,6 +1050,9 @@ static void ppc460ex_pcie_realize(DeviceState *dev,=
 Error **errp)
>      case DCRN_PCIE1_BASE:
>          id =3D 1;
>          break;
> +    default:
> +        error_setg(errp, "invalid PCIe DCRN base");
> +        return;
>      }
>      snprintf(buf, sizeof(buf), "pcie%d-io", id);
>      memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqcnRsACgkQbDjKyiDZ
s5K9Ug/9FRGtfzGNQnZza6fZ1+Upz+Zzws0WHjfNjLJBAvwAXptbkU+aqHxbdKt7
AYfraYKM0bmZIgXLp1AnpA91cJ411ZZtebRES7XrP/uDBM6SabOhBcwAMVdgZd92
5KtC5tO9lAwa4tm+AHy/VjClSSQKYZuOaHUOeC6bxgzi7qMuqLYv7AjErVayA/Sl
t/1Lb5pWaPkSoOWN5C7NEzEhuk3yZH6Xu5whyNiFhcuwQQgCq2Ianb2iR9HT/g5b
ksLXwPL1b1aeaWVBw4q8SM8vvDPabwa5gzI+Dhktw1Mwih5wHTex2jhxXeEZw1i/
rWNmOevky/Shoi1Kh4eX2ImiiT+HeWOpVbJrFtbEVljz96kvfcIfoN+WkF8ywUV6
rik5B4EAb8bnOF0he6JSNltsyWRVkp2mOdLijlBvFUOEatxlEViHYnKdtO89AMFg
MurA/YMEth5DAfYSD+ZrPWMoX9Qz2FY6nBPPTCb6/2sLyomieonv67G1hRZ+TdYW
9X3Q2Ym9zRDgXZO9sEmestGg8DzUf3/+h52Kcl96Pk/TP6OobK0faQPjAB7Yk2FZ
xCCzXxHPe5BA08Al8660f6f7+xVv1IvDc78u1VAZbW1cEcL4xu+Ccc763uCp1/Rp
on7YNl79ONgkBqnvtZQHZDCFr4nHZ6bQNs5VUDRwpks6R059GLg=
=K2Jd
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
