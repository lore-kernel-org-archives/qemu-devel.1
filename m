Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031FC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461892133F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461892133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWmt-0007C0-FB
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iHWju-0005gJ-RJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iHWjs-00039V-Ez
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iHWjs-00037L-61
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:24:04 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0050C51EE9
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 17:24:02 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w2so7899953wrn.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 10:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=esktorrmETKGJQnLtRmNYkpV0I20/H1qzqkxgYkgLj8=;
 b=JJ7F96K8bB05G8J7scmZi3ArqxvRQJbMqaalciiePI51yC4e9JtCXMmyJtwKuq6eoE
 IN6aNwwxynZMsKbkytlqV0NQrsOPHPHNsQWZCMqeWd21th+5eyorTqDjS5a2RONVbDFI
 QBspq4YSXa8+mgy1v+r3VCmQ4DHSeSZqVxwH5YJl+rFCpTPbg0xQbaz9loPbtiP3HPUd
 x1vkzFzY0fFssQdZaSwW998hK/Kmmnfnxj3mBZcrdOgxs9YUSTANQQVV1+tIxFSBwuzF
 xhBi+0e48jf5dUBGR7nXEFDxMIMVzim6aOnojx70L8a+ut3HdTn8cldEguLnlU8b6+QR
 rriw==
X-Gm-Message-State: APjAAAUXLb2CV4zJk0KimuQj1Hplad5NMxa726NUMX1614WYNwyhDfeF
 4mEQbyF4trFcOZZihOOKk+COwyMVLQ2/vZ9xi7kDIgolp36EEgkkgq/Jp5BKzxwe2tNiSn+oFKs
 v77Ghm/dxeRD4ZnSbkYELJq3BIhyichU=
X-Received: by 2002:a5d:440d:: with SMTP id z13mr5957050wrq.176.1570469040623; 
 Mon, 07 Oct 2019 10:24:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzci7BMUFPizPMDVGBL54KbV0sNFECELJralmJv8G3GamLN8U6JhzZBbI6EM+Td6ci70lx+7UXELUPkgjAw82s=
X-Received: by 2002:a5d:440d:: with SMTP id z13mr5957033wrq.176.1570469040384; 
 Mon, 07 Oct 2019 10:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-13-f4bug@amsat.org>
 <9a814d3e-0ae0-08a4-9d43-1d157712029f@redhat.com>
In-Reply-To: <9a814d3e-0ae0-08a4-9d43-1d157712029f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 7 Oct 2019 19:23:49 +0200
Message-ID: <CAP+75-XdU6ZhE+Yivg=VT8EmtRPHmV7J5owifYCh-jut1rioNA@mail.gmail.com>
Subject: Re: [PATCH 12/19] hw/arm/bcm2835_peripherals: Add Clock/Power/Reset
 Manager blocks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 1, 2019 at 11:51 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 9/26/19 7:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Add basic support for BCM283x CPRMAN. Provide support for reading and
