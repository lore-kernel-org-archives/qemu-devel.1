Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D10C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48172075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48172075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRnG-0002wg-VR
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:01:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYRmK-0002Xp-8p
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYRmF-0008Mk-21
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:00:16 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:41226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hYRmE-0007v5-Rh
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:00:11 -0400
Received: from player694.ha.ovh.net (unknown [10.109.160.217])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 352ED5CD8A
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 11:00:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player694.ha.ovh.net (Postfix) with ESMTPSA id 15B626701430;
	Wed,  5 Jun 2019 08:59:53 +0000 (UTC)
Date: Wed, 5 Jun 2019 10:59:51 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190605105951.21c838a7@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190604073459.15651-6-xieyongji@baidu.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
	<20190604073459.15651-6-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9552134813893302573
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegvddguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.107
Subject: Re: [Qemu-devel] [PATCH v2 5/5] virtio: add "use-started" property
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
	qemu-devel@nongnu.org, dgilbert@redhat.com,
	Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  4 Jun 2019 15:34:59 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> In order to avoid migration issues, we introduce a "use-started"
> property to the base virtio device to indicate whether use
> "started" flag or not. This property will be true by default and
> set to false when machine type <= 4.0.1.
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---
>  hw/block/vhost-user-blk.c  |  4 ++--
>  hw/core/machine.c          |  4 +++-
>  hw/virtio/virtio.c         | 21 ++++++++-------------
>  include/hw/virtio/virtio.h | 21 +++++++++++++++++++++
>  4 files changed, 34 insertions(+), 16 deletions(-)
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
> index f1a0f45f9c..133c113ebf 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,7 +24,9 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> -GlobalProperty hw_compat_4_0_1[] = {};
> +GlobalProperty hw_compat_4_0_1[] = {
> +    { "virtio-device", "use-started", "false" },
> +};
>  const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);

I'm discovering hw_compat_4_0_1, which seems to be only used by the
pc-q35-4.0.1 machine type...

>  
>  GlobalProperty hw_compat_4_0[] = {};

Not sure if it's the way to go but the same line should at least be added
here for all other machine types that use hw_compat_4_0[] eg. pseries-4.0
and older, which are the ones I need this fix for.

Cc'ing core machine code maintainers for advice.

> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 3960619bd4..9af2e339af 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1165,10 +1165,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>  
>      if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) !=
>          (val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -        vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> -        if (unlikely(vdev->start_on_kick && vdev->started)) {
> -            vdev->start_on_kick = false;
> -        }
> +        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);

virtio_set_started() takes a bool as second argument, so this should
rather be !!(val & VIRTIO_CONFIG_S_DRIVER_OK) to avoid potential
warnings from picky compilers.

The rest looks good, but I'm wondering if this patch should be the first
one in the series to narrow the range of commits where backward migration
is broken.

>      }
>  
>      if (k->set_status) {
> @@ -1539,8 +1536,7 @@ static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
>          ret = vq->handle_aio_output(vdev, vq);
>  
>          if (unlikely(vdev->start_on_kick)) {
> -            vdev->started = true;
> -            vdev->start_on_kick = false;
> +            virtio_set_started(vdev, true);
>          }
>      }
>  
> @@ -1560,8 +1556,7 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
>          vq->handle_output(vdev, vq);
>  
>          if (unlikely(vdev->start_on_kick)) {
> -            vdev->started = true;
> -            vdev->start_on_kick = false;
> +            virtio_set_started(vdev, true);
>          }
>      }
>  }
> @@ -1581,8 +1576,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
>          vq->handle_output(vdev, vq);
>  
>          if (unlikely(vdev->start_on_kick)) {
> -            vdev->started = true;
> -            vdev->start_on_kick = false;
> +            virtio_set_started(vdev, true);
>          }
>      }
>  }
> @@ -2083,7 +2077,7 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>              }
>          }
>  
> -        if (!vdev->started &&
> +        if (!virtio_device_started(vdev, vdev->status) &&
>              !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>              vdev->start_on_kick = true;
>          }
> @@ -2238,7 +2232,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>          }
>      }
>  
> -    if (!vdev->started &&
> +    if (!virtio_device_started(vdev, vdev->status) &&
>          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>          vdev->start_on_kick = true;
>      }
> @@ -2306,7 +2300,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
>      VirtIODevice *vdev = opaque;
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> -    bool backend_run = running && vdev->started;
> +    bool backend_run = running && virtio_device_started(vdev, vdev->status);
>      vdev->vm_running = running;
>  
>      if (backend_run) {
> @@ -2683,6 +2677,7 @@ static void virtio_device_instance_finalize(Object *obj)
>  
>  static Property virtio_properties[] = {
>      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 303242b3c2..b189788cb2 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -105,6 +105,7 @@ struct VirtIODevice
>      uint16_t device_id;
>      bool vm_running;
>      bool broken; /* device in invalid state, needs reset */
> +    bool use_started;
>      bool started;
>      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
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


