Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E555C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF221744
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38248 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMmn-0000Gp-FA
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hbMcQ-0002Q7-Lm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hbMcL-0003vj-Bf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hbMc9-0003EG-Uz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:05:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DA15C01F28C;
 Thu, 13 Jun 2019 10:05:13 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A18C728561;
 Thu, 13 Jun 2019 10:05:09 +0000 (UTC)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190612124004.27336-1-eric.auger@redhat.com>
 <20190612184659.4b4efcef.cohuck@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <44f4ca42-b64d-4085-13b7-639a8fa3c282@redhat.com>
Date: Thu, 13 Jun 2019 12:05:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190612184659.4b4efcef.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 10:05:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: alex.williamson@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Connie,

On 6/12/19 6:46 PM, Cornelia Huck wrote:
> On Wed, 12 Jun 2019 14:40:04 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> The code used to assign an interrupt index/subindex to an
>> eventfd is duplicated many times. Let's introduce an helper that
>> allows to set/unset the signaling for an ACTION_TRIGGER,
>> ACTION_MASK or ACTION_UNMASK action.
>>
>> In the error message, we now use errno in case of any
>> VFIO_DEVICE_SET_IRQS ioctl failure.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Looks good to me.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

thank you!
> 
> I currently have the following, still untested patch on top (vfio-ap
> doesn't use this ioctl):
> 
> From 9c2efe73d6139e8c7b2109ac2df79fe073d942fb Mon Sep 17 00:00:00 2001
> From: Cornelia Huck <cohuck@redhat.com>
> Date: Wed, 12 Jun 2019 18:42:29 +0200
> Subject: [PATCH] vfio-ccw: use vfio_set_irq_signaling()
> 
> Make use of the new helper.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/vfio/ccw.c | 50 +++++++++++++-------------------------------------
>  1 file changed, 13 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 03a2becb3ec9..3643be0ee254 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -198,9 +198,9 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>  {
>      VFIODevice *vdev = &vcdev->vdev;
>      struct vfio_irq_info *irq_info;
> -    struct vfio_irq_set *irq_set;
>      size_t argsz;
> -    int32_t *pfd;
> +    int fd;
> +    Error *local_err = NULL;
>  
>      if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
>          error_setg(errp, "vfio: unexpected number of io irqs %u",
> @@ -224,56 +224,32 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>          goto out_free_info;
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
> +    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &local_err)) {
> +        error_propagate(errp, local_err);
> +        qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>          event_notifier_cleanup(&vcdev->io_notifier);
>      }
>  
> -    g_free(irq_set);
> -
>  out_free_info:
>      g_free(irq_info);
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
> +    Error *local_err = NULL;
> +
> +    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &local_err)) {
> +        error_report_err(local_err);
>      }
>  
>      qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
>                          NULL, NULL, vcdev);
>      event_notifier_cleanup(&vcdev->io_notifier);
>  
> -    g_free(irq_set);
>  }
>  
>  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> 
Looks good. Looking forward to reviewing it formally.

Best Regards

Eric

