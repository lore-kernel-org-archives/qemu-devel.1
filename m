Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C53C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17672146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXK8UHrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17672146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvvp-00089c-Lg
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhvu0-0007O4-NR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhvtz-0008Be-KI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:59:24 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhvtz-00089m-EF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:59:23 -0400
Received: by mail-ot1-x342.google.com with SMTP id n5so13385801otk.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HMBoIGrEaJ8GR3ze8KYnprE19cd1Pa/U0Sqi2rN/x24=;
 b=IXK8UHrcxj+abxTJBfH8deVWfxI3lRbAiPkBArfMXjbOHSeWzIs6zpqPLS7xmPtv2T
 JFemRYc382XAMwYBQKc5PNcUHcuRZhrlnagzyWvthH546Dqp9KeGb5aaoofEftWi5Jmo
 eMGFGx92EOSGVE+cM6AvDXy+xdR1ED2/Inst+xHPujjpGXFBgiMOl1ppgpGvbPEvxOWD
 UynCz+fOr6+9SUJ24zzbtgcWJTuMJSTsaD+ZpdqSf4WbGY4uKa4tl2QTZU27r3NCdfTY
 CiYw9mGFk+wukjgZ7P3ySnju9RYEgejcs5TtTp8PBSIc0usdRozG0UfBFRlTzoUkoSrt
 UVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HMBoIGrEaJ8GR3ze8KYnprE19cd1Pa/U0Sqi2rN/x24=;
 b=dnazK5RasQqiAkyMmbRc6HqB9LX4C5piKvMjAxrtXAfKCGkLqkA7eV5+WALoEmnUZM
 XVIVR1PeIQDoMOnaOKKuFxWvfxXkQNmBTKr9gNSufIcRgisaoR8vyOfwugMnAK/EqIvR
 Q/IslXYuSsZ6I4bdRB+fTn3ss3nd4LEI2aSbvWLT1kyp7O6S5CocR7SDPss+FqKF2pQ7
 VmhNP1k5sSxtlhnzLmp2PxfSllHhcIcH4UmqTA9xmR+UR4hoaskGOtth7WvV2PhyvA/s
 uAmy8AulUHtVW0VAduYuIRygbPhJVqMoYa5yalHQPW4La+ysU+4r3GDufbbQyRMw521W
 uQaw==
X-Gm-Message-State: APjAAAXJfutN5YohC/bokcRR6gn63T2O8ttWckfzw4UEMVjaj6Df3umv
 XHCmiEBKU7SRCL7RPb7LKKSwQdftre9McN5K+JoYuA==
X-Google-Smtp-Source: APXvYqyNYVGI0J2KRPDJT3Un2q+QDisUTCemB5orit8ww0ysielf06IRZMz7AmLejJvwBeT9biDFBeAhUtzsQW/rGJI=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr8488672otk.221.1561985962431; 
 Mon, 01 Jul 2019 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-11-clg@kaod.org>
In-Reply-To: <20190618165311.27066-11-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 13:59:11 +0100
Message-ID: <CAFEAcA_4E7b6qpHEaZaQRQO3TB5BJCLCRJ7jROAr7CeQsJ5wcw@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 10/21] aspeed/timer: Provide
 back-pressure information for short periods
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 17:54, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Andrew Jeffery <andrew@aj.id.au>
>
> First up: This is not the way the hardware behaves.
>
> However, it helps resolve real-world problems with short periods being
> used under Linux. Commit 4451d3f59f2a ("clocksource/drivers/fttmr010:
> Fix set_next_event handler") in Linux fixed the timer driver to
> correctly schedule the next event for the Aspeed controller, and in
> combination with 5daa8212c08e ("ARM: dts: aspeed: Describe random number
> device") Linux will now set a timer with a period as low as 1us.
>
> Configuring a qemu timer with such a short period results in spending
> time handling the interrupt in the model rather than executing guest
> code, leading to noticeable "sticky" behaviour in the guest.
>
> The behaviour of Linux is correct with respect to the hardware, so we
> need to improve our handling under emulation. The approach chosen is to
> provide back-pressure information by calculating an acceptable minimum
> number of ticks to be set on the model. Under Linux an additional read
> is added in the timer configuration path to detect back-pressure, which
> will never occur on hardware. However if back-pressure is observed, the
> driver alerts the clock event subsystem, which then performs its own
> next event dilation via a config option - d1748302f70b ("clockevents:
> Make minimum delay adjustments configurable")
>
> A minimum period of 5us was experimentally determined on a Lenovo
> T480s, which I've increased to 20us for "safety".
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -423,6 +423,12 @@ static void aspeed_scu_realize(DeviceState *dev, Err=
or **errp)
>                            TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
>
>      sysbus_init_mmio(sbd, &s->iomem);
> +
> +    /*
> +     * Reset on realize to ensure the APB clock value is calculated in t=
ime for
> +     * use by the timer model, which is reset before the SCU.
> +     */
> +    aspeed_scu_reset(dev);

This looks wrong. QEMU should always be resetting devices
after realize and before actually running anything.

>  }

thanks
-- PMM

