Received: from eggs.gnu.org ([2001:4830:134:3::10]:54290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx9-00067R-H2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx6-0001zA-B3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:55 -0400
Date: Wed, 13 Jun 2018 09:38:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612233845.GJ30690@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882288685.114328.8550617676763950480.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Content-Disposition: inline
In-Reply-To: <152882288685.114328.8550617676763950480.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: fix leak in
 h_client_architecture_support()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 07:01:26PM +0200, Greg Kurz wrote:
> If the negotiated compat mode can't be set, but raw mode is supported,
> we decide to ignore the error. An so, we should free it to prevent a
> memory leak.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/spapr_hcall.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 022f6d810182..8b9a4b577fbf 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1547,6 +1547,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>                  error_report_err(local_err);
>                  return H_HARDWARE;
>              }
> +            error_free(local_err);
>              local_err =3D NULL;
>          }
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgWYUACgkQbDjKyiDZ
s5JJ2xAA1cttMq8jyjYTxo/Wc5T4D+g19XEjjjujxMCFprm2aAPVXLlucuO2xNaE
cWM9cQ3bxGNg+KpOO5wAgHwHiT4ZAmworMm+TnNE/xzKXmsvS/gDXnguXOj0dJBJ
3wIxf5363R3Vg0WF4QkyQ0s9tKIgaD/XKX6nD82IVTUJzsawryM2uh2i9Qz1i4X4
QrqlePrlI54qlM+0wTBCt5XlcjzlVEq3pJduzCOSU7Vfu2LXauZob5prbg8sW1l5
g1Cb8WZUFX1Iu0NEPmaBbwKc5JdSKt/hqDE+c/Gke+QaA2ltNUOKTDRdzqwsCjp2
F8cJ7/aUXmSUEsK4Cjp7+f7KBxZTQBx+uppVUBPtliUcWBgwK4WKzDiTCw/XYEEq
3j2pLldnEqQv4BAkvNFOMnFmmLTLCf480bAJPgOKvXEmirkrJNPe09bbpLv03zFH
pH1GGTsofHMgs52BwmzJZvS8RObdNm+9pJOaAsnigeAlwKUs8e6Vww76YkcWiGrZ
nyxKXtCIOL3fuxmgNn5UFpfInZhW2FShMfVls7TEj1UJwuxQDJ7u32ViVMk+jNAb
q4eJpVNSlIgkjWYLsG7RmCrZCcmLNEiSTh2zlOL5wQUZ61V3zzB0Jdwwk4WUYBH9
AB3w1LG+qLQ7xNlKZUWM+Ba5laMds6M1E/H94cKvou5W3YqdR54=
=61NQ
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
