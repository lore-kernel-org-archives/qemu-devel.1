Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A4BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3612C20756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgsIyOjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612C20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WX3-00019M-Fj
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k5WWV-0000kV-V3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:49:11 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k5WWS-0004jR-VZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:49:11 -0400
Received: by mail-oi1-x244.google.com with SMTP id k4so12642490oik.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1RVeC68bW5kj1hWJX1IKGMeXqnEx3C7ffQkeye6n1CU=;
 b=tgsIyOjG83oq62bJgZuxIkT2aKCtpbVJ8RgmSRzplX5mm7BQcA8CApXc9BEjgeS7wj
 JTq96M3hWLxXfPtW8ABJaQwmIeUO2CdicRnug/yLYQgIdP3bc95GsGDu5Tmb6KkHtA21
 cQK1DUieS4zJk5rVPq+GY3iruzo6XSqEqX81+VdFWTvrar7x+cxrxRLUdpK2WOW4nDnv
 mEDH2Q1rx9YRB6TH2H3SVJQIoB5bVlClR5sQeYYbjayfjT9j59j+J07K7Lct3ixFLrq4
 FvP+dvlvlSM+L0bzyNpC9qh2LGr4CO0zF3awwG+OrBHSaLzxU2kp+5iFqe4XZIddGNNW
 RV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1RVeC68bW5kj1hWJX1IKGMeXqnEx3C7ffQkeye6n1CU=;
 b=MRjy437zjbF4gf8cFzEAUtB7HK8o8CRyHyNC2goYKlufmNFg5jsZ+m30p2sKIwPrj+
 +qDdzYuOUWBU5Nc3W4D6ggkLXTveUu54bXEn4akyW/mTtXhH1T0uJHAgoHLco7JeYtyX
 /8ilP09wHgdpFLSbzMtL2ck4W3u3tHK84qqozpHXHXBYrzhHYFpKPXoF+9aWZi8QokIG
 6WetpEP0Earzr4Ez4lso9hqxOUNvxyYLZyu+vhxjgCoY+hfAgQGTTrj/LOMjRM/QHmfQ
 ZFkUO67IPjw/vcpCuwuUUk8SDnd3Wm0Nlqa4AaTnwmc9Hz+P6uOW9VXrniJrjc3pHgIJ
 1BYA==
X-Gm-Message-State: AOAM530fP0p1T/vKlmt/3dbNyNZ7cC8381N+oFiis4//kpLyGs0p1uLQ
 MLza3IaforHOcDrltTnf/P8I4l0Fh4UHTSJMJ3A=
X-Google-Smtp-Source: ABdhPJz4SRkhVq6gRx0mKiACA+64JFYwWuNpQT8kZodEfQ+nz53QFwPp+hu31GkL7RQXz/PfhRbkgYexJ9Sd2RZuqxE=
X-Received: by 2002:aca:fd46:: with SMTP id b67mr3950080oii.150.1597160947803; 
 Tue, 11 Aug 2020 08:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200811114133.672647-5-ppandit@redhat.com>
In-Reply-To: <20200811114133.672647-5-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 11 Aug 2020 23:48:31 +0800
Message-ID: <CAKXe6SJXO8kXOnMxpOf-ZvRo_sXykt5YpKTC1-dcqKyHC=HyHg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] prep: add ppc-parity write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:44=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add ppc-parity mmio write method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/ppc/prep_systemio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Update v4: No change, v3 was acked
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09965.html
>
> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
> index bbc51b6e9a..e583222a1b 100644
> --- a/hw/ppc/prep_systemio.c
> +++ b/hw/ppc/prep_systemio.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -235,8 +236,15 @@ static uint64_t ppc_parity_error_readl(void *opaque,=
 hwaddr addr,
>      return val;
>  }
>
> +static void ppc_parity_error_writel(void *opaque, hwaddr addr,
> +                                    uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid access\n", __func__);
> +}
> +
>  static const MemoryRegionOps ppc_parity_error_ops =3D {
>      .read =3D ppc_parity_error_readl,
> +    .write =3D ppc_parity_error_writel,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> --
> 2.26.2
>

