Received: from eggs.gnu.org ([2001:4830:134:3::10]:57865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e85FA-0001sU-RE
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e85F9-0000EZ-R2
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:04:16 -0400
Date: Fri, 27 Oct 2017 16:03:59 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171027140359.GD7115@umbus>
References: <1508493233-1166-1-git-send-email-thuth@redhat.com>
	<1508748555.16488.4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <1508748555.16488.4.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/display/sm501: Fix comment in
 sm501_sysbus_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2017 at 10:49:15AM +0200, Gerd Hoffmann wrote:
> On Fri, 2017-10-20 at 11:53 +0200, Thomas Huth wrote:
> > The "cannot_instantiate_with_device_add_yet" flag has been renamed
> > to "user_creatable" a while ago.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> > =A0hw/display/sm501.c | 2 +-
> > =A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 6eddac9..7f18224 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -1758,7 +1758,7 @@ static void sm501_sysbus_class_init(ObjectClass
> > *klass, void *data)
> > =A0=A0=A0=A0=A0dc->reset =3D sm501_reset_sysbus;
> > =A0=A0=A0=A0=A0dc->vmsd =3D &vmstate_sm501_sysbus;
> > =A0=A0=A0=A0=A0/* Note: pointer property "chr-state" may remain null, t=
hus
> > -=A0=A0=A0=A0=A0* no need for dc->cannot_instantiate_with_device_add_ye=
t =3D
> > true;
> > +=A0=A0=A0=A0=A0* no need for dc->user_creatable =3D false;
> > =A0=A0=A0=A0=A0=A0*/
> > =A0}
> > =A0
>=20
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Applied to ppc-for-2.11, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnzPM8ACgkQbDjKyiDZ
s5Kwiw/9FVAGVJXIDtxpsw2T/6v4hLOupXk7KNLbOBG391y7ujOvwiHeYPkDhFB2
JYnGuLp50IxI9LpGETTltLVtPO+xO27k7ugaziMscRZmm0+9zdlJkAM2o7Anf3iC
qOb7fFILyOfxVTZRfktxY2FN4NfFRTd7O18WJC8SP9/nsYLrRIg1b1TJD2Fgx95d
IQkQLg9b0Ufa2gpjJGYyhAZAN/NgwLC1MMWt7dDBVIWc+GlKRSoUZE8cgifW/mAy
hW7TFkEwIpkb48xbOIkyqjM/gnOCrDPVv0nqiD/8Ny/eb2kOvshwNnESZevPhbkr
Cmi66a2uUVznbvHxjigY5yzcn5j40S29G0jdbmDzk6vhSQDKMwS6TsOAxj3B6KIh
nL3yGEEGf87//z02nJl8Ls/RmNuccNNMSCQseqJoADUNVs6OmdhpFT/ZrDd0e81/
eJjl5t4jV2tLy0fQa1UK05/ArtK33vlZ5QOWpCghOyhuCmBoGA07IiuM38gvyyvq
prlpqJ27h5oBuR+xylxLEYLEY/0bBOk1BvSlGT4c02LX/SsMR4mMcR+6wIB0Di7V
BLn8D8JAf1rfy9QpWJkLo76YyvtwAOH0hl5D44V4bZLOk/ggYRTdId2h9JxB+VDu
Q46H3vpyXIRZ2vgi5cwS9vY7pj+G8EBjPQRPyOPVUQm52BGHI8Y=
=feLP
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
