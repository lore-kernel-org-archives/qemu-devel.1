Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C3C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 17:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524E320870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 17:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524E320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcYx9-0006yZ-Jw
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 13:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcYw6-000610-53
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 13:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcYw5-0003BZ-2m
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 13:27:22 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:51011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcYw4-00037s-Sl
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 13:27:21 -0400
Received: from player158.ha.ovh.net (unknown [10.108.57.14])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A27F510D4DD
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:27:17 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 32C636C95CB3;
 Sun, 16 Jun 2019 17:27:10 +0000 (UTC)
Date: Sun, 16 Jun 2019 19:27:08 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190616192708.4b824da5@bahia.lan>
In-Reply-To: <20190614093121.5580-3-xieyongji@baidu.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
 <20190614093121.5580-3-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8932045437206173997
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeihedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.49
Subject: Re: [Qemu-devel] [PATCH v3 2/5] virtio: Set "start_on_kick" for
 legacy devices
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

On Fri, 14 Jun 2019 17:31:18 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> Besides virtio 1.0 transitional devices, we should also
> set "start_on_kick" flag for legacy devices (virtio 0.9).
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/virtio/virtio.c         | 6 ++----
>  include/hw/virtio/virtio.h | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 19062fbb96..473881e9ec 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1212,8 +1212,7 @@ void virtio_reset(void *opaque)
>          k->reset(vdev);
>      }
>  
> -    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> -                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> +    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
>      vdev->started = false;
>      vdev->broken = false;
>      vdev->guest_features = 0;
> @@ -2325,8 +2324,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>              g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
>      }
>  
> -    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> -                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> +    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
>      vdev->started = false;
>      vdev->device_id = device_id;
>      vdev->status = 0;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 15d5366939..b189788cb2 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -107,7 +107,7 @@ struct VirtIODevice
>      bool broken; /* device in invalid state, needs reset */
>      bool use_started;
>      bool started;
> -    bool start_on_kick; /* virtio 1.0 transitional devices support that */
> +    bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
>      uint8_t device_endian;


