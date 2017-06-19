Received: from eggs.gnu.org ([2001:4830:134:3::10]:35809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMvi9-0006Wa-PY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMvi6-0005Ai-Ko
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dMvi6-0005Aa-5H
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:23:14 -0400
Date: Mon, 19 Jun 2017 13:23:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170619122306.GH17304@stefanha-x1.localdomain>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-2-stefanha@redhat.com>
	<20170616171149-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline
In-Reply-To: <20170616171149-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-pci: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 05:12:18PM +0300, Michael S. Tsirkin wrote:
> On Thu, Jun 15, 2017 at 05:38:09PM +0100, Stefan Hajnoczi wrote:
> > Old kvm.ko versions only supported a tiny number of ioeventfds so
> > virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> >=20
> > Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> > always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> > ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> > qtest or TCG mode.
> >=20
> > This patch makes -device virtio-blk-pci,iothread=3Diothread0 work even
> > when KVM is disabled.
> >=20
> > I have tested that virtio-blk-pci works under TCG both with and without
> > iothread.
> >=20
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Do you want to merge this with the rest of the patchset,
> or should I?

It can go through Kevin's tree as part of this patch series.

Thanks,
Stefan

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZR8IqAAoJEJykq7OBq3PICscH/0pJTPtm66iaKt+svOTMEXho
Dg9xAmwN6AbDXWXpBj9vHTA+FZ72A0WPz+ElvCVVlXN/jMk4algF4sV5qfuebya1
alUNwLL2KFBMGrqeTQ5Fv4UobGDc7IagaYZL76jEKwxjfc0fbKhkamgKi3+dWQln
qIzAphPWwI03ig257DcR9FToVg0B4ysin4UdSOHecaOdDTU943NQNOMmuwakOE2d
CRl/zSXMrGjVitFVHJ3X8/rBCiQCIzYlSU8+Z0FosxGk3QjdAsnbCgeoxSX64X9n
C6MgJxOGsFY2kUkjVol1Y7Ga2PgeTv5dysTCBlXlQI+tWXs5ow12bc7N8zJbiTM=
=ERSq
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
