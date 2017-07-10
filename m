Received: from eggs.gnu.org ([2001:4830:134:3::10]:45342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUbUr-0004gr-Dh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUbUq-0007ff-MN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:25:17 -0400
Date: Mon, 10 Jul 2017 17:25:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710162505.GT14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zpd1bWBxfrI+71+6"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Block layer thread-safety,
 next part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--zpd1bWBxfrI+71+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:17PM +0200, Paolo Bonzini wrote:
> Here, patches 1-6 make the remaining part of the block layer thread safe.
> Patches 7-11 start removing aio_context_acquire/release, so the line
> count goes down instead of up.
>=20
> This is the penultimate series.  The remaining part makes virtio-blk,
> virtio-scsi and block jobs thread safe, so that the AioContext lock
> can go away altogether.

Looks promising.  I replied to the last patch with my overall concern
about this series.

Stefan

--zpd1bWBxfrI+71+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6phAAoJEJykq7OBq3PI1EQH/jDMJdIlOsp4wHaoUSBDhWF4
0Ra596SMD9ZDmwLkJzrLBaEZfdkiwaKdyT2RbiUPpee8vDfMNFl792KiqYk0HiQ8
oWXeYLuQA2ppGjRJmUYjNe56WbZq8zUN4aihRSEyinWT67Ef3of6W+CrfPuZPMNT
tGJP7Q/eH1LjHoTrCE2tOsNNZ7VP9DWn6wRbOgbGr9wlcpn5NGUdQW6j5dkichhD
JvSouCjKiX0KMfCIyOjETCGDvRwhX6aDKeocA6363q60C+t1LT2aL41p74Lj4evG
GJpC9x8ILkDIxZYA04dRDk2kgzbWxuNW5+RsATOJ0WRTreVugTbNy2m8cNBJhQM=
=M3ga
-----END PGP SIGNATURE-----

--zpd1bWBxfrI+71+6--
