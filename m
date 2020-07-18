Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA388C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 02:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87B62074B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 02:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxOCZxG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87B62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwcQz-0004bi-V5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 22:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jwcQK-00044J-D5
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 22:18:00 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:37716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jwcQI-0001St-Iy
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 22:18:00 -0400
Received: by mail-vs1-xe41.google.com with SMTP id p25so5814549vsg.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 19:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bT4jbb2ulW7Wd6Espc2xduoQRokWofllPb5ImnfoCEE=;
 b=GxOCZxG8zVUn+Jdcf9kKOl5bz6CyZULqVZ/xXYD1n9ix8bGXLX3VvOl6GrHR5fa1CJ
 3XHCRYUrlbQThqJa/FuIb/sdkkvmWyJ+xw52+Wmi1juF8IKt1mGP+DQb2kLHupozVpuU
 tuZ7wREz2sg/VhrRh3NEDuy/sANU3wGaOTyMXse5Wm0fSqAcv6OOJNhdWiTn0u/7hBss
 a/458pFLi512N6rDlZQxJ3aYozo4gBMb1bQc6GMKErC/61+0d0rUkp5aXPClEaIjGG4R
 zsbiEbYhl+DyI/rfAxIhVROeg9ukUCMEUV03MWKZ1/9AdMeJ96gU9XS8E3uCOW4gU9wX
 eX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bT4jbb2ulW7Wd6Espc2xduoQRokWofllPb5ImnfoCEE=;
 b=K233rq5imszMx1Z+yJWJUgVqGQFS6AnVN53h0M5FUlEmvQWmUhYRjHnVxVqwk6GCtw
 k2qfBdJV1azmdqSYsXzNdZ3jmzhYKvr6fwHUMqHNBY0zuemRPZeuqjf3ZUQE84R4YsB4
 DSqU8PpQ9PYyfv6udF50y0ipAvC2F5bpnHYwwBWBNwt8lHdtXlQi1Ar8dHBxpvV1Wz9d
 1/gPA0iaVEuBqx/IdvJPNV9sfvbfIgszqV9Axf3mybqeUulSoOn8vgSFWoyTSMO14g04
 VSoOoUv0V3EKgjcVXN/tqClhHjcqGaoTfH/iaKB3NnhnEifoxUNor4TghY7rpe6NR6nn
 aqEg==
X-Gm-Message-State: AOAM531XD5y2F+SZzgNA8tDki725zl24tviKR02ILqh4gcuKu2r96eX3
 SHumgYm78PhLQ/FLiZVIcnC+k5BolHuFGjHRIMEtoA==
X-Google-Smtp-Source: ABdhPJybb5w3MsRD/5aCJcWI6VyCp9mA23EBdP6qg8QfP1wiNy/oz3tYpf3gnktTDumg74JIaa4p+yohYpZBLJz2PpI=
X-Received: by 2002:a67:e0c3:: with SMTP id m3mr9956094vsl.1.1595038677017;
 Fri, 17 Jul 2020 19:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <686266f7-c19e-918c-6df4-02f470506446@kaod.org>
In-Reply-To: <686266f7-c19e-918c-6df4-02f470506446@kaod.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 17 Jul 2020 19:17:45 -0700
Message-ID: <CAFQmdRZN5DW_NkovyV3DWDuOQoObga4efrgNDxuFeRVZV+nELQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
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

On Fri, Jul 17, 2020 at 1:32 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
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
>
> I think this series is ready to go.
>
> Patch 6 "roms: Add virtual Boot ROM for NPCM7xx SoCs" needs a few
> add-ons which can come later.
>
> Patch 13 "tests/acceptance: console boot tests for quanta-gsj" needs
> an Acked-by by our test gurus. Aspeed needs the same kind of tests
> if possible. It depends on the pressure that the QEMU CI will put on
> the web servers hosting the images.

Hmm, I didn't expect this to be a problem when hosting the images on github=
...?

> I think that the rest of the comments are minor and can be fixed
> as follow-ups when 5.2 is being assembled.

Great! Thanks a lot for reviewing and testing.

I've incorporated the feedback I got today, but I'm keeping them as
separate commits for now. I can either fold them into a v7 series or
post them as follow-ups.

Thanks!

Havard

