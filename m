Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62473C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3884B21479
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3884B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTP1g-0000Pw-I7
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:03:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTP0I-0008EO-AC
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTP0H-0003Vs-5P
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:01:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTP0G-0003VY-Vf
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:01:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so1721736wmk.4
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 04:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=95aKWmcaG88P/RKMc+B5U3v3A1jP1zv6XIktOSU/tpA=;
	b=conY8tYLW6ojYFCy56Fn9i1PPAqyI2hRao2s4VydcBr9LmSlprSdGIfhxGDuSyQEA1
	rHDZuCyYbfoQgXJSGPS/GajsNcQqI0lAt7D4ny0mbM3qXgHsbDnl4on3emaMeum5iPMQ
	eNosutARdbZGpTZwMisp/+/nzS2aZ2mjaVhR9ojAjposoPWSn594vjLgvUlWxjPBqNE+
	2k81DHlzyZQFy+cA3RSkLF/qGaUwfa+eaTdEoeWlgoidCgZBGLS+8DruarQeTJ5EQlBs
	i/jPfv6EYkoQt0nwkZY8RJtTvv1ihxlSuIHY73a4uKAFzBXKJy0umkQAowjbkI9ny/Lh
	f1VQ==
X-Gm-Message-State: APjAAAX61F1ps0uuw5djyG2Dw9yHystCN6BWmGsCitV3nNdbWEbTIYDU
	6oWNsLBEpgdzZkAaa0jJ1C+MsA==
X-Google-Smtp-Source: APXvYqylaqUJVz4HLuNP6hxNgzyAtBmEqSTHye+jytHCmJi+udT4BFGrnaR47llsdKtktdxS60a8FA==
X-Received: by 2002:a1c:2245:: with SMTP id i66mr6913211wmi.19.1558522907944; 
	Wed, 22 May 2019 04:01:47 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	t6sm11519446wmt.34.2019.05.22.04.01.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 04:01:47 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, jslaby@suse.cz
References: <20190510164349.81507-1-liq3ea@163.com>
	<20190510164349.81507-4-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6721f9ce-3150-d491-106c-fb2dfb3b7327@redhat.com>
Date: Wed, 22 May 2019 13:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510164349.81507-4-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v4 3/3] edu: uses uint64_t in dma operation
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/19 6:43 PM, Li Qiang wrote:
> The dma related variable dma.dst/src/cnt is dma_addr_t, it is
> uint64_t in x64 platform. Change these usage from uint32_to
> uint64_t to avoid trancation in edu_dma_timer.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Change since v3:
> Change 'size2' para of 'edu_check_range' to 64-bits.
> 
>  hw/misc/edu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 33de05141f..19e5545e2c 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
>      }
>  }
>  
> -static bool within(uint32_t addr, uint32_t start, uint32_t end)
> +static bool within(uint64_t addr, uint64_t start, uint64_t end)
>  {
>      return start <= addr && addr < end;
>  }
>  
> -static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
> -                uint32_t size2)
> +static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
> +                uint64_t size2)
>  {
> -    uint32_t end1 = addr + size1;
> -    uint32_t end2 = start + size2;
> +    uint64_t end1 = addr + size1;
> +    uint64_t end2 = start + size2;
>  
>      if (within(addr, start, end2) &&
>              end1 > addr && within(end1, start, end2)) {
>          return;
>      }
>  
> -    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
> +    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
> +             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
>              addr, end1 - 1, start, end2 - 1);
>  }
>  
> @@ -139,13 +140,13 @@ static void edu_dma_timer(void *opaque)
>      }
>  
>      if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
> -        uint32_t dst = edu->dma.dst;
> +        uint64_t dst = edu->dma.dst;
>          edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
>          dst -= DMA_START;
>          pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
>                  edu->dma_buf + dst, edu->dma.cnt);
>      } else {
> -        uint32_t src = edu->dma.src;
> +        uint64_t src = edu->dma.src;
>          edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
>          src -= DMA_START;
>          pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> 

