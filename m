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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65E5FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAFC21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+CfCwiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAFC21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDz1-0001LP-Jw
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iLDvR-0004cm-1r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iLDvP-0007Kz-Px
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:07:16 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iLDvP-0007Kd-Im; Thu, 17 Oct 2019 18:07:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id m13so4120264ljj.11;
 Thu, 17 Oct 2019 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k820IKiBfm6r9/V0SKFLAZBxCqyAD2yIhi9sHgH2x0M=;
 b=F+CfCwiT7dq3e6XPNsS5FC6OJ8bDgy0ekmTSuhBAt2Sy2wpMqH6lM79A72BHADuWge
 NDNmsa19lCgK3ayyY7vpxO9pBOWA5/SNqASb42efmTTZQSk/BzIOz0oe2a56o0l6nKkp
 quUGbx0aRYIIjYoC9VjpjowPzU4VonIljMCCc/mXw9h6yEIYXyVrCyNSS7kuwJBO6W96
 r+gLPy39YHIcdx4fhewCuIeCHOuI7r5Yibu0nJcKTATJ5TZ4mKH152t6SL9a6D6DcU70
 K9VEVNOi4aiS+DRTGnBOanMtNcWGILtpPH3FylQGbMX/lConl0VtcidBVN76FaRQ4k1j
 /zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k820IKiBfm6r9/V0SKFLAZBxCqyAD2yIhi9sHgH2x0M=;
 b=Yha7CjVL/RRJVjvf/v8fGB3tWix07oF2ezoYnHkurNReMOXYkQfPVGBavXVTT/tozC
 uj7OtFSQQBZKwhMisCgVCgl+zvBRIMvA833nhWIUfvvLbUJaHHilUqrYQVJ18RmJG2Kw
 vm4tH48j9JYfwzHac622Rt7QsswiNNP8+vEuXXECTVD0rMDEux4Sj6l53L5G3gagEeyS
 dNV3dhoRtXyZBpM6qV3qu1sqsUDZQQuZwU4fj+g1+wPuISUebJiy6B52jzvleuCDCANZ
 9NvI+3c7r8upiY1tTEubUKPJ6U047kYZPtKVYlu9jWDFsbmJioa01lRzjvJVPmtPVFgU
 OXLA==
X-Gm-Message-State: APjAAAU1fCctmxjck2d4PWpooD48w0NM2jm/HfqmCmcPiDuXbLxbwBDw
 1CU+YI9HDV7NVEGhalFfmXIU2sjDd3jzsXhz7Z8=
X-Google-Smtp-Source: APXvYqzWyoyPjuhXWxpNxM6vYAFBbb+VIPfO/NgWRqC/enPlGRSqpmXgN/tAt3Edd1+LVzBC6u0EUOzDtQB2OPDYucE=
X-Received: by 2002:a2e:9604:: with SMTP id v4mr4026121ljh.101.1571350034436; 
 Thu, 17 Oct 2019 15:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-4-peter.maydell@linaro.org>
In-Reply-To: <20191017132122.4402-4-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 17 Oct 2019 15:02:05 -0700
Message-ID: <CAKmqyKNhsF4-W2WuN-KJU+ZVWCKKjaadOLaKwZhqKWs2tQxFXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/dma/xilinx_axidma.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

On Thu, Oct 17, 2019 at 6:53 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Switch the xilinx_axidma code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xilinx_axidma.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index e035d1f7504..fb3a978e282 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -31,7 +31,6 @@
>  #include "hw/ptimer.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/log.h"
> -#include "qemu/main-loop.h"
>  #include "qemu/module.h"
>
>  #include "hw/stream.h"
> @@ -104,7 +103,6 @@ enum {
>  };
>
>  struct Stream {
> -    QEMUBH *bh;
>      ptimer_state *ptimer;
>      qemu_irq irq;
>
> @@ -242,6 +240,7 @@ static void stream_complete(struct Stream *s)
>      unsigned int comp_delay;
>
>      /* Start the delayed timer.  */
> +    ptimer_transaction_begin(s->ptimer);
>      comp_delay = s->regs[R_DMACR] >> 24;
>      if (comp_delay) {
>          ptimer_stop(s->ptimer);
> @@ -255,6 +254,7 @@ static void stream_complete(struct Stream *s)
>          s->regs[R_DMASR] |= DMASR_IOC_IRQ;
>          stream_reload_complete_cnt(s);
>      }
> +    ptimer_transaction_commit(s->ptimer);
>  }
>
>  static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
> @@ -551,9 +551,10 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>          struct Stream *st = &s->streams[i];
>
>          st->nr = i;
> -        st->bh = qemu_bh_new(timer_hit, st);
> -        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
> +        st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
> +        ptimer_transaction_begin(st->ptimer);
>          ptimer_set_freq(st->ptimer, s->freqhz);
> +        ptimer_transaction_commit(st->ptimer);
>      }
>      return;
>
> --
> 2.20.1
>
>

