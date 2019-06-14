Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC40EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8496D208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8496D208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmQW-00084r-Lf
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hbmG0-0000aC-Py
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hbmFy-0005sA-Jg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hbmFy-0005Lo-7L; Fri, 14 Jun 2019 09:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4256D7FDEC;
 Fri, 14 Jun 2019 13:28:14 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 029EC601AC;
 Fri, 14 Jun 2019 13:28:12 +0000 (UTC)
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>
References: <20190614092705.11025-1-cohuck@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8a3cdd5f-680d-d991-5b8e-974ac084ba1c@redhat.com>
Date: Fri, 14 Jun 2019 15:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190614092705.11025-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 13:28:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: use vfio_set_irq_signaling
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Connie,

On 6/14/19 11:27 AM, Cornelia Huck wrote:
> Use the new helper.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/vfio/ccw.c | 68 +++++++++++----------------------------------------
>  1 file changed, 14 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 03a2becb3ec9..3dc08721a3db 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -197,10 +197,7 @@ read_err:
>  static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>  {
>      VFIODevice *vdev = &vcdev->vdev;
> -    struct vfio_irq_info *irq_info;
> -    struct vfio_irq_set *irq_set;
> -    size_t argsz;
> -    int32_t *pfd;
> +    int fd;
>  
>      if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
>          error_setg(errp, "vfio: unexpected number of io irqs %u",
> @@ -208,72 +205,35 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>          return;
>      }
>  
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> -    irq_info->argsz = argsz;
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> -        goto out_free_info;
> -    }
> -
>      if (event_notifier_init(&vcdev->io_notifier, 0)) {
>          error_setg_errno(errp, errno,
>                           "vfio: Unable to init event notifier for IO");
> -        goto out_free_info;
> +        return;
>      }
>  
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *) &irq_set->data;
> -
> -    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> -    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_setg(errp, "vfio: Failed to set up io notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
> +    fd = event_notifier_get_fd(&vcdev->io_notifier);
> +    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> +
> +    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
> +        qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>          event_notifier_cleanup(&vcdev->io_notifier);
>      }
> -
> -    g_free(irq_set);
> -
> -out_free_info:
> -    g_free(irq_info);
>  }
>  
>  static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
>  {
> -    struct vfio_irq_set *irq_set;
> -    size_t argsz;
> -    int32_t *pfd;
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *) &irq_set->data;
> -    *pfd = -1;
> -
> -    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to de-assign device io fd: %m");
> +    Error *err = NULL;
> +
> +    vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                           VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err);
> +    if (err) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>      }
>  
>      qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
>                          NULL, NULL, vcdev);
>      event_notifier_cleanup(&vcdev->io_notifier);
> -
> -    g_free(irq_set);
>  }
>  
>  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> 

