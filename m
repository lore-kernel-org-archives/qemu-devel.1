Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E041C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FA520823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xislj71X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FA520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joB4L-0001aa-AC
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joB3N-0000NK-Oy; Wed, 24 Jun 2020 15:27:25 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joB3M-0008EU-6X; Wed, 24 Jun 2020 15:27:25 -0400
Received: by mail-il1-x141.google.com with SMTP id k1so2001686ils.2;
 Wed, 24 Jun 2020 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ohkushfWbAuiWBiaAz2fJBB4ZNpndH0Xh8mSGqUQD/o=;
 b=Xislj71XtENi8gXBf8LocTywmQUbhmBXsc9sfM1wtzdlrABb0aTl0JZpaOC5yYSLeQ
 G/e0s3UZKlCWQ3TF5EJobgEGe11Jd1afKrW7iJMyU3Bl6K5hhO6ep3GoZfneY+uCkUGC
 nmF9ckOok+tFp1coEsZ4NyINDaHckcK5uQaym+fEiTO+GTwrcRgYq0f9Z0Uyn+Qzh+E0
 GPiWmzI4MoybV51GPwjkoFkpMnGk8qfObfUTX1y3ry+eJspPeLw5ObEaU14+SCwVOgaw
 5vmDcEJ+AuX1RBcyWYrx2L2M9Gs7/ZR5HLknhNsfVoxt15sBVT6KMgicoPdxMg45OeCS
 0I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ohkushfWbAuiWBiaAz2fJBB4ZNpndH0Xh8mSGqUQD/o=;
 b=k6GlzoKc+LlO25R5iYTZ1b2cgC8t5DFISD+rcvFd5F17ijUb51gjMOfuSxKm1JtK4u
 gnedtVTOsHx1Fdz+JmE0p2LPcC60cuH64a+JfIuUHy3az4r6gejdedJY91FlF9s3uIoa
 OT8NEPWznAdwYOfbmGWJrL+x9uzCNBLSGdDThwcRIgVNhp4yFx2KiLWcPwbOyYr2ZVVU
 QoCjIXQGD+brZiN0tEqFVBxNtfGbQVFRl1xHXI+ttR28e/wQLEDa1bAuOgMmfYZrxdFP
 LjLs69z59WxA7sR3n9m49al9U23i1dLmMQ8sY9wIV21EtlM7TMglp3Iwr0qlDwM47y7k
 ZMgQ==
X-Gm-Message-State: AOAM533zEbuzNmGGJLshTiij/vgedaqP1eZ5LnYWYxdtYXOQ4JQY8sqb
 CnmwVknQbV7cayX/avfdHozaBd7LabeWCZ+XDX8=
X-Google-Smtp-Source: ABdhPJxAJRQpshg7EO7XhIcYqdWhUbeXwttAnTCT+2ccF9/k7mDw4vnQzs+Eza3yFfv7yzgnOrrNHTUg27JKy51nqao=
X-Received: by 2002:a92:c213:: with SMTP id j19mr23471978ilo.40.1593026842827; 
 Wed, 24 Jun 2020 12:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200624083737.3086768-1-armbru@redhat.com>
 <20200624083737.3086768-23-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-23-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jun 2020 12:17:48 -0700
Message-ID: <CAKmqyKMrWj9BJ_ANP-wjoO4qB_dLJkPV7q9bw8565THB+yRsdw@mail.gmail.com>
Subject: Re: [PATCH v2 22/25] arm/stm32f205 arm/stm32f405: Fix realize error
 API violation
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 1:44 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> stm32f205_soc_realize() and stm32f405_soc_realize() are wrong that
> way: they pass &err to object_property_set_int() without checking it,
> and then to qdev_realize().  Harmless, because the former can't
> actually fail here.
>
> Fix by passing &error_abort instead.
>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/stm32f205_soc.c | 2 +-
>  hw/arm/stm32f405_soc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> index 19487544f0..56aef686c9 100644
> --- a/hw/arm/stm32f205_soc.c
> +++ b/hw/arm/stm32f205_soc.c
> @@ -154,7 +154,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
>
>      /* ADC 1 to 3 */
>      object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
> -                            "num-lines", &err);
> +                            "num-lines", &error_abort);
>      qdev_realize(DEVICE(s->adc_irqs), NULL, &err);
>      if (err != NULL) {
>          error_propagate(errp, err);
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index c12d9f999d..cf9228d8e7 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -172,7 +172,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>      object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
> -                            "num-lines", &err);
> +                            "num-lines", &error_abort);
>      qdev_realize(DEVICE(&s->adc_irqs), NULL, &err);
>      if (err != NULL) {
>          error_propagate(errp, err);
> --
> 2.26.2
>
>

