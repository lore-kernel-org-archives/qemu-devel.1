Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fragM-0007Ln-Hv
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 23:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fragH-0006mq-Gx
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 23:16:42 -0400
Date: Mon, 20 Aug 2018 13:16:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180820031620.GA3348@umbus.fritz.box>
References: <20180810053712.6587-1-hpoussin@reactos.org>
	<20180810064154.GE4079@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20180810064154.GE4079@umbus>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: on 40p machine,
 change default firmware to OpenBIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 04:41:54PM +1000, David Gibson wrote:
> On Fri, Aug 10, 2018 at 07:37:12AM +0200, Herv=E9 Poussineau wrote:
> > OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
> > Use it, instead of relying on an unmaintained and very limited firmware.
> >=20
> > Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>=20
> Applied to ppc-for-3.1, thanks.

But I'm afraid I've had to pull it out.  This breaks boot-serial-test,
because the new firmware prints different messages than the old one
did and the testcase isn't looking for them.

I tried fixing it, but ran into complications I didn't have time to
debug.  So I'm afraid this will miss my coming-soon pull request.

You should be able to reproduce the problem with "make check
SPEED=3Dslow", can you fix this up and resubmit.

>=20
> > ---
> >  hw/ppc/prep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > index 3401570d98..1558855247 100644
> > --- a/hw/ppc/prep.c
> > +++ b/hw/ppc/prep.c
> > @@ -736,7 +736,7 @@ static void ibm_40p_init(MachineState *machine)
> >      /* PCI host */
> >      dev =3D qdev_create(NULL, "raven-pcihost");
> >      if (!bios_name) {
> > -        bios_name =3D BIOS_FILENAME;
> > +        bios_name =3D "openbios-ppc";
> >      }
> >      qdev_prop_set_string(dev, "bios-name", bios_name);
> >      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlt6MoEACgkQbDjKyiDZ
s5J4UQ/9E65bJHPjyVnCNsATY9d85RetuEYzUtoifD+1XxQhXNkqyhoNmuZ/GFfe
OoV7RhSOPqF/dbMaCNvorOUvdVoKdIc+kdu6Npqfi9W4aeUQAVS61XdJgmYKvk1y
ZNhkX7MAeZWIoy1eRHBJNM5JQLBlho54RsiRMs5PKWLy363Sjc8KedsR9IeE9y6R
U5dmlzOW7Pg9YdtRtLnjgJ1UFDc/SUemP0es78UQ5ws4WiTZVEU1pajKcW5qtX8n
Z5ANAKKoiYDsCKOCmfOxIICuskd5SbZX2qsTgR05DxyRAAVwaWblLKvZHdwbOIAy
PnYSDLG6OtOuscHj9qJL7JvEKTRV0ML+pqtlwK8Tw/Cu/zAXuHt/uedr4Yq+xVxQ
v24l0TDM2/FdLIhF+e3F5pQcwUF94Eb+2YRG7xNwer3Fq3lJVj2V4kaGRZGAMqGU
wctx1mH4XSuqpo+gZh/whTmEXZhbk5X3r0pAifrhsG9iEOPsqQ7r7SVLtkd4EKc2
HnJ/rOTWgIHSEhmWLfY24A/Yua6RrsYbmXLETY2ZJct/dWoVZM72d2mFQ114Y1XI
iyO+U9cWWplxOAVIbnJuj75aAVjZ6Rvc1xj/Onmfl0L4B+2ofXjUQAOlTcIVUayL
CfO4qp7QEmj9MhwZVLwklgIqZMEUg0rWOyKVXEz8g+o4IJ+GxWs=
=HXFG
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
