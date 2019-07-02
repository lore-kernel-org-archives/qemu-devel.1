Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBBC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5343B208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="XdPgz9K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5343B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAeh-0005BE-I4
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hpoussin@reactos.org>) id 1hiAdk-0004Hw-Sz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1hiAdi-000422-QS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:43:36 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:49964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1hiAdi-000413-1Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xtuo3AdguYdWbzNHOptkhXRqgMT+LyOCoIvA/xadDSo=; b=XdPgz9K3o7Mnj9MouKAME9WkfY
 LtZwkiHeJtQx+GcJVoiR97Cu9BmyftcAwFdz8nR7OvRKm8Yhjo0whz9cyOMTJ0D3WfuSco2r7O4ur
 jE+TMlFUWA1bKkb6mnPHkW9EAch2Ba7xLzU09Kf87v52kDN4kTC4B7BZa5NYlEwXoPdM=;
Received: from [2a01:e35:2e3e:3c40:3d64:a34f:19ef:bcc5]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1hiAde-00025J-Qf; Tue, 02 Jul 2019 04:43:30 +0000
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <3b3a712d-4a96-ce42-4ac5-ae485b77890b@reactos.org>
Date: Tue, 2 Jul 2019 06:43:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
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
Cc: arikalo@wavecomp.com, f4bug@amsat.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/06/2019 à 16:27, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fix some simple checkpatch.pl warnings in rc4030.c.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> ---
>   hw/dma/rc4030.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 88ff271..155af9b 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -58,8 +58,8 @@ typedef struct dma_pagetable_entry {
>   
>   #define TYPE_RC4030_IOMMU_MEMORY_REGION "rc4030-iommu-memory-region"
>   
> -typedef struct rc4030State
> -{
> +typedef struct rc4030State {
> +
>       SysBusDevice parent;
>   
>       uint32_t config; /* 0x0000: RC4030 config register */
> @@ -152,8 +152,9 @@ static uint64_t rc4030_read(void *opaque, hwaddr addr, unsigned int size)
>       case 0x0058:
>           val = s->cache_bmask;
>           /* HACK */
> -        if (s->cache_bmask == (uint32_t)-1)
> +        if (s->cache_bmask == (uint32_t)-1) {
>               s->cache_bmask = 0;
> +        }
>           break;
>       /* Remote Speed Registers */
>       case 0x0070:
> @@ -538,8 +539,9 @@ static void rc4030_reset(DeviceState *dev)
>   
>       s->memory_refresh_rate = 0x18186;
>       s->nvram_protect = 7;
> -    for (i = 0; i < 15; i++)
> +    for (i = 0; i < 15; i++) {
>           s->rem_speed[i] = 7;
> +    }
>       s->imr_jazz = 0x10; /* XXX: required by firmware, but why? */
>       s->isr_jazz = 0;
>   
> @@ -551,7 +553,7 @@ static void rc4030_reset(DeviceState *dev)
>   
>   static int rc4030_post_load(void *opaque, int version_id)
>   {
> -    rc4030State* s = opaque;
> +    rc4030State *s = opaque;
>   
>       set_next_tick(s);
>       update_jazz_irq(s);
> @@ -591,7 +593,8 @@ static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int is_wri
>       hwaddr dma_addr;
>       int dev_to_mem;
>   
> -    s->dma_regs[n][DMA_REG_ENABLE] &= ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
> +    s->dma_regs[n][DMA_REG_ENABLE] &=
> +           ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
>   
>       /* Check DMA channel consistency */
>       dev_to_mem = (s->dma_regs[n][DMA_REG_ENABLE] & DMA_FLAG_MEM_TO_DEV) ? 0 : 1;
> @@ -603,8 +606,9 @@ static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int is_wri
>       }
>   
>       /* Get start address and len */
> -    if (len > s->dma_regs[n][DMA_REG_COUNT])
> +    if (len > s->dma_regs[n][DMA_REG_COUNT]) {
>           len = s->dma_regs[n][DMA_REG_COUNT];
> +    }
>       dma_addr = s->dma_regs[n][DMA_REG_ADDRESS];
>   
>       /* Read/write data at right place */
> 


