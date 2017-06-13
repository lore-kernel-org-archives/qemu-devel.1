Received: from eggs.gnu.org ([2001:4830:134:3::10]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKhWk-0004CK-7y
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKhWh-0000NR-3g
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:50:18 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:33489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKhWg-0000N8-TG
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:50:15 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5D34810600D
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 10:50:13 +0200 (CEST)
Date: Tue, 13 Jun 2017 10:50:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613105008.2ad08672@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170613084555.GG30171@umbus>
References: <149734236294.28467.16891018961029258858.stgit@bahia.lan>
	<20170613084555.GG30171@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/dC0EhifVLV++3XXQihxC+su";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: exit gentfully when CPU doesn't
 support requested compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>

--Sig_/dC0EhifVLV++3XXQihxC+su
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2017 16:45:55 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 13, 2017 at 10:26:02AM +0200, Greg Kurz wrote:
> > QEMU currently aborts if the user asks something unrealistic like power9
> > compat mode with a POWER8 CPU for example. Since this isn't a bug in QE=
MU,
> > there's no point in aborting. The same goes with the other possible err=
or
> > paths in ppc_set_compat_all(). Let's just terminate QEMU instead.
> >=20
> > Reported-by: Andrea Bolognani <abologna@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Heh, I already folded an identical fix into ppc-for-2.10.
>=20

Yeah I saw your other mail just after sending this :)

>=20
> > ---
> >  hw/ppc/spapr.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index b2217f39eeea..d0cc124935c0 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1345,7 +1345,7 @@ static void ppc_spapr_reset(void)
> >          spapr_ovec_cleanup(spapr->ov5_cas);
> >          spapr->ov5_cas =3D spapr_ovec_new();
> > =20
> > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_abort);
> > +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> >      }
> > =20
> >      fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> >  =20
>=20


--Sig_/dC0EhifVLV++3XXQihxC+su
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk/p0AACgkQAvw66wEB28IWCQCcDRFwtfeIdm7kFmaroa+2AXwi
yEcAn22VLsVLOUKGbgno8Lug95QtWj3I
=hMbf
-----END PGP SIGNATURE-----

--Sig_/dC0EhifVLV++3XXQihxC+su--
