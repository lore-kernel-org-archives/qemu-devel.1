Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B6C10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B131C20869
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B131C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hI9mr-0005yc-02
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 06:33:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9lv-0005ev-MZ
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9lu-0001NH-N7
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:32:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9lu-0001LW-HW
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:32:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so12457564wre.7
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=D8qWNqRzMWkuCl3YPX6lOpXjESDHAhh0qdQUJ7ZEgVE=;
	b=ZrY5B74q0nC0zgGKM1AYcRpZyqv+DIAbt9YLyr5vtEVnERuP9T1+xI9xPME3rIDCSg
	ddPefd9NDGeo6OJnC9UitV+KXI85A1I6Q9H5XPwHaFpizM25/fXwZS9zDbEzm6MzHoBw
	DRo7qLJ3zncyQ7952ButtjNE9HElg2Q8TPaaa6tp4y/YpLShtPVBmtbOrhZSGLaXas8v
	injzkzTWnZ4bu1Nd9UhXX4iSkMghSgnWfEdorU8qtr6goOGKOwuvmFqcocPPrxhmNaH3
	opmZugc2XQhIMI2U4XL1xLfbNMMpC15P3OH7zw7+SmRmUCcCAjUT8IRYkG3e7hod3zw0
	H3TA==
X-Gm-Message-State: APjAAAVR9xIrlhxMARbJ3tjryvIfedh7JhK0lKcssGT1IFDVOkozxvoi
	rIKGswTHo+r35Of/9mNCckCz2HLtvnlOZA==
X-Google-Smtp-Source: APXvYqxQzTwbUWGwvVDZeH+6G0z3Ydy6NCg7Ev7qCZEbJjsZ72l+PxIKe7zxC2jX+Y3h7keLN/AqWg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr429105wrv.188.1555842747431; 
	Sun, 21 Apr 2019 03:32:27 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	y133sm10049240wmd.2.2019.04.21.03.32.26
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Apr 2019 03:32:26 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-4-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4eb444fe-7e45-1072-770b-17f0db493b6d@redhat.com>
Date: Sun, 21 Apr 2019 12:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420161446.2274-4-liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 3/3] edu: uses uint64_t in dma operation
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
Message-ID: <20190421103225.HvBnRJKVyJ-TObxXo6uaJnDhcAJEALANkXjDulKmdlY@z>

On 4/20/19 6:14 PM, Li Qiang wrote:
> The dma related variable is dma_addr_t, it is uint64_t in
> x64 platform. Change these usage from uint32_to uint64_t to
> avoid trancation.

"to avoid address truncation"?

> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change since v1:
> Fix format compile error on Windows
> 
>  hw/misc/edu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 4018dddcb8..f4a6d5f1c5 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
>      }
>  }
>  
> -static bool within(uint32_t addr, uint32_t start, uint32_t end)
> +static bool within(uint64_t addr, uint64_t start, uint64_t end)

OK.

>  {
>      return start <= addr && addr < end;
>  }
>  
> -static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
> +static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
>                  uint32_t size2)

OK for addr. MMIO range is 1MiB so you can keep uint32_t for
size1/size2. Up to the maintainer (personally I'd prefer keep u32).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

