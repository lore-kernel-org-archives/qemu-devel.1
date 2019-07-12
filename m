Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D4FC742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5C120651
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5C120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlyzk-0008MO-64
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlyzZ-0007yG-Im
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlyzY-0002RN-LQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:05:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlyzY-0002QR-FW
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:05:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so10695013wrr.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gvdau21hphp69N3rbp5KDA0z3bbsOcoNLWey77hXBgg=;
 b=H4rW2R8+A1ZKk4/zaNx0wQ69DM9HywuIvQDn4F9iFzS1tt6FR+hae3ZRG+WUX1rDml
 zYtJTEq4TzR3HsQUHMQFLRgGsuJuJVtrDgjNgaPqqKJ0zyEgnq1aHbufDulH/WxSV/IP
 SRfGqLsfVTlA8/fuRJsLbZmt4Z6tzz1hjuVEvVjTouQHLIXPA7a4e2T0A8nlV66/ikDW
 oyCSxvZgIwMbB3iap9b2J6SalDnwUscpcB4PWM1mwKLOdV696yPMA5Wc6J3V1Thc80JG
 QrTHNgS6M2lem6jWlyHYRYhZjAv5ebgx+EcbzABjod/ohxOcOtkFR4K97QstCBplskgb
 wmNQ==
X-Gm-Message-State: APjAAAXivi8yieSNPTjBid9ABkZg+JZfikfAVeW2eUZaYwNO814vmRzt
 Dj4uPBQfrBCpEwdjOwM92Gu7gQ==
X-Google-Smtp-Source: APXvYqzG/mNIPnWwmgZQOSTPfVXcLe3dUtWOuPf4Ld47zsqMDOBjqg0pSxUs1v1yYaNvlbgQDfSxTg==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr12601219wrs.105.1562951151123; 
 Fri, 12 Jul 2019 10:05:51 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id c14sm7138153wrr.56.2019.07.12.10.05.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:05:50 -0700 (PDT)
To: Pankaj Gupta <pagupta@redhat.com>, mst@redhat.com
References: <20190712073554.21918-1-pagupta@redhat.com>
 <20190712073554.21918-2-pagupta@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <029c9b91-d93a-8af6-38a7-160c10a53d8f@redhat.com>
Date: Fri, 12 Jul 2019 19:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712073554.21918-2-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/3] virtio pmem: fix wrong mem region
 condition
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 9:35 AM, Pankaj Gupta wrote:
> Coverity reported memory region returns zero
> for non-null value. This is because of wrong
> arguments to '?:' , fixing this.
> 

Please amend:

Fixes: Coverity (CID 1403009)

> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/virtio/virtio-pmem-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> index 8b2d0dbccc..0da6627469 100644
> --- a/hw/virtio/virtio-pmem-pci.c
> +++ b/hw/virtio/virtio-pmem-pci.c
> @@ -57,7 +57,7 @@ static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState *md,
>      MemoryRegion *mr = vpc->get_memory_region(pmem, errp);
>  
>      /* the plugged size corresponds to the region size */
> -    return mr ? 0 : memory_region_size(mr);
> +    return mr ? memory_region_size(mr) : 0;
>  }
>  
>  static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
> 

