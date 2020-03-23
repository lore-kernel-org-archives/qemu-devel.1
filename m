Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4271B20637
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIta0b3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4271B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPan-0004aC-A9
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGPVp-0004aG-As
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGPVk-00063P-AW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:01:13 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:38267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGPVj-00062g-HI; Mon, 23 Mar 2020 12:01:08 -0400
Received: by mail-vk1-xa41.google.com with SMTP id n128so3933163vke.5;
 Mon, 23 Mar 2020 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fsrpN92Ba+Aa9m7v+VX26eF17EC615gTnf9oEpSQUIo=;
 b=fIta0b3WQ2+spUBaLKMDjsMq+ianR0y/AIw+47jDyDVL6A/UGtUSbq8OkKQgtjFnQN
 5AclorZoxpOXULKGAmLOZabYemG9EtaLb/JNxTaeB88Nw2Wy6Bc2OORWs5EVhsGH55k2
 gOh8cqIT/b1VnJnhNCRXW+bNVqwIZkY5Fji/T4sBBhZuuJpBYTI4jccp5nqmguMmyhL6
 OIcW4+2D2E8ITTHQ9Vj25x0VEgjZkIhxSzCVOGZAzSGhqC12Zkm8/MWdkp+AEO4HEMCY
 ShwcqgwNxSighXJKnfVznmXMr9q/cfLswgxB90neJHcW+FGm+4oB2T/NFFeS0mewVpOm
 49Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fsrpN92Ba+Aa9m7v+VX26eF17EC615gTnf9oEpSQUIo=;
 b=AfnOmTb5MxPvs9JMstEKRt0hA3gspk6JV1BPgxF5fI1xJoUlnL5+H8gog5opERcqjZ
 ACcr49WR/s0F8vIzcgNwQ/Gq539WKmewIJ7SAWDPgZrvcDfQ+q+xriTk2AqjTYj/yEbz
 EXsNZkM+uRiH59kFkAu6eeXixUsu/Virt8yTTmkzNdxLz3D3q9kPW1jrqF92Q2SN/yWQ
 YfiB0dlBAXYVe6eZecoqIvUVV0VvqfnoM+Gb6ayEqBo/EY6wX8Yf5BRfDz5aSqznj8fO
 k99qBJfL/Rghc5knXv6rG/8MVNCIa4BmWYCyOHI05pKAewZPMqYQ8PGdUnOY+j178sWI
 bZlw==
X-Gm-Message-State: ANhLgQ3dpY2BCYITY4Sw0cTb7bqO13kRG7sohfBo2Cko2weGMVw8Xijo
 7C24J6NrlkEvkG/9+ZatM+L4Qag7FvOtIxrrHJ8=
X-Google-Smtp-Source: ADFU+vvmgAqeFxfO51+XVOIJHWhM18K01oT/e8McXwYN/dQtlYANxrD3hvHdmBvFqkWbi+Dpj/vS5A+58hiVSonUj0A=
X-Received: by 2002:a1f:a2d0:: with SMTP id l199mr14863251vke.77.1584979266742; 
 Mon, 23 Mar 2020 09:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200321144110.5010-1-philmd@redhat.com>
 <20200321144110.5010-10-philmd@redhat.com>
In-Reply-To: <20200321144110.5010-10-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Mar 2020 08:53:09 -0700
Message-ID: <CAKmqyKPa-zc949L=G3gCdA50KQq0GbhE3zqoOTjTatPnsm5Oew@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v2 09/11] hw/timer/stm32f2xx_timer: Remove dead
 assignment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a41
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 7:52 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Fix warning reported by Clang static code analyzer:
>
>     CC      hw/timer/stm32f2xx_timer.o
>   hw/timer/stm32f2xx_timer.c:225:9: warning: Value stored to 'value' is n=
ever read
>           value =3D timer_val;
>           ^       ~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/stm32f2xx_timer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index 06ec8a02c2..ba8694dcd3 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -222,7 +222,6 @@ static void stm32f2xx_timer_write(void *opaque, hwadd=
r offset,
>      case TIM_PSC:
>          timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
>          s->tim_psc =3D value & 0xFFFF;
> -        value =3D timer_val;
>          break;
>      case TIM_CNT:
>          timer_val =3D value;
> --
> 2.21.1
>
>

