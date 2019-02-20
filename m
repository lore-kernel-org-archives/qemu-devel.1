Received: from eggs.gnu.org ([209.51.188.92]:54099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbZ-0005fP-KY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbX-0003fJ-Ab
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:29 -0500
Date: Wed, 20 Feb 2019 14:27:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032755.GK9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059670897.1466090.10843921337591637414.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mHEGYOlXWdrdotU2"
Content-Disposition: inline
In-Reply-To: <155059670897.1466090.10843921337591637414.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/17] spapr: populate PHB DRC entries
 for root DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--mHEGYOlXWdrdotU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:29PM +0100, Greg Kurz wrote:
> From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>=20
> This add entries to the root OF node to advertise our PHBs as being
> DR-capable in accordance with PAPR specification.
>=20
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 96bea7580a3f..fcda17709066 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1365,6 +1365,14 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr)
>          exit(1);
>      }
> =20
> +    if (smc->dr_phb_enabled) {
> +        ret =3D spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_T=
YPE_PHB);
> +        if (ret < 0) {
> +            error_report("Couldn't set up PHB DR device tree properties"=
);
> +            exit(1);
> +        }
> +    }
> +
>      return fdt;
>  }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mHEGYOlXWdrdotU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyTsACgkQbDjKyiDZ
s5Izpw//cnRHUfQE1UZHAw8rsJo9lzAu3D8s7AROc9m/+kZdJt8SKJAlH2vnhlOG
+bmp2PIXU3z5HQ4dg26kYIWbH39DLcHa47gtoQZHoKTRskJauU0hVmdhqVhRPovZ
+ZIQX4lAyW9sHGuJQKkTaq/BtWUJty4/c0xGixv2Dd+P5rbNTmUVEUx5EvgR0Pr4
DATqrHa4tHEhbKaLV69wtbkt9jZpbLL2e6yRP4z2jg7fA8VNC89F2RTWi5PSfx+K
qcc5Zxz+rhkCQczimlHrHoeOqMDwzLMWB3yjwCYF+sqdG7DPEDCICJbzmXEtC4Dd
j9skZqf4q40LsU9isl8sx1jx1guIvK9PMY7z4wmXWP3Qm5ihJZaoZht7z54wdjg0
/7jOxgKS4pU+iDDOWdzebMl4CyyLEfm3ZM4Y+zBmwLty9dwQAAt9qbDYw+IRHeJn
kHBHTfK2+6VEA7LcvZzl1aZ80CcOm97DPfVWq+8S7jus9wBnRV/GIzjoGMCUsGFK
COo8YLpTGAtVAg8Bu7IdLPvY7c+ufkq7ZyuH8RZlf8q8L4ujlcrOdMHMk77I+vFB
+G+cv7D2YSkXj7pPbIiKU1zihhcuufEqgRr5+19xzTu2Gxyx5NnPQ0QQcMWYw4U7
h5yyW/145XAOq0djjGyu2SuGIQvmA26Z9B1O3rdOgmVzR5bu6Mg=
=TTo3
-----END PGP SIGNATURE-----

--mHEGYOlXWdrdotU2--
