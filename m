Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E7ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0046020663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0046020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJx2H-0002eY-5H
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iJx1d-0002Ey-N5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iJx1c-0006by-9P
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iJx1c-0006ak-0F
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAA68883831
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:52:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4AA360605;
 Mon, 14 Oct 2019 09:52:15 +0000 (UTC)
Date: Mon, 14 Oct 2019 10:52:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 6/7] libqos: make the virtio-pci BAR index configurable
Message-ID: <20191014095214.GI22963@stefanha-x1.localdomain>
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-7-stefanha@redhat.com>
 <877e5bqyfq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <877e5bqyfq.fsf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 14 Oct 2019 09:52:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 02:06:01PM +0200, Sergio Lopez wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > The Legacy virtio-pci interface always uses BAR 0.  VIRTIO 1.0 may need
> > to use a different BAR index, so make it configurable.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/libqos/virtio-pci.h | 2 ++
> >  tests/libqos/virtio-pci.c | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> > index b620c30451..f2d53aa377 100644
> > --- a/tests/libqos/virtio-pci.h
> > +++ b/tests/libqos/virtio-pci.h
> > @@ -25,6 +25,8 @@ typedef struct QVirtioPCIDevice {
> >      uint16_t config_msix_entry;
> >      uint64_t config_msix_addr;
> >      uint32_t config_msix_data;
> > +
> > +    uint8_t bar_idx;
> >  } QVirtioPCIDevice;
> > =20
> >  struct QVirtioPCIMSIXOps {
> > diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> > index 3fb4af4016..efd8caee18 100644
> > --- a/tests/libqos/virtio-pci.c
> > +++ b/tests/libqos/virtio-pci.c
> > @@ -300,7 +300,7 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops=
_legacy =3D {
> >  void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
> >  {
> >      qpci_device_enable(d->pdev);
> > -    d->bar =3D qpci_iomap(d->pdev, 0, NULL);
> > +    d->bar =3D qpci_iomap(d->pdev, d->bar_idx, NULL);
> >  }
> > =20
> >  void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
> > @@ -389,6 +389,7 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
> >  static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
> >  {
> >      dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYST=
EM_ID);
> > +    dev->bar_idx =3D 0;
> >      dev->vdev.bus =3D &qvirtio_pci_legacy;
> >      dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
> >      dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
>=20
> qpci_iomap() is also called with a hardcoded bar at
> virtio-blk-test.c:test_nonexistent_virtqueue(). Should it be fixed here
> or in a future patch?

That virtio-blk-pci-specific continues to work because the
virtio-blk-pci device is a Transitional device that still supports
Legacy mode in BAR 0.

Also, that test doesn't use the libqos virtio API so there is no
conflict between it and this patch series.

Stefan

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2kRU0ACgkQnKSrs4Gr
c8j9ygf+LxlJPh8jRD9EzKPaGs/yhhW0QNqOCA86zD+26GhYCtnKNu8mxCSoMXvu
Zz6rjI9N4RoM1whIYHq7K8DPSifEk4nwSrTDEw+3cNgcw77zm5cDBT8GEQUrn9D7
riiJFp23Hhc/yeQb3s9Xjj0dqFKlBjJ5gAlUArmxNhEyUoJNCdPwgZX7MDXlVnjH
kR1I6l+Xzx8HUJog74OdM9OkPXHhn6vNSRlbP90Qlj7MPVP6AWyQYf8XWGP0iMnY
oOKf4qtqh5gPKUPKKpfjgKRN+OuTffnd7yZls+1Z1Z9rsc+AbLVGIXqE8MElrZgo
PxjfZLzMFnGCkVLd4UcspYZvg5gtJw==
=wv2n
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--

