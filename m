Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D482C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 07:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB0F205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 07:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+SgliZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB0F205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haxKt-0007re-5k
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 03:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amit@infradead.org>) id 1haxIc-0006gp-7r
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 03:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@infradead.org>) id 1haxIa-0006CD-AT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 03:03:57 -0400
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1]:51956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@infradead.org>) id 1haxIZ-00068H-Oe
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 03:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7MdRuqWvqOHYiaByb3S+gl7l2mQoK/mhcelq/ysev9E=; b=Y+SgliZArH/QIziKHqrzT9hWxU
 2LGW0CcAgxeCKHE3bNAVHkD8/O698l2UksYKkgDl1nzVn0X9TGUP55uztcvnGTu5y2ft0E9SfIBPQ
 TJ648MO+bD1kt5yBRJsYehGs5nKxOjTSrE2oXGFleutte7MN6Mddbu3+cpBTkv1cXaLcg7q6wqyxA
 SF6A80XNBSaWzdHi/dLytZeF0stYeZHD4R68VOIKXdT1Ci9ShKVjJo4VVKcy6MOAqom3QeKqPe7Iq
 0Fd6TXJFMiCFP2Zu8SrhQt566G+CougOJdNefS5iph4NdMke/7kttg7KC+W4MF/jZTXIxKBFEFpco
 KF05k62Q==;
Received: from [54.239.6.185] (helo=u9312026164465a.ant.amazon.com)
 by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1haxII-0003lR-AP; Wed, 12 Jun 2019 07:03:38 +0000
Message-ID: <8c2d26799074a46fb5f2aaae7dc4e951ec8318a2.camel@infradead.org>
From: Amit Shah <amit@infradead.org>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 09:03:36 +0200
In-Reply-To: <20190611172032.19143-1-lvivier@redhat.com>
References: <20190611172032.19143-1-lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:8b0:10b:1231::1
Subject: Re: [Qemu-devel] [RFC] virtio-rng: add a watchdog
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-06-11 at 19:20 +0200, Laurent Vivier wrote:
> The virtio-rng linux driver can be stuck in virtio_read() on a
> wait_for_completion_killable() call if the virtio-rng device in QEMU
> doesn't provide data.
> 
> It's a problem, because virtio_read() is called from rng_get_data()
> with
> reading_mutex() held.  The same mutex is taken by
> add_early_randomness()
> and hwrng_fillfn() and this brings to a hang during the boot sequence
> if
> the virtio-rng driver is builtin.
> Moreover, another lock is taken (rng_mutex) when the hwrng driver
> wants to switch the RNG device or the user tries to unplug the
> virtio-rng
> PCI card, and this can hang too because the virtio-rng driver is only
> able
> to release the card if the virtio-rng device sends back the virtqueue
> element.
> 
>   # echo -n virtio_rng.1 > /sys/class/misc/hw_random/rng_current
>   [  240.165234] INFO: task kworker/u2:1:34 blocked for more than 120
> seconds.
>   [  240.165961] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
>   [  240.166708] kworker/u2:1    D
> ffffffffb86b85a8     0    34      2 0x00000000
>   [  240.166714] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
>   [  240.166716]  ffffa0e8f3c0b890 0000000000000046 ffffa0e8f3c00000
> ffffa0e8f3c0bfd8
>   [  240.166717]  ffffa0e8f3c0bfd8 ffffa0e8f3c0bfd8 ffffa0e8f3c00000
> ffffffffb86b85a0
>   [  240.166719]  ffffffffb86b85a4 ffffa0e8f3c00000 00000000ffffffff
> ffffffffb86b85a8
>   [  240.166720] Call Trace:
>   [  240.166725]  [<ffffffffb82a61c9>]
> schedule_preempt_disabled+0x29/0x70
>   [  240.166727]  [<ffffffffb82a40f7>]
> __mutex_lock_slowpath+0xc7/0x1d0
>   [  240.166728]  [<ffffffffb82a350f>] mutex_lock+0x1f/0x2f
>   [  240.166730]  [<ffffffffb8022b52>] hwrng_register+0x32/0x1d0
>   [  240.166733]  [<ffffffffc07fa149>] virtrng_scan+0x19/0x30
> [virtio_rng]
>   [  240.166744]  [<ffffffffc03108db>] virtio_dev_probe+0x1eb/0x290
> [virtio]
>   [  240.166746]  [<ffffffffb803d6e5>]
> driver_probe_device+0x145/0x3c0
>   ...
> 
> In some case, the QEMU RNG backend is not able to provide data, and
> the virtio-rng device is not aware of that:
> - with rng-random using /dev/random and no entropy is available,
> - with rng-egd started with a socket in "server,nowait" mode and
>   no daemon connected,
> - with rng-egd and an egd daemon that is not providing enough data,
> - ...
> 
> To release the locks regularly, this patch adds a watchdog in QEMU
> virtio-rng device that sends back to the guest the virtqueue buffer
> with a 0 byte payload. This case is expected and correctly managed by
> the hwrng core.

