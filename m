Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7D7206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcUVMghV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7D7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkq5t-0005XK-5z
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkq2m-0001Sv-ML
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:25:00 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkq2k-0005Rj-Ek
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:25:00 -0400
Received: by mail-oi1-x243.google.com with SMTP id c194so16046968oig.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lX1DhGHvT7CCAJGL5gGUa67aYcG9Xt2i5yMrO/VCpKA=;
 b=RcUVMghVfjqBT5RlKfeDPZ3feXIIX9wNapYadArpurUhkqpCt0Qz64nrnV8oiHxoKw
 zPUwssguiFBdboHx8Jeb9Ctk6rMBRucnDhwVIOuU2yayRzEI0gcGxH23RiVeZ+4Ul9yE
 OMKtTsVAGg0TeleQoIgSIpKFGjmw8ce2F88Y3GF8O5BsIgGQ2wK/L/WDWUlFp5XJzazY
 gVfM4xETri9zqEQigVNBO7Dvh83wCsVlJ36y+ME1j3tkT9B9IRprezVRr6Yt3CJmVHZR
 IOxIMJ8d13tpT3HLVL8v4fn5iqsAeivTbFKBdqTanp12x4QtA3/RGPsE7/KBZ5MT+8Uk
 b+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lX1DhGHvT7CCAJGL5gGUa67aYcG9Xt2i5yMrO/VCpKA=;
 b=IV9mfEzq4hmFRkLtZsGJ12ZNJnbqXE9godKFcsy0huCT9/caSbAbq3wlWPHhBzzhHP
 C/bYSHh5MvmZC0pO/9quz0kPNPIpHbgT/XIhx6BcMZvX/AVa8unHyTU4L6UJJpBNSfrd
 FjhRF/kBxGinJ97l+8GQ6CmUYRoyy7ezTHxNFq4OHC94iPc7c7cHvy1qsEcmEEsYqH0b
 hx0f0eubkunvcJyin5j9VAd2sFKl/0OmL3ZJiCT3eGiVp9UI+FE/A5AATAUAilkh5EI/
 I4eNpNlTxQ5tNSxS8ZkJy+e10Mj+9KLaAP5gLj6G7STFhVnS6P0kiEu+bOmYxAPm0tm8
 65ow==
X-Gm-Message-State: AOAM532DllWzL9RWuZ1ZZ5A6mgyizqczvFltwrCPKmYCJzG0qxzH9TOY
 setx1AYcrt52xSvEK8TiiceM4n52KxGOzWybs4rPLGuojA8=
X-Google-Smtp-Source: ABdhPJwd7oHPLffZnuVpo03JqiW8XtqL2Iw/usV7raRxj5YpDvLUwV3DeWRvvK1pjW7rouSnTVzMMYKDPMqob7MF+do=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr9035908oia.163.1592231097024; 
 Mon, 15 Jun 2020 07:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-12-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-12-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:24:46 +0100
Message-ID: <CAFEAcA_K1gkMwpeXP2DQGTfiQZOGc9O94dLf84oJJJMVpTc-uQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] hw/sd/sdcard: Simplify realize() a bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:28, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> We don't need to check if sd->blk is set twice.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a1b25ed36f..060ca9d993 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2123,12 +2123,12 @@ static void sd_realize(DeviceState *dev, Error **=
errp)
>          return;
>      }
>
> -    if (sd->blk && blk_is_read_only(sd->blk)) {
> -        error_setg(errp, "Cannot use read-only drive as SD card");
> -        return;
> -    }
> -
>      if (sd->blk) {
> +        if (blk_is_read_only(sd->blk)) {
> +            error_setg(errp, "Cannot use read-only drive as SD card");
> +            return;
> +        }
> +
>          ret =3D blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PER=
M_WRITE,
>                             BLK_PERM_ALL, errp);
>          if (ret < 0) {

Originally written with the pattern of "check all the error cases
first; then do actual work". But if you prefer this way around

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

