Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB6BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739E7208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGDO7pCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739E7208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvB8s-0004Rw-QC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 22:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvB84-0003rV-4F
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:57:12 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:42556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvB80-0002q4-AG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:57:11 -0400
Received: by mail-ua1-x942.google.com with SMTP id u33so2813039uad.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mE7dPvO1CgW3ZPUxyh6bx2v0qVFfOnWcTV5dKbi21t8=;
 b=QGDO7pCGZBcvnfGmerp+DPxdKbaYedYpQaVm87Rn8bV6onLO+rNA0pqQL1RbHJvslo
 diW44N/AvKezUVJYAEBiANUSeqiXLZR6a9vIR+ONRcbh+xfyq/SEukKDMm+XsCdv8s+6
 PmEeUYvFXtaDt9/jvcXRYjihL+QBIZS2N1DR9D/xBz+7wdfsTzFceL51sk8c8o0PO7I4
 8w9TU4qbdQm3fmKJqe8DpRzn7EUpXaqb1BnPBrDam8qDGwdLwNERF4Ki9L97H3aShLql
 SlRM9pknC3k0ONvkaondzQBn6nT/dXNKaE9v5kWAHjfRCOUxMk0+VyfHuton6dM5Z4L+
 p3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mE7dPvO1CgW3ZPUxyh6bx2v0qVFfOnWcTV5dKbi21t8=;
 b=Pmg4BQfrY2+clu5ZgMy5B/QH/PtL8GlP+qWtkn2KSmv6lfAeb0KfmTV1oLI9c0C8nj
 f2YEs+lCvfoZmVn6tCqp2N+F4EA1/+M2tkX/I3B8x+68h1Lmodk4sR7Voqyqn9BLSea/
 5JcwZZPtgUqeIietItksgoKa/DMzE0MohqVF7WKL/IFKG4c1NjfyxePP61mPF87ElH7/
 vlXeg3xfUU+mEOcdFYNgHQEkILs3GHHJedN/aLd8Pcdw8rWvJr8xnE1+W8pFvhO8zgk3
 BqMCtZOvl3nkzbqQYBlyvWN2p1yE8xqZWGCF+iu7awDCWllPa7JE0suCfyWd95l9yl+5
 uA1g==
X-Gm-Message-State: AOAM530pocsdLeeWP4u0nSGXdka0BOu2bNjvkcqYPCsnvklKIT5bPq62
 V3cGPPzfpnGGtEHVNNjwNTzHMhJ76z4RYb3efsSQtw==
X-Google-Smtp-Source: ABdhPJwAwwJAHq+HBz2FKv6MZ7TK+0xDlwkKT3/rKbXPEhAlhcn2N/O8UORgmr0BjNoiOahvlCW52wViF29mSPS6dAE=
X-Received: by 2002:ab0:6ec6:: with SMTP id c6mr2208310uav.7.1594695426609;
 Mon, 13 Jul 2020 19:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
In-Reply-To: <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Mon, 13 Jul 2020 19:56:55 -0700
Message-ID: <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 13, 2020 at 7:57 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> > This allows these NPCM7xx-based boards to boot from a flash image, e.g.
> > one built with OpenBMC. For example like this:
> >
> > IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
> > qemu-system-arm -machine quanta-gsj -nographic \
> >       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
> >       -drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,sna=
pshot=3Don
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>
> May be we don't need to create the flash object if dinfo is NULL.

It's soldered on the board, so you can't really boot the board without
it. But if you think it's better to remove it altogether if we don't
have an image to load into it, I can do that.

>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Nice !
>
> We need a SPI controller model and a network device model now.

Yeah, and i2c, PWM, GPIO, etc., but if you're referring to the kernel
crash, see below.

> npcm7xx_bootrom.bin is a bit of a pain. Could we include it in
> the QEMU roms ?

Yeah, I was planning to include this in v6.

> spi_master spi0: /ahb/fiu@fb000000/spi-nor@0 has no valid 'spi-max-freque=
ncy' property (-22)
> spi_master spi0: Failed to create SPI device for /ahb/fiu@fb000000/spi-no=
r@0

This is a device tree bug:

https://github.com/hskinnemoen/openbmc/commit/99b172f88002f4fac939f85debe11=
87b9c569871

> libphy: Fixed MDIO Bus: probed
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address fffffffe

I believe this is a kernel bug:

https://github.com/hskinnemoen/openbmc/commit/77e9f58ba157eabc976f15fa49892=
128fe2b2382

I needed two additional patches to get all the way to the login prompt:

https://github.com/hskinnemoen/openbmc/commits/20200711-gsj-qemu-0

