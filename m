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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8437C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8E420704
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQgFVP3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8E420704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddZJ-0005uu-RQ
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddW8-0001j9-Vn; Tue, 26 May 2020 13:37:33 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddW7-0005ll-4D; Tue, 26 May 2020 13:37:31 -0400
Received: by mail-il1-x141.google.com with SMTP id 17so21344269ilj.3;
 Tue, 26 May 2020 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7dIEbDvjdPSgiC8KM+8KpNw2JYaYxr6R5A6LSlImonY=;
 b=jQgFVP3zBEvCFOi/6th7JnPuipZCfzltmxZv+SAGJbagvzWUylgKGdXJTbxZ/wqNIR
 8cr9l+hXsuY3MfkvyUYE2FDHVv3Q++ZKvgJN12jdv6C11BrFVr8RuJIDJHhjKWpFlWCF
 WMiEC/9BdIics6oxDXdqi8E0eVKzqCrtmbnhAti77ZtRsYE4/M0+S/09dw474ZJKbHFi
 9FG1QRJwvkjk8fCT7C1Yi2EFxnGD4V5TRfY/JR88nqPkikv90yNpkhvXgf0RGrpsWA0R
 hiWYEYaGOKd3+tFwn62+jvI55mmfQo+HE0MxDmAK3XsYJuGFIFHXxNzb/XBeggEgzxex
 ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7dIEbDvjdPSgiC8KM+8KpNw2JYaYxr6R5A6LSlImonY=;
 b=UE4WoQ+LhGxQtUFXVwXHAQreVzRAKJZjCPke00y1jxpypceB8Mf4cMqSEIZ8q95iCS
 VT8ZvSqBrtocBWLXV5bkqzZJhpYZZ2xnX18lfkDiXIi2fto2/kiPycKFurTuu0LhCGKn
 3LyVNpQKfgCK4uoyd6Si4wZjC8yTTv92bg9FSFQ16itZ+hZXetLqOz00Bc0KgzwnLRhM
 GS5nspLPiJw8ju3DwZ/LJo8fcavkvgVbOHu+OQr5ZblghVE8igCzD3STGIIbNe7nkFy4
 aR5RPfYkB9esspp3xDJUSvRhHQ2J8oX6T9/i7Biz7QvSWp3w6gH7cNf/v5ErddFwAuGx
 PDTA==
X-Gm-Message-State: AOAM533l0ZZO5ohZftrRntKIDgoKjrq+mBRTK+G4h1mEy6kMW8KcX4Uq
 mBO7OAI76YucMStKaluufn97Y6MQNH04jGYHil4=
X-Google-Smtp-Source: ABdhPJzhC0PdugwaudBVQOwlxOW61qX8+Ql10z8rH3hctJ4A1vgLodp3f51KA/0/+6NrK4kpdNc3MNv2rc1Si2r2Dwg=
X-Received: by 2002:a92:d087:: with SMTP id h7mr2336786ilh.227.1590514649527; 
 Tue, 26 May 2020 10:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-15-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-15-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 10:28:29 -0700
Message-ID: <CAKmqyKM9r2QXppfiEW4RVrXNbYzhx-Ds2CsODKVUk0Sxei0JwA@mail.gmail.com>
Subject: Re: [PATCH 14/14] hw/display/pxa2xx_lcd: Replace printf() call by
 qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:36 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Replace printf() calls by qemu_log_mask(UNIMP), which is
> disabled by default. This avoid flooding the terminal when
> fuzzing the device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/pxa2xx_lcd.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
> index d5f2e82a4e..ff90104b80 100644
> --- a/hw/display/pxa2xx_lcd.c
> +++ b/hw/display/pxa2xx_lcd.c
> @@ -426,9 +426,10 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr o=
ffset,
>          if ((s->control[0] & LCCR0_ENB) && !(value & LCCR0_ENB))
>              s->status[0] |=3D LCSR0_QD;
>
> -        if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT))
> -            printf("%s: internal frame buffer unsupported\n", __func__);
> -
> +        if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: internal frame buffer unsupported\n", __f=
unc__);
> +        }
>          if ((s->control[3] & LCCR3_API) &&
>                  (value & LCCR0_ENB) && !(value & LCCR0_LCDT))
>              s->status[0] |=3D LCSR0_ABC;
> @@ -462,9 +463,9 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr of=
fset,
>          break;
>
>      case OVL1C1:
> -        if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN))
> -            printf("%s: Overlay 1 not supported\n", __func__);
> -
> +        if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN)) {
> +            qemu_log_mask(LOG_UNIMP, "%s: Overlay 1 not supported\n", __=
func__);
> +        }
>          s->ovl1c[0] =3D value & 0x80ffffff;
>          s->dma_ch[1].up =3D (value & OVLC1_EN) || (s->control[0] & LCCR0=
_SDS);
>          break;
> @@ -474,9 +475,9 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr of=
fset,
>          break;
>
>      case OVL2C1:
> -        if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN))
> -            printf("%s: Overlay 2 not supported\n", __func__);
> -
> +        if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN)) {
> +            qemu_log_mask(LOG_UNIMP, "%s: Overlay 2 not supported\n", __=
func__);
> +        }
>          s->ovl2c[0] =3D value & 0x80ffffff;
>          s->dma_ch[2].up =3D !!(value & OVLC1_EN);
>          s->dma_ch[3].up =3D !!(value & OVLC1_EN);
> @@ -488,9 +489,10 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr o=
ffset,
>          break;
>
>      case CCR:
> -        if (!(s->ccr & CCR_CEN) && (value & CCR_CEN))
> -            printf("%s: Hardware cursor unimplemented\n", __func__);
> -
> +        if (!(s->ccr & CCR_CEN) && (value & CCR_CEN)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: Hardware cursor unimplemented\n", __func_=
_);
> +        }
>          s->ccr =3D value & 0x81ffffe7;
>          s->dma_ch[5].up =3D !!(value & CCR_CEN);
>          break;
> --
> 2.21.3
>
>

