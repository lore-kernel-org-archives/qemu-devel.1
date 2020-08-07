Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF0A20855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nhw2k5X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF0A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yTU-00007e-Hv
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3ySo-0007yv-0I
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:14:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3ySl-000106-54
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:14:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id h3so1301113oie.11
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gf2GxP1wncmiRZSntjLHRNntrKjkXPe/3EQDvZvYvNY=;
 b=Nhw2k5X+MQVyn8nKeKSDBwUoVAteYDnYP/U9h3o42o3wBlB6hwc2tv/PargatMnaTD
 5F97e0z5zBahsq4Hx4olEFu1hnNLvg32ecfdFyCfRuB26YDgl1obPeHYUCvfT2+f15dv
 Ooy3B2ho8Ih9hXKHBwIkXB2TN2GUey3qWoOxUstZAaUJ9v90Umy9YTmWil89hHuUarey
 V9TczME6MDNZHznh1XkvkWVqnU/o2lD31Afh3E/hSbNtKq4oWREyrJh7sWFxB1ln5T3R
 EQf9Rruwj6lTk+FeEHh+x0S62OY4ZTDDZ7et/FLNZfQVfmV8erXOFYoLaOEWJtsn5x8C
 KYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gf2GxP1wncmiRZSntjLHRNntrKjkXPe/3EQDvZvYvNY=;
 b=JeyhRdx807tE47wiAFhcaHiZojZVLhhfi0CNsJNXZ12Jszn2kDxM6amwSNMebAIZf9
 Sb1wMLZJKMBotqhFx4KJrgMQK1Ujc0KkDtQfmdwM4wF2r2OHJtnK/agAYMtS3HA6Gx8H
 bMdN8k2dqexyD3rIusNZNO0NEx0HZ3XY2lERHXqDwQbOTSrmXq4nC3BSMOoPfuumWwRx
 QQV2rmLGQTqwn8k613HJWCtbKcUTzu5FdVramUPNZdrY+PcR/ZF9Ui5havCcMfMJrmXa
 F9MIiwV84S41fjqjNlBJIWtp8InY+0Qwf3+X2WXe5vKsogWQfwP0OzZgw+y+p/tmgSCI
 fBew==
X-Gm-Message-State: AOAM533sjsnQ8uqouBfLBG/B3TlPewP9A3TrnPvEor1JTO8p5qzcnK2g
 jInas0MHi53Ah+QeM+lFSzfiDycL+phvThxXQ/EkKPyiXDY=
X-Google-Smtp-Source: ABdhPJwLG0Qv833ZUDw4niCr8uDZLr26CJR1Q7UbT4P1q7FUzU3ZeFRQg4ddvDMTnYoFsNuA3blEa7l43cC4Nqst8Pg=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr9964604oib.146.1596791693770; 
 Fri, 07 Aug 2020 02:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <c5e38163-5ad0-1965-df7e-7543be284135@kaod.org>
In-Reply-To: <c5e38163-5ad0-1965-df7e-7543be284135@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 10:14:43 +0100
Message-ID: <CAFEAcA88DLWFPynThkkb39KUPsHYsUMawco6UFbyqcVuBTh32w@mail.gmail.com>
Subject: Re: [PATCH for-5.2 00/19] aspeed: mostly cleanups and some extensions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 14:24, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 8/6/20 3:20 PM, C=C3=A9dric Le Goater wrote:
> > Hello,
> >
> > Various fixes improving the support of Aspeed machines.
> >
> > Thanks,
> >
> > C.
> >
> > C=C3=A9dric Le Goater (16):
> >   m25p80: Return the JEDEC ID twice for mx25l25635e
> >   m25p80: Add support for mx25l25635f
> >   m25p80: Add support for n25q512ax3
> >   aspeed/scu: Fix valid access size on AST2400
> >   aspeed/smc: Fix MemoryRegionOps definition
> >   aspeed/smc: Fix max_slaves of the legacy SMC device
> >   aspeed/sdhci: Fix reset sequence
> >   ftgmac100: Fix registers that can be read
> >   ftgmac100: Fix interrupt status "Packet transmitted on ethernet"
> >   ftgmac100: Fix interrupt status "Packet moved to RX FIFO"
> >   ftgmac100: Change interrupt status when a DMA error occurs
> >   ftgmac100: Check for invalid len and address before doing a DMA
> >     transfer
> >   ftgmac100: Fix integer overflow in ftgmac100_do_tx()
> >   ftgmac100: Improve software reset
> >   aspeed/sdmc: Simplify calculation of RAM bits
> >   aspeed/smc: Open AHB window of the second chip of the AST2600 FMC
> >     controller
> >
> > Joel Stanley (2):
> >   aspeed/sdmc: Perform memory training
> >   aspeed/sdmc: Allow writes to unprotected registers
> >
> > erik-smit (1):
> >   hw/arm/aspeed: Add board model for Supermicro X11 BMC
>
> Peter,
>
> I saw that you just merged that one. I did some minor changes in
> the commit log. Nothing very important.

OK, I'll drop the old version from target-arm.next.

I'm wondering whether it would be simpler to let you just
submit pullreqs for aspeed-specific patches, since we seem
to have quite a lot of them and I'm generally letting you do
the review work anyway. What do you think ? I'm happy
to continue to take them in via target-arm.next if you prefer.

thanks
-- PMM

