Received: from eggs.gnu.org ([209.51.188.92]:55840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwNlT-0002Fr-0g
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwNlP-0000Iu-7z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:02:01 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:56445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gwNlN-0000Az-8N
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:01:59 -0500
Received: from player760.ha.ovh.net (unknown [10.109.160.40])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3751E116C72
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:01:43 +0100 (CET)
Date: Wed, 20 Feb 2019 10:01:23 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190220100123.462f8535@bahia.lan>
In-Reply-To: <20190220032219.GE9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059667853.1466090.16527852453054217565.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190220032219.GE9345@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/zIglDYUnYJhDVRRBcTS=rD9";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

--Sig_/zIglDYUnYJhDVRRBcTS=rD9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Feb 2019 14:22:19 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 19, 2019 at 06:17:58PM +0100, Greg Kurz wrote:
> > All DRC subtypes have been converted to generate the FDT fragment at
> > configure connector time instead of attach time. The fdt and fdt_offset
> > arguments of spapr_drc_attach() aren't needed anymore. Drop them and
> > make the implementation of the dt_populate() method mandatory.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I've applied the first 5 patches to ppc-for-4.0, but as a followup...
>=20
> [...]
> > @@ -1113,8 +1104,6 @@ static void rtas_ibm_configure_connector(PowerPCC=
PU *cpu,
> > =20
> >      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > =20
> > -    g_assert(drc->fdt || drck->dt_populate);
> > -
> >      if (!drc->fdt) { =20
>=20
> ..you can now remove this conditional, since it will always be true.
>=20

Hmm... I'm afraid this is not true since configure-connector is supposed
to be called several times according to PAPR. And this is exactly what
the code does: first return the node name to the guest, then all properties
and subnodes one at a time...

--Sig_/zIglDYUnYJhDVRRBcTS=rD9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxtF2MACgkQcdTV5YIv
c9Z41g//V1BZdvduavmHdhc2CblXfn2hGYWoYhJlnylXitiOgOrDg5O4APxLpNAj
KBzi+nkrJcUBFGjGzUBl/ZwfTXmJaZjz7SSSvkhFp3Rq6ENce/LC64wXoHBPVsIQ
Jmdqer7cglRJUSs2R8MqQnYARB70592sInCqzuqYQSJb/bNXRrsEbMRGu/Kr4wdA
EVGwzKteIhjdfsa8TekfM8FHH+isp9UiJwRE0QD8TGNwVdIHHjHD9UKNhTvsnblG
g85kCDaP2NvIEf+hWmYAZVbpYzp+KZBHo/L7e3Zp9k7fKHcRK2mcyrdq/nWx0I4n
xRD+mKluaABOBn6c6Shq7gwz+HUile96765TSbL6R6H5GwqFQzZ98qKhccUTXbfl
IRXgBhdXM8Cr1UAt/JYrrxR32+92Gl3lKGCmDz8Q62X/XhN4TbloVxV0GQlgnwfb
n+y5wqxKNtHnZKMjIDDIYE/IvjawtCrKEHVALaXAN1FUzmO7dSrgfVcf7c1H8nXI
6WoaiDxfTTjcu0YqaRwjOfmQ+6jSO4FAGZ84lsoYU1NIarfeJcAKaakUg+ruXCj1
3uR8j/ei1hik4DHKNnR4UOFfvL/j7W3nb9wGHcpmiqVhY/fohKrsziF/FugLYZ5E
SN4xSkW6iVjSVgsnC4RQOhJ62ZXcG0jysIs6u5iTrsER/gCbYGY=
=VgRM
-----END PGP SIGNATURE-----

--Sig_/zIglDYUnYJhDVRRBcTS=rD9--
