Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835A420792
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IieVOdUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835A420792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Mvp-00037h-RC
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0Mu3-000159-Ec
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:32:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0Mu1-0001zw-Id
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595932328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2IiINGgl+4WOMVRXCsvIQxzqLWlCEUnL71ntQV405o=;
 b=IieVOdUHsY3jfkIxY7xO5oLVDkvHuFMnsimeUAjs3okDeSnpg4iYUz46+t4LujO2i2S4NX
 rBZ9EHaAOmnRygyj1gNzVFyX8ZFn7xl7qbr54wU+M90TOYi0J8EhqbuNKmSW+uySjA39p3
 9tbAGKXtUeD8piksBjqOeP3gAe5Cv7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-8weZ_ZBZMZSYFye6FB1Myw-1; Tue, 28 Jul 2020 06:32:07 -0400
X-MC-Unique: 8weZ_ZBZMZSYFye6FB1Myw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D97A805723;
 Tue, 28 Jul 2020 10:32:06 +0000 (UTC)
Received: from gondolin (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9335E726BA;
 Tue, 28 Jul 2020 10:31:53 +0000 (UTC)
Date: Tue, 28 Jul 2020 12:31:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 1/3] virtio: add vhost-user-fs-ccw device
Message-ID: <20200728123151.468c252b.cohuck@redhat.com>
In-Reply-To: <20200717092929.19453-2-mhartmay@linux.ibm.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-2-mhartmay@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 11:29:27 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Wire up the CCW device for vhost-user-fs.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs       |  1 +
>  hw/s390x/vhost-user-fs-ccw.c | 73 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 hw/s390x/vhost-user-fs-ccw.c
> 

(...)

> diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
> new file mode 100644
> index 000000000000..88a7a11a34b4
> --- /dev/null
> +++ b/hw/s390x/vhost-user-fs-ccw.c
> @@ -0,0 +1,73 @@
> +/*
> + * Ccw transport wiring for vhost-user-fs

"virtio ccw vhost-user-fs implementation" ?

> + *
> + * Copyright 2020 IBM Corp.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "hw/virtio/vhost-user-fs.h"
> +#include "virtio-ccw.h"
> +
> +typedef struct VHostUserFSCcw {
> +    VirtioCcwDevice parent_obj;
> +    VHostUserFS vdev;
> +} VHostUserFSCcw;
> +
> +#define TYPE_VHOST_USER_FS_CCW "vhost-user-fs-ccw"
> +#define VHOST_USER_FS_CCW(obj) \
> +        OBJECT_CHECK(VHostUserFSCcw, (obj), TYPE_VHOST_USER_FS_CCW)
> +
> +
> +static Property vhost_user_fs_ccw_properties[] = {
> +    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
> +                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
> +                       VIRTIO_CCW_MAX_REV),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_user_fs_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
> +{
> +    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(ccw_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
> +}
> +
> +static void vhost_user_fs_ccw_instance_init(Object *obj)
> +{
> +    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(obj);
> +

This needs

    ccw_dev->force_revision_1 = true;

> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_FS);
> +}
> +
> +static void vhost_user_fs_ccw_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
> +
> +    k->realize = vhost_user_fs_ccw_realize;
> +    device_class_set_props(dc,vhost_user_fs_ccw_properties);
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +}
> +
> +static const TypeInfo vhost_user_fs_ccw = {
> +    .name          = TYPE_VHOST_USER_FS_CCW,
> +    .parent        = TYPE_VIRTIO_CCW_DEVICE,
> +    .instance_size = sizeof(VHostUserFSCcw),
> +    .instance_init = vhost_user_fs_ccw_instance_init,
> +    .class_init    = vhost_user_fs_ccw_class_init,
> +};
> +
> +static void vhost_user_fs_ccw_register(void)
> +{
> +    type_register_static(&vhost_user_fs_ccw);
> +}
> +
> +type_init(vhost_user_fs_ccw_register)


