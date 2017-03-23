Received: from eggs.gnu.org ([2001:4830:134:3::10]:33582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cr4GC-0003A2-9n
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cr4G6-0008EZ-4C
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:02:44 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:58978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cr4G5-0008Dr-Uf
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:02:38 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 37252770A8
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 16:02:35 +0100 (CET)
Date: Thu, 23 Mar 2017 16:02:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170323160226.027a9354@bahia.lan>
In-Reply-To: <15207674-c5cd-3874-7ac9-5b23cdac8888@suse.com>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<1490033952-26735-1-git-send-email-sstabellini@kernel.org>
	<20170323140005.6b0853b3@bahia.lan>
	<15207674-c5cd-3874-7ac9-5b23cdac8888@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/XkpC_jtMnHRqy1Z4JUPzrN.";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 1/8] xen: import ring.h from xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/XkpC_jtMnHRqy1Z4JUPzrN.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2017 14:55:26 +0100
Juergen Gross <jgross@suse.com> wrote:

> On 23/03/17 14:00, Greg Kurz wrote:
> > On Mon, 20 Mar 2017 11:19:05 -0700
> > Stefano Stabellini <sstabellini@kernel.org> wrote:
> >  =20
> >> Do not use the ring.h header installed on the system. Instead, import
> >> the header into the QEMU codebase. This avoids problems when QEMU is
> >> built against a Xen version too old to provide all the ring macros.
> >>
> >> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >> CC: anthony.perard@citrix.com
> >> CC: jgross@suse.com
> >> ---
> >> NB: The new macros have not been committed to Xen yet. Do not apply th=
is
> >> patch until they do.
> >> --- =20
> >=20
> > Looking at your other series for the kernel part of this feature:
> >=20
> > https://lkml.org/lkml/2017/3/22/761
> >=20
> > I realize that the ring.h header from Xen also exists in the kernel tre=
e...=20
> >=20
> > Shouldn't all the code that can be used in both kernel and userspace go=
 to a
> > header file under include/uapi in the kernel tree ? And then we would i=
mport
> > it under include/standard-headers/linux in the QEMU tree and we could k=
eep it
> > in sync using scripts/update-linux-headers.sh.
> >=20
> > Cc'ing Paolo for insights. =20
>=20
> As Xen isn't part of the kernel we don't want that. You can use and/or
> build qemu with xen-9pfs backend support on an old Linux kernel without
> the related frontend.
>=20

Ok.

> OTOH I don't see the advantage of not using the headers from Xen. This
> is working for qdisk and pvusb backends and for all the Xen libraries.
> Do you expect the 9pfs backend to be used for a qemu version built
> against a Xen version not supporting that backend?
>=20

Not specifically, I was just feeling dubitative about that Xen header
being manually copied to the kernel tree and also to the QEMU tree.

>=20
> Juergen
>=20


--Sig_/XkpC_jtMnHRqy1Z4JUPzrN.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljT44IACgkQAvw66wEB28ItDgCdGpuNmlzFoPFsY/vlD7hmle7U
jtwAmgJlXmySq6y5/iKaGEJhWnpQgZyu
=tHjo
-----END PGP SIGNATURE-----

--Sig_/XkpC_jtMnHRqy1Z4JUPzrN.--
