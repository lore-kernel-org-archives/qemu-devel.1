Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B557C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F9C20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpmz6zaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F9C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj7D-00060R-Vb
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaj6F-0004iU-8D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:58:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaj6E-0002PW-Cr
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:58:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id l17so12736074wrr.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ikwELEoSWJp/aWCMXVUREuJ623/MKUr+OjCV/7IqSl0=;
 b=Bpmz6zaTShovRqw1KYqMpIRNQlWvnU94TO+Y+m9JPzJMFNV8EhV2BKqeljVFm00dGE
 ohtiGV99TMkNjNd/V3DArjJL7qwTm3g6SnD767JyZ4vzVJGvgN731WVHZMoY8hQ/s+dl
 ByR3qsZGA6hpjaa97ScrrZt74xv+8Etpkviw6nHECpnWjJlSf+MHNR+b9sLFML1Kz37M
 kQzh49GawbZ7vYLes6yY9+fkfddM3ZGGN7d1+I/9slGi0m0sGPMcNK04qP5NxMDQuih7
 u6Q/ZHuHeTxPmyYQrHPjXbDJ+ikpeXFqs8BrsMaDUeuMMJSeO3vIHNHGF0ZF0ACEfApv
 l1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ikwELEoSWJp/aWCMXVUREuJ623/MKUr+OjCV/7IqSl0=;
 b=X6FouZapmufpW844bbPQUzoPBvxLETf4WclPf5axO291EzdXnP9vGUB+E1wDoJRTF5
 2wbBEAApoQXZKg5/GwxR7okERXsGqWFYDwzHKUzIoSrjURf3R2ULtXazVZaHJmeSAsqH
 q4Xc0aa/2p8MPRuGnlPULhFX6D0J7+fKt//Ru9EKdrWZuX1+Q/sORT7jubzpAn0d0UlI
 iMO3BJX+gQOh+PRwMkASv4JdgqlCKXMMqWA0ZEpDlCAmzlJJjUyaY8WM6spVAxvvE20l
 l3dzr1sLGnR8mLrKK+IV+HN4pz/2iay67HkuDnq+PK2TOymW9OREJ5ujZT6wHLAV99kT
 K93w==
X-Gm-Message-State: AOAM531vH/z47bgc2ztU3MKzBE6udJF7JRAWOaCuaVTFtHbOvXGHV6HQ
 ML4d2pFSii7XUtQnDq+OXL8DzRsZGmc=
X-Google-Smtp-Source: ABdhPJzgqtwjeSdYYv3RyNk61nKd+lRaf8EbZWxVXXhgKulE9gVZCFNN96wD3xJDJoPw/alWpNCP9g==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr20067388wrj.45.1589821124925; 
 Mon, 18 May 2020 09:58:44 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q4sm216098wma.9.2020.05.18.09.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:58:44 -0700 (PDT)
Subject: Re: [PATCH] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200518094904.24226-1-f4bug@amsat.org>
 <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c879f8bc-9c48-20ef-7717-c63a65a146a1@amsat.org>
Date: Mon, 18 May 2020 18:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:32 PM, Thomas Huth wrote:
> On 18/05/2020 11.49, Philippe Mathieu-Daudé wrote:
>> hw_error() calls exit(). This a bit overkill when we can log
>> the accesses as unimplemented or guest error.
> 
> Good idea. hw_error() is also mainly for CPU errors, it really should
> not be used for non-CPU devices.
> 
>> When fuzzing the devices, we don't want the whole process to
>> exit. Replace some hw_error() calls by qemu_log_mask().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/m68k/mcf5206.c  |  7 +++++--
>>   hw/m68k/mcf5208.c  | 14 +++++++++-----
>>   hw/m68k/mcf_intc.c |  4 +++-
>>   hw/net/mcf_fec.c   |  8 +++++---
>>   4 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
>> index b155dd8170..34a863a588 100644
>> --- a/hw/m68k/mcf5206.c
>> +++ b/hw/m68k/mcf5206.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/log.h"
>>   #include "cpu.h"
>>   #include "hw/hw.h"
>>   #include "hw/irq.h"
>> @@ -306,7 +307,8 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
>>       case 0x170: return s->uivr[0];
>>       case 0x1b0: return s->uivr[1];
>>       }
>> -    hw_error("Bad MBAR read offset 0x%x", (int)offset);
>> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%" HWADDR_PRIX "\n",
> 
> offset seems to be uint64_t in this function, so I think this should
> rather use PRIx64 instead of HWADDR_PRIX ? Or maybe check whether we can
> change the offset to uint32_t ?

