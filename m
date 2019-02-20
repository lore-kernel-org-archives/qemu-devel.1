Received: from eggs.gnu.org ([209.51.188.92]:44148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwUTF-00078s-Uy
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwUTB-0007sh-Vy
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:11:40 -0500
Date: Wed, 20 Feb 2019 20:57:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220095700.GB13129@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059667853.1466090.16527852453054217565.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190220032219.GE9345@umbus.fritz.box>
	<20190220100123.462f8535@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20190220100123.462f8535@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v5 05/17] spapr/drc: Drop
 spapr_drc_attach() fdt argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 10:01:23AM +0100, Greg Kurz wrote:
> On Wed, 20 Feb 2019 14:22:19 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Feb 19, 2019 at 06:17:58PM +0100, Greg Kurz wrote:
> > > All DRC subtypes have been converted to generate the FDT fragment at
> > > configure connector time instead of attach time. The fdt and fdt_offs=
et
> > > arguments of spapr_drc_attach() aren't needed anymore. Drop them and
> > > make the implementation of the dt_populate() method mandatory.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > I've applied the first 5 patches to ppc-for-4.0, but as a followup...
> >=20
> > [...]
> > > @@ -1113,8 +1104,6 @@ static void rtas_ibm_configure_connector(PowerP=
CCPU *cpu,
> > > =20
> > >      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > =20
> > > -    g_assert(drc->fdt || drck->dt_populate);
> > > -
> > >      if (!drc->fdt) { =20
> >=20
> > ..you can now remove this conditional, since it will always be true.
> >=20
>=20
> Hmm... I'm afraid this is not true since configure-connector is supposed
> to be called several times according to PAPR. And this is exactly what
> the code does: first return the node name to the guest, then all properti=
es
> and subnodes one at a time...

Oh, duh, of course.  Forget I said that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxtJGoACgkQbDjKyiDZ
s5IKexAAyzkOsiEYNVQjxxb5ly81yKzrLKxCuKruAP2xvLb28NFlPLo4ITuWH2FW
LkRrZsjtXcw8z0jtjCAuQwzd1KQGSPiBOIMKWiY3YY+Ej9E83vTaM8TQuKJPbdC9
5wkzGU0JHL6zhYs2JOxHgH0HXCr3A5MIe/A/5ooxUmiCGz5bnW0ZuIUT6d716KwV
gAxLV7DpJ6HbWilFplygJXXHxmGqJVMd6S2QUjkIfPrvFm5ngML0avfUsV1VyQLP
0W2Qmsgm9XU3Zz3HKl2ex6b9qP9RRp5Ytfu0oqeiAdVCY+KqSLQ+dJ/6kS55Xv4P
Y9bZxJnEaVFq3b4hyNKwWMwrhng39NaSoVtKQ/EiY3WUE4rIO5VQyeZQyGN67R0l
6o7NH/seNkZXOhTJTk8rZngn6Q7Z92/0NRXKAiGCVVYPHr/nZxeL0dJEsZO5MK94
o55z/NtlTffGQG9WG+R6zp0DKEXk/9I5mRpQ3aMVqBvFqNoMat/mRzuX9VSrLfFU
ZnrwXTucHLbP6LYQTvtejk7b61Z868ZOqWFUzrd759gqZhVdJ7ia6zFRtssUaGMC
Z858c+cq/ExkoAzDW983ToGACxBCNkxye+2MKeQA72sBGJLCBSho+WpW33TRBXmu
ZM2lzugOXu8GrJ5CkgZXQJs7edj0PtM6qJF1cJZZvjTIoS6hDD0=
=iOLz
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
