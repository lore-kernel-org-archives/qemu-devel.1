Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA04C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231882065E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231882065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbUw-0000Rr-E5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1jvbUO-0008SS-LY
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:06:00 -0400
Received: from [195.135.220.15] (port=47520 helo=mx2.suse.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1jvbUM-0007ku-US
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:06:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0EC47AD78;
 Wed, 15 Jul 2020 07:06:00 +0000 (UTC)
Message-ID: <4b9cc7d60fdbd8fa41686fb94ed55e354fe6fa20.camel@suse.com>
Subject: Re: [PATCH] virtio-rng: return available data with O_NONBLOCK
From: Martin Wilck <mwilck@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Jul 2020 09:05:56 +0200
In-Reply-To: <20200714220019.10854-1-mwilck@suse.com>
References: <20200714220019.10854-1-mwilck@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 195.135.220.15 (failed)
Received-SPF: pass client-ip=195.135.220.15; envelope-from=mwilck@suse.com;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 23:03:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-15 at 00:00 +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
> non-blocking read() to retrieve random data, it ends up in a tight
> loop with poll() always returning POLLIN and read() returning EAGAIN.
> This repeats forever until some process makes a blocking read() call.
> The reason is that virtio_read() always returns 0 in non-blocking
> mode,
> even if data is available.
> 
> The following test program illustrates the behavior.

...

> This can be observed in the real word e.g. with nested qemu/KVM
> virtual
> machines, if both the "outer" and "inner" VMs have a virtio-rng
> device.
> If the "inner" VM requests random data, qemu running in the "outer"
> VM
> uses this device in a non-blocking manner like the test program
> above.
> 
> Fix it by returning available data if it exists.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c
> b/drivers/char/hw_random/virtio-rng.c
> index 79a6e47b5fbc..94806308d814 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -59,6 +59,9 @@ static int virtio_read(struct hwrng *rng, void
> *buf, size_t size, bool wait)
>  	if (vi->hwrng_removed)
>  		return -ENODEV;
>  
> +	if (vi->data_avail >= size || (vi->data_avail && !wait))
> +		return vi->data_avail;
> +
>  	if (!vi->busy) {
>  		vi->busy = true;
>  		reinit_completion(&vi->have_data);

This patch was nonsense. I'm sorry. Looking into it again.

Martin



