Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97ADC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732B32084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpYhCiIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732B32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUVtL-0006JB-L9
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 08:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iUVsT-0005qr-GZ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iUVsS-0007GT-DF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:06:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iUVsS-0007G5-A3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573563995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GhUpOcFwDPlFTNMXz20EkzoWqAXRzViWvjWIIN2c04=;
 b=SpYhCiIoEUr6WWu+FQJ6YBOUCpbOzY7aiTDmOESLTgtjxceTSRKKeP3Mhl+0d46Iesz4QE
 uE/1CGQGzXHHLgmuFjPs5upswVG5GnUZP/oiezl/AogGiaprCL5qi8d8lCVS0gh5kVyj/+
 hvdKLwa/EM6ob6vPTvrTNZaXTLT72t4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-EqYtHMDiN1eAejnnwmnUeA-1; Tue, 12 Nov 2019 08:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C66800C72;
 Tue, 12 Nov 2019 13:06:30 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D89686090D;
 Tue, 12 Nov 2019 13:06:26 +0000 (UTC)
Date: Tue, 12 Nov 2019 14:06:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 023/126] hw/vfio/ap: drop local_err from vfio_ap_realize
Message-ID: <20191112140624.5a582db7.cohuck@redhat.com>
In-Reply-To: <20191011160552.22907-24-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-24-vsementsov@virtuozzo.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EqYtHMDiN1eAejnnwmnUeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 19:04:09 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> No reason for local_err here, use errp directly instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/vfio/ap.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index da6a20669d..db816e1860 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -87,16 +87,14 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vap=
dev, Error **errp)
> =20
>  static void vfio_ap_realize(DeviceState *dev, Error **errp)
>  {
> -    int ret;
>      char *mdevid;
> -    Error *local_err =3D NULL;
>      VFIOGroup *vfio_group;
>      APDevice *apdev =3D AP_DEVICE(dev);
>      VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(apdev);
> =20
> -    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
> +    vfio_group =3D vfio_ap_get_group(vapdev, errp);
>      if (!vfio_group) {
> -        goto out_err;
> +        return;
>      }
> =20
>      vapdev->vdev.ops =3D &vfio_ap_ops;
> @@ -113,18 +111,10 @@ static void vfio_ap_realize(DeviceState *dev, Error=
 **errp)
>       */
>      vapdev->vdev.balloon_allowed =3D true;
> =20
> -    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_er=
r);
> -    if (ret) {
> -        goto out_get_dev_err;
> -    }
> -
> -    return;
> +    vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);

This looks wrong; you still need to check for the outcome of
vfio_get_device().

> =20
> -out_get_dev_err:
>      vfio_ap_put_device(vapdev);
>      vfio_put_group(vfio_group);
> -out_err:
> -    error_propagate(errp, local_err);
>  }
> =20
>  static void vfio_ap_unrealize(DeviceState *dev, Error **errp)


