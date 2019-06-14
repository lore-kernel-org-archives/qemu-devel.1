Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2DC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 07:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB4F2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 07:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qvj4x1Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB4F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbgzK-0005Z3-9U
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 03:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amit@infradead.org>) id 1hbgyB-0004yE-Ik
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@infradead.org>) id 1hbgyA-0006my-5P
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:49:55 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:60060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@infradead.org>) id 1hbgy9-0006dV-Ko
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OoDiWtcrHqNxZwXG4PSuZd7hjkGiq25ictiCIESdko4=; b=Qvj4x1Llm74RoOoV2bjxeKd8o
 e6mZhZHCnyzhChVyezzCFm/eEZr+Q/T+ifgw07gGY9ku8vJ/00Qm/850dtKO/L8V5oTlOZE9Aqtjt
 p9PlOLIIXKn8Tn1bQJhEryIGxPzjGkQgpmwpTrNOuofwl2/vJLylWa2hftL4c5Lar3OSs1ht/34AV
 5GPNy9GhcdzKE14UpY/xSlz1zjJKF/2UcANVLbi2bM6Ii0zZJJ8tKxyecVr/03nNXvLDSjBLO2TIk
 KiHYK4KVXNkFhwK4HhmuTfK2Fr+3YnNTfivnUYXtt1JkbOcRP4pKOiMqV2AcGt55PLsAgfXluotvM
 Fw8SkCOxA==;
Received: from [54.239.6.185] (helo=u9312026164465a.ant.amazon.com)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbgxx-0001dE-Ih; Fri, 14 Jun 2019 07:49:42 +0000
Message-ID: <34b3714f71373982264915d351c3161937500b1a.camel@infradead.org>
From: Amit Shah <amit@infradead.org>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 09:49:38 +0200
In-Reply-To: <3ecdbf3e-abb1-b74c-7751-9740b5a2e4fc@redhat.com>
References: <20190611172032.19143-1-lvivier@redhat.com>
 <8c2d26799074a46fb5f2aaae7dc4e951ec8318a2.camel@infradead.org>
 <3ecdbf3e-abb1-b74c-7751-9740b5a2e4fc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:7c80:54:e::133
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

