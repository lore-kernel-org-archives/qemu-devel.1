Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA09206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E64MPyc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA09206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKM4-0000Jb-Ie
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtKLM-0008Bc-8V
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:23:16 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:34144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtKLJ-0007j2-Pw
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:23:15 -0400
Received: by mail-ua1-x942.google.com with SMTP id o25so184145uar.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5Ti6cFxCewPwMoqTLpH2XDVbkKwcEvNBNKBsSM3cnDc=;
 b=E64MPyc+SlIAJF9sGuCz4wyo1n/WNW7s5SgBzb9VP3utwQ/XadFXdqXPSnGnscBwme
 P5XR920PEl87SAycabDnsHYYtesyzlnOqBgmQedF2lwJmv3RebkcqUddSnafiwXo6DdZ
 /2QoNSKJGExjcV55EndDRU/FJ4/NVappxos1M6BwHZuxJmz1WPaHBL749hVdX55aE34z
 heZj3BaY2Fmtq0yxWpB5unp0eq+/fMpgxUmHtWLT1z+AvTw3+zoTXbzkPUcDxO7XEVfr
 VQuBJmQNDF1Df2xXqlUEuXzWmfI3/iiyFWhcPj6X6XWTQf2cnaQlAbfC/Az/cQ5aysm5
 XNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5Ti6cFxCewPwMoqTLpH2XDVbkKwcEvNBNKBsSM3cnDc=;
 b=G6UoXuljE9Mh8uuxuEbwhYV1jcVUSZsIyxki/Nt2dG6I9fSnYiIRBtjo6sH51BrLkn
 5LG8AjpbApLYz4SEr6fg3JQhjmhpdmNUj8ps6U+5wn1eo+50AF1u+gi2Ew/G7atRjbj1
 o6EdlONrjx3wCxvG87PZdBXMo//om31qescfD8z+fKLPZpamAsrNpnUaUC7fhrUAxSD/
 2F2I+ZA0SGYyj8TWsymjQu4lYBUNjmXhSeVmEYhSEX9/iU3NmWBNjxLULju6l1uyWxix
 oPHGY//LKATwQNve6mGUFUfahA6AGf2YNI86gQMNQN9NkfG21xRvzgxlYPsBOsJSGTqG
 YSbA==
X-Gm-Message-State: AOAM533F+m9V+3u/oAdJMBXFa/E619dUqgaaKmYd4i+JVwWkCEq4W6sW
 9IHVptf+xdxGkYvcVn+xryt4PqaUvZI4mnZ0O3BAlg==
X-Google-Smtp-Source: ABdhPJxR4EmaVUPoPA69IIW3D/BMzxq1Ptt8unMJPIKCo7Wx1hIBEKTID8mq9kOIY0dKp19NVh9AOUbsfngZ4vHk+Eo=
X-Received: by 2002:ab0:4e98:: with SMTP id l24mr12576181uah.15.1594254192420; 
 Wed, 08 Jul 2020 17:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
 <2d1e272b-6575-30df-22ff-5d720973951d@amsat.org>
In-Reply-To: <2d1e272b-6575-30df-22ff-5d720973951d@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 17:23:00 -0700
Message-ID: <CAFQmdRZ-fZGD-Zzr6YvRyB7oEaqdek-e6UeCjekW-DnZLOfbrQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Wed, Jul 8, 2020 at 10:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/8/20 7:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Havard,
> >
> > On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> >> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
> >> Management Controllers in servers. While the family includes four SoCs=
,
> >> this patch implements limited support for two of them: NPCM730 (target=
ed
> >> for Data Center applications) and NPCM750 (targeted for Enterprise
> >> applications).
> >>
> >> This patch includes little more than the bare minimum needed to boot a
> >> Linux kernel built with NPCM7xx support in direct-kernel mode:
> >>
> >>   - Two Cortex-A9 CPU cores with built-in periperhals.
> >>   - Global Configuration Registers.
> >>   - Clock Management.
> >>   - 3 Timer Modules with 5 timers each.
> >>   - 4 serial ports.
> >>
> >> The chips themselves have a lot more features, some of which will be
> >> added to the model at a later stage.
> [...]
>
> >> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    NPCM7xxState *s =3D NPCM7XX(dev);
> >> +    NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
> >> +    Error *err =3D NULL;
> >> +    int i;
> >> +
> >> +    /* I/O space -- unimplemented unless overridden below. */
> >> +    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7X=
X_MMIO_SZ);
> >
> > I still insist this is not the best, but as "The data sheet for these
> > SoCs is not generally available" there is not much I can suggest to
> > improve.
>
> From your other comment I found:
>
> https://github.com/Nuvoton-Israel/bootblock/blob/master/SWC_HAL/Chips/npc=
m750/npcm750.h
>
> In particular:
>
> #define AHB1_BASE_ADDR                  0xF0000000      /* AHB1
> allocation (Including APB allocations)  */
> #define AHB18_BASE_ADDR                 0x80000000      /* AHB18
> allocation  */
> #define AHB3_BASE_ADDR                  0xA0000000      /* AHB3
> allocation  */
> #define XBUSR_BASE_ADDR                 0xC0002000      /* XBUS
> registers  */
> #define AHB14_BASE_ADDR                 0xE0000000      /* AHB14
> Allocation  */
> #define APB14_BASE_ADDR                 0xE0000000      /* APB14
> Allocation  */
> #define VDMX_BASE_ADDR                  0xE0800000      /* VDMX  */
>
> XBUS doesn't seem important.
>
> If SPI flashes aren't connected, returning bus transaction sounds
> correct:
>
> #define SPI0CS0_BASE_ADDR               0x80000000      /* SPI0 direct
> access CS0  */
> #define SPI0CS1_BASE_ADDR               0x88000000      /* SPI0 direct
> access CS1  */
> #define SPI0CS2_BASE_ADDR               0x90000000      /* SPI0 direct
> access CS2  */
> #define SPI0CS3_BASE_ADDR               0x98000000      /* SPI0 direct
> access CS3  */
>
> #define SPI3CS0_BASE_ADDR               0xA0000000      /* SPI3 direct
> access CS0  */
> #define SPI3CS1_BASE_ADDR               0xA8000000      /* SPI3 direct
> access CS1  */
> #define SPI3CS2_BASE_ADDR               0xB0000000      /* SPI3 direct
> access CS2  */
> #define SPI3CS3_BASE_ADDR               0xB8000000      /* SPI3 direct
> access CS3  */
>
> So I'd prefer you use:
>
>   create_unimplemented_device("npcm7xx.AHB1",  0xf0000000, 256 * MiB);
>
> Maybe for the PCI root complex:
>
>   create_unimplemented_device("npcm7xx.AHB14", 0xe0000000, 256 * MiB);
>
> What do you think?

I went ahead and added them all since they are all defined in that
public file. It does make the -d unimp output a lot more helpful.

I'll send v5 tonight. Not sure if I got the DRAM stuff 100% right.
Please let me know what you think.

Havard

