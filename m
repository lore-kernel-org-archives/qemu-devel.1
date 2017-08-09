Received: from eggs.gnu.org ([2001:4830:134:3::10]:55197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfJsO-0004pR-9h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfJsL-000354-6l
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:49:52 -0400
Date: Wed, 9 Aug 2017 15:45:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170809054506.GJ13670@umbus.fritz.box>
References: <20170808175936.28793-1-npiggin@gmail.com>
	<20170809040546.GF13670@umbus.fritz.box>
	<20170809150719.3d0a9cae@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline
In-Reply-To: <20170809150719.3d0a9cae@roar.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: fix unicast H_SIGNAL_SYS_RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 03:07:19PM +1000, Nicholas Piggin wrote:
> On Wed, 9 Aug 2017 14:05:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Aug 09, 2017 at 03:59:36AM +1000, Nicholas Piggin wrote:
> > > Unicast H_SIGNAL_SYS_RESET does not find the target CPU if it
> > > is not the current CPU.
> > >=20
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >=20
> > > Unfortunately this slipped through without my noticing because the
> > > Linux driver for NMI IPIs has a fallback to using regular IPIs, and
> > > because Linux did not make much use of unicasts. A new watchdog
> > > has started using them. After this patch, this function works
> > > properly: =20
> >=20
> > In fact this bug was already fixed in the for-2.11 branch.  If you've
> > hit this for real, I guess it's more important than I realized, so
> > I'll pull it into 2.10 instead.
>=20
> Oh sorry I didn't notice the 2.11 branch fix. Yes please pull it
> into 2.10 if possible.

Already pulled into my ppc-for-2.10 tree, I'm preparing a pull request
at this moment.

>=20
> Thanks,
> Nick
>=20
> >=20
> > >=20
> > > Watchdog CPU:0 detected Hard LOCKUP other CPUS:3
> > > *** Unicast NMI IPI is sent here ***
> > > Watchdog CPU:3 Hard LOCKUP
> > > Modules linked in:
> > > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc3-00305-ge84cf82ae=
73a-dirty #1191
> > > task: c00000001e440000 task.stack: c00000001e480000
> > > NIP: c000000000023800 LR: c00000000000da28 CTR: c000000000626db0
> > > REGS: c00000001ff97d80 TRAP: 0100   Not tainted  (4.13.0-rc3-00305-ge=
84cf82ae73a-dirty)
> > > MSR: 8000000002001033 <SF,VEC,ME,IR,DR,RI,LE>
> > >   CR: 48000224  XER: 20000000
> > > CFAR: c00000000002380c SOFTE: 0=20
> > > GPR00: c00000000000d9cc c00000001e483dc0 c000000000ebd900 00000000000=
7d000=20
> > > GPR04: f000000000078680 c00000001e1a0048 c00000001e1a0048 00000000000=
00001=20
> > > GPR08: 0000000000000000 0000000000075036 00000003d5f633c2 00000000000=
00020=20
> > > GPR12: 0000000000000000 c00000000fd80f00 c00000000000d988 00000000000=
00000=20
> > > GPR16: 0000000000000000 0000000000000000 0000000000000000 00000000000=
00000=20
> > > GPR20: 0000000000000000 0000000000000000 0000000000000000 00000000000=
00000=20
> > > GPR24: 0000000000000000 0000000000000000 0000000000000000 00000000000=
00000=20
> > > GPR28: 0000000000000000 0000000000000000 0000000000000000 00000000000=
00b60=20
> > > NIP [c000000000023800] udelay+0x40/0x60
> > > LR [c00000000000da28] kernel_init+0xa8/0x1b0
> > > Call Trace:
> > > [c00000001e483dc0] [c00000000000d9cc] kernel_init+0x4c/0x1b0 (unrelia=
ble)
> > > [c00000001e483e30] [c00000000000bb1c] ret_from_kernel_thread+0x5c/0xc0
> > > Instruction dump:
> > > 7c6349d2 7c210b78 7d4c42a6 7d2c42a6 7d2a4850 7fa34840 409d0028 480000=
14=20
> > > 60000000 60000000 60000000 60420000 <7d2c42a6> 7d2a4850 7fa34840 419d=
fff4=20
> > >=20
> > >  hw/ppc/spapr_hcall.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 72ea5a8247..f50e979b43 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1432,7 +1432,9 @@ static target_ulong h_signal_sys_reset(PowerPCC=
PU *cpu,
> > >      } else {
> > >          /* Unicast */
> > >          CPU_FOREACH(cs) {
> > > -            if (cpu->cpu_dt_id =3D=3D target) {
> > > +            PowerPCCPU *c =3D POWERPC_CPU(cs);
> > > +
> > > +            if (c->cpu_dt_id =3D=3D target) {
> > >                  run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_=
CPU_NULL);
> > >                  return H_SUCCESS;
> > >              } =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKoWAACgkQbDjKyiDZ
s5IX2hAA4ac1yPkbz4P7dwDCCDKpjjB6NVfV3rjSb19IsmdOOSPrDUaPuJAKdPEf
eKO6+N/SMZfgPuoPQhocu9nuXPgSNnChioWO/K7ft26jeXo5saf+dXoYZk+VzqlV
bx48L/mV2YRUDRCrEBpoD6jtg+zy3NeI9FAZfxuLFpTQRuAt7tuzeN1CykXTCnPE
bU6QOgGB3FJuyqI/Lv7L1dsl2i927XvkjJLIh9PljPXqMy8X3yhvWePDwWUwkDjq
hcJUWmpfdsdt1Ty/rm8uG5U/Hh/sEY18tMEA4GIEkQ2sputLbAJW7+FQzOxIYDGr
7n/ADrToLGTf7dMcZNKQ1cs4ytnxpER/Cl73XrO68SMpYy75KXe8M4nF2SPxbaRC
yAGrDCKGf3Ydej1kVQ4Tq6GkyeCdzEeRPyVTmAsqeDChN511ygSZ03f5zp7VeIFA
wsQeeLTmD1wwW5QobbD8uI9Tb/QpcVlqwoHxI2vapUVjYfIGf3WFm06Qqw8wmXEI
ftgfKPs2QmlnNNQei6poVT0hniMCyELZt6AU95aM8ZXZ0hG0TVkZm2W7mVD9cyBr
s30n9iVT0KOEtb0PJGV4EHRmgsht+AgPwGi8V947uXJu/j4qqyrJaDg5v0VWBAzK
/JXh1li1zu7QTDHnUg/SshabWN7MJf5BWBo0pejpOTDj6ZbjyIA=
=623D
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
