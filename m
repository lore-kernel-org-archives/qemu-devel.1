Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4654C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDF82088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV2HvKa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDF82088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlebT-0007IV-SY
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jleaq-0006MI-7j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:23:32 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:37948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jleao-0001kb-1z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:23:31 -0400
Received: by mail-oo1-xc43.google.com with SMTP id f2so692440ooo.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ft65Ri8kZk19uQqlvgv6DI7d6kztZCTY0G6apv0Ys7E=;
 b=YV2HvKa3RHVnXbj88S8YKL0oZsb9oVQjuOmHvH3O4JNBxbWBbdYZLAAeUBhK6/9YNm
 cBD1Q7qEOIr6X2YOu0zV6t3bHhtGVjKvNgIWbMi0eYMdMBvQM6Y6gi+DuPn5XN/Bc51r
 qs7MmIkivXB0IU+9B8XSyMWotGQ5UUP2c0uMDbbG1mW8sDK9E6Sq3xbJZDiY9+eLgtRU
 oHT8W93/a5ZXY14h/z8YZHfSHpIIyKjX1DcYSTAAVu98301tbYmg9/HC4tVFXoWgAdQf
 TI9KsB5pzBKmWAeDJCPVB/KHocDGX22i2UpQ/2nGhRq9w5aw+XF2OmLzp+FWU4ulZw6k
 V08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ft65Ri8kZk19uQqlvgv6DI7d6kztZCTY0G6apv0Ys7E=;
 b=XH3v82dfXowTHTTFoTi9nLn3Tug7ajEi9qnYiqqwDNwIpMou9sZgAYLaxSsSHrM1zE
 mRfFQZDEfEbKO6K4FApu8ie7HIFECOFFHY5zY7XEc60r5uDUlnNMNcfU6OUtuCF873zz
 13LqI2eBKdmAAEMJmjyb1qbZRvkYyoGMtP3nxudOKL3yXprBs/tQ/R2InKaUPMhlw0yg
 yjMuCkTEzqP9PFTxKEA9yWpHS0l4TsexvQQ5YJT8TzweawyPm8L5fK/fyPz7v/f9YYXl
 HxmcQxcvq0ET6jNgClFYQ+RKFyp8WWJwgED4rNYKqxdWgTWRplWRKmcOP3fslQHHIQDe
 hxow==
X-Gm-Message-State: AOAM533WIaeSYIXzYFR/24LIp+e3MDm35+FI9Es7141N+yx7naxeMUuB
 sXIzwg9zkZyUho0srFJOTo9nJDIlljzjM/JezV9hjQ==
X-Google-Smtp-Source: ABdhPJzXmezL/I6Q6xUWnyidWpmXDtbge7o3dvxNBvsfME4g2n2CvW58qxS0Y4y07RBpgh4zEvigS/xJCRYvx7RCRqY=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr1133551ool.20.1592425408768; 
 Wed, 17 Jun 2020 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
In-Reply-To: <20200615201757.16868-1-aperamak@pp1.inet.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jun 2020 21:23:17 +0100
Message-ID: <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Allan Peramaki <aperamak@pp1.inet.fi>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 22:23, Allan Peramaki <aperamak@pp1.inet.fi> wrote:
>
> Fix audio on software that accesses DRAM above 64k via register peek/poke
> and some cases when more than 16 voices are used.
>
> Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
> Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>

This patch is quite difficult to read because it mixes some
whitespace only changes with some actual changes of
behaviour.

> -#define GUSregb(position) (*            (gusptr+(position)))
> -#define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
> +#define GUSregb(position) (*(gusptr + (position)))
> +#define GUSregw(position) (*(uint16_t *)(gusptr + (position)))
> +#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))

So, I think the actual bugfix change here is just the changing
of uint16_t to uint32_t in the GUSregd definition...

> -#define GUSregb(position)  (*            (gusptr+(position)))
> -#define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
> +#define GUSregb(position)  (*(gusptr + (position)))
> +#define GUSregw(position)  (*(uint16_t *)(gusptr + (position)))
> +#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))

...and similarly here, and all the other changes are purely
cleaning up the spaces. Is that right?

> -#define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
> +#define GUSvoice(position) (*(uint16_t *)(voiceptr + (position)))

Are these accesses all guaranteed to be correctly aligned
to be 16 or 32 bit loads/stores ? Otherwise it would be
better to use the ldl_p/stl_p/ldw_p/stw_p/etc accessors,
which correctly handle possibly misaligned pointers.

thanks
-- PMM

