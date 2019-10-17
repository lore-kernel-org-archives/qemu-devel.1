Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF69ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABD420820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABD420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL95c-00070L-5b
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iL8JT-00025W-P5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iL8JR-0007eI-G7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iL8JR-0007dX-82
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:07:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8629081DE0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:07:39 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC42600C4;
 Thu, 17 Oct 2019 16:07:36 +0000 (UTC)
Date: Thu, 17 Oct 2019 17:07:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 7/7] libqos: add VIRTIO PCI 1.0 support
Message-ID: <20191017160735.GB1266@stefanha-x1.localdomain>
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-8-stefanha@redhat.com>
 <e7821640-de44-5e65-b9c1-2534dc676690@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <e7821640-de44-5e65-b9c1-2534dc676690@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 17 Oct 2019 16:07:39 +0000 (UTC)
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
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 04:52:54PM +0200, Thomas Huth wrote:
> On 11/10/2019 10.56, Stefan Hajnoczi wrote:
> > Implement the VIRTIO 1.0 virtio-pci interface.  The main change here is
> > that the register layout is no longer a fixed layout in BAR 0.  Instead
> > we have to iterate of PCI Capabilities to find descriptions of where
> > various registers are located.  The vring registers are also more
> > fine-grained, allowing for more flexible vring layouts, but we don't
> > take advantage of that.
> >=20
> > Note that test cases do not negotiate VIRTIO_F_VERSION_1 yet and are
> > therefore not running in VIRTIO 1.0 mode.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/Makefile.include           |   1 +
> >  tests/libqos/virtio-pci-modern.h |  17 ++
> >  tests/libqos/virtio-pci.h        |  10 +
> >  tests/libqos/virtio-pci-modern.c | 412 +++++++++++++++++++++++++++++++
> >  tests/libqos/virtio-pci.c        |   6 +-
> >  5 files changed, 445 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/libqos/virtio-pci-modern.h
> >  create mode 100644 tests/libqos/virtio-pci-modern.c
> [...]
> > +static bool probe_device_type(QVirtioPCIDevice *dev)
> > +{
> > +    uint16_t vendor_id;
> > +    uint16_t device_id;
> > +
> > +    /* "Drivers MUST match devices with the PCI Vendor ID 0x1AF4" */
> > +    vendor_id =3D qpci_config_readw(dev->pdev, PCI_VENDOR_ID);
> > +    if (vendor_id !=3D 0x1af4) {
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * "Any PCI device with ... PCI Device ID 0x1000 through 0x107F in=
clusive
> > +     * is a virtio device"
> > +     */
> > +    device_id =3D qpci_config_readw(dev->pdev, PCI_DEVICE_ID);
> > +    if (device_id < 0x1000 || device_id > 0x107f) {
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * "Devices MAY utilize a Transitional PCI Device ID range, 0x1000=
 to
> > +     * 0x103F depending on the device type"
> > +     */
> > +    if (device_id < 0x1040) {
> > +        /*
> > +         * "Transitional devices MUST have the PCI Subsystem Device ID=
 matching
> > +         * the Virtio Device ID"
> > +         */
> > +        dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUB=
SYSTEM_ID);
>=20
> Shouldn't you return "false" here in case the device_type is 0 ? Which
> likely means that it is a legacy or broken device ...?

The real decision whether to use this PCI device or not happens in
probe_device_layout().  If it's broken or a legacy device then that
function will fail.

Stefan

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2okccACgkQnKSrs4Gr
c8jEGAf+Ma7nNS+KvXyutmlXsX5EpM9t/dRWZcvIhdphv31dB1/3oxMLynnB9ggZ
vqdJ5/Bc9Ay3EptH8QxxJVm/yGMTXp5iu3zvsTHZuCs3xfgfCdCmIHpyeSHis0fl
R4sqUAvfXd4zgMxotmre1HzohCT33DCP+H/L09KVVV4F9DUS8AKWCti6tAdKOsGn
rFKku0gHTIXbLdEn1YsdZpgcmhvxw+eb0PKnnf8NzsrES87lc0EuPnQPF4TMoUOe
Bmp9x0i2AUqjLCSsAdT2x7oo+SHgKfUwu/5t3ZaY7s9pihwkg+sd3xri1pnqTEjv
tEOa+pR8hKXBz4RnVl/W9T/CydI/cQ==
=1ahQ
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

