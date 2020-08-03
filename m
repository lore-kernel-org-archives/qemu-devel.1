Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B88C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E94920678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTvW6tD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E94920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hDr-0007rs-4f
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 16:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k2hD9-0007Bz-Ml
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:37:31 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:41614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k2hD7-0003hR-9I
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:37:31 -0400
Received: by mail-vk1-xa43.google.com with SMTP id x2so684881vkd.8
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fk/G1fUE6L6Lp8ha6IxwNOEg++c/xykfvt89kiRx73E=;
 b=tTvW6tD+A2hLWGhgB9vDS5JNYJTn8ehFsy7/BXYEKBWxw/PjAfYBvbvI/Idk49B0xl
 iUyEQI8HA5Y4cRKsBxhqgeyGv1x0hATvJ+MrUak4D/MSajw+uoYPK2Q+1cT4i414TwzL
 tc4Jn9QZyX9hdxdxAIBCd4sbqnF3kc0w5Z0Id4Px9t5bYXM9w+r9dzqLdfzCK9ejdXYM
 qkdIzHY9yxLKgWUDAv9a1vyLsTz/ABYXlq4i6LaaTpsQZv4tIhAUDddjFjajufljVeeG
 f5uk+uVAH6TqJTAXsPdRZr6FwIIJQPbIWYitx9yon4TlJjSEcxeSEVewLvMZWBzMOklf
 pNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fk/G1fUE6L6Lp8ha6IxwNOEg++c/xykfvt89kiRx73E=;
 b=Rq8pIavw6VYoDAykUvdc6qlTESHCOIkAfQQzakKLun/YO+GpYfTmtNjNX3vvEWcAhn
 fJhRT9XxCJiSaEjuC0ki8X4trSSFOKJA6Br+Rq0exb1Fk2UK96qFAVCxvz5bzW3OsCVo
 15Vit07cTrFILRqTOJww0JZjUWIW8tUN9jmu9/+0YwF5riQLouZEcYTSVaqow16WGaY1
 /uIIf/g5lfkW1gCvMwxr89AMwkVaIPzuJ6a1ZiB40TNUcCzxKtfsErdhH27d7Ow+JUD9
 fP3gf9/uPA1OPIZMEEKTdylgA7gYiTN/9oHht332kpp0LBNc//CPwOtWO87TtOMj2NIe
 2c4A==
X-Gm-Message-State: AOAM532pZYbxIibcZhrxN7XhJWnlHU7yDXDkISvaSLPXOIHCNCBIJMZj
 IXk8Vnrtj/dVXiN+eTxNYADgyURwIOCSS6EAWNmYxA==
X-Google-Smtp-Source: ABdhPJy9HIWDa1MCByANKKJcQF7WvKQSnOXFb7AcOqM5dtW15ymxDKojP51F8UYJJUgBM++RUNo7C85X6MZwMiBB4ek=
X-Received: by 2002:a05:6122:2c:: with SMTP id
 q12mr13051161vkd.39.1596487046413; 
 Mon, 03 Aug 2020 13:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <61366428-ca35-e0b5-cfce-99624747631b@amsat.org>
In-Reply-To: <61366428-ca35-e0b5-cfce-99624747631b@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Mon, 3 Aug 2020 13:37:15 -0700
Message-ID: <CAFQmdRZMGbJSaULO9QSVyN914MpD8r4gELzeCw3GWswzGOyM8Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Mon, Aug 3, 2020 at 12:08 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Havard,
>
> On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
> > I also pushed this and the previous two patchsets to my qemu fork on gi=
thub.
> > The branches are named npcm7xx-v[1-6].
> >
> >   https://github.com/hskinnemoen/qemu
> >
> > This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs=
 to boot
> > an OpenBMC image built for quanta-gsj. This includes device models for:
> >
> >   - Global Configuration Registers
> >   - Clock Control
> >   - Timers
> >   - Fuses
> >   - Memory Controller
> >   - Flash Controller
> >
> > These modules, along with the existing Cortex A9 CPU cores and built-in
> > peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in tur=
n form
> > the foundation for the quanta-gsj and npcm750-evb machines, respectivel=
y. The
> > two SoCs are very similar; the only difference is that NPCM730 is missi=
ng some
> > peripherals that NPCM750 has, and which are not considered essential fo=
r
> > datacenter use (e.g. graphics controllers). For more information, see
> >
> > https://www.nuvoton.com/products/cloud-computing/ibmc/
> >
> > Both quanta-gsj and npcm750-evb correspond to real boards supported by =
OpenBMC.
> > At the end of the series, qemu can boot an OpenBMC image built for one =
of these
> > boards with some minor modifications.
> >
> > The patches in this series were developed by Google and reviewed by Nuv=
oton. We
> > will be maintaining the machine and peripheral support together.
> >
> > The data sheet for these SoCs is not generally available. Please let me=
 know if
> > more comments are needed to understand the device behavior.
> >
> > Changes since v5:
> >
> >   - Boot ROM included, as a git submodule and a binary blob, and loaded=
 by
> >     default, so the -bios option is usually not necessary anymore.
> >   - Two acceptance tests added (openbmc image boot, and direct kernel b=
oot).
> >   - npcm7xx_load_kernel() moved to SoC code.
> >   - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
> >   - Comments added clarifying available SPI flash chip selects.
> >   - Error handling adjustments:
> >       - Errors from CPU and GCR realization are propagated through the =
SoC
> >         since they may be triggered by user-configurable parameters.
> >       - Machine init uses error_fatal instead of error_abort for SoC
> >         realization flash init. This makes error messages more helpful.
> >       - Comments added to indicate whether peripherals may fail to real=
ize.
> >       - Use ERRP_GUARD() instead of Error *err when possible.
> >   - Default CPU type is now set, and attempting to set it to anything e=
lse
> >     will fail.
> >   - Format string fixes (use HWADDR_PRIx, etc.)
> >   - Simplified memory size encoding and error checking in npcm7xx_gcr.
> >   - Encapsulate non-obvious pointer subtraction into helper functions i=
n the
> >     FIU and TIMER modules.
> >   - Incorporate review feedback into the FIU module:
> >       - Add select/deselect trace events.
> >       - Use npcm7xx_fiu_{de,}select() consistently.
> >       - Use extract/deposit in more places for consistency.
> >       - Use -Wimplicit-fallthrough compatible fallthrough comments.
> >       - Use qdev_init_gpio_out_named instead of sysbus_init_irq for chi=
p
> >         selects.
> >   - Incorporate review feedback into the TIMER module:
> >       - Assert that we never pause a timer that has already expired, in=
stead of
> >         trying to handle it. This should be safe since QEMU_CLOCK_VIRTU=
AL is
> >         stopped while this code is running.
> >       - Simplify the switch blocks in the read and write handlers.
> >
> > I made a change to error out if a flash drive was not specified, but re=
verted
> > it because it caused make check to fail (qom-test). When specifying a N=
ULL
> > block device, the m25p flash device initializes its in-memory storage w=
ith 0xff
> > and doesn't attempt to write anything back. This seems correct to me.
>
> I've been quite busy, now looking back a this series. Do you have a v7
> in preparation or should I keep reviewing it?

I have a few fixes queued up, but I didn't turn it into a v7 series
yet. I can probably have that ready by tomorrow if you prefer.

Or I can wait a bit longer and queue up more fixes. The merge window
is expected to open next week at the earliest right?

> Hopefully v7 would be the one Peter queue for merging once 5.2 window
> opens :)

I hope so too :)

Havard

