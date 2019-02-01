Received: from eggs.gnu.org ([209.51.188.92]:40860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpRGH-0005jr-Pl
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpRGH-0008UF-4o
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:21:09 -0500
Date: Fri, 1 Feb 2019 13:15:52 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201051552.GG23131@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-2-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] virtio-blk: add acct_failed param
 to virtio_blk_handle_rw_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 04:19:10PM +0100, Stefano Garzarella wrote:
> We add acct_failed param in order to use virtio_blk_handle_rw_error()
> also when is not required to call block_acct_failed(). (eg. a discard
> operation is failed)
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/block/virtio-blk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU9YIAAoJEJykq7OBq3PI1R4H/j76NrOGgjl74IX2gsusrZiC
Yby2AYyFvr5wDzH6B9Aw0dKzsmzsBaR8qSrviwJsiob+YQ6imMmNL0p/hxvUtr4U
hjaWTcyq1tZLeLq7jvLyxRh03xLRMHOFL7yDSGx7YUYrIKWWeA6xIRjyQW0VV2P/
tTCmrrBndWi49Nrc+7aR7Cpfx5rb8g1ljGdp3QRC6S8HoMrBVBRm/bS85W8jOqB7
gA4lWzQvd9Yqd5S8bce9y5ddmAu1ouL0rBlkv9Y885Ubjw1PXHN1f8PEBTSiARPD
Q4XNqrTm9obH9szYrLoj/RKUIm2lcAP1+ejjRQWm8mtIxMmNMZWXcuawHcPz8VM=
=Nt98
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
