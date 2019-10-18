Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FCCCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6E92089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkdj+3a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6E92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVYD-0008Ad-Eu
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVXO-0007XZ-Fg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVXN-0002aF-Ei
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:55:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLVXN-0002Zu-7Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:55:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id o205so5750838oib.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KIqYcN4FSabwWJ3EPSLj/Q3uwagcQXwMI+yuJRNBrF4=;
 b=nkdj+3a6EqPpqBX6Avm4dz4XEK12yBIae31nzHYYwk3fPN/vhIQ7Deg6a3ozdbNdkD
 5pQmOMIR3p79vPSw+NrghEjmqBCumybY8lYob+WnHnORYdmjiFB2yzflW8OtXtpFXy7E
 oMqJoc+Nb9/XVJVZWfoalnnKt4JwtQG4P2LeOAtAXRHon8NWW/O9KaJiE/P5zFtWPcR6
 IGfLx2ttOEVU//pEIU/ATYde00YjTWZZrSMz+iNNAWwuGZmF1xAqqJ3o3fhzu6yK3b9p
 h95HNjqDHcWgZvHfRpvgDJo/hhQ0aTvcnbiqCCCKVAS+ZD2Wd16VyDJdHDlrsL4bvCJi
 qWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KIqYcN4FSabwWJ3EPSLj/Q3uwagcQXwMI+yuJRNBrF4=;
 b=GgOl6xghE1zBv3WN9Uhvu84FoIMWccC5ov3x0Gmtm0troLTw45n3jmMjcMVQjcTuHe
 1fVuNAemTDlW0Ue0k4BleP6jD4cJyvn8AJCvgK9hYB0PPjHN8rsddwhjRGs1mMQLDu/z
 SAc1RyDBelh7StacjQY+xrLtVYlsieRwWPwcisjMBK/wRsVVDpOQrVPFhhUx8mrZoCSd
 xauFITLr0WIHlp917HB9faHMzhiCmWUqxT9/zHGxkmGtOQ/8Uqa6SgAndEX+toEVOKjw
 l9dzotHbR8PMdr14Z5itMSVK3fEsmsgnF5klBTPHBO37blSpF/JxIJmFrC30tJxIt2a7
 GqgQ==
X-Gm-Message-State: APjAAAWMEF5mzLqUSYUN3bFb611HG2oK/dgFvCYVZyVef3dHiy68NB26
 F+MvezhpMX2gWyVVrJykKjQIwVWicW2KUsn/9uT2GA==
X-Google-Smtp-Source: APXvYqxPZIORjCrvEFySfHZsOED5mv9vJ5F6QpbljcIRhR8mwKMsZ/d69y9x/HcoluyRYNJEHUGa8cHxhtGchEIwidQ=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr8477417oik.146.1571417736275; 
 Fri, 18 Oct 2019 09:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-11-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 17:55:25 +0100
Message-ID: <CAFEAcA_0EFdyxfVgnyH=O7HSoZUi7xDLaNRyXt0dRCE7Dr2x6w@mail.gmail.com>
Subject: Re: [PATCH 10/14] omap-intc: remove PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Since clock are not QOM objects, replace PROP_PTR of clocks with
> setters methods.
>
> (in theory there should probably be different methods for omap1 &
> omap2 intc, but this is left as a future improvement)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 2fda996648..6b7897ba27 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -67,6 +67,16 @@ void omap_clk_setrate(omap_clk clk, int divide, int mu=
ltiply);
>  int64_t omap_clk_getrate(omap_clk clk);
>  void omap_clk_reparent(omap_clk clk, omap_clk parent);
>
> +/* omap_intc.c */
> +#define TYPE_OMAP_INTC "common-omap-intc"
> +#define OMAP_INTC(obj)                                              \
> +    OBJECT_CHECK(omap_intr_handler, (obj), TYPE_OMAP_INTC)
> +
> +typedef struct omap_intr_handler_s omap_intr_handler;
> +

If you add
/*
 * TODO: Ideally we should have a clock framework that
 * let us wire these clocks up with QOM properties or links.
 */

> +void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
> +void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
> +

then
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

