Received: from eggs.gnu.org ([2001:4830:134:3::10]:55350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxPV-0006aj-Nb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxPQ-0001Jo-Mf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:31:45 -0400
Date: Mon, 20 Mar 2017 13:31:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320133137.GR17887@stefanha-x1.localdomain>
References: <1489476305-27139-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TDVcAd+kFgbLxwBe"
Content-Disposition: inline
In-Reply-To: <1489476305-27139-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: reset modern vq meta data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 03:25:05PM +0800, Jason Wang wrote:
> We don't reset proxy->vqs[].{num|desc[]|avail[]|used[]}. This means if
> a driver enable the vq without setting vq address after reset. The old
> addresses were leaked. Fixing this by resetting modern vq meta data
> during device reset.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TDVcAd+kFgbLxwBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz9m4AAoJEJykq7OBq3PIU4IH/Rsoy8W0o1JNULPta7+DwRAr
2CwLiQrUaWVzfoqoFARLgDCzhRq6bNLlMGtE4yrUfHnH3ftMjiGfKsGqssJFxHwL
OgTElo9U9m0vxcfjDPTAPvUoGYvxZckwXd4qog4xFb00foLjAncKpdGZGvrD287w
vqEhkq0nIz2JDpYPVyobTBMMsF5jR8DN1fVJJoX4XHagtscfFHEkc9K1Bd0rhUoi
hYBoAV6Y1x5zxB6ZaAQ3LqEGOGJ/GLwLl7PI1aZGezfcysKq/XdiAgZZsEhDx8f4
B7JK9lZLwqaS2tr+xodG8rFNtfrFtTIjagznUFT5T6hJWO91VPCRVZufzVJdGHc=
=R2mp
-----END PGP SIGNATURE-----

--TDVcAd+kFgbLxwBe--
