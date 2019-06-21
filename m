Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2202C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB499208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB499208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKG0-0007E7-0v
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1heJuW-00015d-Vy
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1heJuQ-0003v7-1V
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:48:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1heJuP-0003p5-Qi
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:48:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so4672620oie.9
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 06:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G1FywIiyCMqxL6SzvnxLZqKBDSZaxbpJzM+njOsLzEk=;
 b=kPZKkzjCrUGcBmGv9rVwZYQIli2w2lReycEjqa+wZh/S/uRYwaYnDTcJ1r3t63WHQ8
 G5w12XFEe5flqOTUIzR/q1aFrWXTTWdSl8+BISOVsMvpUMRKKVUO4LD8umLqQjS6W/d+
 j/BwRNnuRz1Hvv7l12hnNh34DSBASVKenw+ZshElnMUibkTP3PhXAcTHlOT5pZk9Ryei
 wUvRiAsNe2HBooQzXoTUIKAHS4XWwVU3j3xJJcbN5JQv3hJErfjqoDpFjm5ZMd0GsRqB
 0lwKIQJ2ast1dPKcIUEeBQICQ5gJV+vcleToNgjiF2bFm8jF9d9nRwuvwHHbIJpEd4Wg
 I1kQ==
X-Gm-Message-State: APjAAAWlN4BdH7ToHV6UVvLItFlxEo4//Y599+na5Lzcg3urDGuaTQH4
 l8AG7hAIStPdF4l4KjOJbSCIUlWHnPSN9dSjplyrUg==
X-Google-Smtp-Source: APXvYqyu1StGaCZhSehZebxl9Bq7HMs4+9XXC5dbWspAKWRLroAFCVBrOLx3Ez3A5WUVvPhygw3R1kDrNzKg5PcJtVs=
X-Received: by 2002:aca:f513:: with SMTP id t19mr2835010oih.76.1561124928108; 
 Fri, 21 Jun 2019 06:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190621094005.4134-1-stefanha@redhat.com>
 <20190621094005.4134-3-stefanha@redhat.com>
