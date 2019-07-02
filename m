Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCCFC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCAF208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="l2MZapgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCAF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAfq-0005TP-EB
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46827)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hpoussin@reactos.org>) id 1hiAdu-0004Ub-Fg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1hiAdt-00045k-Cb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:43:46 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:49974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1hiAdt-00044w-5H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=glDre4EHAZCIIcadpOSt8im8LpeGfVpnJYH2eUUE47k=; b=l2MZapgitfW2HzedZU8Fi7uVBR
 d1QhJ4vwRMUsWT/F53Wgijqp40TJ39iuOF9HaMoIzIJIFwGrnqCOhoNTlprCtlcsvYf3xvmU1uklo
 2dh6+RDuvJh0lKuOTuZrT+9QSCO8e9/KVI5idMRrYXzKAOOZnB9PpIghcD6Gb9NwbLp0=;
Received: from [2a01:e35:2e3e:3c40:3d64:a34f:19ef:bcc5]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1hiAdp-00025Y-5d; Tue, 02 Jul 2019 04:43:41 +0000
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561472838-32272-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <59d268c3-f532-c5be-334f-04befc7fc084@reactos.org>
Date: Tue, 2 Jul 2019 06:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561472838-32272-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] [PATCH 1/2] dma/rc4030: Fix off-by-one error in
 specified memory region size
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
> The size is one byte less than it should be:
> 
> address-space: rc4030-dma
>    0000000000000000-00000000fffffffe (prio 0, i/o): rc4030.dma
> 
> rc4030 is used in MIPS Jazz board context.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> ---
>   hw/dma/rc4030.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 6ccafec..88ff271 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "hw/hw.h"
>   #include "hw/mips/mips.h"
>   #include "hw/sysbus.h"
> @@ -678,7 +679,7 @@ static void rc4030_realize(DeviceState *dev, Error **errp)
>   
>       memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
>                                TYPE_RC4030_IOMMU_MEMORY_REGION,
> -                             o, "rc4030.dma", UINT32_MAX);
> +                             o, "rc4030.dma", 4 * GiB);
>       address_space_init(&s->dma_as, MEMORY_REGION(&s->dma_mr), "rc4030-dma");
>   }
>   
> 


