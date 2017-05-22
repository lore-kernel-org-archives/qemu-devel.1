Received: from eggs.gnu.org ([2001:4830:134:3::10]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdax-0006Tn-9R
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdaw-0005X5-CJ
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:19 -0400
Date: Mon, 22 May 2017 12:41:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522024118.GK30246@umbus.fritz.box>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-4-git-send-email-bharata@linux.vnet.ibm.com>
	<13948266-7fd2-a752-3546-cb236f87d16d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Content-Disposition: inline
In-Reply-To: <13948266-7fd2-a752-3546-cb236f87d16d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] spapr: Make
 h_register_process_table hcall flags global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2017 at 08:48:42PM +0200, Laurent Vivier wrote:
> On 19/05/2017 07:40, Bharata B Rao wrote:
> > The flags used in h_register_process_table hcall are needed in spapr.c
> > and hence move them to a header file. While doing so, give them
> > slightly specific names.
> >=20
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_hcall.c   | 31 ++++++++++++++-----------------
> >  include/hw/ppc/spapr.h | 10 ++++++++++
> >  2 files changed, 24 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index cea5d99..3915e6f 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -921,13 +921,6 @@ static void spapr_check_setup_free_hpt(sPAPRMachin=
eState *spapr,
> >      return;
> >  }
> > =20
> > -#define FLAGS_MASK              0x01FULL
> > -#define FLAG_MODIFY             0x10
> > -#define FLAG_REGISTER           0x08
> > -#define FLAG_RADIX              0x04
> > -#define FLAG_HASH_PROC_TBL      0x02
> > -#define FLAG_GTSE               0x01
> > -
> ...
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index e581c4a..588872a 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -685,4 +685,14 @@ int spapr_rng_populate_dt(void *fdt);
> > =20
> >  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
> > =20
> > +/*
> > + * Defines for flag value used in H_REGISTER_PROC_TBL hcall.
> > + */
> > +#define SPAPR_PROC_TABLE_MASK        0x01FULL
> > +#define SPAPR_PROC_TABLE_MODIFY      0x10
> > +#define SPAPR_PROC_TABLE_REGISTER    0x08
> > +#define SPAPR_PROC_TABLE_RADIX       0x04
> > +#define SPAPR_PROC_TABLE_HPT_PT      0x02
> > +#define SPAPR_PROC_TABLE_GTSE        0x01
>=20
> I think it should be cleaner if you use 0x1fULL

I agree, but looking at the new version of the final patch, I don't
think this patch will actually be necessary any more.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIk/OAAoJEGw4ysog2bOSiaEP/1H986hEoAFz+sUUp10OcPbP
b+l3X0ULO+bS0dp+HjZ4S5KEp+Lr+Uxaj5L0VfyTIVL79TKILCkR5V3sPetKzMAk
WOWpJ6N12u1L5eq2AG8Y78/taPyDi7JAUbyKNQ3o5EX7WwBlEjAwj4Drlu+Tr9k0
pKmoIDg+EPVZSvE8K8mC4p4tx5Z/hQET0IfV53JGWJm1DZnbmcsSy8HzcNGj+3Ix
oxfrvz5rmU0/RSKy3w0curgExQ2jMr37OLS7KXgURxmaLnUaomfm4N6fR+6rgds/
mr1WJlhGuGTKisxYj/Sv+9GBLSzn0r7PtH/VdQEWBnaqjqDzu3PvTcniFMguilrO
fF4si1HnU/84Ql1tbZuN14SLSWSYHTTO6cCXaItxmE1cd9nAVmvInoqEgjEPvnHJ
3AhkIJcyVLO4ecT4lzAWMXomTqJeURlPlX+ix+lLnEL2W9XsIJAv0Pb5sr4+cqAg
GP9Z4is2f9kQYXA+WWSdB5Aqi60ZEs7Ob30Xv7wSSth53aCuCEm/FG+eafLaUUUS
WSJ0ww/34ruqeVYTqVWf0FsIrE63gMBxIP+bDPmRwfVpKg5L/WHpRmSmxoIHtR8X
+irWwEABs6O+KYgS3OBDk0il31E1p6LvGPf7t9M/hcshcabgkjTt9+l1Zjh1n21A
xGRAOd8rE6V8E8a5k2Z7
=Hezb
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