In-Reply-To: <20190621094005.4134-3-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Jun 2019 15:48:36 +0200
Message-ID: <CAMxuvaz64dd00mhoZ4QjOZ_eGPMw_WBJQN1tWS0ueUhpSsN1SQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.195
Subject: Re: [Qemu-devel] [PATCH 2/4] libvhost-user: support many virtqueues
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
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jun 21, 2019 at 11:40 AM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> Currently libvhost-user is hardcoded to at most 8 virtqueues.  The
> device backend should decide the number of virtqueues, not
> libvhost-user.  This is important for multiqueue device backends where
> the guest driver needs an accurate number of virtqueues.
>
> This change breaks libvhost-user and libvhost-user-glib API stability.
> There is no stability guarantee yet, so make this change now and update
> all in-tree library users.
>
> This patch touches up vhost-user-blk, vhost-user-gpu, vhost-user-input,
> vhost-user-scsi, and vhost-user-bridge.  If the device has a fixed
> number of queues that exact number is used.  Otherwise the previous
> default of 8 virtqueues is used.
>
> vu_init() and vug_init() can now fail if malloc() returns NULL.  I
> considered aborting with an error in libvhost-user but it should be safe
> to instantiate new vhost-user instances at runtime without risk of
> terminating the process.  Therefore callers need to handle the vu_init()
> failure now.
>
> vhost-user-blk and vhost-user-scsi duplicate virtqueue index checks that
> are already performed by libvhost-user.  This code would need to be
> modified to use max_queues but remove it completely instead since it's
> redundant.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.h |  2 +-
>  contrib/libvhost-user/libvhost-user.h      | 10 ++++--
>  contrib/libvhost-user/libvhost-user-glib.c | 12 +++++--
>  contrib/libvhost-user/libvhost-user.c      | 32 ++++++++++++-----
>  contrib/vhost-user-blk/vhost-user-blk.c    | 16 +++++----
>  contrib/vhost-user-gpu/main.c              |  9 ++++-
>  contrib/vhost-user-input/main.c            | 11 +++++-
>  contrib/vhost-user-scsi/vhost-user-scsi.c  | 21 +++++------
>  tests/vhost-user-bridge.c                  | 42 ++++++++++++++--------
>  9 files changed, 104 insertions(+), 51 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhos=
t-user/libvhost-user-glib.h
> index d3200f3afc..64d539d93a 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.h
> +++ b/contrib/libvhost-user/libvhost-user-glib.h
> @@ -25,7 +25,7 @@ typedef struct VugDev {
>      GSource *src;
>  } VugDev;
>
> -void vug_init(VugDev *dev, int socket,
> +bool vug_init(VugDev *dev, uint16_t max_queues, int socket,
>                vu_panic_cb panic, const VuDevIface *iface);
>  void vug_deinit(VugDev *dev);
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 3b888ff0a5..46b600799b 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -25,7 +25,6 @@
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>  #define VHOST_LOG_PAGE 4096
>
> -#define VHOST_MAX_NR_VIRTQUEUE 8
>  #define VIRTQUEUE_MAX_SIZE 1024
>
>  #define VHOST_MEMORY_MAX_NREGIONS 8
> @@ -353,7 +352,7 @@ struct VuDev {
>      int sock;
>      uint32_t nregions;
>      VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
> -    VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
> +    VuVirtq *vq;
>      VuDevInflightInfo inflight_info;
>      int log_call_fd;
>      int slave_fd;
> @@ -362,6 +361,7 @@ struct VuDev {
>      uint64_t features;
>      uint64_t protocol_features;
>      bool broken;
> +    uint16_t max_queues;
>
>      /* @set_watch: add or update the given fd to the watch set,
>       * call cb when condition is met */
> @@ -391,6 +391,7 @@ typedef struct VuVirtqElement {
>  /**
>   * vu_init:
>   * @dev: a VuDev context
> + * @max_queues: maximum number of virtqueues
>   * @socket: the socket connected to vhost-user master
>   * @panic: a panic callback
>   * @set_watch: a set_watch callback
> @@ -398,8 +399,11 @@ typedef struct VuVirtqElement {
>   * @iface: a VuDevIface structure with vhost-user device callbacks
>   *
>   * Intializes a VuDev vhost-user context.
> + *
> + * Returns: true on success, false on failure.
>   **/
> -void vu_init(VuDev *dev,
> +bool vu_init(VuDev *dev,
> +             uint16_t max_queues,
>               int socket,
>               vu_panic_cb panic,
>               vu_set_watch_cb set_watch,
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhos=
t-user/libvhost-user-glib.c
> index 42660a1b36..99edd2f3de 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.c
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -131,18 +131,24 @@ static void vug_watch(VuDev *dev, int condition, vo=
id *data)
>      }
>  }
>
> -void
> -vug_init(VugDev *dev, int socket,
> +bool
> +vug_init(VugDev *dev, uint16_t max_queues, int socket,
>           vu_panic_cb panic, const VuDevIface *iface)
>  {
>      g_assert(dev);
>      g_assert(iface);
>
> -    vu_init(&dev->parent, socket, panic, set_watch, remove_watch, iface)=
;
> +    if (!vu_init(&dev->parent, max_queues, socket, panic, set_watch,
> +                 remove_watch, iface)) {
> +        return false;
> +    }
> +
>      dev->fdmap =3D g_hash_table_new_full(NULL, NULL, NULL,
>                                         (GDestroyNotify) g_source_destroy=
);
>
>      dev->src =3D vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
> +
> +    return true;
>  }
>
>  void
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index a8657c7af2..0c88431e8f 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -493,9 +493,9 @@ vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>  static void
>  vu_set_enable_all_rings(VuDev *dev, bool enabled)
>  {
> -    int i;
> +    uint16_t i;
>
> -    for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
> +    for (i =3D 0; i < dev->max_queues; i++) {
>          dev->vq[i].enable =3D enabled;
>      }
>  }
> @@ -916,7 +916,7 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vms=
g)
>  {
>      int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
>
> -    if (index >=3D VHOST_MAX_NR_VIRTQUEUE) {
> +    if (index >=3D dev->max_queues) {
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Invalid queue index: %u", index);
>          return false;
> @@ -1213,7 +1213,7 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *=
vmsg)
>      DPRINT("State.index: %d\n", index);
>      DPRINT("State.enable:   %d\n", enable);
>
> -    if (index >=3D VHOST_MAX_NR_VIRTQUEUE) {
> +    if (index >=3D dev->max_queues) {
>          vu_panic(dev, "Invalid vring_enable index: %u", index);
>          return false;
>      }
> @@ -1582,7 +1582,7 @@ vu_deinit(VuDev *dev)
>      }
>      dev->nregions =3D 0;
>
> -    for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
> +    for (i =3D 0; i < dev->max_queues; i++) {
>          VuVirtq *vq =3D &dev->vq[i];
>
>          if (vq->call_fd !=3D -1) {
> @@ -1627,18 +1627,23 @@ vu_deinit(VuDev *dev)
>      if (dev->sock !=3D -1) {
>          close(dev->sock);
>      }
> +
> +    free(dev->vq);
> +    dev->vq =3D NULL;
>  }
>
> -void
> +bool
>  vu_init(VuDev *dev,
> +        uint16_t max_queues,
>          int socket,
>          vu_panic_cb panic,
>          vu_set_watch_cb set_watch,
>          vu_remove_watch_cb remove_watch,
>          const VuDevIface *iface)
>  {
> -    int i;
> +    uint16_t i;
>
> +    assert(max_queues > 0);
>      assert(socket >=3D 0);
>      assert(set_watch);
>      assert(remove_watch);
> @@ -1654,18 +1659,27 @@ vu_init(VuDev *dev,
>      dev->iface =3D iface;
>      dev->log_call_fd =3D -1;
>      dev->slave_fd =3D -1;
> -    for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
> +
> +    dev->vq =3D malloc(max_queues * sizeof(dev->vq[0]));
> +    if (!dev->vq) {
> +        DPRINT("%s: failed to malloc virtqueues\n", __func__);
> +        return false;
> +    }
> +
> +    for (i =3D 0; i < max_queues; i++) {
>          dev->vq[i] =3D (VuVirtq) {
>              .call_fd =3D -1, .kick_fd =3D -1, .err_fd =3D -1,
>              .notification =3D true,
>          };
>      }
> +
> +    return true;
>  }
>
>  VuVirtq *
>  vu_get_queue(VuDev *dev, int qidx)
>  {
> -    assert(qidx < VHOST_MAX_NR_VIRTQUEUE);
> +    assert(qidx < dev->max_queues);
>      return &dev->vq[qidx];
>  }
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index 86a3987744..ae61034656 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -25,6 +25,10 @@
>  #include <sys/ioctl.h>
>  #endif
>
> +enum {
> +    VHOST_USER_BLK_MAX_QUEUES =3D 8,
> +};

why do you use enum,(and not const int) ? (similarly for other devices)

other than than
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +
>  struct virtio_blk_inhdr {
>      unsigned char status;
>  };
> @@ -334,12 +338,6 @@ static void vub_process_vq(VuDev *vu_dev, int idx)
>      VuVirtq *vq;
>      int ret;
>
> -    if ((idx < 0) || (idx >=3D VHOST_MAX_NR_VIRTQUEUE)) {
> -        fprintf(stderr, "VQ Index out of range: %d\n", idx);
> -        vub_panic_cb(vu_dev, NULL);
> -        return;
> -    }
> -
>      gdev =3D container_of(vu_dev, VugDev, parent);
>      vdev_blk =3D container_of(gdev, VubDev, parent);
>      assert(vdev_blk);
> @@ -631,7 +629,11 @@ int main(int argc, char **argv)
>          vdev_blk->enable_ro =3D true;
>      }
>
> -    vug_init(&vdev_blk->parent, csock, vub_panic_cb, &vub_iface);
> +    if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
> +                  vub_panic_cb, &vub_iface)) {
> +        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> +        goto err;
> +    }
>
>      g_main_loop_run(vdev_blk->loop);
>
> diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.=
c
> index 04b753046f..b45d2019b4 100644
> --- a/contrib/vhost-user-gpu/main.c
> +++ b/contrib/vhost-user-gpu/main.c
> @@ -25,6 +25,10 @@
>  #include "virgl.h"
>  #include "vugbm.h"
>
> +enum {
> +    VHOST_USER_GPU_MAX_QUEUES =3D 2,
> +};
> +
>  struct virtio_gpu_simple_resource {
>      uint32_t resource_id;
>      uint32_t width;
> @@ -1169,7 +1173,10 @@ main(int argc, char *argv[])
>          exit(EXIT_FAILURE);
>      }
>
> -    vug_init(&g.dev, fd, vg_panic, &vuiface);
> +    if (!vug_init(&g.dev, VHOST_USER_GPU_MAX_QUEUES, fd, vg_panic, &vuif=
ace)) {
> +        g_printerr("Failed to initialize libvhost-user-glib.\n");
> +        exit(EXIT_FAILURE);
> +    }
>
>      loop =3D g_main_loop_new(NULL, FALSE);
>      g_main_loop_run(loop);
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
> index 8b4e7d2536..449fd2171a 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -17,6 +17,10 @@
>  #include "standard-headers/linux/virtio_input.h"
>  #include "qapi/error.h"
>
> +enum {
> +    VHOST_USER_INPUT_MAX_QUEUES =3D 2,
> +};
> +
>  typedef struct virtio_input_event virtio_input_event;
>  typedef struct virtio_input_config virtio_input_config;
>
> @@ -384,7 +388,12 @@ main(int argc, char *argv[])
>          g_printerr("Invalid vhost-user socket.\n");
>          exit(EXIT_FAILURE);
>      }
> -    vug_init(&vi.dev, fd, vi_panic, &vuiface);
> +
> +    if (!vug_init(&vi.dev, VHOST_USER_INPUT_MAX_QUEUES, fd, vi_panic,
> +                  &vuiface)) {
> +        g_printerr("Failed to initialize libvhost-user-glib.\n");
> +        exit(EXIT_FAILURE);
> +    }
>
>      loop =3D g_main_loop_new(NULL, FALSE);
>      g_main_loop_run(loop);
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
> index 496dd6e693..0fc14d7899 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -19,6 +19,10 @@
>
>  #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
>
> +enum {
> +    VHOST_USER_SCSI_MAX_QUEUES =3D 8,
> +};
> +
>  typedef struct VusIscsiLun {
>      struct iscsi_context *iscsi_ctx;
>      int iscsi_lun;
> @@ -231,11 +235,6 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>
>      gdev =3D container_of(vu_dev, VugDev, parent);
>      vdev_scsi =3D container_of(gdev, VusDev, parent);
> -    if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
> -        g_warning("VQ Index out of range: %d", idx);
> -        vus_panic_cb(vu_dev, NULL);
> -        return;
> -    }
>
>      vq =3D vu_get_queue(vu_dev, idx);
>      if (!vq) {
> @@ -295,12 +294,6 @@ static void vus_queue_set_started(VuDev *vu_dev, int=
 idx, bool started)
>
>      assert(vu_dev);
>
> -    if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
> -        g_warning("VQ Index out of range: %d", idx);
> -        vus_panic_cb(vu_dev, NULL);
> -        return;
> -    }
> -
>      vq =3D vu_get_queue(vu_dev, idx);
>
>      if (idx =3D=3D 0 || idx =3D=3D 1) {
> @@ -398,7 +391,11 @@ int main(int argc, char **argv)
>          goto err;
>      }
>
> -    vug_init(&vdev_scsi->parent, csock, vus_panic_cb, &vus_iface);
> +    if (!vug_init(&vdev_scsi->parent, VHOST_USER_SCSI_MAX_QUEUES, csock,
> +                  vus_panic_cb, &vus_iface)) {
> +        g_printerr("Failed to initialize libvhost-user-glib\n");
> +        goto err;
> +    }
>
>      g_main_loop_run(vdev_scsi->loop);
>
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 0bb03af0e5..c4e350e1f5 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -45,6 +45,10 @@
>          } \
>      } while (0)
>
> +enum {
> +    VHOST_USER_BRIDGE_MAX_QUEUES =3D 8,
> +};
> +
>  typedef void (*CallbackFunc)(int sock, void *ctx);
>
>  typedef struct Event {
> @@ -512,12 +516,16 @@ vubr_accept_cb(int sock, void *ctx)
>      }
>      DPRINT("Got connection from remote peer on sock %d\n", conn_fd);
>
> -    vu_init(&dev->vudev,
> -            conn_fd,
> -            vubr_panic,
> -            vubr_set_watch,
> -            vubr_remove_watch,
> -            &vuiface);
> +    if (!vu_init(&dev->vudev,
> +                 VHOST_USER_BRIDGE_MAX_QUEUES,
> +                 conn_fd,
> +                 vubr_panic,
> +                 vubr_set_watch,
> +                 vubr_remove_watch,
> +                 &vuiface)) {
> +        fprintf(stderr, "Failed to initialize libvhost-user\n");
> +        exit(1);
> +    }
>
>      dispatcher_add(&dev->dispatcher, conn_fd, ctx, vubr_receive_cb);
>      dispatcher_remove(&dev->dispatcher, sock);
> @@ -560,12 +568,18 @@ vubr_new(const char *path, bool client)
>          if (connect(dev->sock, (struct sockaddr *)&un, len) =3D=3D -1) {
>              vubr_die("connect");
>          }
> -        vu_init(&dev->vudev,
> -                dev->sock,
> -                vubr_panic,
> -                vubr_set_watch,
> -                vubr_remove_watch,
> -                &vuiface);
> +
> +        if (!vu_init(&dev->vudev,
> +                     VHOST_USER_BRIDGE_MAX_QUEUES,
> +                     dev->sock,
> +                     vubr_panic,
> +                     vubr_set_watch,
> +                     vubr_remove_watch,
> +                     &vuiface)) {
> +            fprintf(stderr, "Failed to initialize libvhost-user\n");
> +            exit(1);
> +        }
> +
>          cb =3D vubr_receive_cb;
>      }
>
> @@ -584,7 +598,7 @@ static void *notifier_thread(void *arg)
>      int qidx;
>
>      while (true) {
> -        for (qidx =3D 0; qidx < VHOST_MAX_NR_VIRTQUEUE; qidx++) {
> +        for (qidx =3D 0; qidx < VHOST_USER_BRIDGE_MAX_QUEUES; qidx++) {
>              uint16_t *n =3D vubr->notifier.addr + pagesize * qidx;
>
>              if (*n =3D=3D qidx) {
> @@ -616,7 +630,7 @@ vubr_host_notifier_setup(VubrDev *dev)
>      void *addr;
>      int fd;
>
> -    length =3D getpagesize() * VHOST_MAX_NR_VIRTQUEUE;
> +    length =3D getpagesize() * VHOST_USER_BRIDGE_MAX_QUEUES;
>
>      fd =3D mkstemp(template);
>      if (fd < 0) {
> --
> 2.21.0
>

