Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ED6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA10320776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSm8IFUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA10320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcsV-0001pW-Rv
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdclM-000678-F6; Tue, 26 May 2020 12:49:12 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdclL-0007Oc-Fe; Tue, 26 May 2020 12:49:12 -0400
Received: by mail-io1-xd44.google.com with SMTP id r2so12450171ioo.4;
 Tue, 26 May 2020 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o6vFOUblTNolcbaRL4nx5kYJgwZRaRBiJrsxMHHl+zw=;
 b=DSm8IFUePY+/iZDmV2dfu1XDvfBpDCU2wQqmk5/3bvYWxyqQF/Dlgsq8XR7wEu06u3
 Tiao6YMjv0bW7HaXsvcEd3KQzZRAlkay65nIGq062Slmb5I9trCTvTW9Qo65tpw9I4D0
 z9TYe93YFW7HM3HVCPzl0b5fb1BrKs24tC28vV0jcD4/6j0TsAFkKmHahHbNKwcVvhxM
 c5gvkl82k8Ed2MsMmQw25EOpdTFQG0H5xpTBwnG7kCTAfTwmfB10WBpsaN3i7Od4oJbb
 g18n+6PKOky0naQjcuCRhnWZdX6dr/q7m8Nus8dnyF+sD4YzY9VxaFbo5/AvpqKq2pbG
 JI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o6vFOUblTNolcbaRL4nx5kYJgwZRaRBiJrsxMHHl+zw=;
 b=fAXTXzeFPam2yKiVP0H1UdqZd+nBeKyCSSlgep1ajMfG5JIW8S4PI5jHhj5tfCFCsv
 OTcr2VCFLL1WwfAQdVpSvLYPmwspHU6NIJcpWqEOyfUZqsT1D3ecxSSpidCMI/n3mZwm
 8d/lXA6QpkwyNdiGx1B4qeGeMRnZYboBsOn822W6DuU++N4WoiiPYOCYN36RcaiEbEYh
 X/adIUEKM38CgYLzzYTjdis0aTLuUHsT/kcF6T4GxK05quseuo+yZkpqQl93/LS7X4Y7
 yumeUXJiwjGhqLxK8Pyp2UMSMyJ9XfTbENN3SAnyrd1u+qm6ncAy9qCjeAjWmmuO6S5T
 zZJw==
X-Gm-Message-State: AOAM5307c+SKZeXWZuRogQ9Isz0SxRmo26NNxF/LB+IRnKC9MX+/xgoY
 YoMt8ykkCNdYE5DsJjvgxKYVSrSC93X5MHLozNo=
X-Google-Smtp-Source: ABdhPJwCb7MhtLOi2/+Ctk/F0TbbZ+J8GGABdDDLn5kv3bgXUOuQWq8FYmh5+i+SpYgQycvfOVRVwuacayh70/LoJ0A=
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr17622754iog.175.1590511749432; 
 Tue, 26 May 2020 09:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200525034459.28535-1-f4bug@amsat.org>
 <20200525034459.28535-5-f4bug@amsat.org>
In-Reply-To: <20200525034459.28535-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:40:10 -0700
Message-ID: <CAKmqyKP5T-X7wOSp0Fvdwi-V7BOUzY6SUxC=bL2tJDhEUkcSBg@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/display/xlnx_dp: Replace disabled DPRINTF() by
 error_report()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 8:49 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> DPRINTF() calls are disabled by default, so when unexpected
> data is used, the whole process abort without information.
>
> Display a bit of information with error_report() before crashing.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/xlnx_dp.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 3e5fb44e06..8d940cd8d1 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1,5 +1,5 @@
>  /*
> - * xlnx_dp.c
> + * Xilinx Display Port
>   *
>   *  Copyright (C) 2015 : GreenSocs Ltd
>   *      http://www.greensocs.com/ , email: info@greensocs.com
> @@ -24,6 +24,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/display/xlnx_dp.h"
> @@ -465,7 +466,7 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s=
)
>      uint8_t ret;
>
>      if (fifo8_is_empty(&s->tx_fifo)) {
> -        DPRINTF("tx_fifo underflow..\n");
> +        error_report("%s: TX_FIFO underflow", __func__);
>          abort();
>      }
>      ret =3D fifo8_pop(&s->tx_fifo);
> @@ -525,6 +526,7 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, u=
int32_t value)
>          qemu_log_mask(LOG_UNIMP, "xlnx_dp: Write i2c status not implemen=
ted\n");
>          break;
>      default:
> +        error_report("%s: invalid command: %u", __func__, cmd);
>          abort();
>      }
>
> @@ -631,8 +633,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s=
)
>          s->g_plane.format =3D PIXMAN_b8g8r8;
>          break;
>      default:
> -        DPRINTF("error: unsupported graphic format %u.\n",
> -                s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
> +        error_report("%s: unsupported graphic format %u", __func__,
> +                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MAS=
K);
>          abort();
>      }
>
> @@ -647,8 +649,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s=
)
>          s->v_plane.format =3D PIXMAN_x8b8g8r8;
>          break;
>      default:
> -        DPRINTF("error: unsupported video format %u.\n",
> -                s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK)=
;
> +        error_report("%s: unsupported video format %u", __func__,
> +                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_=
MASK);
>          abort();
>      }
>
> --
> 2.21.3
>
>

