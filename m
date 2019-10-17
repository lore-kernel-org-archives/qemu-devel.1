Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E2ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5479721835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5479721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8AI-0006hV-5V
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7HT-0002YY-Eo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7HS-0005TO-67
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7HR-0005So-Tb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:01:34 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6CD42BFDD
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:01:32 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a15so1107725wrr.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xiOnFR8zeJSyvv//++lhxYz9K3RkXaCChwBO1zVkPGg=;
 b=gzW6UlihitBTqDL6waqfvw6NqgrO/oPCQm4CyteGNWkax+FOLyJ0jP5PowVKOIH8MN
 VseRfy6tWrIW+Y5eVxPftS8XpIbIuiEnM0KQUl2NcUBlFpWNgwuNkLSOguhwNzim4CqO
 c9r/a/hIbIY7f8IozUfDQaoERwXhCanhFiMUkiWoZvgxnFyhEMSxWbvaqPObzkmZelg5
 hMnKFDXoIZgzMROLELSDHMLeb329fcB2Pq/GqV+KSsQvqrS4h4jtsXA2zPSgTaDmmr2h
 YvR1ABTlePK5qi7N8IKPi+PdE9j3XfzeVizh3zG2Z7pSqTjtdcgRfCtp44B1XsFm7PLM
 TQQA==
X-Gm-Message-State: APjAAAXfdquoCDw294vg0dAEIDEj2xFLvoqc1Ybstx237KfrQx7MTUVC
 Doc+gXTolejv+T+9aZBvkN15u92qxAD6I52hZcHE3iN/sT4/ipGBxN/Zg6tR0/DEs6PX8zpP/DZ
 TMJYCZDpYt203gPg=
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr2405937wrr.41.1571324491305;
 Thu, 17 Oct 2019 08:01:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxA6d2Hy6pdi7bRZ5QA97IcbCVTsGGAEZIPU66MiL6mlVfpOXVUxeXl8KiZ3J1x7rvUraCTTA==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr2405905wrr.41.1571324491113;
 Thu, 17 Oct 2019 08:01:31 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id 3sm2325311wmo.22.2019.10.17.08.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:01:30 -0700 (PDT)
Subject: Re: [PATCH 3/3] hw/dma/xilinx_axidma.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9e7dd55-01e5-d852-bbab-84f5209abb6f@redhat.com>
Date: Thu, 17 Oct 2019 17:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132122.4402-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/17/19 3:21 PM, Peter Maydell wrote:
> Switch the xilinx_axidma code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/xilinx_axidma.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index e035d1f7504..fb3a978e282 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -31,7 +31,6 @@
>   #include "hw/ptimer.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/log.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   
>   #include "hw/stream.h"
> @@ -104,7 +103,6 @@ enum {
>   };
>   
>   struct Stream {
> -    QEMUBH *bh;
>       ptimer_state *ptimer;
>       qemu_irq irq;
>   
> @@ -242,6 +240,7 @@ static void stream_complete(struct Stream *s)
>       unsigned int comp_delay;
>   
>       /* Start the delayed timer.  */
> +    ptimer_transaction_begin(s->ptimer);
>       comp_delay = s->regs[R_DMACR] >> 24;
>       if (comp_delay) {
>           ptimer_stop(s->ptimer);
> @@ -255,6 +254,7 @@ static void stream_complete(struct Stream *s)
>           s->regs[R_DMASR] |= DMASR_IOC_IRQ;
>           stream_reload_complete_cnt(s);
>       }
> +    ptimer_transaction_commit(s->ptimer);

I'd restrict the transaction here within the if() statement:

-- >8 --
@@ -244,9 +244,11 @@ static void stream_complete(struct Stream *s)
      /* Start the delayed timer.  */
      comp_delay = s->regs[R_DMACR] >> 24;
      if (comp_delay) {
+        ptimer_transaction_begin(s->ptimer);
          ptimer_stop(s->ptimer);
          ptimer_set_count(s->ptimer, comp_delay);
          ptimer_run(s->ptimer, 1);
+        ptimer_transaction_commit(s->ptimer);
      }

      s->complete_cnt--;
---

>   }
>   
>   static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
> @@ -551,9 +551,10 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>           struct Stream *st = &s->streams[i];
>   
>           st->nr = i;
> -        st->bh = qemu_bh_new(timer_hit, st);
> -        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
> +        st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
> +        ptimer_transaction_begin(st->ptimer);
>           ptimer_set_freq(st->ptimer, s->freqhz);
> +        ptimer_transaction_commit(st->ptimer);
>       }
>       return;
>   
> 

