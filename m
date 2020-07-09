Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26614C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E292B2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfdGahAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E292B2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jta4S-00049t-2b
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jta3c-0002x6-QI
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:10:00 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:32775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jta3a-0002cj-NG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:10:00 -0400
Received: by mail-vs1-xe41.google.com with SMTP id u133so1508553vsc.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oWgx/HXjd5VuWIsM/+lPXPhN2h9TrQ0jlUJlxiNqTTA=;
 b=OfdGahAlbLmlOCZtXS8KB+fM9hpNrgIJuQ7q/dAJ0IuBsfLq0rfi9sTBVI3nW7/Xvv
 95AdYyzksUZui11wOvNsGOkR8zb/OmG/mbdjKUAYGGSGJW3B9d4r5rpidAzhx8OcE7Z4
 YPTly7856bfzqMJrKfTeLWZmJXozH+RmHq5eel3J41ozhjeOxKGF+RBWFsG4homlKHeu
 XCgpJ8i+8uTm8iMY35VdtxDMXEDUyPnXglhZj0mWQly9fCHX/gizt1KJ0NdK3rx89R8X
 QPREHrFlSye7L4lN1rkDWjdZzo/Vpb0sArVE9EtrQlvwZaMGSO50dhHcI9WkZlbuqOUB
 XklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oWgx/HXjd5VuWIsM/+lPXPhN2h9TrQ0jlUJlxiNqTTA=;
 b=FTT120ix4BmYqFRKVHs3VaSjMyVcqSwRHr6lLdYyic7a+UfNRdMuK5QGheI7X+hIpX
 eKUJxIk4R4H5ldtiwYiUH8v9TASpTYJ+om8MuN9j/y4HYluaPG2V3Fapa7eGjdXrQNg/
 bItfyeDvmlFHkzVBpIGL7iAkCtc/6cZ2nM9V6TmLZwVlX/rfNk23L799HL+IjOJhEu44
 ygsk//uW2qRpqeoSYaIR97Z6hUY4/SyiPALQEI4akkt/zGj5Dh2kFMuTHBtMXcmgh3Dn
 X8d9l4WfVDY7dPhb6kM5u3XpyI4OV7d6QLPb+HuWWdI/kuTYFTQhtWXtWpj6Y23uvIYc
 OPpA==
X-Gm-Message-State: AOAM53389WO2vcywl8TEjCWX+RB9uqHBpvBEPlVcCiSSr0lDWyW+kHXn
 KgeiuKFWpFKWB4S/lGQUvGEconWvLG1D2Zn8/Pu0HQ==
X-Google-Smtp-Source: ABdhPJymgopyJXkhTmqWErmhAbej2EY/ejRNVRzVuvpa/hWQq4OoI6MLRV2bcYmbOw8BR+WqfuNiuZSythOFoQcl4RA=
X-Received: by 2002:a67:d88c:: with SMTP id f12mr46990229vsj.92.1594314596019; 
 Thu, 09 Jul 2020 10:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
 <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
 <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
 <bd2972b0-0684-e379-6d66-16ceb62deade@amsat.org>
In-Reply-To: <bd2972b0-0684-e379-6d66-16ceb62deade@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 9 Jul 2020 10:09:44 -0700
Message-ID: <CAFQmdRbHXhd9-HUQP5ET=JQEnQ3FMCQBHajwZrP5d7=iCc0tzA@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Thu, Jul 9, 2020 at 9:23 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 7/9/20 8:43 AM, Havard Skinnemoen wrote:
> > On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> >>> Implement a device model for the System Global Control Registers in t=
he
> >>> NPCM730 and NPCM750 BMC SoCs.
> >>>
> >>> This is primarily used to enable SMP boot (the boot ROM spins reading
> >>> the SCRPAD register) and DDR memory initialization; other registers a=
re
> >>> best effort for now.
> >>>
> >>> The reset values of the MDLR and PWRON registers are determined by th=
e
> >>> SoC variant (730 vs 750) and board straps respectively.
> >>>
> >>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> >>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> >>> ---
> [...]
> >>> diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
> >>> new file mode 100644
> >>> index 0000000000..9934cd238d
> >>> --- /dev/null
> >>> +++ b/hw/misc/npcm7xx_gcr.c
> >>> @@ -0,0 +1,226 @@
> >>> +/*
> >>> + * Nuvoton NPCM7xx System Global Control Registers.
> >>> + *
> >>> + * Copyright 2020 Google LLC
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or mod=
ify it
> >>> + * under the terms of the GNU General Public License as published by=
 the
> >>> + * Free Software Foundation; either version 2 of the License, or
> >>> + * (at your option) any later version.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> >>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> >>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Lice=
nse
> >>> + * for more details.
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +
> >>> +#include "hw/misc/npcm7xx_gcr.h"
> >>> +#include "hw/qdev-properties.h"
> >>> +#include "migration/vmstate.h"
> >>> +#include "qapi/error.h"
> >>> +#include "qemu/log.h"
> >>> +#include "qemu/module.h"
> >>> +#include "qemu/units.h"
> >>> +
> >>> +#include "trace.h"
> >>> +
> >>> +static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] =3D {
> >>> +    [NPCM7XX_GCR_PDID]          =3D 0x04a92750,   /* Poleg A1 */
> >>> +    [NPCM7XX_GCR_MISCPE]        =3D 0x0000ffff,
> >>> +    [NPCM7XX_GCR_SPSWC]         =3D 0x00000003,
> >>> +    [NPCM7XX_GCR_INTCR]         =3D 0x0000035e,
> >>> +    [NPCM7XX_GCR_HIFCR]         =3D 0x0000004e,
> >>> +    [NPCM7XX_GCR_INTCR2]        =3D (1U << 19),   /* DDR initialized=
 */
