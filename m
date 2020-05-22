Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B110E206F6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOyQwc9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B110E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc9sk-0001wE-TV
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 11:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jc9rO-0000Ej-Sh; Fri, 22 May 2020 11:45:22 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jc9rN-0008GW-DR; Fri, 22 May 2020 11:45:22 -0400
Received: by mail-io1-xd41.google.com with SMTP id j8so11745121iog.13;
 Fri, 22 May 2020 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f800XsxbRoP+8fjozgRCoBbk2ftKwwQk+mzzP/QIsLU=;
 b=BOyQwc9CT7QyQzOXHGSEcXad52XDgRHJudY+D4ELr/CN5ASi6ILEQVvAGr5A6SFT7e
 E7FJKDPYbKEx7x0f5xD3MuT0j1B3CYhGL6ue6IuYkDhVtcMGsehBZg2HUR5+rvAzZeUN
 zSNjlvQWX0LEsUaI92rmMRZSfRNin5o9ppYgR5T+qv1WqRfkw9dUkdy7gfzKQEOxcLpq
 cnHCfr7Q4KII+svyoyY6GsGEXjjaQ4QiYgMZTV74Goe+hxABk7j6is5IOpFzCeXaSNDt
 2iXXOoW9IRybvwcXV+B8Dh08AjJ9riFrsW2Xfmh0vBauYPr2jsoc2ofxTUf9KmLzWMrU
 MDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f800XsxbRoP+8fjozgRCoBbk2ftKwwQk+mzzP/QIsLU=;
 b=Qz1Ej2q8NKHxBrQcVubNKP3N/neiWVLM3QamhJIkCEWpc4siaoFvIN2aAtsZp0B59k
 bWN6MOOstT61j7aaAB+eSlgKqbfD1oiGYskoNhpcPF/UFwTrEoqtSCV4JszfERFv+Yo0
 A0xAwOnl5eLFsyQgR4v+bwHHKIL2NpDeqsLQY/JAa+ji8Vq0oOxKAQaXONgfDqa7OJQp
 mMkBPYie26wFJm34qeRSXn5U/jUDdQW5t3k8dq9nSe+16Gprzjp93e144pL07XiTUgG9
 CN3HmlJFoRQIYV9t//4r/wW0byg2UlHZIULybBbgESEyug/0+e+R2ZRkyWJzt236KBir
 1ejg==
X-Gm-Message-State: AOAM532CiEZ98IJJZ8iIYKXWkDRRn9peyWVcwQK1ZI1gDnQ6QQ+LPkhU
 SyKqvXGVmrDIROz9irDsnjAKTLcKo7QOyy//8Co=
X-Google-Smtp-Source: ABdhPJxn4WQMWQEecsS6DHeRTBfd/c/LqS8oWzzhVDoRHXh5HkZ0sqK7/AB1fKST8wwEomfjnGGUQ0qLl+J6lzSSRcE=
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr3566843iog.175.1590162319379; 
 Fri, 22 May 2020 08:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8FFc_Vf-UQO9f_3qoXiCJf9N1uWh7qB-WXrEWTzKBu8Q@mail.gmail.com>
 <20200522115036.31516-1-e.mikitas@gmail.com>
 <20200522115036.31516-3-e.mikitas@gmail.com>
In-Reply-To: <20200522115036.31516-3-e.mikitas@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 May 2020 08:36:22 -0700
Message-ID: <CAKmqyKMgfochqOK47t8c_HfRbCBbJqSVvcHYV0tU6_f3GHCQBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/ssi/imx_spi: Removed unnecessary cast of rx data
 received from slave
To: Eden Mikitas <e.mikitas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 4:52 AM Eden Mikitas <e.mikitas@gmail.com> wrote:
>
> When inserting the value retrieved (rx) from the spi slave, rx is pushed to
> rx_fifo after being cast to uint8_t. rx_fifo is a fifo32, and the rx
> register the driver uses is also 32 bit. This zeroes the 24 most
> significant bits of rx. This proved problematic with devices that expect to
> use the whole 32 bits of the rx register.
>
> Signed-off-by: Eden Mikitas <e.mikitas@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/imx_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index 6fef5c7958..43b2f14dd2 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -206,7 +206,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
>          if (fifo32_is_full(&s->rx_fifo)) {
>              s->regs[ECSPI_STATREG] |= ECSPI_STATREG_RO;
>          } else {
> -            fifo32_push(&s->rx_fifo, (uint8_t)rx);
> +            fifo32_push(&s->rx_fifo, rx);
>          }
>
>          if (s->burst_length <= 0) {
> --
> 2.17.1
>
>

