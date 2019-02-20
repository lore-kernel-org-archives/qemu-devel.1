Received: from eggs.gnu.org ([209.51.188.92]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUTA-00072C-Mv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUT5-0007nq-Tc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:11:34 -0500
Date: Wed, 20 Feb 2019 16:11:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220161115.GF30403@stefanha-x1.localdomain>
References: <20190218140301.197408-1-sgarzare@redhat.com>
	<20190218140301.197408-9-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <20190218140301.197408-9-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/10] tests/virtio-blk:
 add virtio_blk_fix_dwz_hdr() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:02:59PM +0100, Stefano Garzarella wrote:
> This function is useful to fix the endianness of struct
> virtio_blk_discard_write_zeroes headers.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/virtio-blk-test.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbXwjAAoJEJykq7OBq3PIZYIH/2Lmfs3P96+i5z9aEHVhUXO1
m4lcCDEcvBa2QThujSHZJF4r3mIpBS9c5bg0+79CZDk+klK4n2JP/MNtN1P0P6jM
EsD4WVsZdCFhuYNPtXH4rvGi/N5gsqXl3ap5MqZBH04ZeiJB1RrihYn1FxezNzHK
2Z6Dn0SlpVrWc2rU3fFfDAxc6zxpuQqZ1HkOykRsACQ0+MiRgNlUx9ZiG6Kw5+/M
R0iqGHXP9ahynxySOsLuwRun1kOThh12lj1UYquQBaLZpZJRYOKP9y1mRn2+JOdp
wY3MOgUKDkOl2SXVLDeIUP++WRE/daiM/Eaj2PaVBVhOZs+1EVtOOtpmVSs0124=
=bZOX
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