Too many copy/pasting, sorry.

> 
>> +                  __func__, offset);
>>       return 0;
>>   }
>>   
>> @@ -360,7 +362,8 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
>>           s->uivr[1] = value;
>>           break;
>>       default:
>> -        hw_error("Bad MBAR write offset 0x%x", (int)offset);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%x\n",
>> +                      __func__, offset);
> 
> Here offset seems to be uint32_t ... so I guess it should be fine for
> the _read function, too.
> 
>>           break;
>>       }
>>   }
>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>> index b84c152ce3..cd8a32e0c6 100644
>> --- a/hw/m68k/mcf5208.c
>> +++ b/hw/m68k/mcf5208.c
>> @@ -9,10 +9,10 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/units.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/log.h"
>>   #include "qapi/error.h"
>>   #include "qemu-common.h"
>>   #include "cpu.h"
>> -#include "hw/hw.h"
>>   #include "hw/irq.h"
>>   #include "hw/m68k/mcf.h"
>>   #include "hw/m68k/mcf_fec.h"
>> @@ -111,7 +111,8 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
>>       case 4:
>>           break;
>>       default:
>> -        hw_error("m5208_timer_write: Bad offset 0x%x\n", (int)offset);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
>> +                      __func__, offset);
>>           break;
> 
> Should the "break" be replaced by a "return" now?

I was not sure, OK.

> 
>>       }
>>       m5208_timer_update(s);
>> @@ -136,7 +137,8 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
>>       case 4:
>>           return ptimer_get_count(s->timer);
>>       default:
>> -        hw_error("m5208_timer_read: Bad offset 0x%x\n", (int)addr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
>> +                      __func__, addr);
>>           return 0;
>>       }
>>   }
>> @@ -164,7 +166,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>>           return 0;
>>   
>>       default:
>> -        hw_error("m5208_sys_read: Bad offset 0x%x\n", (int)addr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
>> +                      __func__, addr);
>>           return 0;
>>       }
>>   }
>> @@ -172,7 +175,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>>   static void m5208_sys_write(void *opaque, hwaddr addr,
>>                               uint64_t value, unsigned size)
>>   {
>> -    hw_error("m5208_sys_write: Bad offset 0x%x\n", (int)addr);
>> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
>> +                  __func__, addr);
>>   }
>>   
>>   static const MemoryRegionOps m5208_sys_ops = {
>> diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
>> index d9e03a06ab..7dddf17d33 100644
>> --- a/hw/m68k/mcf_intc.c
>> +++ b/hw/m68k/mcf_intc.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/module.h"
>> +#include "qemu/log.h"
>>   #include "cpu.h"
>>   #include "hw/hw.h"
>>   #include "hw/irq.h"
>> @@ -127,7 +128,8 @@ static void mcf_intc_write(void *opaque, hwaddr addr,
>>           }
>>           break;
>>       default:
>> -        hw_error("mcf_intc_write: Bad write offset %d\n", offset);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n",
>> +                      __func__, offset);
>>           break;
> 
> "return" instead of "break" ?
> 
>>       }
>>       mcf_intc_update(s);
>> diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
>> index 9327ac8a30..b3a92c0114 100644
>> --- a/hw/net/mcf_fec.c
>> +++ b/hw/net/mcf_fec.c
>> @@ -7,7 +7,7 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> -#include "hw/hw.h"
>> +#include "qemu/log.h"
>>   #include "hw/irq.h"
>>   #include "net/net.h"
>>   #include "qemu/module.h"
>> @@ -392,7 +392,8 @@ static uint64_t mcf_fec_read(void *opaque, hwaddr addr,
>>       case 0x188: return s->emrbr;
>>       case 0x200 ... 0x2e0: return s->mib[(addr & 0x1ff) / 4];
>>       default:
>> -        hw_error("mcf_fec_read: Bad address 0x%x\n", (int)addr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
>> +                      __func__, addr);
>>           return 0;
>>       }
>>   }
>> @@ -492,7 +493,8 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
>>           s->mib[(addr & 0x1ff) / 4] = value;
>>           break;
>>       default:
>> -        hw_error("mcf_fec_write Bad address 0x%x\n", (int)addr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
>> +                      __func__, addr);
> 
> return here?
> 
>>       }
>>       mcf_fec_update(s);
>>   }
>>
> 
>   Thomas
> 
> 

