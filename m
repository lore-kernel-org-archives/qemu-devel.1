Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FBBC761A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2D92072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXVlvlr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2D92072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gRI-0003IO-QP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3gQX-0002Lq-TR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3gQW-00008F-Vm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:27:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3gQW-00007j-RN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:27:08 -0500
Received: by mail-ot1-x343.google.com with SMTP id h9so16008776otj.11
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 05:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tIZ1cjAe6zrSvNlyAIOBTaEtDU7r4MfwRMcWvjWCgos=;
 b=CXVlvlr9bY37ufmqx05k7GaCp5Ytv38FEmDws5rtiCE4u/5UfXk7In7JsSm7XrAc6c
 eWM5KMMsI7j++pEijiWb7d/t1TA8fMCIcVu7nRnx3ImuFn5mAcJE3P9PY2yz/nAbV1c6
 /4kG8jmjphRpeammmn10MFe8TxZBw00aZQ7ne7rU65mCuDICU/ry4Op5FAFFJnxvmYe+
 iZGB9OVK/bpPDvA7DcehiY5khA8P901T6TLjndDCxBGTSMlfehz+aSSUkxiDna/KgLD1
 Y/YLpkIPs6fLnD+aIXpTQ4f00OD8Cgkzk+Z63IE7TGhLOyWZYEpN7lOTPVuc4amc/h5j
 6fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tIZ1cjAe6zrSvNlyAIOBTaEtDU7r4MfwRMcWvjWCgos=;
 b=nsrs6OEvAfuenrRBC1nklSPbZ+p/gitrbsqsKHev2kB83V1mqBieqV+iVbwiJScIer
 vKaycmwymsrS4PsR/bKZGMqiFIHUsiaU/h9a6DCP2IAubpwxyyfnHfY0Me9funudyfZ6
 r1yJeBGLf0ZWF0K+/MAgMdq7s9MU9nULed3ltsTXMziSlmdveSeuqognkKKmkcE1pMu7
 Z2VDOqDsIbsrt5zeoTSm405pYF28WgdE5t+U4Gpudpg/OiMtpIYLQ/eogWXOJWnro5tc
 WtDiHzz0INism5I1RZjzRboPV0nfb6T2n+A4c//OxKREAKNlpxdAGFFKreL4pZPUXp3S
 6QtQ==
X-Gm-Message-State: APjAAAWd9s1BFKDL/KzNs015bMcAeQSOl27H2PQkI47GVueHJPA4+XgK
 Sg+5xc5tdxi8BTff1CyjU2g3XZLg+V6kKWjrmq64fw==
X-Google-Smtp-Source: APXvYqxuLpBADezxXYOmBVzYXKSSuYL5krIFGoUBqwY0Vk3WP4lJGsJ8udp7TlVCjifa2ppnzI/yeVxPdy2s3pXvneM=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr12138264otq.135.1581946028154; 
 Mon, 17 Feb 2020 05:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-3-philmd@redhat.com>
In-Reply-To: <20200215154706.19837-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 13:26:57 +0000
Message-ID: <CAFEAcA8P9yFjX5t96NJwzQpFEwsYg1eAWicO-Vneh1_zszJ_Aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sd: Delay timer_new_ns() from init to realize
 to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Feb 2020 at 15:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> In commit f3a508eb4e the Euler Robot reported calling timer_new()
> in instance_init() can leak heap memory. The easier fix is to
> delay the timer creation at instance realize(). Similarly move
> timer_del() into a new instance unrealize() method.

> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 71a9af09ab..d72cf3de2a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2058,14 +2058,12 @@ static void sd_instance_init(Object *obj)
>      SDState *sd =3D SD_CARD(obj);
>
>      sd->enable =3D true;
> -    sd->ocr_power_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powe=
rup, sd);
>  }
>
>  static void sd_instance_finalize(Object *obj)
>  {
>      SDState *sd =3D SD_CARD(obj);
>
> -    timer_del(sd->ocr_power_timer);
>      timer_free(sd->ocr_power_timer);
>  }
>
> @@ -2098,6 +2096,15 @@ static void sd_realize(DeviceState *dev, Error **e=
rrp)
>          }
>          blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
>      }
> +
> +    sd->ocr_power_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powe=
rup, sd);
> +}
> +
> +static void sd_unrealize(DeviceState *dev, Error **errp)
> +{
> +    SDState *sd =3D SD_CARD(dev);
> +
> +    timer_del(sd->ocr_power_timer);
>  }

Here too the old code was doing things correctly in that
it does a timer_del/timer_free on the timer it allocates
in instance_init, and the new code has weirdly split the
freeing between unrealize and finalize.

thanks
-- PMM

