Received: from eggs.gnu.org ([2001:4830:134:3::10]:56909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgXBI-0001W8-Hr
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgXBF-00017T-Go
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:42:08 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:42687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cgXBF-00017D-A5
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:42:05 -0500
Received: from player711.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id E349F3EE82
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 14:42:02 +0100 (CET)
Date: Wed, 22 Feb 2017 14:41:53 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170222144153.131dee9d@bahia.lan>
In-Reply-To: <20170214132122.GH23310@stefanha-x1.localdomain>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan>
	<20170207113231.44e35be6@bahia.lan>
	<6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
	<20170207172933.05574f60@bahia.lan>
	<20170214132122.GH23310@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Bk/.ETSYc3L/o2PgiCIURLI";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

--Sig_/Bk/.ETSYc3L/o2PgiCIURLI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Eric,

I fully understand your concern about the missing QMP bits, but given the o=
ther
comments people made on this series, I'd like to move forward and merge it =
for
2.9, without the 'x-' prefixed options. Is it okay with you ?

Cheers.

--
Greg

On Tue, 14 Feb 2017 13:21:22 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Feb 07, 2017 at 05:29:33PM +0100, Greg Kurz wrote:
> > Cc'ing Stefan who reviewed patch 2/2.
> >=20
> > On Tue, 7 Feb 2017 09:56:08 -0600
> > Eric Blake <eblake@redhat.com> wrote:
> >  =20
> > > On 02/07/2017 04:32 AM, Greg Kurz wrote: =20
> > > >>
> > > >> I'm not aware of anything related to fsdev in QMP... and libvirt s=
eems to
> > > >> only parse the output of -help to guess fsdev capabilities.   =20
> > > >=20
> > > > Oops, reading some more libvirt code I now see that libvirt doesn't=
 parse
> > > > -help anymore with QEMU >=3D 1.2.0... sorry for the noise :)
> > > >    =20
> > > >> And indeed,
> > > >> qemu-options.hx doesn't expose this new feature.
> > > >>   =20
> > > >>> Please make sure we don't reach 2.9 with only a half-baked featur=
e;
> > > >>> whether that means finishing the QMP work or temporarily disablin=
g the
> > > >>> cli additions until a later release can finish the work.
> > > >>>      =20
> > > >>
> > > >> Would this be ok to add the missing bits in qemu-options.hx or do =
you
> > > >> expect more ?   =20
> > >=20
> > > If it cannot be probed via QMP, then libvirt will most likely assume
> > > that it does not exist.  I guess we're okay having command line only =
in
> > > 2.9 if you can't get QMP working, because libvirt will just never dri=
ve
> > > the feature until 2.10 when QMP is available; but then we risk the
> > > command line subtly changing and breaking someone else that was using
> > > the command line without QMP.  Maybe the safest approach is to just u=
se
> > > the 'x-' prefix to the command line portion, until the feature is com=
plete.
> > >  =20
> >=20
> > The semantics here are exactly the same as for block devices. The
> > command line options added to -fsdev are the very same already used
> > by -drive for years.
> >=20
> > Patch 2/2 in this series even factors them out to a common header file
> > to be used by fsdev and blockdev. I really don't expect any modification
> > at all on the command line (nor the other people who reviewed that patch
> > obviously)... are you suggesting that we should put 2/2 on hold and
> > use the 'x-' prefix anyway ? =20
>=20
> I see these parameter names as stable.  There is little risk that they
> would change.
>=20
> Stefan

--Sig_/Bk/.ETSYc3L/o2PgiCIURLI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlitlSEACgkQAvw66wEB28JzcgCfdIyYKj7bSmXRO/M+yKpQupoK
vGMAn3amQw1Ez8VNWSr1pj3U3B69JkCT
=SDJE
-----END PGP SIGNATURE-----

--Sig_/Bk/.ETSYc3L/o2PgiCIURLI--
