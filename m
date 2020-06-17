Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9757FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6069A2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqvSvXxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6069A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlOMy-0003LI-L7
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 23:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jlOMK-0002bL-5E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 23:03:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jlOMH-0003ko-6v
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 23:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592363003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KuZxUWg0DnnZNzeOud5e4DykVaw6yjrY9Y4ELFAc7TQ=;
 b=LqvSvXxyi/GX8sWd1a/KS43Zcdwy+lAYc1VDnNEuxqXy3G8sVm8QxtRJeSy7SHTRVltdlJ
 AFCuQmNxSSQxz4IOElMCDZ5UKdVns76mC2qNK6TFtIRk6UxhCSFlTo+poHCx9yxlKhZjiu
 QcRK5aCFXJZFBOGxPmg1K7P82oYupi4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-A0e2kUZRPRCJTG0sozqmTA-1; Tue, 16 Jun 2020 23:03:22 -0400
X-MC-Unique: A0e2kUZRPRCJTG0sozqmTA-1
Received: by mail-pl1-f199.google.com with SMTP id f18so522516plj.15
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 20:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KuZxUWg0DnnZNzeOud5e4DykVaw6yjrY9Y4ELFAc7TQ=;
 b=TIVB1P2xLVAywgrr0FAUHfiPLZ2Pn2R5Y2FoIKUA7bngupB4swviWDp1gKhqW1X70D
 4fehufzze0R+S8iDCsycoqq3vfg+vWE01on7L80q15ZdKDgwKs1w7BBFPFceIMHBjW7a
 D8c/Q5kjapNcJD8krfrQ9c4LgYcnoKGkascKGuwQ4/c6rVBZPOo8ine1yNKv4rsN18ol
 +Y2flxTMzsr9YGGrpi+DhzseF3wMuLARDRkcndti9LNKTEUx5OpJgUotfGxQYIMcEiCR
 SuLezJMRLOBTq3qgAomGarKIBMurvsbrKJ1rDKAwREcSYdYCvQwaaaMAJm5GDvOq2YRq
 laig==
X-Gm-Message-State: AOAM533kRnexwxPosw3UqhWlqFt4VwyE5dxIEz/2gbhNgpYOX0YNPy2z
 weS/CTvEqBB0AEL03/FNoe84qUE1wmyRfi8mARwEyvM+Dt76zrHlmX/Udl+3Zqz/JoWOzcfiU7T
 1XT6dJjDHbhACugaSgqucLd4/QapwA+M=
X-Received: by 2002:a17:90a:250b:: with SMTP id
 j11mr6270629pje.194.1592363001173; 
 Tue, 16 Jun 2020 20:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkfTzauGu/D5vfdMLqASeh+qCgTDbG1GRIGYsBSU7kOxyVZOC23eQ0DgoCu8nkcQflIc0OgxzqF8xUTMwE+GY=
X-Received: by 2002:a17:90a:250b:: with SMTP id
 j11mr6270577pje.194.1592363000866; 
 Tue, 16 Jun 2020 20:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-7-lulu@redhat.com>
 <5d4c5c2d-ffba-c37a-f710-aaa23c395315@redhat.com>
In-Reply-To: <5d4c5c2d-ffba-c37a-f710-aaa23c395315@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 17 Jun 2020 11:03:10 +0800
Message-ID: <CACLfguXoHxe6M5ouSdMdgYdnC9Mvu6nXkOcWR9D4kOjQndw0Uw@mail.gmail.com>
Subject: Re: [RFC v3 6/8] vhost-backend: export the vhost backend helper
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 22:15:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 4:17 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 29/05/2020 16:06, Cindy Lu wrote:
> > export the helper then we can reuse some of them in vhost-vdpa
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/vhost-backend.c         | 34 ++++++++++++++++++-------------
> >  include/hw/virtio/vhost-backend.h | 28 +++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 48905383f8..42efb4967b 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -14,7 +14,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> >  #include "standard-headers/linux/vhost_types.h"
> > -
> > +#include "hw/virtio/vhost-vdpa.h"
>
> You can't include this file because it is created in the next patch.
>
> >  #ifdef CONFIG_VHOST_KERNEL
> >  #include <linux/vhost.h>
> >  #include <sys/ioctl.h>
> > @@ -22,10 +22,16 @@
> >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
> >                               void *arg)
> >  {
> > -    int fd = (uintptr_t) dev->opaque;
> > -
> > -    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_KERNEL);
> > -
> > +    int fd = -1;
> > +    struct vhost_vdpa *v = NULL;
> > +    if (dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_KERNEL) {
> > +        fd  = (uintptr_t) dev->opaque;
> > +    }
> > +    if (dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA) {
> > +        v = dev->opaque;
> > +        fd = v->device_fd;
> > +    }
> > +    assert(fd != -1);
>
> A switch would be cleaner:
>
>     switch (dev->vhost_ops->backend_type) {
>     case VHOST_BACKEND_TYPE_KERNEL:
>         fd  = (uintptr_t)dev->opaque;
>         break;
>     case VHOST_BACKEND_TYPE_VDPA:
>         fd = ((struct vhost_vdpa *)dev->opaque)->device_fd;
>         break;
>     default:
>         g_assert_not_reached()
>     }
>
> >      return ioctl(fd, request, arg);
> >  }
> >
>
Thanks Laurent , will fix this
> Thanks,
> Laurent
>


