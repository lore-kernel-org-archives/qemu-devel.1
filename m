Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4618BC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6402082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6402082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKe24-0004Cn-Ac
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 03:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iKe1O-0003la-U7
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iKe1M-0002nr-SY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iKe1M-0002nO-MM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:47:00 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BEA0689AC4
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 07:46:58 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id z205so792827wmb.7
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 00:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+YKy91bKOvJ4wexHPhW/4/jiScgHegfQ+rKgJFMOd0U=;
 b=dkwyWMttg6A3OyK2tkfOw7E6Y4wUcWANJdHOe4QJhNih3BgXwxhGx/JItU7/bMxHTn
 PkM3dzmr06BLQCVvCKw077MdjvwpXwS9EapkfkAVrKtmNpwOl2HHCc3ceUrihcyjPFeI
 hNdNXx+aqZjtbt5T/WywpelQLqrXt46q3MqHHVo4wFT3CPJFdLjYjDdRNkOzPDrArAsM
 8YDm3VUlqqcxKb+QkM8eXsAVRGwmmFc7mz4vEvfdtzJUT41Ur10ZmszTAykH3DNujUpk
 AiFpsleFObVwmKqFBMlQ9Oq8UkLRV2dcBkXCWYln6Hqi2TYYNGCak4VMnoT2MdnNHki5
 O5sg==
X-Gm-Message-State: APjAAAV+cSPUbZlHeN3/yHsWPhP8wYUijy5mrX3poFHvvzHx2K0Hsmty
 xqj3hWCmKTQQxq5B8X95tRqoeoS8iwRjU8G5p47xrlqGPkc/BJ3JN1Gs7cT4CPb+taJc1X/RHyE
 9QqGSc/J8XMKaMSo=
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr1396890wrb.222.1571212017368; 
 Wed, 16 Oct 2019 00:46:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9ASc2rNRMKnyQqX9RlMQBcNPaaSwDSDKxyhAkMXf8tk4zR5SHk7DbGPWr2HsrFMxsKqfFJA==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr1396876wrb.222.1571212017095; 
 Wed, 16 Oct 2019 00:46:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id y5sm1685953wma.14.2019.10.16.00.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 00:46:56 -0700 (PDT)
Subject: Re: [PATCH v9 14/15] hw/i386: Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-15-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6276a8e7-2928-6e33-64a1-3ae01a30a718@redhat.com>
Date: Wed, 16 Oct 2019 09:46:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015112346.45554-15-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com, kraxel@redhat.com,
 imammedo@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index c5c9d4900e..d399dcba52 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -92,6 +92,10 @@ config Q35
>      select SMBIOS
>      select FW_CFG_DMA
>  
> +config MICROVM
> +    bool

Missing:

    select ISA_BUS
    select APIC
    select IOAPIC
    select I8259
    select MC146818RTC

No need to post v10 just for this.

Paolo


> +    select VIRTIO_MMIO
> +
>  config VTD
>      bool
>  
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 7ed80a4853..0d195b5210 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -4,6 +4,7 @@ obj-y += x86.o
>  obj-y += pc.o
>  obj-$(CONFIG_I440FX) += pc_piix.o
>  obj-$(CONFIG_Q35) += pc_q35.o
> +obj-$(CONFIG_MICROVM) += microvm.o
>  obj-y += fw_cfg.o pc_sysfw.o
>  obj-y += x86-iommu.o
>  obj-$(CONFIG_VTD) += intel_iommu.o
> 


