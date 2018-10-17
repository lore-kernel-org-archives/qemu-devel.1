Received: from eggs.gnu.org ([2001:4830:134:3::10]:52599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gCbW4-0002Fi-N0
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 22:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gCbW3-0002Nr-O8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 22:24:56 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gCbW2-0002GC-D1
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 22:24:55 -0400
Date: Wed, 17 Oct 2018 11:34:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181017003415.GK16167@umbus.fritz.box>
References: <20180727123112.13707-1-dgilbert@redhat.com>
	<d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
	<20180727134453.GB2498@work-vm>
	<c8608e2e-35da-d095-193a-626d0d47c036@ilande.co.uk>
	<20180727151412.GC2498@work-vm> <20181016113044.GE2426@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <20181016113044.GE2426@work-vm>
Subject: Re: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, lvivier@redhat.com, qemu-devel@nongnu.org, agraf@suse.de


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:30:45PM +0100, Dr. David Alan Gilbert wrote:
>=20
> I noticed this hadn't got merged - who wants it?

I think that's one for my tree, but I'm afraid I completely missed it
before.  It's generally best to CC me on ppc related patches,
otherwise I'm likely to lose them in the flood of qemu-devel.

Anyway, I dug it out of my archives and applied.

>=20
> Dave
>=20
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > * Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> > > On 27/07/18 14:44, Dr. David Alan Gilbert wrote:
> > >=20
> > > > * Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> > > > > On 27/07/18 13:31, Dr. David Alan Gilbert (git) wrote:
> > > > >=20
> > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > >=20
> > > > > > Fix missing terminator in VMStateDescription
> > > > > >=20
> > > > > > Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
> > > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > > ---
> > > > > >    hw/misc/macio/pmu.c | 1 +
> > > > > >    1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> > > > > > index e246b0fd41..27dfaf8a74 100644
> > > > > > --- a/hw/misc/macio/pmu.c
> > > > > > +++ b/hw/misc/macio/pmu.c
> > > > > > @@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu=
_adb =3D {
> > > > > >            VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
> > > > > >            VMSTATE_UINT8(adb_reply_size, PMUState),
> > > > > >            VMSTATE_BUFFER(adb_reply, PMUState),
> > > > > > +        VMSTATE_END_OF_LIST()
> > > > > >        }
> > > > > >    };
> > > > >=20
> > > > > Gah, yes indeed it certainly looks like I missed this whilst work=
ing on the
> > > > > PMU code :(
> > > > >=20
> > > > > Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > >=20
> > > > > Just out of interest does a savevm/loadvm migration still succeed=
 once this
> > > > > has been added?
> > > >=20
> > > > Have you got a suggested command line to test it with?
> > >=20
> > > I'm effectively AFK until tomorrow now, but just quickly:
> > >=20
> > > $ ./qemu-system-ppc -M mac99,via=3Dpmu
> > >=20
> > > Note that PMU support is new for 3.0 so there shouldn't be any backwa=
rd
> > > compatibility issue here.
> >=20
> > [root@virtlab414 try-64]# ./ppc-softmmu/qemu-system-ppc -M mac99,via=3D=
pmu -nographic /home/vms/dummy1.qcow2=20
> > QEMU 2.12.50 monitor - type 'help' for more information
> > (qemu) ss>> et_property: NULL phandle
> >=20
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> OpenBIOS 1.1 [Jun 18 2018 18:20]
> > >> Configuration device id QEMU version 1 machine id 1
> > >> CPUs: 1
> > >> Memory: 128M
> > >> UUID: 00000000-0000-0000-0000-000000000000
> > >> CPU type PowerPC,G4
> > milliseconds isn't unique.
> > saWelcome to OpenBIOS v1.1 built on Jun 18 2018 18:20
> > Trying hd:,\\:tbxi...
> > savTrying hd:,\ppc\bootinfo.txt...
> > Trying hd:,%BOOT...
> > saveNo valid state has been set by load or init-program
> >=20
> >=20
> > (qemu)=20
> >   ok
> > 0 >   ok
> > 0 > (qemu)=20
> > (qemu) savevm "frob"
> > (qemu) loadvm "frob"
> > (qemu)=20
> >   ok
> > 0 > 2 2 + . 4  ok
> >=20
> > Looks OK to me.
> >=20
> > Dave
> >=20
> > >=20
> > > ATB,
> > >=20
> > > Mark.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGg4QACgkQbDjKyiDZ
s5JamRAA4yd5OBWx8QXoq5hJFu+IfZ+N7s/1PP+ydCFVOr741RITRukTICm0ld27
A8YEEWoWcSP8PslMdQyIzIlC+ih2OosgwqGWqBrsF4laqTzMlN2TKzO4tVuCC632
Hk45wGlPV+2lLgzVD2mSTuepHv06ZDeZfkK4WIAXQF/yrVD+NAZ3nnpmlcKjgW2G
1RILqLTojR4SEV9omNsnsNrT49pA5dyrncNU4WnKQQlDCRvna9Cd956lPHwxXJN0
OzicnvufOpwpq9x5drNh92SpsVaRE11PWGV7tjHW3IGtAFjb9iLkxtqzA8+3dKXF
3fcQ++z6cspeJnstSMi2kdvtH3PsjGHLRi209KSD91M5VgScjc1lxOzHjKeL3xjV
HvY9K5k+ssN1UDw17GWeaHPf/QVV55N+dTNdjU8fcrtn3RhLvlk4Mi3sFA2qI2vy
44h5oGvGkeKeykh3I+QzIjKjy9q5rVoFxmkKto8KBXqeLJHaYfxhlroL5Kk/xSlk
9qRcxBbXJAHTLFwD4W5rJEcBVA9OdDTnRkC4MccWC84S380/Fs2ijFY0csu2nLl2
kBuWbJsDoZR/cq5N80MH+qbWUtD51s9p9Xvpu/yMliaQeJdfvxW4wUHtGtppLqDd
l95t9rY7TMcB6zWknn/IlslQyGvA1MFf+/Xi7yfal/PjNz+wzvM=
=XUf3
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
