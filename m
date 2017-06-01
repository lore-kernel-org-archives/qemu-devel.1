Received: from eggs.gnu.org ([2001:4830:134:3::10]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSH9-0005gt-Qe
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGSH6-0007Hp-P5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:44:39 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:39770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGSH6-0007HL-IN
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:44:36 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 29FF1100AB1
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 17:44:31 +0200 (CEST)
Date: Thu, 1 Jun 2017 17:44:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601174415.01c1ec1f@bahia.lan>
In-Reply-To: <20170601122447.GF13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-4-david@gibson.dropbear.id.au>
	<1496295880.4414.1.camel@gmail.com>
	<20170601092908.5a17eeec@bahia.lan>
	<20170601122447.GF13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rQfBR=mA.U+i57pO42_yvKG";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv4 3/5] pseries: Move CPU
 compatibility property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: dgilbert@redhat.com, quintela@redhat.com, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, abologna@redhat.com, sbobroff@redhat.com, armbru@redhat.com

--Sig_/rQfBR=mA.U+i57pO42_yvKG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Jun 2017 22:24:47 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
> >=20
> > Yeah. This basically does:
> >=20
> >     inpieces[i + 1] =3D inpieces[i];
> >=20
> > and we end up overwriting the terminal NULL pointer with a non-NULL
> > pointer.
> >=20
> > What about simplifying the loop to:
> >=20
> >     /* inpieces[0] is the actual model string */
> >     i =3D 1;
> >     while (inpieces[i]) {
> >         if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> >             /* in case of multiple compat=3D optipons */
> >             g_free(compat_str);
> >             compat_str =3D inpieces[i];
> >             /* Excise compat options from list */
> >             inpieces[i] =3D inpieces[i + 1];
> >         }
> >         i++;
> >     } =20
>=20
> No.. that would duplicate the entry after the compat=3D, instead of
> properly excising it.  I've already fixed this for my next draft.
>=20

D'oh you're right... sorry for the noise :)

--Sig_/rQfBR=mA.U+i57pO42_yvKG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwNk8ACgkQAvw66wEB28KQaQCfU3BE7Qyg0lm1F0vmjACkqalg
3CwAn2qVFRcR423YC43RdYY8GEtFXEVI
=0hmA
-----END PGP SIGNATURE-----

--Sig_/rQfBR=mA.U+i57pO42_yvKG--
