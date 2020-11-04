Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1809C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4899A206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB59nJU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4899A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLv9-0004Tl-Aq
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kaLjO-0004X4-L7; Wed, 04 Nov 2020 11:33:54 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kaLjM-0000r2-5c; Wed, 04 Nov 2020 11:33:54 -0500
Received: by mail-il1-x143.google.com with SMTP id p2so5002047ilg.1;
 Wed, 04 Nov 2020 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hqwmb6PrP8ZH8SWTlskXS7GXfl2EXLdVj41LHwfo5jc=;
 b=NB59nJU80o5gEBh61X4PCFfbJzGBGOWlj6TuXeNwWO/NuRBIQ9WMtKvNxGxF3P4bEB
 zkBMHt3+5+Z85LNF9I53glrcdcBWdjIc8q1PZdoV+a03TTR1zZBp1QV5SbWZdF6BlAi5
 vj99CswShiN/rLbN19S4qmewmsncDZhqOPkkFYJKTgIpAH6zAHJB2NCHSPY+YgyPju7y
 TgxNph46mh3K9+ShNizXqBvFIlyrxyCxkoR2LAhiQ97uBqOO2CCppWDdJZ/Stp5xyrKG
 t0BcH61ULFdDcuvaG2TNBuf8/XEAu9Yiniyj5YZO6//XmHPkl2L3tJmoaFBOLRBZgypL
 g7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hqwmb6PrP8ZH8SWTlskXS7GXfl2EXLdVj41LHwfo5jc=;
 b=mNNzYP6DXmQn1r5+TNQ2khlDiJbDxckqiuxsTg9iWjA6F5c5kPTeaq2g7gPW5bsyRg
 IycGuzWCaOGjJaFArqem6m9uVHaRlCjBLPagI9yB0IYOMb/BoRiQra2u2dahwFGTHQzA
 dG0gun3WhDV0LHgKyiNZ2iTHgw+9zGB5q9F/75WyT27U+/nyk+vdEvDO0Je1T2QM0Xo7
 RF/OGzNS11aWcxth5gk1KSbGpAhk77RrD09knY5tL2+ClZV2WDwH46/wGgFWs4kctfzQ
 w/QTr5rUbeMpz+yJOSr17mYM9mnQXNZKAi0GM/KNYcfblpYRmiQJhPgPJSd1Gkwca456
 tIOw==
X-Gm-Message-State: AOAM5310wWcj6L3EEJpeSRlQdfaCvTyDqREQ6wmq1I0EWCXO7tLdJgv3
 2Wt/Yb99n/gERV5YQqm20TTel85xvOBzu1E1PuY=
X-Google-Smtp-Source: ABdhPJy7/J9q5USDPMNzIyY+8ms4dvOYO68l/BY4jW8L5HQbOwwZYaD3aIVqBnVjaVEgz+ASjRvH9ILni7bfHETAdxI=
X-Received: by 2002:a05:6e02:f41:: with SMTP id
 y1mr19868790ilj.267.1604507630165; 
 Wed, 04 Nov 2020 08:33:50 -0800 (PST)
MIME-Version: 1.0
References: <5FA280F5.8060902@huawei.com>
In-Reply-To: <5FA280F5.8060902@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Nov 2020 08:21:52 -0800
Message-ID: <CAKmqyKOS4bALKNTA9wMK=HANz4Dc=fffq2pZafCxGFqsJ_LMkg@mail.gmail.com>
Subject: Re: [PATCH] ssi: Fix bad printf format specifiers
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, QEMU <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 4, 2020 at 2:23 AM AlexChen <alex.chen@huawei.com> wrote:
>
> We should use printf format specifier "%u" instead of "%d" for
> argument of type "unsigned int".
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/imx_spi.c    | 2 +-
>  hw/ssi/xilinx_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index 7f703d8328..d8885ae454 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -53,7 +53,7 @@ static const char *imx_spi_reg_name(uint32_t reg)
>      case ECSPI_MSGDATA:
>          return  "ECSPI_MSGDATA";
>      default:
> -        sprintf(unknown, "%d ?", reg);
> +        sprintf(unknown, "%u ?", reg);
>          return unknown;
>      }
>  }
> diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
> index fec8817d94..49ff275593 100644
> --- a/hw/ssi/xilinx_spi.c
> +++ b/hw/ssi/xilinx_spi.c
> @@ -142,7 +142,7 @@ static void xlx_spi_update_irq(XilinxSPI *s)
>         irq chain unless things really changed.  */
>      if (pending != s->irqline) {
>          s->irqline = pending;
> -        DB_PRINT("irq_change of state %d ISR:%x IER:%X\n",
> +        DB_PRINT("irq_change of state %u ISR:%x IER:%X\n",
>                      pending, s->regs[R_IPISR], s->regs[R_IPIER]);
>          qemu_set_irq(s->irq, pending);
>      }
> --
> 2.19.1
>

