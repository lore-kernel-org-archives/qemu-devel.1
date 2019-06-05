Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70409C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EA72075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EA72075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPdt-0006qv-G1
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:43:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYPd7-0006Sy-So
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYPd6-0001po-6T
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:42:37 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:37251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hYPd5-0001mv-Ve
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:42:36 -0400
Received: from player728.ha.ovh.net (unknown [10.108.54.217])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 69A8B17CD9E
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 08:42:32 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player728.ha.ovh.net (Postfix) with ESMTPSA id 5D61C66A9213;
	Wed,  5 Jun 2019 06:42:25 +0000 (UTC)
Date: Wed, 5 Jun 2019 08:42:24 +0200
From: Greg Kurz <groug@kaod.org>
To: elohimes@gmail.com
Message-ID: <20190605084224.22e4cd92@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190604073459.15651-3-xieyongji@baidu.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
	<20190604073459.15651-3-xieyongji@baidu.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7229966252579133741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeguddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.128
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio: Set "start_on_kick" for
 legacy devices
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

On Tue,  4 Jun 2019 15:34:56 +0800
elohimes@gmail.com wrote:

> From: Xie Yongji <xieyongji@baidu.com>
> 
> Besides virtio 1.0 transitional devices, we should also
> set "start_on_kick" flag for legacy devices (virtio 0.9).
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> ---

Patch looks good but it would be even better if applied
earlier so that it doesn't revert lines added by the
previous patch...

>  hw/virtio/virtio.c         | 2 --
>  include/hw/virtio/virtio.h | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 6508b2faad..6ec45d8f0a 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2080,7 +2080,6 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>          }
>  
>          if (!vdev->started &&
> -            virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&

... here and...
>              !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>              vdev->start_on_kick = true;
>          }
> @@ -2236,7 +2235,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>      }
>  
>      if (!vdev->started &&
> -        virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&

... here.

>          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>          vdev->start_on_kick = true;
>      }
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27c0efc3d0..303242b3c2 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -106,7 +106,7 @@ struct VirtIODevice
>      bool vm_running;
>      bool broken; /* device in invalid state, needs reset */
>      bool started;
> -    bool start_on_kick; /* virtio 1.0 transitional devices support that */
> +    bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
>      uint8_t device_endian;


