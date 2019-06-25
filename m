Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABBCC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FD6208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FD6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmtQ-00035L-BI
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfmc6-0000o4-3E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfmc4-0000P3-2q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:40:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfmc2-0000GG-0s
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:39:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so18171369wre.7
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 07:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j1ecm2KfToermzYuR3x6+mpOHLA0t947Ln9n8tcC4/s=;
 b=G0WE+gX/Agjftym86EU+vbo87BHwGkqlkE1XXpbv/U4pWAf7V3MfSBXa3HvL1bkIjJ
 vcQD7wp2ZYATFGDCbtkA+VPlA3WtaDUcmnxalkeVopALTiSGJJZ51PyKPaB4DewbDkbV
 h1pHSSHKJDMPAAAdbQTfII+TZK7ZaCTkedaoobOK4osxGIMhfWA9e55Y3xd82T86Tf/Y
 aPJh2P3SJYsGfUCMoumLL+BBv2np7KnWmepEDf1e8GEvMlmeCDXKLt7DPkSMNKViQe7C
 1nvNty+0naRpGg3ZkFVzOnKXA6wbYgl29DaW6r7/HAdnJ754I/sWOzvtsMHsVNEfeybf
 U/GA==
X-Gm-Message-State: APjAAAUw9Cp/uJQI5BRWWsQX01VFIFhpaeSmVb2pwX51cA13SMi31HvH
 LxYgJ2KTrtHfRlGrJ0l5+GI09g==
X-Google-Smtp-Source: APXvYqy9/oH+Km20lhfFz64mYlzmAZYjuffszOFhrhmdGZTm87MmdU1CLaGh0G5s0OcTmm8Ma6TZKQ==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3625654wrp.149.1561473595326; 
 Tue, 25 Jun 2019 07:39:55 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id b2sm19176038wrp.72.2019.06.25.07.39.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 07:39:54 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561472838-32272-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fdd0b7d8-270d-bdc6-ab56-f1925f82e97b@redhat.com>
Date: Tue, 25 Jun 2019 16:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561472838-32272-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: arikalo@wavecomp.com, hpoussin@reactos.org, f4bug@amsat.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 4:27 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> The size is one byte less than it should be:
> 
> address-space: rc4030-dma
>   0000000000000000-00000000fffffffe (prio 0, i/o): rc4030.dma
> 
> rc4030 is used in MIPS Jazz board context.

Ah thanks :) I was planing to send this once at home tonight.

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

  (qemu) info mtree
  ...
  address-space: rc4030-dma
    0000000000000000-00000000ffffffff (prio 0, i/o): rc4030.dma

  address-space: dp8393x
    0000000000000000-00000000ffffffff (prio 0, i/o): rc4030.dma

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/dma/rc4030.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 6ccafec..88ff271 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/mips/mips.h"
>  #include "hw/sysbus.h"
> @@ -678,7 +679,7 @@ static void rc4030_realize(DeviceState *dev, Error **errp)
>  
>      memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
>                               TYPE_RC4030_IOMMU_MEMORY_REGION,
> -                             o, "rc4030.dma", UINT32_MAX);
> +                             o, "rc4030.dma", 4 * GiB);
>      address_space_init(&s->dma_as, MEMORY_REGION(&s->dma_mr), "rc4030-dma");
>  }
>  
> 

