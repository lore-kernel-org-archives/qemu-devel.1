Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB7C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28AA20857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAw6u1ZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28AA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTG3-0000DI-1O
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPTFB-0007pl-3p
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPTFA-0000U0-5B
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:49:29 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPTFA-0000Tb-1O; Fri, 17 Apr 2020 11:49:28 -0400
Received: by mail-il1-x144.google.com with SMTP id t10so2544760ilg.9;
 Fri, 17 Apr 2020 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FWLpvl0JIUlSVOxkX226ifRA2l8uKNomPDLQoWEyxO0=;
 b=LAw6u1ZGg120ixFKf+pSPvm02t99e2GFpo05yEX8NLjAD9xDH2Il5nDXwpyNsWyhPx
 LZxIkaqh2O90igP/iKoXUfbZXD0br9mt5tEHkSrw8FpXSE62g+E1g5zIkrtC4fDtIUvJ
 YGd/dackUhH1U/7dNSHEY3pdqlYjeervIrMPckXirR94T68Nsy6KriFvVM9FdmojMlB9
 9ccDF9/DCHjW0zk0umz8dE4HLnpSA3iUv/ayvTEql6PATofRo6jDt/tqiwilcJeHpsyA
 2goIXCyTz8albrcVSV/xO4dXWHnCMONefRCK4/c4ckwCrvVi5sZvaiaLq+cXHKYkX38P
 77Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FWLpvl0JIUlSVOxkX226ifRA2l8uKNomPDLQoWEyxO0=;
 b=Ce8xEmiRm3fqpHF9enUO/hn4GMkmj3u23leJjLUWg9vtVJ3jFQaFkTyOzxQEXsqcQQ
 I4BODXYqQlgbUh89Pf2n0D49jAYHycH6Szdw7K/wssh7aikmL0a1mL52liuo6NoYeNTI
 4ON2+rkjZCVd+/JyrrEGESmY/HEbIdKALv9Ja7OjaA9rDC0d6amquTu+nQyU5OXEAHGZ
 jHqCIhiY3U2hhnqA6tXlrhvOY7zpyZSolCMxuyB9YCEaG9edKCCtnC0gabnvNXAQ7iVW
 Ne5m4mMC2wCcVPQ49XQ1xLra2jiEGfdnHTWowrUbF8RTdKjbNe3n78dBEbWrN2PsHha5
 5yuA==
X-Gm-Message-State: AGi0PuZCL+zisWzYseROnZZLiVH202fsMRdF9PRK1ISktYs26b1E3wCg
 Z0mTHK0l7c3eDusWZHDsePi+eTjg+diV28frwCc=
X-Google-Smtp-Source: APiQypJMuoGMX/yuG9J4qdTf27kjEfMDqph2xfpIl0uyODJoYUVhRgeiqRAal5h2efwq376kb+bVpLw5KC2FMnBBew4=
X-Received: by 2002:a92:d182:: with SMTP id z2mr3794454ilz.177.1587138566993; 
 Fri, 17 Apr 2020 08:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200417153800.27399-1-edgar.iglesias@gmail.com>
 <20200417153800.27399-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200417153800.27399-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 08:41:04 -0700
Message-ID: <CAKmqyKMjLNqK_KcKum=n1sD0w-GbUJ2uofUNuKKjyuy1JRuf_g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/arm: versal: Setup the ADMA with 128bit
 bus-width
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 8:38 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Setup the ADMA with 128bit bus-width. This matters when
> FIXED BURST mode is used.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index cb0122a3a6..94460f2343 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -205,6 +205,8 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
>
>          dev = qdev_create(NULL, "xlnx.zdma");
>          s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
> +        object_property_set_int(OBJECT(s->lpd.iou.adma[i]), 128, "bus-width",
> +                                &error_abort);
>          object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
>          qdev_init_nofail(dev);
>
> --
> 2.20.1
>
>

