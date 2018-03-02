Received: from eggs.gnu.org ([2001:4830:134:3::10]:51002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ergw4-0006zZ-Qe
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ergw3-0004QZ-TQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:25:04 -0500
Date: Fri, 2 Mar 2018 09:24:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180302092457.GB6026@stefanha-x1.localdomain>
References: <20180228181946.22958-1-stefanha@redhat.com>
	<20180301011517.GH21336@lemon.usersys.redhat.com>
	<20180301145446.GA30789@stefanha-x1.localdomain>
	<20180302005826.GI21198@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20180302005826.GI21198@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 08:58:26AM +0800, Fam Zheng wrote:
> On Thu, 03/01 14:54, Stefan Hajnoczi wrote:
> > On Thu, Mar 01, 2018 at 09:15:17AM +0800, Fam Zheng wrote:
> > > On Wed, 02/28 18:19, Stefan Hajnoczi wrote:
> > > > v2:
> > > >  * Tackle the .ioeventfd_stop() vs vq handler race by removing the =
ioeventfd
> > > >    from a BH in the IOThread [Fam]
> > > >=20
> > > > There are several race conditions in virtio-blk/virtio-scsi datapla=
ne code.
> > > > This patch series addresses them, see the commit description for de=
tails on the
> > > > individual cases.
> > >=20
> > > This doesn't apply to master. Which branch is it based off?
> >=20
> > Sorry, I was going to look up the Based-on: syntax and then forgot.  I'm
> > not sure where it's documented, here is a guess at how it works:
> >=20
> > Based-on: "[PATCH v3 0/5] block: fix blk_aio_*() segfault when blk->roo=
t =3D=3D NULL" <20180216165015.30715-1-stefanha@redhat.com>
>=20
> Sorry for the poor documentation of Patchew, we should improve the situat=
ion
> soon:

It would be nice if the patchew.org front page linked to a guide for
patch authors that documents available features.

Stefan

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJamRhpAAoJEJykq7OBq3PIQC0H/3TR2r3DyA9jrDHvCIdgSVXB
G3Y1PW9aSDi56dMAaCpZwJEi2D84GNsX/9yrad686I1l31g6LO619Sy8bAIbRUSC
1fHxcj3yL7iVtl/MqA5PqmAAu8LVfGagPRcixUn9M0eRh3i2UYGdusbEa1P8vs8V
US8CZnMsloL8EJ3+Zz/6sXgx0XR/3Lb3ka3oh6uL5wI0/GVa3B91pw+LMfDKhAtl
DnR0xc7FKa4pxysy072euLPboOOcRNlFUbngIOSE44qPfHPquS+68qE5jfX+X/1F
uCYCwwMuky6bUchuRMF1f/PFDXqbXYvRjIkYK3wgSSjgJgidUtkq7a9dTtRJfrc=
=xGWu
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
