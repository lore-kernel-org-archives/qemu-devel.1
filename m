Received: from eggs.gnu.org ([209.51.188.92]:42127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1glN1P-0001bO-8X
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1glN1O-0006Er-6a
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:00:59 -0500
Date: Mon, 21 Jan 2019 09:28:25 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190120202824.GA2423@umbus>
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20190102025904.GH27457@umbus.fritz.box>
	<41c0bc74-a976-93e1-1104-99b191934d89@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <41c0bc74-a976-93e1-1104-99b191934d89@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] target/ppc: remove various endian
 hacks from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 01:25:37PM +0000, Mark Cave-Ayland wrote:
> On 02/01/2019 02:59, David Gibson wrote:
>=20
> > On Fri, Dec 28, 2018 at 01:52:27PM +0000, Mark Cave-Ayland wrote:
> >> >From working on the TCG vector operations patchset, it is apparent th=
at there
> >> are a large number of endian-based hacks in int_helper.c which can be =
removed by
> >> making use of the various Vsr* macros.
> >>
> >> Patch 1 is simple enough, and implements the complete set of Vsr* macr=
os for
> >> both big endian and little endian hosts.
> >>
> >> Patches 2 and 3 rework the vector merge and multiply algorithms so tha=
t they
> >> no longer require the endian-dependent HI_IDX and LO_IDX macros.
> >>
> >> Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX ma=
cros by
> >> replacing the element accesses with their equivalent Vsr* macro instea=
d.
> >>
> >> Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential shif=
t bug
> >> in the ROTRu32 and ROTRu64 macros pointed out by Richard during the re=
view of
> >> v1.
> >>
> >> Finally patch 8 is an inspection-based removal of other HOST_WORDS_BIG=
ENDIAN
> >> hacks in int_helper.c, again replacing accesses with the relevant Vsr*=
 macro
> >> instead.
> >>
> >> Note that there are still some endian hacks left in int_helper.c after=
 this
> >> patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I mac=
ro still
> >> remains in places where the index variable was used for purposes other=
 than
> >> accessing elements within the vector.
> >>
> >> There were also some parts where additional conversion could be done, =
but I
> >> wasn't confident enough to make the change without access to PPC64 tes=
t images
> >> or real big-endian host hardware.
> >=20
> > Applied to ppc-for-4.0, thanks.
>=20
> Just checking your ppc-for-4.0 branch on github, I can't see where this h=
as been
> applied? Is it queued in a local branch still?

Yeah, probably.  I've pushed it out now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxE2eYACgkQbDjKyiDZ
s5LruQ/+LhMCJQ9IY88bAztKeZ6fNOUi6NPhMKs8yX2lLr7u29l5ZD5/7O6d6WAA
LIyRP7W7pWEvtvyIcc4b6GLjfnVJcuBTP6qjo+V4ClZFZP9p9RotEEUWRu2UDWRv
dVrHYCsR45HL2axMS7oJ7bTe5HiFc8dJPzFlBs2ARb1w41JC3pUKLkX4w44+SJ26
GwRxWwBJOx6Vh2/a4cXoW6FENU06pnWbMe7O2ecJWe53UcdGetAHIuHj8jrFvBTP
e00l/M1QkVxPZEQR2Ece/MFqbTmi3nbfFnyiab5UX5gcSP9WpNjKNlsXdFK+KKwT
+I66ITERa4aavTkZRDM6Bhy+U/okKG/GO42cU1uSPUnai9vM92hnKWzuQ5PK3kqJ
1d97Nsmelp9ymhuudnC1omIDVL0Opn8LIrdYhWF5i7m5bcv6MIBtT1JCQhV42tlW
Uj33fL59egmiWgfy+Up4j7k/5TjtW1q51NkbS9SMC7AnsO93m+PpyzJBE7LoYx+K
mJGf5dSenVy0k/dVLNtj5qBbN1IZvIRUQWdrYbm5jE1Pmcn+B4SF4FK7bZC9Ge84
B6GZ+/ARQu5Fz3LbyZ2sitUte8jqlLKbHsDEn/kzjWT2BvqKaon304kxzhfznIKz
RLSGrJow/u7r8m32xt+Cnz7/9aH4taD++k1LDGVAKbPLm+kHxbM=
=vCmJ
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
