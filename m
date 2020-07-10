Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CF82078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSyQ+h8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CF82078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrIg-0006mL-2S
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrHp-0006Dn-G3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:33:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrHm-0003xN-NX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:33:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so3973831otc.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TQieVr+5/KL3MUIAhN3d/yT7oqDU6w64xTDiaUm5f4s=;
 b=gSyQ+h8xHV0UwEdfe6gnsyNfMdQAib548m+mTaU//q+50nLICt04u6aF+JIk27aKMt
 MawRCQ0zz3Lgaxll2OhErppCJapFu2JBLEkHz2nOX2KU0WzPk5uFYMJYCwbvUSR0WI3N
 AoiJ0nGTUjb57y9wda5cQF3AUqh1EnDOs/vufoPFZ/tIXrFHbOMNWT4NfqAwcp6U5Ckx
 dBoFv9QCF252VkJNnZvyfGicJxQcx8lX4OezkiKDPAB0qngU11VHMD5SNvhFb8LwLgsP
 k8wa0S714ivLHdryXxV/a5FDb7mbA2GqGF8TuDsdA6RqxduEQrK673cn6MlKLkwtmAjW
 Xn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TQieVr+5/KL3MUIAhN3d/yT7oqDU6w64xTDiaUm5f4s=;
 b=Qks3HAfkjTtABNAB+uYm2xrC4/tAJneIgwb4bAbEZxOIyXpoT1I18Im+3ASIAOoA42
 BcnWAc2QNHQbADkLsOmDh6VM1b7sxkoaQCUGfwnMTKfeTdZVjBdfTkWoCf/j1yHi+CgG
 O46PKd4ydiQH5dMDp1R5SDb+eEBDWIGabZ8TMedxEKa2POZb8y2m+G5Z+mulYGiKsxZx
 8oguRgsTisIyjG6SwfMjuKtGiqh7ETwFr07aXuGyKA0vz60GVoI/CBad0YH3cRgh4Xxh
 IKAvClZdK1CkVnJ5X/OrALEIlSYs6dp/N9Z560nT4y8Z+UzRAymk2a4OEUhJZM963Oet
 9Rmg==
X-Gm-Message-State: AOAM532q275WVR4NhCz0b6dTI83cpmrI2KhQCcZukLk5UU02I7jFej68
 800xOXwi8kAU7VhPj3IKhaQjDnL9gqCdSrXPddgNNg==
X-Google-Smtp-Source: ABdhPJyWfVFY1ykTuyxF3rmEdnWtYGFmCq1UUoH3YvqbBtQ7SEcyDIM5m7+V42itaa2JI64Yy6iI5BqgeDjLrMfWTuY=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr55313034ota.91.1594380825254; 
 Fri, 10 Jul 2020 04:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200710085417.638904-1-mcascell@redhat.com>
In-Reply-To: <20200710085417.638904-1-mcascell@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 12:33:34 +0100
Message-ID: <CAFEAcA-pRXOz5JVcwHa8=oaeogwaOK0YVXYQiJUpdM_rFZ+QTA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 09:56, Mauro Matteo Cascella <mcascell@redhat.com> wrote:
>
> An integer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
> occurs while inserting the VLAN tag in packets whose length is less than
> 12 bytes, as (len-12) is passed to memmove() without proper checking.
> This patch is intended to fix this issue by checking the minimum
> Ethernet frame size during packet transmission.
>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> ---
>  hw/net/ftgmac100.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 043ba61b86..bcf4d84aea 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -238,6 +238,11 @@ typedef struct {
>   */
>  #define FTGMAC100_MAX_FRAME_SIZE    9220
>
> +/*
> + * Min frame size
> + */
> +#define FTGMAC100_MIN_FRAME_SIZE    64
> +
>  /* Limits depending on the type of the frame
>   *
>   *   9216 for Jumbo frames (+ 4 for VLAN)
> @@ -507,6 +512,15 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>          }
>
>          len = FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
> +
> +        /* drop small packets */
> +        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
> +            len < FTGMAC100_MIN_FRAME_SIZE) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too small: %d bytes\n",
> +                          __func__, len);
> +            break;
> +        }
> +

Andrew, Cedric: do you have the datasheet for this devic? Do you
know if we should also be flagging the error back to the
guest somehow?

I think a 'break' here means we'll never update the
descriptor flags to hand it back to the guest, which
is probably not what the hardware does.

thanks
-- PMM

