Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF8CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCE822B49
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH6EbsbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCE822B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k13D3-0007v5-Jf
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 03:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k13CQ-0007Vu-HW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 03:41:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k13CN-00085S-RU
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 03:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596094912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRhu1KbzBCeT46SPbTDQbmbBVbFxh3XKQCHrFJTQnx0=;
 b=fH6EbsbINtrJRJLasLnaFfq6wcik82J3cVahfOI0ohiTazIYguPS9BgiI8vJqDQ9NkhTRu
 Qtl2CXp5VQXkFQHyhfOsikyoc2nTnreKwSgjSROIUBYGQi76qwsDA479coMKBdLTXl8RZ2
 8uJvWx5jyjOIUaSlNBLMLNgrov1DGAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-CqUMb84ENByJnJHD-0Uxdg-1; Thu, 30 Jul 2020 03:41:51 -0400
X-MC-Unique: CqUMb84ENByJnJHD-0Uxdg-1
Received: by mail-wr1-f69.google.com with SMTP id d6so6038645wrv.23
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 00:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hRhu1KbzBCeT46SPbTDQbmbBVbFxh3XKQCHrFJTQnx0=;
 b=OguvqT7z5HEw5D/h9DmKa6ZaEvCVH1RA8bDRq6ejCWPe5asr3jaZ1buA/MevTtgO21
 /Oj5REUtnOaGXVFtLzsHXNkuA43pHQOTgxMrZt+wBRaHeXtToToGE1OwIiJMMigz0L7D
 3bW2O5k8iqvVYo3SV/J3wRJwUf3nz8ODOBPDx9eMhoE+Ov3VtY1Ky9DRsd4/GtYOVDTF
 nw9F8SbOCxiwZ081X+bsirb2XZgci068up0pUoGHzGKaM0Wvrshjio9tYXLIf/UaN0jn
 usFGDt9QqCTtK+5Hh2uD/bclcG5zp7behnekUHFlF6eQ35/ZQgnt0KQHLBwHCJVSDhBX
 aOrQ==
X-Gm-Message-State: AOAM532ZCLAGU+Z/hf1ibHsczFs0Ki8Kzaavr6wk0k+PyuJ0iCjzzr+j
 e4sDrC2uOow0sT0RJ5KCNig45tX9jF+EcHbY0v1sGKcyyKlO4V3gZH/sR+OijEuUnzGPMjdKRGD
 jyfLl/RTMgJQXSBs=
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr12055900wme.70.1596094909838; 
 Thu, 30 Jul 2020 00:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrQRXN91AtdQq+eDt3hOjLZ9O5XrizN+h4e7Uhd/W4AmqK33prneyZYR3Qlmc57eZLOGbgRQ==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr12055884wme.70.1596094909591; 
 Thu, 30 Jul 2020 00:41:49 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id 69sm8937970wmb.8.2020.07.30.00.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 00:41:49 -0700 (PDT)
Date: Thu, 30 Jul 2020 09:41:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Subject: Re: [PATCH] pci_dma_rw: return correct value instead of 0
Message-ID: <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
References: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 12:17:32AM +0200, Emanuele Giuseppe Esposito wrote:
> pci_dma_rw currently always returns 0, regardless
> of the result of dma_memory_rw. Adjusted to return
> the correct value.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  include/hw/pci/pci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index c1bf7d5356..41c4ab5932 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -787,8 +787,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
>  static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                               void *buf, dma_addr_t len, DMADirection dir)
>  {
> -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> -    return 0;
> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
>  }

I think it's a left over from when we used "void cpu_physical_memory_rw()".

I agree that it is better to return the dma_memory_rw() return value, but
at first look, no one seems to check the return value of pci_dma_rw(),
pci_dma_read(), andpci_dma_write().

Should we make them void?


Anyway, for this patch:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


