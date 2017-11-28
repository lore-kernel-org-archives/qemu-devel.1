Received: from eggs.gnu.org ([2001:4830:134:3::10]:40576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJdHA-0008Fg-CQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJdH7-0004b4-7q
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:38:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eJdH7-0004ae-1B
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:38:01 -0500
Date: Tue, 28 Nov 2017 10:37:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171128103757.GD17146@stefanha-x1.localdomain>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711272251290.24944@wniryva>
	<20171128101154.64b49cb0.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <20171128101154.64b49cb0.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 10:11:54AM +0100, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 23:25:28 +0530 (IST)
> P J P <ppandit@redhat.com> wrote:
> > +-- On Mon, 27 Nov 2017, Stefan Hajnoczi wrote --+
> > | > +    if (!vdev->vq[n].vring.num || !desc || !vdev->vq[n].vring.alig=
n) {
> > | ...
> > |   vdev->vq[n].vring.desc =3D desc;
> > |
> > | Why !desc?
> >=20
> > virtio_queue_set_rings
> >  virtio_init_region_cache
> >    VirtQueue *vq =3D &vdev->vq[n];
> >    ...
> >    addr =3D vq->vring.desc;
> >    if (!addr) {
> >        return;
> >    }
> >=20
> > These checks seem to be repeating all over. As mentioned earlier, could=
 these=20
> > be collated in one place, maybe virtio_queue_get_num()?
> >=20
> >   int virtio_queue_get_num(VirtIODevice *vdev, int n)
> >   {
> >       VirtQueue *vq =3D &vdev->vq[n];
> >=20
> >       if (!vq->.vring.num
> >            || !vq->vring.desc
> >            || !vq->vring.align) {
> >           return 0;  /* vq not set */
> >       }
> >=20
> >       return vdev->vq[n].vring.num;
> >   }
>=20
> This is conflating different things:
> - vq does not exist (num =3D=3D 0)
> - vq is not setup by the guest (desc =3D=3D 0)
> - vq has no valid alignment (which is only relevant for legacy)

I agree.

Stefan

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHTyFAAoJEJykq7OBq3PIlegIAIRHoK+w0i5pfbjIkAkzd/l3
ydhnCO43ORoXp8p3nkmM9OfY6PZxJtmIoCym2BMCm1yFjyZLfv4hL7OCSB8JIljE
Hg42fqLF0TVSEaWxGFFEHvQI9nIge9xyExkDILuG0G/Dqhsjd/5ncjPL4ZgwGDOo
xGRXTIDl0q9eJSrDBMy4mFoXFGCwJZ1SY2lnGM5jLptXXQ2QxcdOca6luxYa9MTC
y72bf8F38KRm6sBH5VSqOdmmm63kb9auB7IfY1uRs9KLWazefO59qDdWb81KauLo
qqO9D2f5FVRLP1hL9uceCfLPM72WXfqXM11RoLP3dOjJMHR+pAOlEYZkzC96cVY=
=+pdT
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
