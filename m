Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC84ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EAC21D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teLzqaBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EAC21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDwK-0005PN-P9
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iLDuN-0003Oa-V4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iLDuM-00070m-L8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:06:11 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iLDuM-00070W-Dz; Thu, 17 Oct 2019 18:06:10 -0400
Received: by mail-lj1-x241.google.com with SMTP id m13so4117915ljj.11;
 Thu, 17 Oct 2019 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wW1gsJAKAqrWA84LZQqMug49UEkbIIAcdKY/aWru668=;
 b=teLzqaBtxGX7fqTGy4CvuUbrwOrorhAnmYH54uJgfUqjQCi7sMwkmwrevuKs/IV50C
 qOLkE8L1p0dFSO9yhMLWyTWn9WEh73L2zmaKiI9spy8QLi51sRVcp3E1pXf7WSpHXv8m
 2yPeXU9mIavJJKe+XZB0k41vWyHzNP7WAVIpOirwpBgLsafFEudDVGAgpQsMLL9M2FNf
 PViM/yzJe7Rq0wC0wBVAR5IffDcAMSBAy1HRcyR2DinW30V/AjxxtZ36AlhB/ipbiaW6
 pX5+dy+mMHIbygx/hYgzA/UwW2kZPoe62jGrjVfTXR3cH0z6M+IvJfdTIrwKPCdkB1aB
 jT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wW1gsJAKAqrWA84LZQqMug49UEkbIIAcdKY/aWru668=;
 b=Fd2EOKqWxO6EGAxXlvQ7a4YlO1nj9zrFU9NVaOSeJPKcTslA2W5YuLHSAYrD3w4e4n
 0d0tb1R6KUAnljmCKLxV4iI33a7RSBpit/PaXVX60MK8ON9fx3IrRUW86PgIg/NqruP+
 HzMqRSXZZAibcbpjcF8vLN3Da5Lo9HnaXIENfDTpzpJvRceZrDeKOrG0bH01XZBONIdJ
 IDCgSWM3FiINxZIZNJWN1sFkvOuZnim4lWiGFHkhEQ7exmFVUMAb5kBpxK0sNFecf7tb
 1TSrsjcijffuSR+ra/9ZSVbo57wmjTt9V4Lo3MtbUlBy3W2AhATsoeBFt9lTpjHAZ5eD
 76WQ==
X-Gm-Message-State: APjAAAWVfZfI5HaNpiLKWA8OY7xuNl3+yjtwEy9sXsEMb6P3u3Z79Oew
 GrsBjuWPS0WZfUgcpzwniRY7GfjL55SOgdJSMG7BAkwL
X-Google-Smtp-Source: APXvYqzcuCktKftWptYotu4hrEZ1t1F/eNLwL5TVuy+hqmDiHHTX4o5MAXRl9NWbHADsn47UICaMatfo0c6n3HAjYw8=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr4050577ljj.4.1571349969098;
 Thu, 17 Oct 2019 15:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-3-peter.maydell@linaro.org>
In-Reply-To: <20191017132122.4402-3-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 17 Oct 2019 15:00:59 -0700
Message-ID: <CAKmqyKMVf_htgF5MpKVV5gsD0iKasaPdKOQmgWTRL9i4JsYDfg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/timer/xilinx_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 6:50 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Switch the xilinx_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/xilinx_timer.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 92dbff304d9..7191ea54f58 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -28,7 +28,6 @@
>  #include "hw/ptimer.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/log.h"
> -#include "qemu/main-loop.h"
>  #include "qemu/module.h"
>
>  #define D(x)
> @@ -52,7 +51,6 @@
>
>  struct xlx_timer
>  {
> -    QEMUBH *bh;
>      ptimer_state *ptimer;
>      void *parent;
>      int nr; /* for debug.  */
> @@ -134,6 +132,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
>      return r;
>  }
>
> +/* Must be called inside ptimer transaction block */
>  static void timer_enable(struct xlx_timer *xt)
>  {
>      uint64_t count;
> @@ -174,8 +173,11 @@ timer_write(void *opaque, hwaddr addr,
>                  value &= ~TCSR_TINT;
>
>              xt->regs[addr] = value & 0x7ff;
> -            if (value & TCSR_ENT)
> +            if (value & TCSR_ENT) {
> +                ptimer_transaction_begin(xt->ptimer);
>                  timer_enable(xt);
> +                ptimer_transaction_commit(xt->ptimer);
> +            }
>              break;
>
>          default:
> @@ -220,9 +222,10 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
>
>          xt->parent = t;
>          xt->nr = i;
> -        xt->bh = qemu_bh_new(timer_hit, xt);
> -        xt->ptimer = ptimer_init_with_bh(xt->bh, PTIMER_POLICY_DEFAULT);
> +        xt->ptimer = ptimer_init(timer_hit, xt, PTIMER_POLICY_DEFAULT);
> +        ptimer_transaction_begin(xt->ptimer);
>          ptimer_set_freq(xt->ptimer, t->freq_hz);
> +        ptimer_transaction_commit(xt->ptimer);
>      }
>
>      memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "xlnx.xps-timer",
> --
> 2.20.1
>
>

