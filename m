Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C4AC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E26824E04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E26824E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXtPc-0006R4-Uc
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 16:18:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXtNw-0005gt-NZ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXtNv-0000TC-Po
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:16:48 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:34638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hXtNv-0000Ou-K3
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:16:47 -0400
Received: from player714.ha.ovh.net (unknown [10.108.42.215])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 401A921791F
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 22:16:45 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player714.ha.ovh.net (Postfix) with ESMTPSA id 419446608E43;
	Mon,  3 Jun 2019 20:16:40 +0000 (UTC)
Date: Mon, 3 Jun 2019 22:16:39 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190603221639.5e4ddac1@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190529070955.25565-3-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-3-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9235756938363902253
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefjedgudegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.36
Subject: Re: [Qemu-devel] [PATCH 2/5] virtio: Migrate the "start_on_kick"
 flag
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

On Wed, 29 May 2019 15:09:52 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> We should migrate the "start_on_kick" flag so that we
> would not miss starting device on kicking at startup
> after migration.
> 

Hmm... IIUC "start_on_kick" means "virtio 1.0 transitional device that has
not been started yet", ie:

!vdev->started &&
(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
 !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))

If so, not sure why you need this extra field in the first place, but
you probably don't need to migrate it. Just recalculate in a post load
callback.

> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---
>  hw/virtio/virtio.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index fc8fca81ad..4d4ff67791 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1802,6 +1802,13 @@ static bool virtio_started_needed(void *opaque)
>      return vdev->started;
>  }
>  
> +static bool virtio_start_on_kick_needed(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    return vdev->start_on_kick;
> +}
> +
>  static const VMStateDescription vmstate_virtqueue = {
>      .name = "virtqueue_state",
>      .version_id = 1,
> @@ -1941,6 +1948,17 @@ static const VMStateDescription vmstate_virtio_started = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_virtio_start_on_kick = {
> +    .name = "virtio/start_on_kick",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = &virtio_start_on_kick_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(start_on_kick, VirtIODevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio = {
>      .name = "virtio",
>      .version_id = 1,
> @@ -1957,6 +1975,7 @@ static const VMStateDescription vmstate_virtio = {
>          &vmstate_virtio_broken,
>          &vmstate_virtio_extra_state,
>          &vmstate_virtio_started,
> +        &vmstate_virtio_start_on_kick,
>          NULL
>      }
>  };


