Received: from eggs.gnu.org ([209.51.188.92]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhZ-00022g-Mt
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhX-0001I6-QK
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:25 -0500
Date: Thu, 31 Jan 2019 09:50:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190130225045.GE1771@umbus.fritz.box>
References: <20190130014216.98287-1-aik@ozlabs.ru>
	<20190130134303.754a43ab@bahia.lan>
	<ff95d376-1253-a5eb-0a71-02b8b4b76013@redhat.com>
	<20190130175316.198597c9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <20190130175316.198597c9@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] spapr: Drop unused
 parameters from fdt building helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:53:16PM +0100, Greg Kurz wrote:
> On Wed, 30 Jan 2019 17:43:44 +0100
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
>=20
> > Hi Alexey,
> >=20
> > On 1/30/19 1:43 PM, Greg Kurz wrote:
> > > On Wed, 30 Jan 2019 12:42:16 +1100
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >  =20
> > >> spapr_load_rtas() handles now RTAS address and size information in t=
he FDT
> > >> so drop them from spapr_build_fdt().
> > >>
> > >> While we are here, fix a small typo.
> > >>
> > >> Fixes: 2cac78c12ade9 "pseries: Consolidate RTAS loading" =20
> > >=20
> > > One nit. The last rtas_* user in spapr_build_fdt() was removed by the
> > > following hunk:
> > >=20
> > > @@ -949,12 +966,6 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
> > >          }
> > >      }
> > > =20
> > > -    /* RTAS */
> > > -    ret =3D spapr_rtas_device_tree_setup(fdt, rtas_addr, rtas_size);
> > > -    if (ret < 0) {
> > > -        error_report("Couldn't set up RTAS device tree properties");
> > > -    }
> > > -
> > >      /* cpus */
> > >      spapr_populate_cpus_dt_node(fdt, spapr);
> > > =20
> > > from commit:
> > >=20
> > > 3f5dabceba24 "pseries: Consolidate construction of /rtas device tree =
node" =20
> >=20
> > Can you (or David if he agrees) add a line about since when/why it is no
> > more required?
> >=20
>=20
> Commit 3f5dabceba24 (first released in QEMU 2.10) simply moved the FDT co=
de
> for RTAS to some other function, leaving the rtas_addr and rtas_size argu=
ments
> unused in spapr_build_fdt(). This patch is a trivial cleanup really.

Applied to ppc-for-4.0, with the Fixes line adjusted as suggested.

>=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > >  =20
> > >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >=20
> > >> ---
> > >>  hw/ppc/spapr.c | 8 +++-----
> > >>  1 file changed, 3 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >> index a217c7f..fa12723 100644
> > >> --- a/hw/ppc/spapr.c
> > >> +++ b/hw/ppc/spapr.c
> > >> @@ -1225,9 +1225,7 @@ static void spapr_dt_hypervisor(sPAPRMachineSt=
ate *spapr, void *fdt)
> > >>      }
> > >>  }
> > >> =20
> > >> -static void *spapr_build_fdt(sPAPRMachineState *spapr,
> > >> -                             hwaddr rtas_addr,
> > >> -                             hwaddr rtas_size)
> > >> +static void *spapr_build_fdt(sPAPRMachineState *spapr)
> > >>  {
> > >>      MachineState *machine =3D MACHINE(spapr);
> > >>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > >> @@ -1644,14 +1642,14 @@ static void spapr_machine_reset(void)
> > >> =20
> > >>      /*
> > >>       * We place the device tree and RTAS just below either the top =
of the RMA,
> > >> -     * or just below 2GB, whichever is lowere, so that it can be
> > >> +     * or just below 2GB, whichever is lower, so that it can be
> > >>       * processed with 32-bit real mode code if necessary
> > >>       */
> > >>      rtas_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR);
> > >>      rtas_addr =3D rtas_limit - RTAS_MAX_SIZE;
> > >>      fdt_addr =3D rtas_addr - FDT_MAX_SIZE;
> > >> =20
> > >> -    fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > >> +    fdt =3D spapr_build_fdt(spapr);
> > >> =20
> > >>      spapr_load_rtas(spapr, fdt, rtas_addr);
> > >>   =20
> > >=20
> > >  =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSKi0ACgkQbDjKyiDZ
s5K6rRAAmxqmS1YcLk9rRo5keijb1LkXimWfJVmfDgC0CEYYlt1RTpk/mk2TmEfF
MaXq731kT0F0s1a9yKtORFecRm4ZDliy85s1CWLz+KEPzivyiSkpfkJ4wsQo/cSd
40zPAaTsQ/GuJV7AyyvuEPTHP4h33rAR+UMB4BNyNMeIWlnT/2q9XPDE3H0NmkGt
adP/U8nfzAb2JT1g142fCs4l3JKxs9s3pHb/c9DYZk9iI6aiGEL/gbXP6qTDlDqo
/yajCkai9NRI3RkBq8Tr1Vpm7FmJubr4nd76CWL17Uo1w0b4wgPJ8xULcz4YImPR
9RdYbgWKZxjf664FPjvaGc6Ol1YTnZvHvc7ak1Y4jqcYMHDsqEUcboNGrdKCFjKO
TQ8jsHOFoyNsDFific9N0yaep2WMOJluMi3FzRonaOjs8S/gySOiUEiC0gD/k0Fv
dq2MyZMMFXgkBD3A/Dp3+blq9vHwyiLFyRTlYmOsa0LE3VU/I8cS0kbE9oWPh6uK
XICJR64ixRBIL7wpnpOwq6N+FTBM0BfJ9tTw0O4zLMaOfVikp1jOMAWGZPCKde6g
TLE92Fz99ZH39GmfkDBcEtWKNDkzvd6VfygZ6wXYJqbQnS/TQMRH8OsydY3TTFd0
vQpxuUrLhFFM00XpUkagWrm2ZW9zT/B8HgY1mnRCetn36TZA8hM=
=GFn+
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
