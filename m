Received: from eggs.gnu.org ([209.51.188.92]:34853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gnk06-0001pJ-78
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gnk05-0003wq-JM
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:57:26 -0500
Date: Sun, 27 Jan 2019 12:57:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190127125720.GC13784@stefanha-x1.localdomain>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-3-sgarzare@redhat.com>
	<5b3c3076-8f0e-c6a2-b6d1-707db2ae3a66@redhat.com>
	<962ebaff-23ce-57ff-3387-9017c2ccd14a@redhat.com>
	<20190125081615.2cevf7cy7bcnxqwh@steredhat>
	<d4aa8b25-f0ad-1444-587c-3d90a8ddc74a@redhat.com>
	<20190125151245.GD28305@stefanha-x1.localdomain>
	<20190125141502-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20190125141502-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/virtio-blk: add test for
 WRITE_ZEROES command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 02:17:01PM -0500, Michael S. Tsirkin wrote:
> On Fri, Jan 25, 2019 at 03:12:45PM +0000, Stefan Hajnoczi wrote:
> > Based on the Linux guest driver code and the lack of more evidence in
> > the spec, I'm pretty sure data[] doesn't need to be padded to 512 bytes
> > for discard/write zero requests.
>=20
> OK. Must devices support such padding?

I see no reason to require padding.  Host APIs and physical storage
controllers do not require it.

> > > Looking at the QEMU sources, it seems like it can deal with both and
> > > always sets the status right behind the last byte:
> > >=20
> > >     req->in =3D (void *)in_iov[in_num - 1].iov_base
> > >               + in_iov[in_num - 1].iov_len
> > >               - sizeof(struct virtio_blk_inhdr);
> > >=20
> > > Anyway, I think the virtio spec should be clearer here to avoid bad
> > > implementations in the future, so maybe Changpeng or Michael could
> > > update the spec here a little bit?
> >=20
> > Yep, good point.  VIRTIO 1.1 is available for public comments, so I've
> > CCed the list.
> >=20
> > Stefan
>=20
> Thanks!
> Care creating a github issue? And maybe proposing a spec patch.

Okay.  I will do this on Wednesday 30th of January.

Stefan

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcTaqwAAoJEJykq7OBq3PI5EMIAL5RlXi3OXGuij11tSpqsIGe
EBBEO4B4RUVUmre3fbSwlHeaC2QR4/NpeFEjHckNpxhGT6AB+hOa9haSH9uD+3n/
o+lidkVfkFX6pNNANMxc75Xg7MlXY0z3Jt/pWncThSIqpOC+zF9tbzuQN+0FUVQ8
RBQKi6b7h4SuFpa3Fl5x4KQV/YwwrTGQf67yCirHIyaMbcyBVoUci4Y2OViCl2CC
AeDah/vNHlgFg/FJiRHMXtdLFuPeSE7NdEh+7gK3vdb/Bz+8vxt/vDe9Ze/MuI2n
+JzK8rBeh2xm1EPqZTQ36W4zuC0N6JkEH3nxrT3zJzQnk//g8x7jOW1lHrPZFQg=
=HxOX
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
