Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A9FC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DCD20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DCD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbkij-0005er-3h
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 07:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbkdr-0004XV-EI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbkdp-0005Yd-D5
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:45:11 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:33631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbkdo-0005Sm-HH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:45:08 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.168])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 22CF310E077
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 13:45:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 244786CEF0A0;
 Fri, 14 Jun 2019 11:44:54 +0000 (UTC)
Date: Fri, 14 Jun 2019 13:44:52 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190614134452.7924f135@bahia.lan>
In-Reply-To: <20190614093121.5580-2-xieyongji@baidu.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
 <20190614093121.5580-2-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9853031563890694445
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.180
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio: add "use-started" property
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 17:31:17 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> In order to avoid migration issues, we introduce a "use-started"
> property to the base virtio device to indicate whether use
> "started" flag or not. This property will be true by default and
> set to false when machine type <= 4.0.1.
> 
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---
>  hw/block/vhost-user-blk.c  |  4 ++--
>  hw/core/machine.c          |  8 ++++++--

This patch conflicts with latest upstream changes to hw_compat_4_0_1[].

It seems you need to rebase. Also, I'm still not sure how we're supposed
to handle hw_compat_4_0_1[] versus hw_compat_4_0[]... nobody commented
on:

https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00637.html
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00641.html

Maybe worth to sort that out before re-posting.

>  hw/virtio/virtio.c         | 18 +++++++-----------
>  include/hw/virtio/virtio.h | 21 +++++++++++++++++++++
>  4 files changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9cb61336a6..85bc4017e7 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -191,7 +191,7 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>  static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>  {
>      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> -    bool should_start = vdev->started;
> +    bool should_start = virtio_device_started(vdev, status);
>      int ret;
>  
>      if (!vdev->vm_running) {
> @@ -317,7 +317,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
>      }
>  
>      /* restore vhost state */
> -    if (vdev->started) {
> +    if (virtio_device_started(vdev, vdev->status)) {
>          ret = vhost_user_blk_start(vdev);
>          if (ret < 0) {
>              error_report("vhost-user-blk: vhost start failed: %s",
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f1a0f45f9c..60d1e27d2c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,10 +24,14 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> -GlobalProperty hw_compat_4_0_1[] = {};
> +GlobalProperty hw_compat_4_0_1[] = {
> +    { "virtio-device", "use-started", "false" },
> +};
>  const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
>  
> -GlobalProperty hw_compat_4_0[] = {};
> +GlobalProperty hw_compat_4_0[] = {
> +    { "virtio-device", "use-started", "false" },
> +};
>  const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
>  
>  GlobalProperty hw_compat_3_1[] = {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 07f4a64b48..19062fbb96 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1162,10 +1162,8 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>              }
>          }
>      }
> -    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> -    if (unlikely(vdev->start_on_kick && vdev->started)) {
> -        vdev->start_on_kick = false;
> -    }
> +
> +    virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>  
>      if (k->set_status) {
>          k->set_status(vdev, val);
> @@ -1536,8 +1534,7 @@ static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
>          ret = vq->handle_aio_output(vdev, vq);
>  
>          if (unlikely(vdev->start_on_kick)) {
> -            vdev->started = true;
> -            vdev->start_on_kick = false;
> +            virtio_set_started(vdev, true);
>          }
>      }
>  
> @@ -1557,8 +1554,7 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
>          vq->handle_output(vdev, vq);
>  
>          if (unlikely(vdev->start_on_kick)) {
> -            vdev->started = true;
> -            vdev->start_on_kick = false;
> +            virtio_set_started(vdev, true);
>          }
>      }
>  }
> @@ -1579,8 +1575,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
>      }
>  
>      if (unlikely(vdev->start_on_kick)) {
> -        vdev->started = true;
> -        vdev->start_on_kick = false;
> +        virtio_set_started(vdev, true);
>      }
>  }
>  
> @@ -2291,7 +2286,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
>      VirtIODevice *vdev = opaque;
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> -    bool backend_run = running && vdev->started;
> +    bool backend_run = running && virtio_device_started(vdev, vdev->status);
>      vdev->vm_running = running;
>  
>      if (backend_run) {
> @@ -2669,6 +2664,7 @@ static void virtio_device_instance_finalize(Object *obj)
>  
>  static Property virtio_properties[] = {
>      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27c0efc3d0..15d5366939 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -105,6 +105,7 @@ struct VirtIODevice
>      uint16_t device_id;
>      bool vm_running;
>      bool broken; /* device in invalid state, needs reset */
> +    bool use_started;
>      bool started;
>      bool start_on_kick; /* virtio 1.0 transitional devices support that */
>      VMChangeStateEntry *vmstate;
> @@ -351,4 +352,24 @@ static inline bool virtio_is_big_endian(VirtIODevice *vdev)
>      /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>      return false;
>  }
> +
> +static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
> +{
> +    if (vdev->use_started) {
> +        return vdev->started;
> +    }
> +
> +    return status & VIRTIO_CONFIG_S_DRIVER_OK;
> +}
> +
> +static inline void virtio_set_started(VirtIODevice *vdev, bool started)
> +{
> +    if (started) {
> +        vdev->start_on_kick = false;
> +    }
> +
> +    if (vdev->use_started) {
> +        vdev->started = started;
> +    }
> +}
>  #endif


