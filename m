Received: from eggs.gnu.org ([2001:4830:134:3::10]:60772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dy8Rl-0001xw-TQ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 23:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dy8Ri-0002eX-PC
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 23:28:09 -0400
Date: Sat, 30 Sep 2017 13:23:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170930032312.GD3251@umbus.fritz.box>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1506264466-28252-7-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170926034706.GG12504@umbus>
	<aaa2b280-4028-b593-e92a-5125d96fcbb6@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <aaa2b280-4028-b593-e92a-5125d96fcbb6@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 6/7] mac_dbdma: change
 DBDMA_register_channel to a MAC_DBDMA type method
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 07:40:18AM +0100, Mark Cave-Ayland wrote:
> On 26/09/17 04:47, David Gibson wrote:
>=20
> > On Sun, Sep 24, 2017 at 03:47:45PM +0100, Mark Cave-Ayland wrote:
> >> Using this we can change the MACIO_IDE instance to register the channel
> >> itself via a type method instead of requiring a separate
> >> DBDMA_register_channel() function.
> >>
> >> As a consequence of this it is now possible to remove the old external
> >> macio_ide_register_dma() function.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >=20
> > Ok, two concerns about this.
> >=20
> > First, you've added the function pointer to the instance, not to the
> > class, which is not how a QOM method would normally be done.
>=20
> Yeah I did think about whether I needed to create a full class but was
> torn since as you say there is only one implementation.
>=20
> > More generally, though, why is a method preferable to a plain
> > function?  AFAICT it's not plausible that there will ever be more than
> > one implementation of the method.
> >=20
> > Same comments apply to patch 7/7.
>=20
> For me it's really for encapsulation. It seems a little odd requiring a
> global function to configure a QOM object to which I already have a
> reference.

Instead you're using the method which is defined in a global type
definition.  I don't think it really makes any different to
encapsulation.

> If I were to redo the last 2 patches using a proper class, would you
> accept them?
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnPDiAACgkQbDjKyiDZ
s5Kkew//c6vvi8G7IcHe299J4Y2yJHJAS7e5pYDSdPFs8CIeVNW/mUGmcxEOmFLy
t1rSVTpbQHFr4QchsnepZRRlzfnnY2hh/LQCXTt0o6F5bwde0C91iUdMdY3JQXki
7+B9h4MxtAsCrbglGe0MX90iZPDWJiriWy+nWcqTpUwLA81FpdUlJzrLvbl0lmA8
6AU6BFNjr7YJLniyj9nayVJkrsNMgogOIRkMrzIuTxHqpIUV3q4AOlmz+ge1YmW/
o5858Ftrpysp/k1woxqvdPo1l/S3eHZroVbRiH8+MDjW79nIdNas0e0JdgNjbWdU
aP2n8GvLGq/iCamQD6X1ADC+O+sXJCxEaWztrfQKFEFJ74c6rDna6LKSscRAcsLB
93SS9MBxbX3I540tFKP3tGeegZpJNN7r5wDVvC8+AcNSeM0q+QFWFfhrYahvm001
wm8cyymUxzJohLxLBUAgd0rM1r0wKtLrI3tQLZMpJaLPyccsrrFnywRzhsiLLPxs
B1pJDAFh597pDNv58Az11X0kKn9ISRfiFGYOmh5wxP/iq4CDDnoldDRL4rXfNB5S
fafg0EMBlYGDzbYsknR/u52eZmf7UmQS6uSlIPrD3FgKWTXZiSfykQNe3rUe5eNy
bfgJnwOOLpZytO6xmKrCzen7VwjQlxwnMM7l3sfVAhxj4n5rIzg=
=nCyT
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
