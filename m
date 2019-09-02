Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECFC41514
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE16216C8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE16216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4mbb-0004kH-Jk
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 09:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i4maa-000423-9I
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i4maX-0000KR-28
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1i4maW-0000IF-RD
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:41:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3404580F6D;
 Mon,  2 Sep 2019 13:41:43 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D72D360C18;
 Mon,  2 Sep 2019 13:41:37 +0000 (UTC)
Date: Mon, 2 Sep 2019 15:41:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190902154135.39043595.cohuck@redhat.com>
In-Reply-To: <20190829165026.225173-1-slp@redhat.com>
References: <20190829165026.225173-1-slp@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 02 Sep 2019 13:41:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: stefanha@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 abologna@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 18:50:27 +0200
Sergio Lopez <slp@redhat.com> wrote:

> Implement the modern (v2) personality, according to the VirtIO 1.0
> specification.
> 
> Support for v2 among guests is not as widespread as it'd be
> desirable. While the Linux driver has had it for a while, support is
> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
> 
> For this reason, the v2 personality is disabled, keeping the legacy
> behavior as default. Machine types willing to use v2, can enable it
> using MachineClass's compat_props.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changelog:
> 
> v2:
>  - Switch from RFC to PATCH.
>  - Avoid the modern vs. legacy dichotomy. Use legacy or non-legacy
>    instead. (Andrea Bolognani, Cornelia Huck)
>  - Include the register offset in the warning messages. (Stefan
>    Hajnoczi)
>  - Fix device endianness for the non-legacy mode. (Michael S. Tsirkin)
>  - Honor the specs in VIRTIO_MMIO_QUEUE_READY. (Michael S. Tsirkin)
> ---
>  hw/virtio/virtio-mmio.c | 296 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 279 insertions(+), 17 deletions(-)
> 

> @@ -146,28 +163,51 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      case VIRTIO_MMIO_MAGIC_VALUE:
>          return VIRT_MAGIC;
>      case VIRTIO_MMIO_VERSION:
> -        return VIRT_VERSION;
> +        if (proxy->legacy) {
> +            return VIRT_VERSION_LEGACY;
> +        } else {
> +            return VIRT_VERSION;
> +        }
>      case VIRTIO_MMIO_DEVICE_ID:
>          return vdev->device_id;
>      case VIRTIO_MMIO_VENDOR_ID:
>          return VIRT_VENDOR;
>      case VIRTIO_MMIO_DEVICE_FEATURES:
> -        if (proxy->host_features_sel) {
> -            return 0;
> -        }
> -        return vdev->host_features;
> +        return vdev->host_features >> (32 * proxy->host_features_sel);

Hm... I think you want to return 0 for host_features_sel > 0 on legacy
devices.

Also, there's VirtIODeviceClass->legacy_features, which probably should
be masked out for non-legacy devices?

(...)

> @@ -229,17 +275,33 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      }
>      switch (offset) {
>      case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
> -        proxy->host_features_sel = value;
> +        if (value) {
> +            proxy->host_features_sel = 1;
> +        } else {
> +            proxy->host_features_sel = 0;
> +        }
>          break;
>      case VIRTIO_MMIO_DRIVER_FEATURES:
> -        if (!proxy->guest_features_sel) {
> +        if (!proxy->legacy) {
> +            proxy->guest_features[proxy->guest_features_sel] = value;
> +        } else if (!proxy->guest_features_sel) {
>              virtio_set_features(vdev, value);

If the guest tries to set something !0 for guest_features_sel > 0 on a
legacy device, should that be logged as a guest bug?

>          }
>          break;

(...)

Otherwise, looks good to me.

