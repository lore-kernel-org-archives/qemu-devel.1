Received: from eggs.gnu.org ([2001:4830:134:3::10]:33662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caY3e-00012e-Bl
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caY3b-00059B-9D
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:25:30 -0500
Date: Mon, 6 Feb 2017 10:39:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170205233938.GA17644@umbus.fritz.box>
References: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
	<148615989046.33.5463181790096988546@eba24e3a0d7f>
	<20170204012937.GA7402@pacoca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20170204012937.GA7402@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] POWER9 TCG enablements -
 part 13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, famz@redhat.com


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 11:29:37PM -0200, joserz@linux.vnet.ibm.com wrote:
> On Fri, Feb 03, 2017 at 02:11:31PM -0800, no-reply@patchew.org wrote:
> > Hi,
> >=20
> > Your series seems to have some coding style problems. See output below =
for
> > more information:
> >=20
> > Type: series
> > Subject: [Qemu-devel] [PATCH 0/4] POWER9 TCG enablements - part 13
> > Message-id: 1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> >=20
> > BASE=3Dbase
> > n=3D1
> > total=3D$(git log --oneline $BASE.. | wc -l)
> > failed=3D0
> >=20
> > # Useful git options
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> >=20
> > commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> > for c in $commits; do
> >     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
> >     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailb=
ack -; then
> >         failed=3D1
> >         echo
> >     fi
> >     n=3D$((n+1))
> > done
> >=20
> > exit $failed
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > From https://github.com/patchew-project/qemu
> >  * [new tag]         patchew/1486159277-25949-1-git-send-email-joserz@l=
inux.vnet.ibm.com -> patchew/1486159277-25949-1-git-send-email-joserz@linux=
=2Evnet.ibm.com
> >  - [tag update]      patchew/20170203120254.15062-1-berrange@redhat.com=
 -> patchew/20170203120254.15062-1-berrange@redhat.com
> > Switched to a new branch 'test'
> > 52f618a ppc: implement xssubqp instruction
> > f7dfdbf ppc: implement xssqrtqp instruction
> > 4d895a4 ppc: implement xsrqpxp instruction
> > 5d49c07 ppc: implement xsrqpi[x] instruction
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > Checking PATCH 1/4: ppc: implement xsrqpi[x] instruction...
> > ERROR: Macros with complex values should be enclosed in parenthesis
> > #125: FILE: target/ppc/translate/vsx-ops.inc.c:106:
> > +#define GEN_VSX_Z23FORM_300(name, opc2, opc3, opc4, inval) \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x00, opc4 | 0x0, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x08, opc4 | 0x0, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x0, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x0, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x00, opc4 | 0x1, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x08, opc4 | 0x1, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x1, inval), \
> > +GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
> >=20
>=20
> I tried to improve it but this style is used everywhere

Yeah, that's ok.  These instruction generation macros trigger known
false positives in checkpatch.  I think it thinks these are macro
definitions, rather than macro invocations.

>=20
> > total: 1 errors, 0 warnings, 103 lines checked
> >=20
> > Your patch has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> >=20
> > Checking PATCH 2/4: ppc: implement xsrqpxp instruction...
> > Checking PATCH 3/4: ppc: implement xssqrtqp instruction...
> > Checking PATCH 4/4: ppc: implement xssubqp instruction...
> > =3D=3D=3D OUTPUT END =3D=3D=3D
> >=20
> > Test command exited with code: 1
> >=20
> >=20
> > ---
> > Email generated automatically by Patchew [http://patchew.org/].
> > Please send your feedback to patchew-devel@freelists.org
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYl7e4AAoJEGw4ysog2bOSH/QQAKjcYGuSMScy82IgGNguPw0g
Oh3ph1PbMv2j6hWPp1pXWn8pjkxi0CPiTVicYfNE0G0c7ahtidsBZQcjOPHiSlM1
GN7ev3zttYqY1xy5BdY1oAn4CBgRhEggIRiQWxKCoU5g5vkay/lR1hvEk8QIAXkd
cNvdfh8FwnTzHmxlP5OExocLbRG+/HFYSsu6kQKAXXYiOPD4AVBz5INgedGkURmE
vYW0PWEncQXF5G/E6nNeCmSCIQ47bbRGc/1dazzvSlQxjKAdxJCnDRiT8afeuVsW
agVet7urTquJo+zcPJlENk11QGtJdaCA7kPMYatan0rbSUztyDfh+JMQfpfLWhtW
NV+SUGUnH4CCUAdHdIVskKTnrAc5EJb08udkxCDJeSV/SzxLKCm9GWmyqvXU3iUf
AYJpM1YJDIjqrPY8pExgcs6t38QRVB85gChZoXhhEJVZmNUV3DQhIIYm/J7C4mqy
/0LW354PAm5PGCsb3UzzEmoluJcpQ9ptgBXlcDFgaEV92XfCzHuX2CD/WPkZVAb9
X2MkfvxEEZCqpd7TAEHKJwrVdozVPqYauuUxiBfecnBZc3y7abdeXK+Rv5xjk63y
ctiiMyudmfqC5XIXBPES+Xaz9FYrkWb6l4uoJS0ag+LFff+qMk4cA29+ppcuDQho
9oIuLxPngIHFbTBj7Bqb
=iv2u
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
