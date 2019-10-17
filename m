Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274EFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D8D20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D8D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL81O-0001u2-4u
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7D8-0005CS-9A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7D6-0003AS-Uz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7D6-00039b-LN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:04 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A4558553F
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 14:57:03 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id s9so1073867wrw.23
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uMdAiWip7KyhYWmFEHqoUDP8uaHMYKFRgJSe/YWHELs=;
 b=ohXnAXuRJeFx5Sm8iPysDBb/U9CI54MxEKrjlWPDsMLLBHYgH7wSWdU6oLL1KR6JSX
 oJAYfQEm2TBfiljUj1y4QYItqpnB0AlzwjRk06Shyic2GpuYDu3PN+Vm2UnDK9hWeDj1
 nCrW7gFkPZr4dPaUWXU8scfF8AOVRpRcISYvEpx73paP5OutVGNwlIq5Hz9JYpsZ5NNr
 jUk5FZP49k7RiDfaGhlKtV0ZR6VqJWVN+jVrSv9qcMqs2jQXSBzdMPfAAOl1iJAzXraP
 mQ2i1O7dkwtG5ZSYopbUyWzT0ERmVYXjL7L8Y7CreMcWRQPjtZjnpc9ZazbCzWrgg46L
 IN8Q==
X-Gm-Message-State: APjAAAU4H5pZ4H77TqdcfXzVFrILS3wuR+fVZzjuUu3U0av72uyCy1fs
 Gzv40YlaIweQPQNe4IQPYBjZstO4qKMh44LbbLsKOsgvjCws6HMrTLFg1fsRHJtJoYwRyltjdIT
 38JyUispyGVeT3ew=
X-Received: by 2002:adf:f342:: with SMTP id e2mr3636568wrp.61.1571324222163;
 Thu, 17 Oct 2019 07:57:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdbddbpq5p3MMwIDBuNECUZ2nk3dSFYgBmPE7rpt6vW2kU5xcBEioJKKoy8TZFOKb2KQrnIg==
X-Received: by 2002:adf:f342:: with SMTP id e2mr3636535wrp.61.1571324221921;
 Thu, 17 Oct 2019 07:57:01 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id h63sm3543106wmf.15.2019.10.17.07.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:57:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] hw/timer/xilinx_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cabcec27-c6a7-6ea7-e933-589f2385c137@redhat.com>
Date: Thu, 17 Oct 2019 16:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132122.4402-3-peter.maydell@linaro.org>
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
> Switch the xilinx_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/xilinx_timer.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 92dbff304d9..7191ea54f58 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -28,7 +28,6 @@
>   #include "hw/ptimer.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/log.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   
>   #define D(x)
> @@ -52,7 +51,6 @@
>   
>   struct xlx_timer
>   {
> -    QEMUBH *bh;
>       ptimer_state *ptimer;
>       void *parent;
>       int nr; /* for debug.  */
> @@ -134,6 +132,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
>       return r;
>   }
>   
> +/* Must be called inside ptimer transaction block */
>   static void timer_enable(struct xlx_timer *xt)
>   {
>       uint64_t count;
> @@ -174,8 +173,11 @@ timer_write(void *opaque, hwaddr addr,
>                   value &= ~TCSR_TINT;
>   
>               xt->regs[addr] = value & 0x7ff;
> -            if (value & TCSR_ENT)
> +            if (value & TCSR_ENT) {
> +                ptimer_transaction_begin(xt->ptimer);
>                   timer_enable(xt);
> +                ptimer_transaction_commit(xt->ptimer);

Why not move these inside timer_enable()?

> +            }
>               break;
>    
>           default:
> @@ -220,9 +222,10 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
>   
>           xt->parent = t;
>           xt->nr = i;
> -        xt->bh = qemu_bh_new(timer_hit, xt);
> -        xt->ptimer = ptimer_init_with_bh(xt->bh, PTIMER_POLICY_DEFAULT);
> +        xt->ptimer = ptimer_init(timer_hit, xt, PTIMER_POLICY_DEFAULT);
> +        ptimer_transaction_begin(xt->ptimer);
>           ptimer_set_freq(xt->ptimer, t->freq_hz);
> +        ptimer_transaction_commit(xt->ptimer);
>       }
>   
>       memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "xlnx.xps-timer",
> 