> >>> +    [NPCM7XX_GCR_RESSR]         =3D 0x80000000,
> >>> +    [NPCM7XX_GCR_DSCNT]         =3D 0x000000c0,
> >>> +    [NPCM7XX_GCR_DAVCLVLR]      =3D 0x5a00f3cf,
> >>> +    [NPCM7XX_GCR_SCRPAD]        =3D 0x00000008,
> >>> +    [NPCM7XX_GCR_USB1PHYCTL]    =3D 0x034730e4,
> >>> +    [NPCM7XX_GCR_USB2PHYCTL]    =3D 0x034730e4,
> >>> +};
> >>> +
> >>> +static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsign=
ed size)
> >>> +{
> >>> +    uint32_t reg =3D offset / sizeof(uint32_t);
> >>> +    NPCM7xxGCRState *s =3D opaque;
> >>> +
> >>> +    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of ran=
ge\n",
> >>> +                      __func__, (unsigned int)offset);
> >>
> >> Maybe use HWADDR_PRIx instead of casting to int?
> >
> > Will do, thanks!
>
> Glad you are not annoyed by my review comments.
>
> FYI your series quality is in my top-4 "adding new machine to QEMU".
> I'd like to use it as example to follow.
>
> I am slowly reviewing because this is not part of my work duties,
> so I do that in my free time before/after work, which is why I can
> barely do more that 2 per day, as I have to learn the SoC and
> cross check documentation (or in this case, existing firmware code
> since there is no public doc).

Your feedback is super valuable, thanks a lot. I really appreciate it.

>
> [...]
> >>> +static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
> >>> +{
> >>> +    NPCM7xxGCRState *s =3D NPCM7XX_GCR(dev);
> >>> +    uint64_t dram_size;
> >>> +    Error *err =3D NULL;
> >>> +    Object *obj;
> >>> +
> >>> +    obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err);
> >>> +    if (!obj) {
> >>> +        error_setg(errp, "%s: required dram-mr link not found: %s",
> >>> +                   __func__, error_get_pretty(err));
> >>> +        return;
> >>> +    }
> >>> +    dram_size =3D memory_region_size(MEMORY_REGION(obj));
> >>> +
> >>> +    /* Power-on reset value */
> >>> +    s->reset_intcr3 =3D 0x00001002;
> >>> +
> >>> +    /*
> >>> +     * The GMMAP (Graphics Memory Map) field is used by u-boot to de=
tect the
> >>> +     * DRAM size, and is normally initialized by the boot block as p=
art of DRAM
> >>> +     * training. However, since we don't have a complete emulation o=
f the
> >>> +     * memory controller and try to make it look like it has already=
 been
> >>> +     * initialized, the boot block will skip this initialization, an=
d we need
> >>> +     * to make sure this field is set correctly up front.
> >>> +     *
> >>> +     * WARNING: some versions of u-boot only looks at bits 8 and 9, =
so 2 GiB or
> >>> +     * more of DRAM will be interpreted as 128 MiB.
> >>
> >> I'd say u-boot is right in wrapping at 2GB, as more DRAM is
> >> un-addressable.
> >
> > Ah, maybe I shouldn't have said "or more". The bug is that if you
> > specify _exactly_ 2GiB, u-boot will see 128 MiB.
> >
> > But I agree more than 2GiB doesn't make sense, so I'll add a check for =
that.
> >
> > Not sure if I agree that the check should be here. > 2 GiB is an
> > addressing limitation, and the GCR module shouldn't really know what
> > the SoC's address space looks like. The lower limit is because the GCR
> > module can't encode anything less than 128 MiB.
> >
> >>> +     *
> >>> +     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb=
5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
> >>> +     */
> >>> +    if (dram_size >=3D 2 * GiB) {
> >>
> >> See my comment in this series on the machine patch.
> >>
> >>> +        s->reset_intcr3 |=3D 4 << 8;
> >>> +    } else if (dram_size >=3D 1 * GiB) {
> >>> +        s->reset_intcr3 |=3D 3 << 8;
> >>> +    } else if (dram_size >=3D 512 * MiB) {
> >>> +        s->reset_intcr3 |=3D 2 << 8;
> >>> +    } else if (dram_size >=3D 256 * MiB) {
> >>> +        s->reset_intcr3 |=3D 1 << 8;
> >>> +    } else if (dram_size >=3D 128 * MiB) {
> >>> +        s->reset_intcr3 |=3D 0 << 8;
>
> I think this can be simplified as:
>
>          s->reset_intcr3 =3D (4 - clz32(dram_size)) << 8;
>
> Which implicitly truncate to power of 2 (which is what this
> block does, as you can have only 1 bank managed per this SGC).

Good idea. I find this a little easier to understand though:

#define NPCM7XX_GCR_MIN_DRAM_SIZE   (128 * MiB)

    s->reset_intcr3 |=3D ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;

> But checking is_power_of_2(dram_size) and reporting an error
> else, is probably even better.

OK, I'll add a check for this, and also explicit checks for too large
and too small. The former is currently redundant with the DRAM size
check I'm adding to npcm7xx_realize(), but I kind of like the idea of
checking for encoding limitations and addressing limitations
separately, as they may not necessarily stay the same forever.

> >>> +    } else {
> >>> +        error_setg(errp,
> >>> +                   "npcm7xx_gcr: DRAM size %" PRIu64
> >>> +                   " is too small (need 128 MiB minimum)",
> >>> +                   dram_size);
> >>
> >> Ah, so you could add the same error for >2GB. Easier.
> >>
> >> Preferably using HWADDR_PRIx, and similar error for >2GB:
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

