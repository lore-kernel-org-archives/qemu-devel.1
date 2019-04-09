Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF6EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2702064B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2702064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDs7O-0000Rb-Fs
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:52:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDs6b-00007J-DC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDs6a-0004mH-9b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:52:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDs6a-0004k4-38
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:52:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so10419064qki.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=GrqC0GrHfTETn5jCZw9IW6WZERNACzdc7ouz7UhgXdE=;
	b=s0LSbl1POQHXXb2QQdwgEaHaRZd/1Nom43HxzhmNbGT7uhLEaE8vWRqQmzJjbUF1XA
	dKl0//5ywSmRvpVMj9mEx7uYu5l0j/6CKXqKpBbuLveSYD68yHXUiI1bF+iaF7vEoMAe
	Cl7VzOcxtFuBFJ1GyYfocQOaOkzRI79L/a6ELDScFdGwyp/5ZObUzXh+CtsUe8EBGavO
	b0fsoffybuB5KarKInGP1OuWT1dWAMZZfkxeZNLOgMOCI7vfcdq1G/bFpBXFdfBYkfYw
	wUrcesmwNIWkK95+TZalODtZoGzCRkkeFj1Ty/TRl/pFbuE0flb0/TBapcM+ZZSVMrES
	Tx/A==
X-Gm-Message-State: APjAAAU3PD9K9RCXH+3iYNMrTFEWk4gsY5/+z/hEk3ig0yFRxxdNx6rY
	Pyo+Rd2ZqLX3Awl7ChY5OvAJLQ==
X-Google-Smtp-Source: APXvYqy+nUMEzF69W8oc/NvGLBKiy+FUkdDUNGq6zp+YHzS5QHtu6sJcNEJO9m1mBeNTt7XAJ2XqiQ==
X-Received: by 2002:a05:620a:126e:: with SMTP id
	b14mr28228494qkl.49.1554821523813; 
	Tue, 09 Apr 2019 07:52:03 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	k41sm27653037qtc.89.2019.04.09.07.52.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 07:52:02 -0700 (PDT)
Date: Tue, 9 Apr 2019 10:52:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Message-ID: <20190409102526-mutt-send-email-mst@kernel.org>
References: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH] msix: fix interrupt aggregation problem at
 the passthrough of NVMe SSD
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
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409145200.cdAOkcCq1LwFh5d-SxbJxqf8R4P-5ciGodCx1gT0g9Q@z>

On Tue, Apr 09, 2019 at 02:14:56PM +0000, Zhuangyanying wrote:
> From: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> 
> Recently I tested the performance of NVMe SSD passthrough and found that interrupts
> were aggregated on vcpu0(or the first vcpu of each numa) by /proc/interrupts,when
> GuestOS was upgraded to sles12sp3 (or redhat7.6). But /proc/irq/X/smp_affinity_list
> shows that the interrupt is spread out, such as 0-10, 11-21,.... and so on.
> This problem cannot be resolved by "echo X > /proc/irq/X/smp_affinity_list", because
> the NVMe SSD interrupt is requested by the API pci_alloc_irq_vectors(), so the
> interrupt has the IRQD_AFFINITY_MANAGED flag.
> 
> GuestOS sles12sp3 backport "automatic interrupt affinity for MSI/MSI-X capable devices",
> but the implementation of __setup_irq has no corresponding modification. It is still
> irq_startup(), then setup_affinity(), that is sending an affinity message when the
> interrupt is unmasked. The bare metal configuration is successful, but qemu will
> not trigger the msix update, and the affinity configuration fails.
> The affinity is configured by /proc/irq/X/smp_affinity_list, implemented at
> apic_ack_edge(), the bitmap is stored in pending_mask,
> mask->__pci_write_msi_msg()->unmask,
> and the timing is guaranteed, and the configuration takes effect.
> 
> The GuestOS linux-master incorporates the "genirq/cpuhotplug: Enforce affinity
> setting on startup of managed irqs" to ensure that the affinity is first issued
> and then __irq_startup(), for the managerred interrupt. So configuration is
> successful.
> 
> It now looks like sles12sp3 (up to sles15sp1, linux-4.12.x), redhat7.6
> (3.10.0-957.10.1) does not have backport the patch yet.
> "if (is_masked == was_masked) return;" can it be removed at qemu?
> What is the reason for this check?

The reason is simple:

The PCI spec says:

Software must not modify the Address or Data fields of an entry while it is unmasked.

It's a guest bug then?

> 
> Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> ---
>  hw/pci/msix.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 4e33641..e1ff533 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -119,10 +119,6 @@ static void msix_handle_mask_update(PCIDevice *dev, int vector, bool was_masked)
>  {
>      bool is_masked = msix_is_masked(dev, vector);
>  
> -    if (is_masked == was_masked) {
> -        return;
> -    }
> -
>      msix_fire_vector_notifier(dev, vector, is_masked);
>  
>      if (!is_masked && msix_is_pending(dev, vector)) {
> -- 
> 1.8.3.1
> 

