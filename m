Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csnWH-000165-Vd
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csnWE-0006ZU-Qb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:34:30 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:41795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csnWE-0006ZH-KB
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:34:26 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0416870723
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 11:34:22 +0200 (CEST)
Date: Tue, 28 Mar 2017 11:34:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170328113415.7c1881ef@bahia.lan>
In-Reply-To: <20170328102421.2f4fbeec.cornelia.huck@de.ibm.com>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
	<149063676337.4447.2095575576822297032.stgit@bahia.lan>
	<20170327211728-mutt-send-email-mst@kernel.org>
	<20170328101409.1aa23618@bahia.lan>
	<20170328102421.2f4fbeec.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/YikKo.mtqHphTH9ONCm5vi/";
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/YikKo.mtqHphTH9ONCm5vi/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Mar 2017 10:24:21 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Tue, 28 Mar 2017 10:14:09 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Mon, 27 Mar 2017 21:20:56 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > On Mon, Mar 27, 2017 at 07:46:03PM +0200, Greg Kurz wrote: =20
> > > > This introduces an Error object based implementation of virtio_erro=
r(). It
> > > > allows to implement virtio_error() wrappers in device-specific code.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/virtio/virtio.c         |   21 ++++++++++++++++-----
> > > >  include/hw/virtio/virtio.h |    1 +
> > > >  2 files changed, 17 insertions(+), 5 deletions(-)
> > > >  =20
>=20
> > > Also, whether to stop the device, or the VM, or just warn,
> > > seems like a policy decision. Why not set it on command line
> > > like we do for other storage?
> > >  =20
> >=20
> > Huh? This patch simply introduces a new API to a feature that underwent
> > several rounds of discussion and reached a reasonable consensus (even
> > your R-b).
> >=20
> > I'm not sure this 9pfs series is the right place to talk about all the
> > behavior changes you're suggesting for virtio_error()... I'd rather
> > drop this patch and duplicate code in virtio-9p instead if I want the
> > fixes to go to 2.9. =20
>=20
> I agree that we should discuss this outside of this patch series. It's
> not like it is introducing a new error case.
>=20
> >=20
> > Cc'ing Connie and Stefanha for insights. =20
>=20
> See my reply to Michael's mail.
>=20

Yeah, I saw that just after pressing the send button :)

The points raised by Michael make a lot of sense anyway. Maybe we can
discuss them for 2.10 ?

Cheers.

--
Greg

--Sig_/YikKo.mtqHphTH9ONCm5vi/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljaLhcACgkQAvw66wEB28LliwCfQq7qAihdTZ5TUgyu/0gKngHw
IC0An0nIRYtMGmq4kFgwhQRLsudPkeAN
=YXfe
-----END PGP SIGNATURE-----

--Sig_/YikKo.mtqHphTH9ONCm5vi/--
