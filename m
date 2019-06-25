Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08EC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308C72080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308C72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmmN-0006Si-AT
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfmd9-0001aC-AP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfmd7-0001wk-W1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:41:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfmcv-0001kh-OW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:40:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id f15so8306974wrp.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 07:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=13VpiflEJtk8dW1iYJ/QRvjZYnsUF8wVSoCEqfo4YiA=;
 b=YNAzKX7bJ4cQb4xEQ4m5vtzGrnvRrn4evykgIrPGcJh7qdf3MPON1vDgTBgikcaVL1
 QOUztX6U1j0K5K3g6gLc/vUZ1Xf33opzDSdgNFwqgaOPqcAC/UI2n4NcQ6pTNh2G3T1G
 kuTU6kaaJJRZFHTyxQPNodMQqohZ7S6ni5GlUhE8zwvbI4Wdm1aWTWKVKfo5oC5aUoWC
 7U5MSuzsGAtsN+3gPozwsf7kTAK0lrY26Y1B/dC/t/7SYv5iZ51WI5+EikuWToFQbk0L
 Ykk3JU2VQ0jf1kz9k68kEV8TVllOimG1peIr28HfB626X9a6fNQ5MMlyBATIFyxhrqcs
 /5kQ==
X-Gm-Message-State: APjAAAW5MEI4Ss2AldA/UHS6TRLHvsQLQlxkxuw7VzlV9grEjr/DRS1C
 n8uQ15Ww8Y3SPRviBA8XcNcDkw==
X-Google-Smtp-Source: APXvYqyV2aZA6yvNKAsxKGDHAidvPt/YHlkTfxccgeGBdKpBZBBQF4JFBNzG8WVDg/+AtB+nZR1Frg==
X-Received: by 2002:adf:f186:: with SMTP id h6mr24432692wro.274.1561473649234; 
 Tue, 25 Jun 2019 07:40:49 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h1sm13740850wrt.20.2019.06.25.07.40.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 07:40:48 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <acd885a3-b5b8-dba9-8f30-c1a7b5c2a2e3@redhat.com>
Date: Tue, 25 Jun 2019 16:40:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 2/2] dma/rc4030: Minor code style cleanup
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
Cc: arikalo@wavecomp.com, hpoussin@reactos.org, f4bug@amsat.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 4:27 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fix some simple checkpatch.pl warnings in rc4030.c.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/dma/rc4030.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 88ff271..155af9b 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -58,8 +58,8 @@ typedef struct dma_pagetable_entry {
>  
>  #define TYPE_RC4030_IOMMU_MEMORY_REGION "rc4030-iommu-memory-region"
>  
> -typedef struct rc4030State
> -{
> +typedef struct rc4030State {
> +
>      SysBusDevice parent;
>  
>      uint32_t config; /* 0x0000: RC4030 config register */
> @@ -152,8 +152,9 @@ static uint64_t rc4030_read(void *opaque, hwaddr addr, unsigned int size)
>      case 0x0058:
>          val = s->cache_bmask;
>          /* HACK */
> -        if (s->cache_bmask == (uint32_t)-1)
> +        if (s->cache_bmask == (uint32_t)-1) {
>              s->cache_bmask = 0;
> +        }
>          break;
>      /* Remote Speed Registers */
>      case 0x0070:
> @@ -538,8 +539,9 @@ static void rc4030_reset(DeviceState *dev)
>  
>      s->memory_refresh_rate = 0x18186;
>      s->nvram_protect = 7;
> -    for (i = 0; i < 15; i++)
> +    for (i = 0; i < 15; i++) {
>          s->rem_speed[i] = 7;
> +    }
>      s->imr_jazz = 0x10; /* XXX: required by firmware, but why? */
>      s->isr_jazz = 0;
>  
> @@ -551,7 +553,7 @@ static void rc4030_reset(DeviceState *dev)
>  
>  static int rc4030_post_load(void *opaque, int version_id)
>  {
> -    rc4030State* s = opaque;
> +    rc4030State *s = opaque;
>  
>      set_next_tick(s);
>      update_jazz_irq(s);
> @@ -591,7 +593,8 @@ static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int is_wri
>      hwaddr dma_addr;
>      int dev_to_mem;
>  
> -    s->dma_regs[n][DMA_REG_ENABLE] &= ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
> +    s->dma_regs[n][DMA_REG_ENABLE] &=
> +           ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
>  
>      /* Check DMA channel consistency */
>      dev_to_mem = (s->dma_regs[n][DMA_REG_ENABLE] & DMA_FLAG_MEM_TO_DEV) ? 0 : 1;
> @@ -603,8 +606,9 @@ static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int is_wri
>      }
>  
>      /* Get start address and len */
> -    if (len > s->dma_regs[n][DMA_REG_COUNT])
> +    if (len > s->dma_regs[n][DMA_REG_COUNT]) {
>          len = s->dma_regs[n][DMA_REG_COUNT];
> +    }
>      dma_addr = s->dma_regs[n][DMA_REG_ADDRESS];
>  
>      /* Read/write data at right place */
> 