> > writing CPRMAN registers and initialize registers with sensible default
> > values. During runtime retain any written values.
> >
> > Basic CPRMAN support is necessary and sufficient to boot Linux on raspi=
2
> > and raspi3 systems.
> >
> > Based on:
> > https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/clk/bcm/clk=
-bcm2835.c
> > https://github.com/u-boot/u-boot/blob/v2019.07/include/dt-bindings/cloc=
k/bcm2835.h
> > https://github.com/arisena-com/rpi_src/blob/master/apps/i2s_test/src/i2=
s_test.c#L273
> >
> > Co-developed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   hw/arm/bcm2835_peripherals.c         |  20 +-
> >   hw/misc/Makefile.objs                |   1 +
> >   hw/misc/bcm2835_cprman.c             | 383 ++++++++++++++++++++++++++=
+
> >   hw/misc/trace-events                 |   8 +
> >   include/hw/arm/bcm2835_peripherals.h |   4 +-
> >   include/hw/misc/bcm2835_cprman.h     |  32 +++
> >   6 files changed, 444 insertions(+), 4 deletions(-)
> >   create mode 100644 hw/misc/bcm2835_cprman.c
> >   create mode 100644 include/hw/misc/bcm2835_cprman.h
> >
> > diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> > new file mode 100644
> > index 0000000000..6c3b5b6837
> > --- /dev/null
> > +++ b/hw/misc/bcm2835_cprman.c
> > @@ -0,0 +1,383 @@
> > +/*
> > + * BCM2835 Clock/Power/Reset Manager subsystem (poor man's version)
> > + *
> > + * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
> > + * Copyright (C) 2018 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "sysemu/runstate.h"
> > +#include "hw/registerfields.h"
> > +#include "hw/misc/bcm2835_cprman.h"
> > +#include "trace.h"
> > +
> > +#define CPRMAN_PASSWD 'Z'
> > +
> > +FIELD(CPRMAN, PASSWD,   24, 8)
> > +
[...]
> > +REG32(A2W_PLL_CTRL, 0x00)
> > +FIELD(A2W_PLL_CTRL, NDIV,                   0, 12)
> > +FIELD(A2W_PLL_CTRL, PDIV,                   12, 3)
> > +FIELD(A2W_PLL_CTRL, POWER_DOWN,             16, 1)
> > +FIELD(A2W_PLL_CTRL, POWER_RESET_DISABLE,    17, 1)
> > +
> > +REG32(A2W_PLL_ANA0, 0x10)
> > +
> > +FIELD(A2W_PLL_FRAC, DIV,                    0, 20)
> > +
> > +FIELD(A2W_PLL_CHAN, DIV,                    0, 8)
> > +FIELD(A2W_PLL_CHAN, DISABLE,                8, 1)
> > +
> > +static const char *a2w_name(hwaddr addr)
> > +{
> > +    if (addr >=3D 0x300) {
> > +        return "CHANx";
> > +    }
> > +    if (addr >=3D 0x200) {
> > +        return "FRACx";
> > +    }
> > +    switch (addr & 0x1f) {
> > +    case A_A2W_PLL_CTRL:
> > +        return "CTRL";
> > +    case A_A2W_PLL_ANA0:
> > +        return "ANA0";
> > +    default:
> > +        return "UNKN";
> > +    }
> > +}
> > +
> > +static const char *pll_name(int idx)
> > +{
> > +    static const char *pll_names[8] =3D {
> > +        [0] =3D "PLLA",
> > +        [1] =3D "PLLC",
> > +        [2] =3D "PLLD",
> > +        [3] =3D "PLLH",
> > +        [7] =3D "PLLB",
> > +    };
> > +    return pll_names[idx] ? pll_names[idx] : "UNKN";
> > +}
> > +
> > +static uint64_t bcm2835_cprman_a2w_read(void *opaque, hwaddr addr,
> > +                                        unsigned size)
> > +{
> > +    uint32_t res =3D 0;
> > +
> > +    if (addr < 0x200) {
> > +        /* Power */
> > +        switch (addr & 0x1f) {
> > +        case A_A2W_PLL_CTRL:
> > +            res =3D R_A2W_PLL_CTRL_POWER_DOWN_MASK; /* On */

This should be R_A2W_PLL_CTRL_POWER_RESET_DISABLE_MASK.

> > +            break;
> > +        case A_A2W_PLL_ANA0:
> > +            break;
> > +        }
> > +    } else {
> > +        /* addr < 0x300 is FREQ, else CHANNEL */
> > +        qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n"=
,
> > +                      __func__, addr);
> > +    }
> > +    trace_bcm2835_cprman_read(size << 3, addr, "A2W", a2w_name(addr),
> > +                              pll_name((addr >> 5) & 7), res);
> > +
> > +    return res;
> > +}
> > +
> > +static void bcm2835_cprman_a2w_write(void *opaque, hwaddr addr,
> > +                                     uint64_t value, unsigned size)
> > +{
> > +    if (FIELD_EX32(value, CPRMAN, PASSWD) !=3D CPRMAN_PASSWD) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w=
%02d"
> > +                                       " *0x%04"HWADDR_PRIx" =3D 0x%"P=
RIx64"\n",
> > +                      size << 3, addr, value);
> > +        return;
> > +    }
> > +    value &=3D ~R_CPRMAN_PASSWD_MASK;
> > +
> > +    trace_bcm2835_cprman_write_a2w(addr, a2w_name(addr),
> > +                                   pll_name((addr >> 5) & 7), value);
> > +}
> > +
> > +static const MemoryRegionOps bcm2835_cprman_a2w_ops =3D {
> > +    .read =3D bcm2835_cprman_a2w_read,
> > +    .write =3D bcm2835_cprman_a2w_write,
> > +    .impl.max_access_size =3D 4,
> > +    .valid.min_access_size =3D 4,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
[...]

