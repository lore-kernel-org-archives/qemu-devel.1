Received: from eggs.gnu.org ([2001:4830:134:3::10]:55529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds7BY-0003hL-VD
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds7BY-0003rx-1d
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:54:33 -0400
Date: Wed, 13 Sep 2017 22:54:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913125404.GE3972@umbus.fritz.box>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
	<20170913053533.GF7550@umbus.fritz.box>
	<20170913124456.GB2096@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <20170913124456.GB2096@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 01:44:57PM +0100, Dr. David Alan Gilbert wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > On Tue, Sep 12, 2017 at 04:01:47PM +0200, Laurent Vivier wrote:
> > > Running QEMU with
> > >     qemu-system-ppc64 -M none -nographic -m 256
> > > and executing
> > >     dump-guest-memory /dev/null 0 8192
> > > results in segfault
> > >=20
> > > Fix by checking if we have CPU, and exit with
> > > error if there is no CPU:
> > >=20
> > >     (qemu) dump-guest-memory /dev/null
> > >     this feature or command is not currently supported
> > >=20
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >=20
> > Applied to ppc-for-2.11.  I'm not really sure what to do with the rest
> > of the series though.
>=20
> I can take the whole set through HMP.

Great, thanks.

>=20
> Dave
>=20
> > > ---
> > >  target/ppc/arch_dump.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> > > index 8e9397aa58..95b9ab6f29 100644
> > > --- a/target/ppc/arch_dump.c
> > > +++ b/target/ppc/arch_dump.c
> > > @@ -224,8 +224,15 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
> > >  int cpu_get_dump_info(ArchDumpInfo *info,
> > >                        const struct GuestPhysBlockList *guest_phys_bl=
ocks)
> > >  {
> > > -    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > > -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > +    PowerPCCPU *cpu;
> > > +    PowerPCCPUClass *pcc;
> > > +
> > > +    if (first_cpu =3D=3D NULL) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    cpu =3D POWERPC_CPU(first_cpu);
> > > +    pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > =20
> > >      info->d_machine =3D PPC_ELF_MACHINE;
> > >      info->d_class =3D ELFCLASS;
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm5KmwACgkQbDjKyiDZ
s5IZzhAAhk3qwxJmwrlO68yggZAs7JP7bQc40GOiBRXgCVMADTWwO0Zjym5/2kLm
szuGxwLaGkUM+I9cLYqdxERV3C6nRMCe2UDtrQx8foXyFaygT1V+DL5Gt2vmT7iy
z6ZTCstyS0wCWWg2VP0x0ZsPzuoJbnRd4xIvQhI7IyVQFkJrm/5TTftjoHf/xD54
52xG2P2c5UVxUjQ5UPwTNCIE9m+foP8ipX0bQLqWdnHhVuBygDSlNKFeiNMFw3NN
625wulMzb7pet8rFoIC4AVtXD8NlRYxrRlSmBbjjsoRf7fOEtDrhrW0jUEeseJzt
ZZBF+qzqaZ8qeH3VeISLQH5ja3Vq76yw9QyJo2QaWurSYaa3PhXRQBNBAlvi0Y9u
cXL90PibW+5Zu8oXiyQRg//SxOYegLTDtA5jjQODjEBZOPEJRZZ31pKE2PnzPk4u
BruMOd641ewVQFTRTz7Q7OCHZW33GnqpYaoXHwdytz/YHoY0HcvMJ7aLCjWt72AA
dcyRCDzSQDCcB6JE0Hlm8igIg+mw435X0QHIygdpoSm0qUPd8RGFgSQHcgtkoh48
U259lfDP3Eu8yvQ18ogbmyQ9kNciRHYYdnjd1Mf3ZdCLuYuSiwPZ1wOZ5xJjOqD7
OBwO3ZqGSMr1M3M9lABUjNEXeaXnYrWYFjIT4imbm5NVPLEk1V0=
=+XJF
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
