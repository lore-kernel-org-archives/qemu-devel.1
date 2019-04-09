Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A3C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD57820833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD57820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsJY-00078B-Sa
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:05:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDsIc-0006mN-DP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDsIa-000280-MM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:04:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDsIa-00027X-Au
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:04:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so11796968qtn.3
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=sxjSnVokzPr2vYwKeVpxbmOjQmUxCI+7TeYIDHrIkYM=;
	b=t7X+NPEE9pRZqNbInIr7N6szlFnRq31UM9e0hJ+Vp8Iy3Na8djT2kVszrSruV8ZeV9
	CJOw+GkAh+i5tk4t/J6RU7BE3LEI0/hKrNeSdOwutUyQKrehBLLgTbaXoYwrdlhriLD8
	Vd6xtSLGo2/GLoywKNrpXAb6XQlzEI6Hv7SDMgDIUdsY2PnA11D6PqeAWJFhJ4V1Slky
	4A1Im4FdREWMEcKlcntrNkGKwLXppnRe/nZUgJZVIuTUoUcarzTA91tKI+74BQojbzEV
	ISHXHx1O8h95l7mXQLzpJXSVZLX7FofasQ1An2gv4y6ENjqYpLqoqvsZN8scCBBH8+y4
	DHRw==
X-Gm-Message-State: APjAAAVC0RICMLH3Ky7tORCyjdReJ6lySgW5xAHNywMimfGaJnpJi6BE
	jfeU31WK1I+Jef261Ul/ELlbBA==
X-Google-Smtp-Source: APXvYqzlBkwjloGxXm9zgEbhOkYPbvzM4Ro3B3C7TsBFYVW7y68nd5MSsa73TxPHVKoFnzl5jv6FDA==
X-Received: by 2002:a0c:87d9:: with SMTP id 25mr29416737qvk.219.1554822270375; 
	Tue, 09 Apr 2019 08:04:30 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	d17sm14495110qko.93.2019.04.09.08.04.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 08:04:29 -0700 (PDT)
Date: Tue, 9 Apr 2019 11:04:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Message-ID: <20190409110149-mutt-send-email-mst@kernel.org>
References: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
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
Message-ID: <20190409150427.Fticmh46tAJwv2Vg0ZGVwVNT-JdpntN5X6Tzi7JM3CA@z>

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
> interrupt is unmasked.

So does latest upstream still change data/address of an
unmasked vector?

> The bare metal configuration is successful, but qemu will
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

Sorry - which patch?

> "if (is_masked == was_masked) return;" can it be removed at qemu?
> What is the reason for this check?
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


To add to that, notifiers generally assume that updates
come in pairs, unmask followed by mask.



> -- 
> 1.8.3.1
> 

