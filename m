Received: from eggs.gnu.org ([2001:4830:134:3::10]:54165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfPom-00055J-SP
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfPoT-000129-W2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:10:32 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:60336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfPoT-00010r-PE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:10:13 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id EF24A8BEC0
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 14:10:11 +0200 (CEST)
Date: Wed, 9 Aug 2017 14:10:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809141001.3b65e53f@bahia.lan>
In-Reply-To: <20170809130608.3ce61bd3.cohuck@redhat.com>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<20170809114705.39dc0455@bahia.lan>
	<20170809130608.3ce61bd3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/lOTNmdupKgJso_xBlH/KH5P";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/lOTNmdupKgJso_xBlH/KH5P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 13:06:14 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 9 Aug 2017 11:47:05 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Wed, 9 Aug 2017 10:27:37 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >  =20
> > > On Wed, 9 Aug 2017 10:23:04 +0200
> > > Thomas Huth <thuth@redhat.com> wrote: =20
>=20
> > > > But thinking about this again, I wonder whether it would be enough =
to
> > > > simply check for CONFIG_VIRTIO=3Dy here instead. CONFIG_VIRTIO=3Dy =
should be
> > > > sufficient to assert that there is also at least one kind of virtio
> > > > transport available, right?
> > > > Otherwise this will look really horrible as soon as somebody also t=
ries
> > > > to add support for virtio-mmio here later ;-)     =20
> > >    =20
> >=20
> > And virtio isn't the only transport for 9p: we also have a Xen backend,
> > which happen to be built because targets that support Xen also have
> > CONFIG_PCI I guess. =20
>=20
> Only if they also have virtio enabled, no?
>=20

Yes, you're right. This is actually the case for i386 and x86_64 targets,
which seem to be the only that support Xen.

> Should the condition be VIRTFS && (VIRTIO || XEN), then?

That's what I was beginning to think as well :)

--Sig_/lOTNmdupKgJso_xBlH/KH5P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmK+5kACgkQAvw66wEB28JwCQCaAvwjOe4H58fJWq15tCF29UkK
zJ4An3vGksvc/XVsz4KqgDCdzpwNMKdU
=H57p
-----END PGP SIGNATURE-----

--Sig_/lOTNmdupKgJso_xBlH/KH5P--
