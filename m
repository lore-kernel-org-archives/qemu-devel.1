Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD03CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6823420882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCf2N8Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6823420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMgzU-0003l7-Hq
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 19:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMgyH-0003Gu-UJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMgyF-0007q1-Hd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:20:17 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMgyE-0007pg-PV; Mon, 21 Oct 2019 19:20:15 -0400
Received: by mail-lj1-x242.google.com with SMTP id m7so15145243lji.2;
 Mon, 21 Oct 2019 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EiZSdHZTxIQrn7R3UMKYO3ieft0tHbUa2HxOXgeQww0=;
 b=mCf2N8GhcNCWBs/oJWnKGk3o4d5BG55HVbBREs8SxlUAPO2U2J488Q4UJNn5brHilB
 0IZrIqSS4LSVNoeT6aIB4GF4V2Vo98eo+8N9SruzG2lXkX/eXhxtn8Rbx7WayTeesnJu
 f2idVWttRIT21OLeEuTrXOsuhsWL6vC7vIUz72io9gM4iZU9K4Z53To08aCw289T1Ut6
 3x+0aahRN8YKMaqnQg7oG6SS5bKrbfdPaXbLNhj/i6wiJwN2oLhcIsJkGOJdzJNl87ed
 IMBRp969SSMa38FvqePh6N6hGuvUMfp9dXDrF8zJVqh6jKLRjr473GgjSXz/2Ey4N5mp
 8KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EiZSdHZTxIQrn7R3UMKYO3ieft0tHbUa2HxOXgeQww0=;
 b=uS0+9SAog/lLs9qMOiHwXBsLgVhqvUYIFG3qKT3duk6w+cYifEEAd5my6//n/LLrqt
 ostUTcCVZzyGc6MDXNAlXgncUDz1oi6kUNC7bnccrCpujnwGaM6YcFFeKWHOjl27Tw2j
 kB5CN7kPgdRVt01BpHreNyqNuy44glQSUs0WI5uhNm/PjdG/ekDq8y5ACk4r+/aeh7Y4
 Rv091RRUCQE1oINKeIsiLrNDsMeVmcEY2vi+U7CLD6OxfYAecqU/1xUMqMNflyvUEasU
 AAU7ixy4uOh0Qy9fmT6qjYsNCeaoxiPZ20m77fUahBFu5Fc63o/UvFpvz6cTqCzTUH7s
 VhIw==
X-Gm-Message-State: APjAAAWbrEXNpSIINnELakmFIcjyeg4IAnnx4A7YsKQXV2n9TJwF9uU8
 g27HxuEyMtE1WuwSgFGNi+w5GH+K7jjQf1GENxY=
X-Google-Smtp-Source: APXvYqwICR4ycR6FA8699IK53MRiXV8LWLqp6EQR//aZfUAzLYwpea/UrxUOH5XDO+85T9xBTqVPMoBBUIEIKKJpkTY=
X-Received: by 2002:a2e:420a:: with SMTP id p10mr17048243lja.16.1571700011666; 
 Mon, 21 Oct 2019 16:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-8-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 16:14:55 -0700
Message-ID: <CAKmqyKO+gbe9uADAb-y+cu06X_fLRWTNv7u7hY_ivtvRLFNHhg@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] hw/arm/bcm2836: Use per CPU address spaces
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 4:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Currently all CPUs access the main system bus. Let each CPU have
> his own address space.
>
> Before:
>
>   (qemu) info mtree
>   address-space: memory
>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>       0000000000000000-000000003fffffff (prio 0, ram): ram
>       000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripheral=
s
>         000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-time=
r
>         000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
>         000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
>         000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp80=
4
>         000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
>         000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprm=
an
>         000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
>         000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
>         000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
>         000000003f201000-000000003f201fff (prio 0, i/o): pl011
>         000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
>         000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
>         000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
>         000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
>         000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
>         000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
>         000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
>         000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
>         000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
>         000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
>         000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
>         000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
>         000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
>         000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
>         000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
>         000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdra=
mc
>         000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan=
15
>       0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control
>
>   address-space: cpu-secure-memory-0
>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>       0000000000000000-000000003fffffff (prio 0, ram): ram
>       000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripheral=
s
>         000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-time=
r
>         000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
>         000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
>         000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp80=
4
>         000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
>         000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprm=
an
>         000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
>         000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
>         000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
>         000000003f201000-000000003f201fff (prio 0, i/o): pl011
>         000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
>         000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
>         000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
>         000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
>         000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
>         000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
>         000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
>         000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
>         000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
>         000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
>         000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
>         000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
>         000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
>         000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
>         000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
>         000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdra=
mc
>         000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan=
15
>       0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control
>
>   address-space: cpu-memory-0
>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>       0000000000000000-000000003fffffff (prio 0, ram): ram
>       000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripheral=
s
>         000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-time=
r
>         000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
>         000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
>         000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp80=
4
>         000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
>         000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprm=
an
>         000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
>         000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
>         000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
>         000000003f201000-000000003f201fff (prio 0, i/o): pl011
>         000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
>         000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
>         000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
>         000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
>         000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
>         000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
>         000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
>         000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
>         000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
>         000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
>         000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
>         000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
>         000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
>         000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
>         000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
>         000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdra=
mc
>         000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan=
15
>       0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control
>
>   memory-region: ram
>     0000000000000000-000000003fffffff (prio 0, ram): ram
>
>   memory-region: bcm2835-peripherals
>     000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
>       000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
>       000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
>       000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
>       000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
>       000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
>       000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
>       000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
>       000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
>       000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
>       000000003f201000-000000003f201fff (prio 0, i/o): pl011
>       000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
>       000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
>       000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
>       000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
>       000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
>       000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
>       000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
>       000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
>       000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
>       000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
>       000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
>       000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
>       000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
>       000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
>       000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
>       000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
>       000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
>
> After:
>
>   (qemu) info mtree
>   address-space: memory
>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>
>   address-space: cpu-secure-memory-0
>     0000000000000000-00000000ffffffff (prio 0, i/o): cpu-bus
>       0000000000000000-000000003fffffff (prio 1, i/o): alias arm-ram @ram=
 0000000000000000-000000003fffffff
