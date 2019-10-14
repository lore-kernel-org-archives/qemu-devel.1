Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49C4ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793AF20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793AF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxtb-0006dw-Ho
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iJxsY-0006BH-8V
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iJxsW-0002h2-0F
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iJxsV-0002eq-Lw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:47:03 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC2F28553D
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:47:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i14so8321480wro.19
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=A7dB7NuiHuhHdxP5Zx1Nc3ItnZn4fE1OcGpaYrrdZdk=;
 b=qFTjDLxapNIgRcI4X73c5yz/NcAO7TivPcPOrxh/ktzkGC3rqBtpMpthHmvJDHZyxJ
 VLkGsDdfs5qp/wneyMQfZSJ4YACYOzmzM3uCgFk7n8mSNTCvOZxvae4wQELoKHejFCm3
 FV5eQPjc8PFjPM63+pLoxMhAzbb31dau/OZt/3si6B8sdageeLMPfyjmN8tWg6AebGzC
 +Q71HXNJEc5Gpn1OF7xyNXrxxanpAagWeb57KEPoqUkjtpKhkIfSrIUrlph9jkp9uaLQ
 9jPbcuG0EPGAWBDrU5fFO0pQMny82ok6usv0WvHABM7QmzKUqKcqQA00mVW9eH3kescV
 YRww==
X-Gm-Message-State: APjAAAV/HDgRqjTmgeSqX/GCp5lstnECymZaLzOKhpiIb86pagkcxyy1
 6YhceLBqn20P/4nAWQsBCvoJ9plvjmnHWpFnw9N7NdW4t6l3XZCUh7gjsnix8f1XWK4BP9oL6iK
 N5HlAxev4dAESBi4=
X-Received: by 2002:a5d:5587:: with SMTP id i7mr25231022wrv.57.1571050020474; 
 Mon, 14 Oct 2019 03:47:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCPbIU6FmnhXOYuPOQoM4tRsoxFZfCE9bsY0dvjBeqM/kwLqGQE5K+R4b2uYd7p1SwBZ93vA==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr25230999wrv.57.1571050020235; 
 Mon, 14 Oct 2019 03:47:00 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id a204sm30040864wmh.21.2019.10.14.03.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:46:59 -0700 (PDT)
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-7-stefanha@redhat.com> <877e5bqyfq.fsf@redhat.com>
 <20191014095214.GI22963@stefanha-x1.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 6/7] libqos: make the virtio-pci BAR index configurable
In-reply-to: <20191014095214.GI22963@stefanha-x1.localdomain>
Date: Mon, 14 Oct 2019 12:46:53 +0200
Message-ID: <87imorzjs2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Oct 11, 2019 at 02:06:01PM +0200, Sergio Lopez wrote:
>>=20
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > The Legacy virtio-pci interface always uses BAR 0.  VIRTIO 1.0 may need
>> > to use a different BAR index, so make it configurable.
>> >
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> >  tests/libqos/virtio-pci.h | 2 ++
>> >  tests/libqos/virtio-pci.c | 3 ++-
>> >  2 files changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
>> > index b620c30451..f2d53aa377 100644
>> > --- a/tests/libqos/virtio-pci.h
>> > +++ b/tests/libqos/virtio-pci.h
>> > @@ -25,6 +25,8 @@ typedef struct QVirtioPCIDevice {
>> >      uint16_t config_msix_entry;
>> >      uint64_t config_msix_addr;
>> >      uint32_t config_msix_data;
>> > +
>> > +    uint8_t bar_idx;
>> >  } QVirtioPCIDevice;
>> >=20=20
>> >  struct QVirtioPCIMSIXOps {
>> > diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
>> > index 3fb4af4016..efd8caee18 100644
>> > --- a/tests/libqos/virtio-pci.c
>> > +++ b/tests/libqos/virtio-pci.c
>> > @@ -300,7 +300,7 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_op=
s_legacy =3D {
>> >  void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
>> >  {
>> >      qpci_device_enable(d->pdev);
>> > -    d->bar =3D qpci_iomap(d->pdev, 0, NULL);
>> > +    d->bar =3D qpci_iomap(d->pdev, d->bar_idx, NULL);
>> >  }
>> >=20=20
>> >  void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
>> > @@ -389,6 +389,7 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
>> >  static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
>> >  {
>> >      dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYS=
TEM_ID);
>> > +    dev->bar_idx =3D 0;
>> >      dev->vdev.bus =3D &qvirtio_pci_legacy;
>> >      dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
>> >      dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
>>=20
>> qpci_iomap() is also called with a hardcoded bar at
>> virtio-blk-test.c:test_nonexistent_virtqueue(). Should it be fixed here
>> or in a future patch?
>
> That virtio-blk-pci-specific continues to work because the
> virtio-blk-pci device is a Transitional device that still supports
> Legacy mode in BAR 0.
>
> Also, that test doesn't use the libqos virtio API so there is no
> conflict between it and this patch series.

OK, in that case:

Reviewed-by: Sergio Lopez <slp@redhat.com>

> Stefan


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2kUh4ACgkQ9GknjS8M
AjXvwA//c3KMrz5ao6V/QPG49v41KB72/wwS/bkiDRTcNJG8Gd7eWqby/xZ/mtXS
MwvMPi23HBdRb3cTBtzFwKxd+dLs2TMiBjO6TSG89L6/culiHrt9p5SyqkQIdEjt
onAmrq/u+68uK06CrnnxQ64p2VeczW8UYQfbxdCqyzsN2zL9t3t9/m3tlM571zan
EjDVtGYcdbFI7kV/1WCvqMrShqOekwfgvVDdDBPuRNnPhSsFfcahmEsDzRqJBfyH
bauDLAT7F5/JY7l7sOVDnUHV43EKzgZmZ0hphrCix/LfaYMso/2XBLcJtlEY4340
ZEIhRdrFWd6a1Q8rhDP2TVbWVQFzRYB1Sq/o9iEdEvqvF2PhCucVBTk6upksDzV6
tNeRjBptCGJY1cFFUtgreSzCm1oOO6EEoNmDrq4fL2ig+Oj6sgNWGAACqYxqoQUG
3C7QkGkLwT7K0B6/6/93tWP+lFZ+id3tARInaA58zKY7gwy5kcGmQM6/lwiw4rR5
oPMuEep8EOw+NVj8zWvV1DVJTsAAGWhaH3Zcr4G0+6y5PuxMH9hbTS7/g5lCXutT
BUyA4yYhtQFBYbJo0GJwznKp0hfW5/VnB9qS9l3zxApaWSXElEywfmEBMIbHFM24
AXUjI2/wyoo1DCVp5SVDCah0idbtkkGImZxQ8ai5/BSwT0CZM8Q=
=yftF
-----END PGP SIGNATURE-----
--=-=-=--

