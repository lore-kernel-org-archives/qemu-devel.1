Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E9DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81952654C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81952654C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXtuy-0005iX-1Y
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 16:50:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXttx-0005KD-Uf
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXttt-000121-Sz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:49:52 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:56400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hXtto-0000f5-Ld
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:49:47 -0400
Received: from player787.ha.ovh.net (unknown [10.108.35.210])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 667C710BFDD
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 22:49:37 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player787.ha.ovh.net (Postfix) with ESMTPSA id 7238468AE89E;
	Mon,  3 Jun 2019 20:49:31 +0000 (UTC)
Date: Mon, 3 Jun 2019 22:49:30 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190603224930.4f3c14fe@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190529070955.25565-6-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-6-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9790825592104261933
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefjedgudehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.93
Subject: Re: [Qemu-devel] [PATCH 5/5] virtio: add "use-started" property
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
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@baidu.com>,
	dgilbert@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 15:09:55 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> In order to avoid migration issues, we introduce a "use-started"
> property to the base virtio device to indicate whether "started"
> and "start_on_kick" flag could be used. This property will be
> true by default and set to false when machine type <= 4.0.
> 
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---
>  hw/block/vhost-user-blk.c  |  8 ++++++--
>  hw/core/machine.c          |  4 +++-
>  hw/virtio/virtio.c         |  7 ++++---
>  include/hw/virtio/virtio.h | 10 ++++++++++
>  4 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9cb61336a6..520c5d3d4b 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -191,9 +191,13 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>  static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>  {
>      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> -    bool should_start = vdev->started;
> +    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;

I guess you need the above because the set_status callback is called
before setting vdev->status, and virtio_device_started() thus doesn't
return the expected result for older machine types ?

What about adding a status argument to virtio_device_started() ?

    bool should_start = virtio_device_started(vdev, status);

>      int ret;
>  
> +    if (virtio_device_started(vdev)) {
> +        should_start = true;
> +    }
> +
>      if (!vdev->vm_running) {
>          should_start = false;
>      }
> @@ -317,7 +321,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
>      }
>  
>      /* restore vhost state */
> -    if (vdev->started) {
> +    if (virtio_device_started(vdev)) {

    if (virtio_device_started(vdev, vdev->status)) {

and so on...

>          ret = vhost_user_blk_start(vdev);
>          if (ret < 0) {
>              error_report("vhost-user-blk: vhost start failed: %s",
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 934c1bcceb..1730d28c1b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,7 +24,9 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> -GlobalProperty hw_compat_4_0[] = {};
> +GlobalProperty hw_compat_4_0[] = {
> +    { "virtio-device", "use-started", "false" },
> +};
>  const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
>  
>  GlobalProperty hw_compat_3_1[] = {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9e17293d46..4c05a9efe3 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1803,14 +1803,14 @@ static bool virtio_started_needed(void *opaque)
>  {
>      VirtIODevice *vdev = opaque;
>  
> -    return vdev->started;
> +    return vdev->started && vdev->use_started;

Hmm... the idea is that vdev->started should never be set when
"use-started" is "off". Instead of checking vdev->use_started
here, you should rather assign it to vdev->started everywhere
you currently assign true.

>  }
>  
>  static bool virtio_start_on_kick_needed(void *opaque)
>  {
>      VirtIODevice *vdev = opaque;
>  
> -    return vdev->start_on_kick;
> +    return vdev->start_on_kick && vdev->use_started;
>  }
>  
>  static const VMStateDescription vmstate_virtqueue = {
> @@ -2320,7 +2320,7 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
>      VirtIODevice *vdev = opaque;
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> -    bool backend_run = running && vdev->started;
> +    bool backend_run = running && virtio_device_started(vdev);
>      vdev->vm_running = running;
>  
>      if (backend_run) {
> @@ -2698,6 +2698,7 @@ static void virtio_device_instance_finalize(Object *obj)
>  
>  static Property virtio_properties[] = {
>      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27c0efc3d0..ba4dbd7480 100644
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
> @@ -351,4 +352,13 @@ static inline bool virtio_is_big_endian(VirtIODevice *vdev)
>      /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>      return false;
>  }
> +
> +static inline bool virtio_device_started(VirtIODevice *vdev)
> +{
> +    if (vdev->use_started) {
> +        return vdev->started;
> +    }
> +
> +    return vdev->status & VIRTIO_CONFIG_S_DRIVER_OK;
> +}
>  #endif