>       000000003f000000-000000003fffffff (prio 2, i/o): alias arm-peripher=
als @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000040000000-0000000040003fff (prio 2, i/o): alias arm-control =
@bcm2836-control 0000000000000000-0000000000003fff
>
>   address-space: cpu-memory-0
>     0000000000000000-00000000ffffffff (prio 0, i/o): cpu-bus
>       0000000000000000-000000003fffffff (prio 1, i/o): alias arm-ram @ram=
 0000000000000000-000000003fffffff
>       000000003f000000-000000003fffffff (prio 2, i/o): alias arm-peripher=
als @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000040000000-0000000040003fff (prio 2, i/o): alias arm-control =
@bcm2836-control 0000000000000000-0000000000003fff
>
>   memory-region: ram
>     0000000000000000-000000003fffffff (prio 0, ram): ram
>
>   memory-region: bcm2835-peripherals
>     0000000000000000-0000000000ffffff (prio 0, i/o): bcm2835-peripherals
>       0000000000003000-000000000000301f (prio 0, i/o): bcm2835-sys-timer
>       0000000000007000-0000000000007fff (prio 0, i/o): bcm2835-dma
>       000000000000b200-000000000000b3ff (prio 0, i/o): bcm2835-ic
>       000000000000b400-000000000000b43f (prio -1000, i/o): bcm2835-sp804
>       000000000000b800-000000000000bbff (prio 0, i/o): bcm2835-mbox
>       0000000000100000-0000000000100fff (prio -1000, i/o): bcm2835-cprman
>       0000000000102000-0000000000102fff (prio -1000, i/o): bcm2835-a2w
>       0000000000104000-000000000010400f (prio 0, i/o): bcm2835-rng
>       0000000000200000-0000000000200fff (prio 0, i/o): bcm2835_gpio
>       0000000000201000-0000000000201fff (prio 0, i/o): pl011
>       0000000000202000-0000000000202fff (prio 0, i/o): bcm2835-sdhost
>       0000000000203000-00000000002030ff (prio -1000, i/o): bcm2835-i2s
>       0000000000204000-000000000020401f (prio -1000, i/o): bcm2835-spi0
>       0000000000205000-000000000020501f (prio -1000, i/o): bcm2835-i2c0
>       000000000020f000-000000000020f07f (prio -1000, i/o): bcm2835-otp
>       0000000000212000-0000000000212007 (prio 0, i/o): bcm2835-thermal
>       0000000000214000-00000000002140ff (prio -1000, i/o): bcm2835-spis
>       0000000000215000-00000000002150ff (prio 0, i/o): bcm2835-aux
>       0000000000300000-00000000003000ff (prio 0, i/o): sdhci
>       0000000000600000-00000000006000ff (prio -1000, i/o): bcm2835-smi
>       0000000000804000-000000000080401f (prio -1000, i/o): bcm2835-i2c1
>       0000000000805000-000000000080501f (prio -1000, i/o): bcm2835-i2c2
>       0000000000900000-0000000000907fff (prio -1000, i/o): bcm2835-dbus
>       0000000000910000-0000000000917fff (prio -1000, i/o): bcm2835-ave0
>       0000000000980000-0000000000980fff (prio -1000, i/o): dwc-usb2
>       0000000000e00000-0000000000e000ff (prio -1000, i/o): bcm2835-sdramc
>       0000000000e05000-0000000000e050ff (prio 0, i/o): bcm2835-dma-chan15
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2836.c         | 39 ++++++++++++++++++++++++++++++++++-----
>  hw/arm/raspi.c           |  2 --
>  include/hw/arm/bcm2836.h |  4 ++++
>  3 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 221ff06895..374a44b38c 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "cpu.h"
> @@ -51,6 +52,8 @@ static void bcm2836_init(Object *obj)
>      int n;
>
>      for (n =3D 0; n < BCM283X_NCPUS; n++) {
> +        memory_region_init(&s->cpu[n].container, obj, "cpu-bus", 4 * GiB=
);
> +
>          object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
>                                  sizeof(s->cpu[n].core), info->cpu_type,
>                                  &error_abort, NULL);
> @@ -72,9 +75,11 @@ static void bcm2836_realize(DeviceState *dev, Error **=
errp)
>      BCM283XState *s =3D BCM283X(dev);
>      BCM283XClass *bc =3D BCM283X_GET_CLASS(dev);
>      const BCM283XInfo *info =3D bc->info;
> +    MemoryRegion *ram_mr, *peri_mr, *ctrl_mr;
>      Object *obj;
>      Error *err =3D NULL;
>      int n;
> +    uint64_t ram_size;
>
>      /* common peripherals from bcm2835 */
>
> @@ -84,13 +89,14 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>                     __func__, error_get_pretty(err));
>          return;
>      }
> +    ram_mr =3D MEMORY_REGION(obj);
> +    ram_size =3D memory_region_size(ram_mr);
>
>      object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, =
&err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
> -
>      object_property_set_bool(OBJECT(&s->peripherals), true, "realized", =
&err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -104,8 +110,7 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>          return;
>      }
>
> -    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
> -                            info->peri_base, 1);
> +    peri_mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->peripherals), =
0);
>
>      /* bcm2836 interrupt controller (and mailboxes, etc.) */
>      object_property_set_bool(OBJECT(&s->control), true, "realized", &err=
);
> @@ -113,8 +118,7 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>          error_propagate(errp, err);
>          return;
>      }
> -
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
> +    ctrl_mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->control), 0);
>
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
> @@ -122,6 +126,31 @@ static void bcm2836_realize(DeviceState *dev, Error =
**errp)
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
>
>      for (n =3D 0; n < BCM283X_NCPUS; n++) {
> +        memory_region_init_alias(&s->cpu[n].ram_alias, OBJECT(s),
> +                                 "arm-ram", ram_mr, 0, ram_size);
> +        memory_region_add_subregion_overlap(&s->cpu[n].container, 0,
> +                                            &s->cpu[n].ram_alias, 1);
> +
> +        memory_region_init_alias(&s->cpu[n].peri_alias, OBJECT(s),
> +                                 "arm-peripherals", peri_mr, 0, 16 * MiB=
);
> +        memory_region_add_subregion_overlap(&s->cpu[n].container,
> +                                            info->peri_base,
> +                                            &s->cpu[n].peri_alias, 2);
> +
> +        memory_region_init_alias(&s->cpu[n].control_alias, OBJECT(s),
> +                                 "arm-control", ctrl_mr, 0, 16 * KiB);
> +        memory_region_add_subregion_overlap(&s->cpu[n].container,
> +                                            info->ctrl_base,
> +                                            &s->cpu[n].control_alias, 2)=
;
> +
> +        object_property_set_link(OBJECT(&s->cpu[n].core),
> +                                 OBJECT(&s->cpu[n].container),
> +                                 "memory", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
>          /* TODO: this should be converted to a property of ARM_CPU */
>          s->cpu[n].core.mp_affinity =3D (info->clusterid << 8) | n;
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 615d755879..a12459bc41 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -184,8 +184,6 @@ static void raspi_init(MachineState *machine, int ver=
sion)
>      /* Allocate and map RAM */
>      memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram"=
,
>                                           machine->ram_size);
> -    /* FIXME: Remove when we have custom CPU address space support */
> -    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram,=
 0);
>
>      /* Setup the SOC */
>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 92a6544816..e3498cb861 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -37,6 +37,10 @@ typedef struct BCM283XState {
>
>      struct {
>          ARMCPU core;
> +        MemoryRegion container;
> +        MemoryRegion ram_alias;
> +        MemoryRegion peri_alias;
> +        MemoryRegion control_alias;
>      } cpu[BCM283X_NCPUS];
>      BCM2836ControlState control;
>      BCM2835PeripheralState peripherals;
> --
> 2.21.0
>
>

