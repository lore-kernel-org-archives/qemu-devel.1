Received: from eggs.gnu.org ([2001:4830:134:3::10]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFzVR-0003xJ-M0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFzVM-0006TG-Qa
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:01:29 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:47221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFzVM-0006Su-KG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:01:24 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CB20FFC53D
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 11:01:22 +0200 (CEST)
Date: Wed, 31 May 2017 11:01:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531110115.7d44d86e@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170531063321.GL12163@umbus.fritz.box>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
	<20170525035132.24268-12-david@gibson.dropbear.id.au>
	<20170529231408.43f12e95@bahia.ttt.fr.ibm.com>
	<20170531063321.GL12163@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/wcY3PYZ7JVs.J1QU65mMDiI";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 11/18] pseries: Split CAS PVR
 negotiation out into a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sbobroff@redhat.com

--Sig_/wcY3PYZ7JVs.J1QU65mMDiI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 16:33:21 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, May 29, 2017 at 11:14:08PM +0200, Greg Kurz wrote:
> > On Thu, 25 May 2017 13:51:25 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > Guests of the qemu machine type go through a feature negotiation proc=
ess
> > > known as "client architecture support" (CAS) during early boot.  This=
 does
> > > a number of things, one of which is finding a CPU compatibility mode =
which
> > > can be supported by both guest and host.
> > >=20
> > > In fact the CPU negotiation is probably the single most complex part =
of the
> > > CAS process, so this splits it out into a helper function.  We've rec=
ently
> > > made some mistakes in maintaining backward compatibility for old mach=
ine
> > > types here.  Splitting this out will also make it easier to fix this.
> > >=20
> > > This also adds a possibly useful error message if the negotiation fai=
ls
> > > (i.e. if there isn't a CPU mode that's suitable for both guest and ho=
st).
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > --- =20
> >=20
> > Any reason for not seing these patches as well in this pull request ?
> >=20
> > pseries: Restore PVR negotiation logic for  pre-2.9 machine types
> > pseries: Improve tracing of CPU  compatibility negotiation =20
>=20
> Yes.  After more discussion; and comparison with analogous x86 cases
> that came up with Igor's NUMA cleanups, I've decided that the
> behaviour here while guest visible comes under the heading of a
> firmware behaviour change, which we don't typically arrange 100%
> matching behaviour for.  Meanwhile, I also found out more things that
> suggest matching old behaviour correctly is going to be even messier
> than I though.
>=20
> So, I've decided that leaving the behaviour change in place is the
> better course.  Note that it won't affect migration (at least after
> the other compat/migration fixes are merged).
>=20
> I'll reconsider if we observe a real problem in the wild with it.
>=20

Thanks for the detailed explanation!

--Sig_/wcY3PYZ7JVs.J1QU65mMDiI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEARECAAYFAlkuhlsACgkQAvw66wEB28LRRQCgpc0v1tLp8Ta3onIF2uQS5xg7
EewAmIiUYYNbju3R8v2oVgSI66TGehM=
=Na2X
-----END PGP SIGNATURE-----

--Sig_/wcY3PYZ7JVs.J1QU65mMDiI--
