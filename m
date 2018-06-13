Received: from eggs.gnu.org ([2001:4830:134:3::10]:40827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT0AF-0007xD-BG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT0AC-000805-7Q
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:25:55 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:38631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT0AB-0007zD-W0
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:25:52 -0400
Received: from player776.ha.ovh.net (unknown [10.109.105.10])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 39160B6455
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:25:50 +0200 (CEST)
Date: Wed, 13 Jun 2018 09:25:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613092542.576e8c33@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180612233140.GH30690@umbus.fritz.box>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
	<CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
	<20180612175241.7340be80@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAFEAcA8yKyHX-xVx5VPxBOy7-hiKDo+DgztVZ_sD5FxK77Z-9w@mail.gmail.com>
	<20180612204603.7bf254cb@bahia.lab.toulouse-stg.fr.ibm.com>
	<20180612233140.GH30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/rf=ua1hrfbCOIxhhBNo.UMR";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/rf=ua1hrfbCOIxhhBNo.UMR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Jun 2018 09:31:40 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 12, 2018 at 08:46:03PM +0200, Greg Kurz wrote:
> > On Tue, 12 Jun 2018 16:55:08 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  =20
> > > On 12 June 2018 at 16:52, Greg Kurz <groug@kaod.org> wrote: =20
> > > > On Tue, 12 Jun 2018 15:34:22 +0100
> > > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >   =20
> > > >> On 12 June 2018 at 07:44, David Gibson <david@gibson.dropbear.id.a=
u> wrote:   =20
> > > >> > ----------------------------------------------------------------
> > > >> > ppc patch queue 2018-06-12
> > > >> >
> > > >> > Here's another batch of ppc patches towards the 3.0 release.  Th=
ere's
> > > >> > a fair bit here, because I've been working through my mail backl=
og
> > > >> > after a holiday.  There's not much of a central theme, amongst o=
ther
> > > >> > things we have:
> > > >> >     * ppc440 / sam460ex improvements
> > > >> >     * logging and error cleanups
> > > >> >     * 40p (PReP) bugfixes
> > > >> >     * Macintosh fixes and cleanups
> > > >> >     * Add emulation of the new POWER9 store-forwarding barrier
> > > >> >       instruction variant
> > > >> >     * Hotplug cleanups
> > > >> >   =20
> > > >>
> > > >> Applied, thanks.   =20
> > >  =20
> > > > Oh... so we've broken bisect until Cedric's fix is merged.   =20
> > >=20
> > > If you want me not to merge a pullreq you need to follow up to
> > > the cover letter saying "please don't merge this" or something
> > > similar. Otherwise I will not notice. =20
> >=20
> > Yeah I've only answered to the offending patch, sorry... =20
>=20
> And it was the middle of the night for me.
>=20
> It's only with pretty old gcc, I think we can live with it, I intend
> to send another pullreq with the fixup as soon as I can.
>=20

It was meeting day for me yesterday so I didn't have time to check with
other GCC versions, but I could finally do it this morning. They fail
all the same:

hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
hw/intc/xics_kvm.c:281:20: error: =E2=80=98ret=E2=80=99 may be used uniniti=
alized in this
 function [-Werror=3Dmaybe-uninitialized]
             return ret;

Fedora28:

$ cc --version
cc (GCC) 8.1.1 20180502 (Red Hat 8.1.1-1)

Ubuntu 18.04:

$ cc --version
cc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

Ubuntu 17.10:

$ cc --version
cc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0

RHEL 7.5:

$ cc --version
cc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)

My concern is more that it requires --enable-debug to be passed to
configure. As noted by Cedric in another mail, -O2 seems to prevent
GCC to detect this obvious error...


--Sig_/rf=ua1hrfbCOIxhhBNo.UMR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsgxvYACgkQcdTV5YIv
c9ZxqA//cMAoRmXcXsrI7uazDRyjoS4Ur4xb1GG/imAHyG6QL9qQAm0a9D7XTJ75
FEMx1c2MQwxLNOsjSyOVP8rdHgLXxSzfWuUZ4fgqKvC+/jBKpyT5jhEvnkGD6rd2
AtuegQwNpYu8UlLA6xoVW+4RprAZBmKhybVK74ZkO+o/3N+uYe7NymdHtoTOreWr
f7IpzJCx0bUBe6DM0O96qyJqt3UFtZL2b2RY5QZgE5JaZ0zeaIuaSllC3W7sOiz6
IBZftOSvq61phUbvHsQsPDnvUM3m7eCd9HvYJxbZNa7CcdlqeNLrGqxic41EF+sx
HyT+6C//Wrd3EoHu6lM4RYSA7SD8ZFiaCUjzPMbnonz1kLfPpSMwco2E5HdpLgmr
Gg9c9rKLLYddHj8hNkyfYuhbCXToklXyx2mfQyBV0efGhzi47EiJYx5sKov3yML/
EayXEyzHi5dodULKHnsHklSS0J8kZupJySWZJ900VBv8zq8H6sk+dCwAliWQcJA/
/vnCFQXUzxorwInSISo7FxufkmYT9IGbdqwO1V+D0OdjK13WhaI9FsrBbl6uKY3z
My/4i2TaZPpTFZ2KrcEQ9+3RduhmxLmB3btO/fCLFi2RVR3bqhBu9SFoKyHOgDPA
3NKzfQZBNG1TkyvopUrK68BrHOrOiWnes8NuXb7s4vOVd+Fbrh8=
=Go1U
-----END PGP SIGNATURE-----

--Sig_/rf=ua1hrfbCOIxhhBNo.UMR--
