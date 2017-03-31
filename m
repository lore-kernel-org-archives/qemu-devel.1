Received: from eggs.gnu.org ([2001:4830:134:3::10]:56430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctxCY-0004pc-Vl
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctxCU-0002ka-Qt
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:06:54 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:33867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctxCU-0002jO-K9
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:06:50 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2BE4E33DA9
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 16:06:49 +0200 (CEST)
Date: Fri, 31 Mar 2017 16:06:35 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170331160635.1b4217a0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170328121459.23edec49.cornelia.huck@de.ibm.com>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
	<149063676337.4447.2095575576822297032.stgit@bahia.lan>
	<20170327211728-mutt-send-email-mst@kernel.org>
	<20170328101409.1aa23618@bahia.lan>
	<20170328102421.2f4fbeec.cornelia.huck@de.ibm.com>
	<20170328113415.7c1881ef@bahia.lan>
	<20170328121459.23edec49.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Vd4CA.dmzU_PHEmgHOmRSWz";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Error object based
 virtio_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

--Sig_/Vd4CA.dmzU_PHEmgHOmRSWz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Mar 2017 12:14:59 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Tue, 28 Mar 2017 11:34:15 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Tue, 28 Mar 2017 10:24:21 +0200
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> >  =20
> > > On Tue, 28 Mar 2017 10:14:09 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >  =20
> > > > On Mon, 27 Mar 2017 21:20:56 +0300
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >    =20
> > > > > On Mon, Mar 27, 2017 at 07:46:03PM +0200, Greg Kurz wrote:   =20
> > > > > > This introduces an Error object based implementation of virtio_=
error(). It
> > > > > > allows to implement virtio_error() wrappers in device-specific =
code.
> > > > > >=20
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > ---
> > > > > >  hw/virtio/virtio.c         |   21 ++++++++++++++++-----
> > > > > >  include/hw/virtio/virtio.h |    1 +
> > > > > >  2 files changed, 17 insertions(+), 5 deletions(-)
> > > > > >    =20
> > >  =20
> > > > > Also, whether to stop the device, or the VM, or just warn,
> > > > > seems like a policy decision. Why not set it on command line
> > > > > like we do for other storage?
> > > > >    =20
> > > >=20
> > > > Huh? This patch simply introduces a new API to a feature that under=
went
> > > > several rounds of discussion and reached a reasonable consensus (ev=
en
> > > > your R-b).
> > > >=20
> > > > I'm not sure this 9pfs series is the right place to talk about all =
the
> > > > behavior changes you're suggesting for virtio_error()... I'd rather
> > > > drop this patch and duplicate code in virtio-9p instead if I want t=
he
> > > > fixes to go to 2.9.   =20
> > >=20
> > > I agree that we should discuss this outside of this patch series. It's
> > > not like it is introducing a new error case.
> > >  =20
> > > >=20
> > > > Cc'ing Connie and Stefanha for insights.   =20
> > >=20
> > > See my reply to Michael's mail.
> > >  =20
> >=20
> > Yeah, I saw that just after pressing the send button :) =20
>=20
> :)
>=20
> >=20
> > The points raised by Michael make a lot of sense anyway. Maybe we can
> > discuss them for 2.10 ? =20
>=20
> Certainly. We should not delay any fixes for 2.9, though.
>=20

Michael,

Your comments call for some more discussion to take place during 2.10 devel.

Can you please ack this patch and I'll take it through my tree for 2.9 ?

Cheers.

--
Greg

--Sig_/Vd4CA.dmzU_PHEmgHOmRSWz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljeYmsACgkQAvw66wEB28LTEgCdHm8sCHADuLtfWu4/1nG33TXj
FhYAoKHj+W8n83llgWIBgW2Gd6k+a1be
=bCrP
-----END PGP SIGNATURE-----

--Sig_/Vd4CA.dmzU_PHEmgHOmRSWz--
