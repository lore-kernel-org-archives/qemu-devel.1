Received: from eggs.gnu.org ([2001:4830:134:3::10]:60186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqiaA-000715-Q6
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqia5-0003Sp-0e
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:53:54 -0400
Date: Wed, 22 Mar 2017 15:53:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170322155344.GA16717@stefanha-x1.localdomain>
References: <20170228132132.20231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20170228132132.20231-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: always use handle_aio_output if
 registered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com, mst@redhat.com


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 02:21:32PM +0100, Paolo Bonzini wrote:
> Commit ad07cd6 ("virtio-scsi: always use dataplane path if ioeventfd is
> active", 2016-10-30) and 9ffe337 ("virtio-blk: always use dataplane
> path if ioeventfd is active", 2016-10-30) broke the virtio 1.0
> indirect access registers.
>=20
> The indirect access registers bypass the ioeventfd, so that virtio-blk
> and virtio-scsi now repeatedly try to initialize dataplane instead of
> triggering the guest->host EventNotifier.  Detect the situation by
> checking vq->handle_aio_output; if it is not NULL, trigger the
> EventNotifier, which is how the device expects to get notifications
> and in fact the only thread-safe manner to deliver them.
>=20
> Fixes: ad07cd6
> Fixes: 9ffe337
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0p4IAAoJEJykq7OBq3PIolUIAK5AVQO7mBFWsyW3iaSJ2rfc
QBXNu9egf39P6vcXy7PB1/cNWpogR+XlEsGiH6v5zUS1x2asIkjZqQPrzRKmP0FP
TrjbWrpa+aVvc/n9rGBtRQBWJsNemtilmx7p5JoTfzbW+AqkDE41QjbV9NGEYBbo
hrFZdpGb09ZfcIVG2z8RpDTeQ/1Xman3T1qtpHehzvo83UsN0NHaCYCOUHN6pZWC
q0XpgI2e5r6gO7Vls2YGoR/FyF55wckbOMyo+4fINOGU3yIWyDFD+TGp2o+7cxte
myreyGR908jy525/bMXqiPdU5Tf4Fqicv+w7GC/xL3N/5iNnSFOoz8LAn1DcZlw=
=BXsT
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
