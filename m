Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30638C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059002081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059002081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8V92-0006Om-6K
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 15:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i8V8O-0005u7-Uv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i8V8M-00039S-KX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i8V8M-00037i-D1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:52:02 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90E092EF16A
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 19:52:00 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id r141so3053162qke.7
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aotAdU72G5pTqxYjz+e96Z1fqINic8/KHTXxTc7Etqw=;
 b=PPcoyoit8ms2MPnQIY70+RpAKe2l2Gj1mqAb7fakjo4G7dOvexnBJvcwMv17bB5apS
 0z+sxczx/1sntKKD80Zx31CN5rMJ9af0L1GbMBtXrWc4pDdQJ75nxcZMiuXXoh171mWV
 0MMdQiLh7YUabEO0772i2AKoQ/oJx1zFhu+WJF7HTBFmI/bccJNABfXAWw5owy4fZAyD
 kuHd/uCJxunj8HDIbBaHdvTpwLjYhwAEH3WbnNSE55WnsR5o/RlVYTLCQh/JH5s8V2aj
 M6d+tBz7pctaZvc+bdcIBdIUtnwfmzDRsevhb2g4dw0exiqeBJvbWDP04DsnTuBonaLl
 yvMg==
X-Gm-Message-State: APjAAAU7SyUsf8SArmIiBgWZ/Ktk2j36Q+oZPYmmDfLtMPrax63KsIP0
 W9T4KEoKrLeUbaSsbJ4mkr4rFmacQGZWlHjZeZ5ob8ybN2B0Fxj35q2w7rtDJlVCX+lJjdQR+vO
 izw0p7CG3ScS4J0I=
X-Received: by 2002:ac8:1103:: with SMTP id c3mr19165148qtj.88.1568317919727; 
 Thu, 12 Sep 2019 12:51:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzVAwSTjlW/84a5DkNdoyC9GQB92QmNtAkFlDOqyI0ilY5p/WteGNIWHh6T+EOQ+UiWNwivg==
X-Received: by 2002:ac8:1103:: with SMTP id c3mr19165137qtj.88.1568317919563; 
 Thu, 12 Sep 2019 12:51:59 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id f5sm7522529qkg.9.2019.09.12.12.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 12:51:58 -0700 (PDT)
Date: Thu, 12 Sep 2019 15:51:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190912155023-mutt-send-email-mst@kernel.org>
References: <20190912181924.48539-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912181924.48539-1-slp@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] virtio-blk: schedule
 virtio_notify_config to run on main context
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
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 12, 2019 at 08:19:25PM +0200, Sergio Lopez wrote:
> Another AioContext-related issue, and this is a tricky one.
> 
> Executing a QMP block_resize request for a virtio-blk device running
> on an iothread may cause a deadlock involving the following mutexes:
> 
>  - main thead
>   * Has acquired: qemu_mutex_global.
>   * Is trying the acquire: iothread AioContext lock via
>     AIO_WAIT_WHILE (after aio_poll).
> 
>  - iothread
>   * Has acquired: AioContext lock.
>   * Is trying to acquire: qemu_mutex_global (via
>     virtio_notify_config->prepare_mmio_access).

Hmm is this really the only case iothread takes qemu mutex?
If any such access can deadlock, don't we need a generic
solution? Maybe main thread can drop qemu mutex
before taking io thread AioContext lock?

> With this change, virtio_blk_resize checks if it's being called from a
> coroutine context running on a non-main thread, and if that's the
> case, creates a new coroutine and schedules it to be run on the main
> thread.
> 
> This works, but means the actual operation is done
> asynchronously, perhaps opening a window in which a "device_del"
> operation may fit and remove the VirtIODevice before
> virtio_notify_config() is executed.
> 
> I *think* it shouldn't be possible, as BHs will be processed before
> any new QMP/monitor command, but I'm open to a different approach.
> 
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1744955
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 18851601cb..c763d071f6 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -16,6 +16,7 @@
>  #include "qemu/iov.h"
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "trace.h"
>  #include "hw/block/block.h"
>  #include "hw/qdev-properties.h"
> @@ -1086,11 +1087,33 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>      return 0;
>  }
>  
> +static void coroutine_fn virtio_resize_co_entry(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> +    virtio_notify_config(vdev);
> +    aio_wait_kick();
> +}
> +
>  static void virtio_blk_resize(void *opaque)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
> +    Coroutine *co;
>  
> -    virtio_notify_config(vdev);
> +    if (qemu_in_coroutine() &&
> +        qemu_get_current_aio_context() != qemu_get_aio_context()) {
> +        /*
> +         * virtio_notify_config() needs to acquire the global mutex,
> +         * so calling it from a coroutine running on a non-main context
> +         * may cause a deadlock. Instead, create a new coroutine and
> +         * schedule it to be run on the main thread.
> +         */
> +        co = qemu_coroutine_create(virtio_resize_co_entry, vdev);
> +        aio_co_schedule(qemu_get_aio_context(), co);
> +    } else {
> +        virtio_notify_config(vdev);
> +    }
>  }
>  
>  static const BlockDevOps virtio_block_ops = {
> -- 
> 2.21.0

