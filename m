Received: from eggs.gnu.org ([209.51.188.92]:57848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juZ-00081L-50
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juY-0006xQ-1W
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:35 -0500
Date: Thu, 7 Mar 2019 14:30:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307033013.GD7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 11/27] ppc/pnv: fix logging primitives
 using Ox
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:16AM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Wow, that's a deeply weird starting point.  Applied.

> ---
>  hw/ppc/pnv_lpc.c | 10 +++++-----
>  hw/ppc/pnv_psi.c |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 172a915cfc55..9b18ce55e391 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -294,7 +294,7 @@ static uint64_t lpc_hc_read(void *opaque, hwaddr addr=
, unsigned size)
>          val =3D  lpc->lpc_hc_error_addr;
>          break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: 0x%"
>                        HWADDR_PRIx "\n", addr);
>      }
>      return val;
> @@ -332,7 +332,7 @@ static void lpc_hc_write(void *opaque, hwaddr addr, u=
int64_t val,
>      case LPC_HC_ERROR_ADDRESS:
>          break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: 0x%"
>                        HWADDR_PRIx "\n", addr);
>      }
>  }
> @@ -370,7 +370,7 @@ static uint64_t opb_master_read(void *opaque, hwaddr =
addr, unsigned size)
>          val =3D lpc->opb_irq_input;
>          break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "OPB MASTER Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "OPBM: read on unimplemented register: =
0x%"
>                        HWADDR_PRIx "\n", addr);
>      }
> =20
> @@ -399,8 +399,8 @@ static void opb_master_write(void *opaque, hwaddr add=
r,
>          /* Read only */
>          break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "OPB MASTER Unimplemented register: Ox%"
> -                      HWADDR_PRIx "\n", addr);
> +        qemu_log_mask(LOG_UNIMP, "OPBM: write on unimplemented register:=
 0x%"
> +                      HWADDR_PRIx " val=3D0x%08"PRIx64"\n", addr, val);
>      }
>  }
> =20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 44bc0cbf58cb..c872be0b9c0d 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -323,7 +323,7 @@ static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_=
t offset, bool mmio)
>          val =3D psi->regs[offset];
>          break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "PSI: read at Ox%" PRIx32 "\n", offset);
> +        qemu_log_mask(LOG_UNIMP, "PSI: read at 0x%" PRIx32 "\n", offset);
>      }
>      return val;
>  }
> @@ -382,7 +382,7 @@ static void pnv_psi_reg_write(PnvPsi *psi, uint32_t o=
ffset, uint64_t val,
>          pnv_psi_set_irsn(psi, val);
>          break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "PSI: write at Ox%" PRIx32 "\n", offset=
);
> +        qemu_log_mask(LOG_UNIMP, "PSI: write at 0x%" PRIx32 "\n", offset=
);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAkEUACgkQbDjKyiDZ
s5LWrg/+IqvwB7rF4+vWm8lBmA2FywgsOy/rVYI4SQryI5UiaquXWRDVBo0jfiNC
/I3Rfn8ODCzli0qW2TGJDNtkc1kizc3MsQW8GORfph3vQcRwDonNbROAZyaZhbHm
CTG6h4DajZUdPH0tAOBWKskK70lDY0xVgS0xsgpae+npiR81QHaG3ZZkfIEZFbDR
T2VkLbduMRInClG/jT74yMt2azNNH5aS9obDnbv0oA5fnzBEsiXGL3bMNShtiAW6
ClR9ubv6Rk4oWVvOHteARLLJhC217FunMQZdEZfVsRDJvjJvfjJ02R9eUhY1nNUm
3W8AXo5XYfgkbI1uSw00I2Da9svf8sLcToCNxk3STb1s1KfMyQU7DUsi3llOpQQl
7YPUyMz0kidQSamM6tjsvE1Jj5soJDd/dFcSxswPDdTXsAQf8FTBwNjWRoz62/d3
PO0YV1Y896KNn9JWHiB+PHPcqTtLZ9XWzHXDa1Wwaxw5HzU5DfQ+o23mzmnMpB56
4BIZOeGJiStZ7X4XL5TNu/QkrPGwQx5lQnvm0b+PtZhFguFhp5LDBXqCAUE2ySui
pn2HwzkProTgJOZ8zeIBU0QIVI+bCJJjN+HDP1qfIqQDijhWF11Ij1mLpqMXPckq
PqtRv5tfvvYkxSQG9dg6e4eOE5ZHCnZc4s+FNCPW/kBF6+GMWIQ=
=ciqA
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
