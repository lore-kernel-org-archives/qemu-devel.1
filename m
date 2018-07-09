Received: from eggs.gnu.org ([2001:4830:134:3::10]:40698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fcQcY-0001dM-Ro
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fcQcX-0004mb-K7
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:30:06 -0400
Date: Mon, 9 Jul 2018 09:29:53 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180709072953.GE7755@andariel.pipo.sk>
References: <20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <20180706145645.GB3939@localhost.localdomain>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 16:56:46 +0200, Kevin Wolf wrote:
> Am 06.07.2018 um 13:11 hat Cornelia Huck geschrieben:
> > On Wed, 4 Jul 2018 17:14:02 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >=20
> > > On 4 July 2018 at 14:34, Kevin Wolf <kwolf@redhat.com> wrote:
> > > > Essentially, what is important to me isn't getting these options dr=
opped
> > > > exactly in 3.0, but not setting a bad precedence that deprecation i=
sn't
> > > > actually worth anything. We may easily end up with this deprecation
> > > > process:
> > > >
> > > > depreate a feature
> > > > release QEMU version n + 1
> > > > release QEMU version n + 2
> > > > remove the feature
> > > > while libvirt hasn't removed use of the feature:
> > > >     # ...and why should it when everything is still working?
> > > >     reinstate the feature
> > > >     release QEMU version n + x
> > > >     remove the feature =20
> > >=20
> > > My take on the deprecation policy essentially is that it gives
> > > us a *minimum* bar for how soon we can drop something. We
> > > shouldn't be using it as an "always target this speed for
> > > dropping something" -- we ought to be pragmatic. We can
> > > drop stuff that's unused quickly, but should be slower
> > > for things that still have major users (or reconsider
> > > the deprecation entirely, potentially). There should be
> > > a balance between making our work as developers easier and
> > > inconveniencing our users.
> >=20
> > What about the following?
> >=20
> > - put a feature on the "normal" deprecation list to remove after two
> >   releases
> > Case (a): nobody complains, either within the deprecation period or
> > when it is finally removed
> >   -> all is good
> > Case (b): the feature turns out to be widely used, and/or it turns out
> > that it offers value that currently can't be offered easily in another
> > way
> >   -> remove from deprecation list; this obviously needs more thinking
> > Case (c): the feature is used, the users are willing to move away from
> > it, but they need a bit more time
> >   -> put it on a "deprecation watchlist", listing the users we are
> >   waiting for, and then remove after all are done (no +2)
> >=20
> > That way, we can still easily remove old cruft (case (a)), but still
> > accommodate cases like this (case (c)). The obvious drawback is that
> > we'd need someone to curate the deprecation watchlist, to poke the
> > users we're waiting for, and probably remove anyway after some time if
> > they don't get their act together.
>=20
> The problem is that things are only starting to move after two releases
> have passed. The original idea was to already use that time. If we don't
> use it, then waiting for two releases is pointless and we can just
> directly let things go to a deprecation watchlist.
>=20
> Maybe we can just use the existing wiki page:
>=20
>     https://wiki.qemu.org/index.php/Features/LegacyRemoval
>=20
> And add a column for whether libvirt is ready? Of course, that only
> makes sense if libvirt people make use of and contribute to this page.

This should not be a problem, but I think we need some active
encouraging/prodding to remove deprecated stuff. Otherwise we might miss
the news.

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAltDDu4ACgkQHGwCByjY
1GqhOhAAhw4ipOt7uf1eW0FWEx6sLYTZTntJjZkrWgHJNhNeDgy7ydHF1TeAiror
AMj8Z3ijrQqk9Q+IEl5/y/KH+aVHHRorRZt6fJQQD+ukMdwx6Hs/2JkbZeDtdrex
gbBRXGS473V4I0qXmcdyn0blVcx36El/QsvUftlnur67uOXg87evsgm6MV6d0pR0
8b1BV+6yLjlUYEqZAuZz1hazH2g1FzqoXnr6i81lGCkJ5feevhn92gvXYKJo72fi
mL2XNmubI6bW0Xzbj54L2YmG7mhQB/OkpckDluR9EPrLaOV5V5rCmNHux2ZaymyB
4JOZPNoZYGj7j13qilsqTrrjUiMH60qT5VpqCJaR6cePNp4bFajXYCnHVYqgHQYo
R9Nl9V4bqUVPRTXFvI2WVNHKCj+J2AaY/XB0MMo6nPvIZ/W97qGiJ8E399Lz9aVC
LLgaLCSvTe77sJUUsczu1gDuejyciOErcf/Um5aB/+k5y4eVtiguyKFJWpnY7Oyv
v1snuG2jPoYGv1/YHAf1qeNEDyOErvhMDALHKnRFV8NXXEDYhtam/wppROnl274Z
by3CqDEIb3qKRrFcgX/Hq5CpeSqOFVbpBGDTWUSEylogg9jM2vJz6b5gdIDh9ndg
gzQc+zfUAVP6hpZH7A4Plm6x7iXLk9LL+vYYqpNcWj0mi7EZhNY=
=jarQ
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
