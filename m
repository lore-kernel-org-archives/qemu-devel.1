Received: from eggs.gnu.org ([209.51.188.92]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUKV-0007IE-HB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUKT-0003eL-Et
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:02:39 -0500
Date: Wed, 20 Feb 2019 16:02:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220160225.GE30403@stefanha-x1.localdomain>
References: <20190218140301.197408-1-sgarzare@redhat.com>
	<20190218140301.197408-6-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <20190218140301.197408-6-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 05/10] virtio-blk: set
 config size depending on the features enabled
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


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:02:56PM +0100, Stefano Garzarella wrote:
> Starting from DISABLE and WRITE_ZEROES features, we use an array of
> VirtIOFeature (as virtio-net) to properly set the config size
> depending on the features enabled.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/block/virtio-blk.c          | 31 +++++++++++++++++++++++++------
>  include/hw/virtio/virtio-blk.h |  1 +
>  2 files changed, 26 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbXoRAAoJEJykq7OBq3PIAPkH/3DRcf2+kjRBzt6dEQqay8AR
z0fUm5fxE5EdPlsgn5Aq3z3HogNdjPLlIqLasjvIcB61mR2QlAK3OMi6j3/0suCz
vQHuT/kl4b2QW1/viEI1rLKlQUBKJA5kHLeibFWO4Fu0LIOeCWSTqyEafKYYWyvj
w+qps7RhHyuuaFQ+4NMYocSgf2BR4uYlmBvdJvdQx9uQKvrR1rMzL0nf2IR70aic
cr3/4sbYoz+FF+4SeRN+rSppN+Fpmq4iC79dD+Qrio16bhktKNZ5iyXCvxHr3g8v
HtJs/GGjgPFkWSEE7NDKNqohD8jEc8rYbILvLDeFSUdbSkW8BNtjWMC/eQOQyHI=
=+IF3
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
