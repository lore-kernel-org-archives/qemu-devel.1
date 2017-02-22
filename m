Received: from eggs.gnu.org ([2001:4830:134:3::10]:40530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgW7b-0007gE-8A
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgW7X-0008MR-Np
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgW7X-0008MJ-I7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:11 -0500
Date: Wed, 22 Feb 2017 11:33:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170222113335.GB3386@stefanha-x1.localdomain>
References: <20170221185901.3256-1-stefanha@redhat.com>
	<20170221185901.3256-3-stefanha@redhat.com>
	<20170222101653.4df25bc4.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20170222101653.4df25bc4.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: add missing region cache init
 in virtio_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 10:16:53AM +0100, Cornelia Huck wrote:
> > @@ -2062,6 +2068,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f,=
 int version_id)
> >      for (i =3D 0; i < num; i++) {
> >          if (vdev->vq[i].vring.desc) {
> >              uint16_t nheads;
> > +
> > +            /* All ring addresses have been loaded now... */
> > +            virtio_init_region_cache(vdev, i);
>=20
> It feels a bit weird that the region cache was already initialized when
> update rings was called. Should the call to init_region_cache be moved
> from update_rings() to virtio_queue_set_addr()?

Will fix in v2.

Stefan

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrXcPAAoJEJykq7OBq3PIHkcH+wVyC4GhTAyrhhi6ata/4Pqy
5tUTI66xF00UAs84b2a+buQDqlzGey8fVJLaqe5yccw+CrE/t3KFg4J/POF7T7uG
8XWGJufp3oYLwdF5l1d6nfTifWz0Iip2ZcBMioc3kYwS3tY8hbBJmEeUxvvptWvx
u+ylB0Yw0WPbQKzsyTeC3P3waVxP1CFmUCpx4nyg7g+lJSoqk+YQPjNaBzPePK/H
3NDx06DUgJcaSI0Oxvj/N8836LL42IMiKNUASZw2Fw5whzWDHC3kn5iA1nUj8hDw
3YB/jUpAcFzyuiNF07XeJrbfqtC83R1GvBkEMVTKqqRUWdsxmbvozFneKvFLKHY=
=iIJG
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
