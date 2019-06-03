Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB7AC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC2C251FA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC2C251FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqE0-0000UL-9K
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:54:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXqDB-0000Bx-HH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXqDA-0006si-Ga
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:53:29 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:45325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hXqDA-0006n1-9s
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:53:28 -0400
Received: from player737.ha.ovh.net (unknown [10.108.57.211])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E822B17B8F7
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 18:53:24 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player737.ha.ovh.net (Postfix) with ESMTPSA id 50DD168D43AE;
	Mon,  3 Jun 2019 16:53:19 +0000 (UTC)
Date: Mon, 3 Jun 2019 18:53:18 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190603185318.659015e0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190529070955.25565-2-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-2-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5801762220228122925
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefjedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.127.22
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Set "start_on_kick" on
 virtio_set_features()
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

On Wed, 29 May 2019 15:09:51 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> The guest feature is not set correctly on virtio_reset() and
> virtio_init(). So we should not use it to set "start_on_kick" at that
> point. This patch set "start_on_kick" on virtio_set_features() instead.
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---

Maybe add a Fixes: badaf79cfdbd3 ?

>  hw/virtio/virtio.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4805727b53..fc8fca81ad 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1214,8 +1214,7 @@ void virtio_reset(void *opaque)
>          k->reset(vdev);
>      }
>  
> -    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> -                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> +    vdev->start_on_kick = false;
>      vdev->started = false;
>      vdev->broken = false;
>      vdev->guest_features = 0;
> @@ -2069,14 +2068,21 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>          return -EINVAL;
>      }
>      ret = virtio_set_features_nocheck(vdev, val);
> -    if (!ret && virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> -        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> -        int i;
> -        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> -            if (vdev->vq[i].vring.num != 0) {
> -                virtio_init_region_cache(vdev, i);
> +    if (!ret) {
> +        if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +            /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> +            int i;
> +            for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +                if (vdev->vq[i].vring.num != 0) {
> +                    virtio_init_region_cache(vdev, i);
> +                }
>              }
>          }
> +
> +        if (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +            vdev->start_on_kick = true;
> +        }
>      }
>      return ret;
>  }
> @@ -2331,8 +2337,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>              g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
>      }
>  
> -    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> -                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> +    vdev->start_on_kick = false;

virtio_init() is called at realize on an object that was just allocated with
g_malloc0(). You shouldn't need to set anything to 0 or false... or I'm
missing something ?

Anyway, I guess this doesn't hurt, so:

Reviewed-by: Greg Kurz <groug@kaod.org>

>      vdev->started = false;
>      vdev->device_id = device_id;
>      vdev->status = 0;


