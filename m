Received: from eggs.gnu.org ([2001:4830:134:3::10]:40888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6OB-0002Zf-1d
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6O7-00081V-OT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:08:11 -0500
Date: Tue, 19 Dec 2017 11:35:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219003508.GE4786@umbus.fritz.box>
References: <20171218092024.21645-1-david@gibson.dropbear.id.au>
	<20171218092024.21645-3-david@gibson.dropbear.id.au>
	<20171218121041.0377a5c9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <20171218121041.0377a5c9@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/6] spapr: Treat Hardware Transactional
 Memory (HTM) as an optional capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: surajjs@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, abologna@redhat.com


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 12:10:41PM +0100, Greg Kurz wrote:
> On Mon, 18 Dec 2017 20:20:20 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This adds an spapr capability bit for Hardware Transactional Memory.  I=
t is
> > enabled by default for pseries-2.11 and earlier machine types. with POW=
ER8
> > or later CPUs (as it must be, since earlier qemu versions would implici=
tly
> > allow it).  However it is disabled by default for the latest pseries-2.=
12
> > machine type.
> >=20
> > This means that with the latest machine type, HTM will not be available,
> > regardless of CPU, unless it is explicitly enabled on the command line.
> > That change is made on the basis that:
> >=20
> >  * This way running with -M pseries,accel=3Dtcg will start with whateve=
r cpu
> >    and will provide the same guest visible model as with accel=3Dkvm.
> >      - More specifically, this means existing make check tests don't ha=
ve
> >        to be modified to use cap-htm=3Doff in order to run with TCG
> >=20
> >  * We hope to add a new "HTM without suspend" feature in the not too
> >    distant future which could work on both POWER8 and POWER9 cpus, and
> >    could be enabled by default.
> >=20
> >  * Best guesses suggest that future POWER cpus may well only support the
> >    HTM-without-suspend model, not the (frankly, horribly overcomplicate=
d)
> >    POWER8 style HTM with suspend.
> >=20
> >  * Anecdotal evidence suggests problems with HTM being enabled when it
> >    wasn't wanted are more common than being missing when it was.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c         | 15 ++++++++++-----
> >  hw/ppc/spapr_caps.c    | 29 ++++++++++++++++++++++++++++-
> >  include/hw/ppc/spapr.h |  3 +++
> >  3 files changed, 41 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d472baef8d..f8fee8ebcf 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -253,7 +253,9 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int o=
ffset, PowerPCCPU *cpu)
> >  }
> > =20
> >  /* Populate the "ibm,pa-features" property */
> > -static void spapr_populate_pa_features(PowerPCCPU *cpu, void *fdt, int=
 offset,
> > +static void spapr_populate_pa_features(sPAPRMachineState *spapr,
>=20
> While here, maybe you could rename spapr_populate_pa_features() to
> spapr_dt_pa_features() ?
>=20
> But anyway, this isn't really the point of this series, so:

Yeah, I don't think that's really in scope for this series.

> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4XrcACgkQbDjKyiDZ
s5KU1hAAqsetPfflzXAi0kGUbwY8bHFejhdMwe7zMXzxXQl5lVd5UmFXSSHex0+y
PKmHzpuFaUxh+4+HW4go/UXrshgS4GdgI+jDWB9NSIcFMZp+jm87eqWSukrxwvUF
ZAZltCpYVpDjleWRNBL4LWcGq5REfUEEMGe+uUXK9NPA1Yuw+FJoWa7IklN2gMVk
xAVdp/yY+G2/8Hbf45oBlhIoucFpdRqzVs8V010P4nH8gf51RlTQVIlRR4nVbUTI
gscZQ8iiStmOBozyp4ZbCRtFKIExWUVQ2kXrLyDDtbh1wzGWxZzdAHCAuXTLzXde
c1u3A8jRVLndA18comBayUnnxxxkuZWkljPgTPPCYF8dz14hgxSzweKZWqwryyGv
qtwv9PhnPGg4GB4+RY0aD7k5xDqCe2J/ciBDJz2xtEt+b2A4QBd6MIJoH7bt+Rqu
MGzwUavV47koBBtQKwWFaUCOK9p+YtOgMXl6TLPCDYqRZqUhyNxsROU6e0WUPc+R
HldevIbEnfCnkzKzSXpjCGSmSjvF9tKeAeNq8me9IjRAFo6i1SMHpqWX74wHpX5o
Rc+hXAEi0pU29JGMlzNvQdeoGHJjjdA+OoBWwGLg3cUCVd+KaBqHnrc9l+b+vYz0
ZJwY2EU5zKHQmcSbDm5i+rnM5AcKkTkZK3jKaX4q+/kniG57VyY=
=4WNH
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
