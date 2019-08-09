Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289EC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B221F2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B221F2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7rt-0004cC-To
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hw7rV-00047p-CH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hw7rU-0005U8-8D
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:35:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hw7rU-0005TQ-3n
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:35:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id z16so2285211qka.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 09:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F5uHMDxjjgBE10i2i5vQFV4kfYVwViF+4v8/iXiU+DQ=;
 b=HCaSsGzvJ6FyIhhRn2L97HzgIiGOaxjZUG7/Yi3y5vC3Tt+EgfwXEcLJfkyQ0bEvj7
 ag1Xvfx0cxoKiWes2/5q//mzaQIOuo6H8ljeoiFFacTTpxHwMsWrPIZ+0krZAe/8EncT
 74XmurWVgsAxYLvUVWj9cJ8+KILizfyRcz9ChXleFZoA1ORF2eGDTdh99uOr2+EiAZli
 QUARKMELcT3wdBUstdPbf7BrTNN81jydJCo/ZXsA7cMeE5PrpO7LVCWuYXzAxn47alnd
 dxsG7krExTtClTPYcGguWrqCLKs6hhOyw8i0jW7Zeg0/g8u8yvv33efYdJIQdlVyrQa7
 POsA==
X-Gm-Message-State: APjAAAWVuLINqX/NrYZaT5iiYKf/0NAriEh7fTjjp45lkGbraPg7HD8x
 yujCroDmOPPdUmx37Svvlo6SnA==
X-Google-Smtp-Source: APXvYqwtV6v/QzH2EXkh+BYRDb+5Ux7hKmrIxN/zzVeCwxmu9aCEKGxnCmkqGDzaYZqGLW9Z7Oe1/Q==
X-Received: by 2002:a37:a742:: with SMTP id q63mr18313538qke.421.1565368526971; 
 Fri, 09 Aug 2019 09:35:26 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 d123sm44741955qkb.94.2019.08.09.09.35.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 09:35:26 -0700 (PDT)
Date: Fri, 9 Aug 2019 12:35:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Message-ID: <20190809123341-mutt-send-email-mst@kernel.org>
References: <20190807082241.23984-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807082241.23984-1-jusual@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add Function Level Reset
 support
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 10:22:41AM +0200, Julia Suvorova wrote:
> Using FLR becomes convenient in cases where resetting the bus is
> impractical, for example, when debugging the behavior of individual
> functions.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 10 ++++++++++
>  hw/virtio/virtio-pci.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f6d2223e78..37c5d6efbc 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -599,6 +599,10 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
>  
>      pci_default_write_config(pci_dev, address, val, len);
>  
> +    if (proxy->has_flr) {
> +        pcie_cap_flr_write_config(pci_dev, address, val, len);
> +    }
> +
>      if (range_covers_byte(address, len, PCI_COMMAND) &&
>          !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
>          virtio_pci_stop_ioeventfd(proxy);
> @@ -1718,6 +1722,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>      proxy->notify_pio.size = 0x4;
>      proxy->notify_pio.type = VIRTIO_PCI_CAP_NOTIFY_CFG;
>  
> +    proxy->has_flr = false;
> +
>      /* subclasses can enforce modern, so do this unconditionally */
>      memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
>                         /* PCI BAR regions must be powers of 2 */
> @@ -1749,6 +1755,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>  
>          pci_dev->exp.pm_cap = pos;
>  
> +        /* Set Function Level Reset capability bit */
> +        pcie_cap_flr_init(pci_dev);
> +        proxy->has_flr = true;
> +
>          /*
>           * Indicates that this function complies with revision 1.2 of the
>           * PCI Power Management Interface Specification.


I don't think we can set this for everyone: this will break
things like cross version migration.



> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 292275acb1..16d293a6bf 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -152,6 +152,7 @@ struct VirtIOPCIProxy {
>      VirtIOIRQFD *vector_irqfd;
>      int nvqs_with_notifiers;
>      VirtioBusState bus;
> +    bool has_flr;
>  };
>  
>  static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)



> -- 
> 2.21.0

