Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6706C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEE420856
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEE420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU7JL-0003zg-LH
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 06:20:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hU7IK-0003cL-PT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hU7IJ-0002Gt-JE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:19:24 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hU7IJ-0002DU-BL
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:19:23 -0400
Received: from player738.ha.ovh.net (unknown [10.109.159.73])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 69CBB5B855
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 12:19:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player738.ha.ovh.net (Postfix) with ESMTPSA id 4872963F62ED;
	Fri, 24 May 2019 10:19:11 +0000 (UTC)
Date: Fri, 24 May 2019 12:19:09 +0200
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190524121909.277ae31e@bahia.lan>
In-Reply-To: <20190320112646.3712-2-xieyongji@baidu.com>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14205760602299079129
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduiedgvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.203
Subject: Re: [Qemu-devel] [PULL v2 04/36] virtio: Introduce started flag to
 VirtioDevice
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
	qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
	Zhang Yu <zhangyu31@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 19:10:35 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> The virtio 1.0 transitional devices support driver uses the device
> before setting the DRIVER_OK status bit. So we introduce a started
> flag to indicate whether driver has started the device or not.
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio.h |  2 ++
>  hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7140381e3a..27c0efc3d0 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -105,6 +105,8 @@ struct VirtIODevice
>      uint16_t device_id;
>      bool vm_running;
>      bool broken; /* device in invalid state, needs reset */
> +    bool started;
> +    bool start_on_kick; /* virtio 1.0 transitional devices support that */
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
>      uint8_t device_endian;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 28056a7ef7..5d533ac74e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>              }
>          }
>      }
> +    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> +    if (unlikely(vdev->start_on_kick && vdev->started)) {
> +        vdev->start_on_kick = false;
> +    }
> +
>      if (k->set_status) {
>          k->set_status(vdev, val);
>      }
>      vdev->status = val;
> +
>      return 0;
>  }
>  
> @@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
>          k->reset(vdev);
>      }
>  
> +    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> +    vdev->started = false;
>      vdev->broken = false;
>      vdev->guest_features = 0;
>      vdev->queue_sel = 0;
> @@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
>  
>  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
>  {
> +    bool ret = false;
> +
>      if (vq->vring.desc && vq->handle_aio_output) {
>          VirtIODevice *vdev = vq->vdev;
>  
>          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> -        return vq->handle_aio_output(vdev, vq);
> +        ret = vq->handle_aio_output(vdev, vq);
> +
> +        if (unlikely(vdev->start_on_kick)) {
> +            vdev->started = true;
> +            vdev->start_on_kick = false;
> +        }
>      }
>  
> -    return false;
> +    return ret;
>  }
>  
>  static void virtio_queue_notify_vq(VirtQueue *vq)
> @@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
>  
>          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
>          vq->handle_output(vdev, vq);
> +
> +        if (unlikely(vdev->start_on_kick)) {
> +            vdev->started = true;
> +            vdev->start_on_kick = false;
> +        }
>      }
>  }
>  
> @@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
>      } else if (vq->handle_output) {
>          vq->handle_output(vdev, vq);
>      }
> +
> +    if (unlikely(vdev->start_on_kick)) {
> +        vdev->started = true;
> +        vdev->start_on_kick = false;
> +    }
>  }
>  
>  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
>      return vdev->broken;
>  }
>  
> +static bool virtio_started_needed(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    return vdev->started;

Existing machine types don't know about the "virtio/started" subsection. This
breaks migration to older QEMUs if the driver has started the device, ie. most
probably always when it comes to live migration.

My understanding is that we do try to support backward migration though. It
is a regular practice in datacenters to migrate workloads without having to
take care of the QEMU version. FWIW I had to fix similar issues downstream
many times in the past because customers had filed bugs.

Cc'ing David for his opinion.

> +}
> +
>  static const VMStateDescription vmstate_virtqueue = {
>      .name = "virtqueue_state",
>      .version_id = 1,
> @@ -1898,6 +1931,17 @@ static const VMStateDescription vmstate_virtio_broken = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_virtio_started = {
> +    .name = "virtio/started",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = &virtio_started_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(started, VirtIODevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio = {
>      .name = "virtio",
>      .version_id = 1,
> @@ -1913,6 +1957,7 @@ static const VMStateDescription vmstate_virtio = {
>          &vmstate_virtio_ringsize,
>          &vmstate_virtio_broken,
>          &vmstate_virtio_extra_state,
> +        &vmstate_virtio_started,
>          NULL
>      }
>  };
> @@ -2286,6 +2331,9 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>              g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
>      }
>  
> +    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> +    vdev->started = false;
>      vdev->device_id = device_id;
>      vdev->status = 0;
>      atomic_set(&vdev->isr, 0);


