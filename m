Received: from eggs.gnu.org ([2001:4830:134:3::10]:43868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdJay-0001qo-MA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdJat-0008Do-Qb
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:35:20 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdJat-0008DQ-Kb
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:35:15 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so20351242wmv.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 08:35:15 -0800 (PST)
Date: Mon, 13 Feb 2017 16:35:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213163512.GP10361@stefanha-x1.localdomain>
References: <20170209084047.7897-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kOdvwer/5gjFgNo6"
Content-Disposition: inline
In-Reply-To: <20170209084047.7897-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Report real progress in VQ aio
 poll handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--kOdvwer/5gjFgNo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 04:40:47PM +0800, Fam Zheng wrote:
> In virtio_queue_host_notifier_aio_poll, not all "!virtio_queue_empty()"
> cases are making true progress.
>=20
> Currently the offending one is virtio-scsi event queue, whose handler
> does nothing if no event is pending. As a result aio_poll() will spin on
> the "non-empty" VQ and take 100% host CPU.
>=20
> Fix this by reporting actual progress from virtio queue aio handlers.
>=20
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c |  4 ++--
>  hw/block/virtio-blk.c           | 12 ++++++++++--
>  hw/scsi/virtio-scsi-dataplane.c | 14 +++++++-------
>  hw/scsi/virtio-scsi.c           | 14 +++++++++++---
>  hw/virtio/virtio.c              | 15 +++++++++------
>  include/hw/virtio/virtio-blk.h  |  2 +-
>  include/hw/virtio/virtio-scsi.h |  6 +++---
>  include/hw/virtio/virtio.h      |  4 ++--
>  8 files changed, 45 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kOdvwer/5gjFgNo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYoeBAAAoJEJykq7OBq3PIbIoH/2MSk/5WACDDAGqFwdRUT0a6
l0/SP8G2rn26tZQ/glgo2Bu37+zm3s2iPmB2pX9q2sQV3l8J98GTEf0+iSRKYI+r
fKuLLGb7q1nO6j2BgcMFXj+P66f2ROYChgn/2PLMPhXJDNRkz5rXa+CFhteThbI7
eGCHnvyaSvY3kGW4r0IJ4qAgNfg4u+euWCpFHg4gxoKYSlpaGqyz0z7vQ3bGZQ7b
uNAb5DKlNQTHjoJSjGF9XAZikiJFubd6baRG4+t+NL8FTs1OkMys/QXwxW5Ae8df
zYnCYHWyjL+jzVfuIvuQa9X8RCktsAgnyRHJ2ZK81nKj7VsDLNBa8NhdlHXRz9k=
=aUxs
-----END PGP SIGNATURE-----

--kOdvwer/5gjFgNo6--
