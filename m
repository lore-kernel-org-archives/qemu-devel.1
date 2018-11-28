Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRqWd-0002q2-Nt
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRqWa-00036b-Jp
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:28:31 -0500
Date: Wed, 28 Nov 2018 13:57:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128025714.GW2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sL7C0a98p/u5aVah"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 12/36] spapr: initialize VSMT before
 initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--sL7C0a98p/u5aVah
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:05AM +0100, C=E9dric Le Goater wrote:
> We will need to use xics_max_server_number() to create the sPAPRXive
> object modeling the interrupt controller of the machine which is
> created before the CPUs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

My only concern here is that this moves the spapr_set_vsmt_mode()
before some of the sanity checks in spapr_init_cpus().  Are we certain
there are no edge cases that could cause badness?

> ---
>  hw/ppc/spapr.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a175bf2..50cb9f9f4a02 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
>          boot_cores_nr =3D possible_cpus->len;
>      }
> =20
> -    /* VSMT must be set in order to be able to compute VCPU ids, ie to
> -     * call xics_max_server_number() or spapr_vcpu_id().
> -     */
> -    spapr_set_vsmt_mode(spapr, &error_fatal);
> -
>      if (smc->pre_2_10_has_unused_icps) {
>          int i;
> =20
> @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      /* Setup a load limit for the ramdisk leaving room for SLOF and FDT =
*/
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> =20
> +    /* VSMT must be set in order to be able to compute VCPU ids, ie to
> +     * call xics_max_server_number() or spapr_vcpu_id().
> +     */
> +    spapr_set_vsmt_mode(spapr, &error_fatal);
> +
>      /* Set up Interrupt Controller before we create the VCPUs */
>      smc->irq->init(spapr, &error_fatal);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sL7C0a98p/u5aVah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv+BAcACgkQbDjKyiDZ
s5IrYBAA3hM6JppEOhZ6OxVmMXH035/2VaPVVzH1uOZfr/S8aG7XZmsKOGSB5zor
4Wio9m1Nv0956m+4GpXT431IBE9EFNuvMGze1WLjiCNrVUNU4ArzZpgy/khK6OyK
4HTDXKbD4HXjtjNavc8VMAtcTwQexM5C+uELE3Dq3scJtokhi0pwfnLYx76ttcXQ
nPev8Jh7KqyPXEXzKPKpC4UvgThAFEL/SN3aapH7tbcbHbFAMmxEbPYpHclysvyT
FfzfU1Y04Nri6TYHUDIpozRxhPjRvT8WyHDnWj7aSe21ZmtoPdNb5xLniYa2YA25
USM3r426THqTnoCyUzYdyGSFVafgAExN73SZFS75kIM5r7lnaFBTMM4jFSoX4TMB
mNBF3/RVnEUz5aAZZq/0li2QhzFjAKdfwslbqNmx77YHNHEnc1Sz1D4xfjCDB+A2
XF63PJJAOtgbpQ6hqkStEipSPQbaYlvR/LnlNXztdJau/kh6IAhB17iWTt9Hoovn
/hI2HH7emLSuVdqGzjekKhpZMJv0ODsIH7G0A+UPzXaFGHF7gNFLEhmi8GWMnApI
4rWHYexxWkYQ6rLygtGt6ILVLXSjTbK0m3Lu4nw4julpDDMsSHXghrZconPlLz8d
JVexlU1VIKWhLmi+gLe6mLgAXd3bkYKAhohK8RCpinGmV0JMoqU=
=6uUo
-----END PGP SIGNATURE-----

--sL7C0a98p/u5aVah--
