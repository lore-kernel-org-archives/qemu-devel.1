Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D05BC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE2D2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFWRp3nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE2D2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wtA-0001M6-Bw
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6wsQ-0000lX-3U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6wsM-0007cK-81
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:37:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6wsM-0007aO-4K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582724241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zkt/tfJkv3o57wHjyvWxmUMSNt5fOSEp6LXX/Q9jYVY=;
 b=YFWRp3nCxTsW17LefKqTpECyCG7b5t+y/dRuPfB2hrOT8llv5XxA8OnDePtk/614K1alkw
 3/mMnPK8op5LPaMKlmjCD9vha5px7On+tu/D0C6VvbIiwgQjmJX09OVOmrP6W9kbP76NRL
 bJSjhwS89wSalop9ZAi2+xIqOJPRRN4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-ut0FRFFFPWa2_lsQW5A1QQ-1; Wed, 26 Feb 2020 08:37:19 -0500
X-MC-Unique: ut0FRFFFPWa2_lsQW5A1QQ-1
Received: by mail-qk1-f197.google.com with SMTP id t17so4167495qkg.16
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 05:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+BIMN/5SQZr80WV5M0wLLE/vdoBGXEJutKKUqshyxIg=;
 b=jLCyIeDV5l+JNFNWosQAlPHBf9S/Jvi1yloGtJRSurBVx/fNyt+8q4QgRCw/E2fii0
 LjMEa0kLErTaspVYk5WH1CrU7C/+kqgJ6u2L1DSvLJfgfdQ0hJR0k3/ZsmDKUBlMYIe6
 q/23xWIVAzX1j1GWeBwrbJwo4iVjFYTR2rRbGiz2Z9hMcvQsfP/Ir4U2q8htVeC+DXRw
 CwulwvEh+DNmMpwMywb6lOV4ju3ipTebFchq4mHiEtKoj9MI00sKAJ1F/J4G9RvixB22
 shAc6paGtx/R5UipmHxNZnZM1ZmZCcQlEIQ1oAuSBhcku6ng6664fRFDa4mEtgB7lPwI
 2Leg==
X-Gm-Message-State: APjAAAULlltNqg8M9GJFZmp0Kb/2FhZJeLuLF/wZ3fpq/4BaymBRmgN9
 IXIMgmyrWrv6NrTS/JX6VirSletumyUUxnBEGf0pVNoXan0oFrlLARThqH4lT22PW8h1OAvZh9p
 +xysbOYD2hNLUG3M=
X-Received: by 2002:a37:27c2:: with SMTP id n185mr5725893qkn.423.1582724238723; 
 Wed, 26 Feb 2020 05:37:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3mIwG64RyguvEipBJrzRMxJTiDSwLNPIQdP2aatvK9IsyoAJMyCCD3/hC+/cuU2BKpY4WpA==
X-Received: by 2002:a37:27c2:: with SMTP id n185mr5725855qkn.423.1582724238451; 
 Wed, 26 Feb 2020 05:37:18 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 f26sm1053883qtv.77.2020.02.26.05.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 05:37:17 -0800 (PST)
Date: Wed, 26 Feb 2020 08:37:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226083654-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200226142839.4263de9b.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 02:28:39PM +0100, Halil Pasic wrote:
> On Wed, 26 Feb 2020 17:43:57 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
> > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
> > platform without IOMMU support. This can lead unnecessary IOTLB
> > transactions which will damage the performance.
> >=20
> > Fixing this by check whether the device is backed by IOMMU and disable
> > device IOTLB.
> >=20
> > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>=20
> Tested-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>=20
> Thank you very much for fixing this! BTW as I mentioned before it
> fixes vhost-vsock with iommu_platform=3Don as well.

Fixes as in improves performance?

> Regards,
> Halil
>=20
> > ---
> > Changes from V1:
> > - do not check acked_features
> > - reuse vhost_dev_has_iommu()
> > ---
> >  hw/virtio/vhost.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 9edfadc81d..9182a00495 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev *d=
ev)
> >  {
> >      VirtIODevice *vdev =3D dev->vdev;
> > =20
> > -    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > +    /*
> > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > +     * incremental memory mapping API via IOTLB API. For platform that
> > +     * does not have IOMMU, there's no need to enable this feature
> > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > +     */
> > +    return vdev->dma_as !=3D &address_space_memory &&
> > +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> >  }
> > =20
> >  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> > @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_dev =
*dev,
> >      if (enable_log) {
> >          features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> >      }
> > +    if (!vhost_dev_has_iommu(dev)) {
> > +        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > +    }
> >      r =3D dev->vhost_ops->vhost_set_features(dev, features);
> >      if (r < 0) {
> >          VHOST_OPS_DEBUG("vhost_set_features failed");