On Thu, 2019-06-13 at 10:53 +0200, Laurent Vivier wrote:
> On 12/06/2019 09:03, Amit Shah wrote:
> > On Tue, 2019-06-11 at 19:20 +0200, Laurent Vivier wrote:
> > > The virtio-rng linux driver can be stuck in virtio_read() on a
> > > wait_for_completion_killable() call if the virtio-rng device in
> > > QEMU
> > > doesn't provide data.
> > > 
> > > It's a problem, because virtio_read() is called from
> > > rng_get_data()
> > > with
> > > reading_mutex() held.  The same mutex is taken by
> > > add_early_randomness()
> > > and hwrng_fillfn() and this brings to a hang during the boot
> > > sequence
> > > if
> > > the virtio-rng driver is builtin.
> > > Moreover, another lock is taken (rng_mutex) when the hwrng driver
> > > wants to switch the RNG device or the user tries to unplug the
> > > virtio-rng
> > > PCI card, and this can hang too because the virtio-rng driver is
> > > only
> > > able
> > > to release the card if the virtio-rng device sends back the
> > > virtqueue
> > > element.
> > > 
> > >   # echo -n virtio_rng.1 > /sys/class/misc/hw_random/rng_current
> > >   [  240.165234] INFO: task kworker/u2:1:34 blocked for more than
> > > 120
> > > seconds.
> > >   [  240.165961] "echo 0 >
> > > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > >   [  240.166708] kworker/u2:1    D
> > > ffffffffb86b85a8     0    34      2 0x00000000
> > >   [  240.166714] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > >   [  240.166716]  ffffa0e8f3c0b890 0000000000000046
> > > ffffa0e8f3c00000
> > > ffffa0e8f3c0bfd8
> > >   [  240.166717]  ffffa0e8f3c0bfd8 ffffa0e8f3c0bfd8
> > > ffffa0e8f3c00000
> > > ffffffffb86b85a0
> > >   [  240.166719]  ffffffffb86b85a4 ffffa0e8f3c00000
> > > 00000000ffffffff
> > > ffffffffb86b85a8
> > >   [  240.166720] Call Trace:
> > >   [  240.166725]  [<ffffffffb82a61c9>]
> > > schedule_preempt_disabled+0x29/0x70
> > >   [  240.166727]  [<ffffffffb82a40f7>]
> > > __mutex_lock_slowpath+0xc7/0x1d0
> > >   [  240.166728]  [<ffffffffb82a350f>] mutex_lock+0x1f/0x2f
> > >   [  240.166730]  [<ffffffffb8022b52>] hwrng_register+0x32/0x1d0
> > >   [  240.166733]  [<ffffffffc07fa149>] virtrng_scan+0x19/0x30
> > > [virtio_rng]
> > >   [  240.166744]  [<ffffffffc03108db>]
> > > virtio_dev_probe+0x1eb/0x290
> > > [virtio]
> > >   [  240.166746]  [<ffffffffb803d6e5>]
> > > driver_probe_device+0x145/0x3c0
> > >   ...
> > > 
> > > In some case, the QEMU RNG backend is not able to provide data,
> > > and
> > > the virtio-rng device is not aware of that:
> > > - with rng-random using /dev/random and no entropy is available,
> > > - with rng-egd started with a socket in "server,nowait" mode and
> > >   no daemon connected,
> > > - with rng-egd and an egd daemon that is not providing enough
> > > data,
> > > - ...
> > > 
> > > To release the locks regularly, this patch adds a watchdog in
> > > QEMU
> > > virtio-rng device that sends back to the guest the virtqueue
> > > buffer
> > > with a 0 byte payload. This case is expected and correctly
> > > managed by
> > > the hwrng core.
> > 
> > I'm wondering if it makes more sense to rework the way the kernel
> > driver requests for seeding entropy during probe.
> 
> The kernel side was my first angle of attack.
> I tried first to not block in add_early_randomness():
> 
>   "hwrng: core - don't block in add_early_randomness()"
>   https://patchwork.kernel.org/patch/10877571/
> 
> But I agree with the maintainer, the problem must be fixed at virtio-
> rng 
> level.

Yea.

How much of this is due to 'rng-egd was not set up properly; the
backend did not appear in time' -- ie a setup problem; vs a problem we
can expect to recur?

The current patch affects *all* requests from the guest.  The problem
being seen though is just during the driver probe.  Is the current
patch doing much more than is required?  Say the device runs out of
randomness to provide after setup - the guest's read calls will just
block and remain killable.  It's the probe currently that is not
killable.

Other options to explore are:

1. Ensure setup is ready (ie the device's backend is set up before
plugging in the device), so that the device is ready to serve requests
as soon as it's plugged in

2. Make the add_early_randomness optional for virtio-rng.  (This is a
big hammer, and working around bad setup problems.)




> 
> > The virtio_read call is killable, so it can take signals when
> > initiated
> > by userspace.  For the initial probe, specifying a timeout /
> > watchdog
> > in the driver is better.
> 
> Yes, I think also it's better, I tried to do something like that:
> 
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -77,10 +77,7 @@ static int virtio_read(struct hwrng *rng, void
> *buf, size_t size, bool wait)
>                 register_buffer(vi, buf, size);
>         }
>  
> -       if (!wait)
> -               return 0;
> -
> -       ret = wait_for_completion_killable(&vi->have_data);
> +       ret = wait_for_completion_timeout(&vi->have_data, wait ?
> MAX_SCHEDULE_TIMEOUT : HZ);
>         if (ret < 0)
>                 return ret;
> 
> But I have a problem doing the timeout / watchdog at driver level:
> once 
> the buffer is submitted to the virtqueue, how to cancel it? Is there
> a 
> way to ask the QEMU device to not process the element in the
> virtqueue 
> we have stopped to wait for because of the timeout (or for the
> signal: I 
> don't understand how it works in this case. How it is canceled?)?

Could be achieved via a control command?  But all that sounds quite
ugly (and also requires host+guest modification).