I'm wondering if it makes more sense to rework the way the kernel
driver requests for seeding entropy during probe.

The virtio_read call is killable, so it can take signals when initiated
by userspace.  For the initial probe, specifying a timeout / watchdog
in the driver is better.

> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/virtio/virtio-rng.c         | 23 +++++++++++++++++++++++
>  include/hw/virtio/virtio-rng.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 30493a258622..173ecd370c0e 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -19,6 +19,8 @@
>  #include "qom/object_interfaces.h"
>  #include "trace.h"
>  
> +#define VIRTIO_RNG_WATCHDOG_MS 500
> +
>  static bool is_guest_ready(VirtIORNG *vrng)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(vrng);
> @@ -38,6 +40,21 @@ static size_t get_request_size(VirtQueue *vq,
> unsigned quota)
>      return in;
>  }
>  
> +static void watchdog(void *opaque)
> +{
> +    VirtIORNG *vrng = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(vrng);
> +    VirtQueueElement *elem;
> +
> +    /* wake up driver */
> +    elem = virtqueue_pop(vrng->vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +    virtqueue_push(vrng->vq, elem, 0);
> +    virtio_notify(vdev, vrng->vq);
> +}
> +
>  static void virtio_rng_process(VirtIORNG *vrng);
>  
>  /* Send data from a char device over to the guest */
> @@ -98,6 +115,9 @@ static void virtio_rng_process(VirtIORNG *vrng)
>          return;
>      }
>  
> +    timer_mod(vrng->watchdog_timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> VIRTIO_RNG_WATCHDOG_MS);
> +
>      if (vrng->activate_timer) {
>          timer_mod(vrng->rate_limit_timer,
>                    qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + vrng-
> >conf.period_ms);
> @@ -222,6 +242,7 @@ static void virtio_rng_device_realize(DeviceState
> *dev, Error **errp)
>  
>      vrng->vq = virtio_add_queue(vdev, 8, handle_input);
>      vrng->quota_remaining = vrng->conf.max_bytes;
> +    vrng->watchdog_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> watchdog, vrng);
>      vrng->rate_limit_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                                 check_rate_limit,
> vrng);
>      vrng->activate_timer = true;
> @@ -236,6 +257,8 @@ static void
> virtio_rng_device_unrealize(DeviceState *dev, Error **errp)
>      VirtIORNG *vrng = VIRTIO_RNG(dev);
>  
>      qemu_del_vm_change_state_handler(vrng->vmstate);
> +    timer_del(vrng->watchdog_timer);
> +    timer_free(vrng->watchdog_timer);
>      timer_del(vrng->rate_limit_timer);
>      timer_free(vrng->rate_limit_timer);
>      virtio_cleanup(vdev);
> diff --git a/include/hw/virtio/virtio-rng.h
> b/include/hw/virtio/virtio-rng.h
> index 922dce7caccf..05d6b0e7d881 100644
> --- a/include/hw/virtio/virtio-rng.h
> +++ b/include/hw/virtio/virtio-rng.h
> @@ -42,6 +42,7 @@ typedef struct VirtIORNG {
>      /* We purposefully don't migrate this state.  The quota will
> reset on the
>       * destination as a result.  Rate limiting is host state, not
> guest state.
>       */
> +    QEMUTimer *watchdog_timer;
>      QEMUTimer *rate_limit_timer;
>      int64_t quota_remaining;
>      bool activate_timer;


