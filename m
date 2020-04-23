Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135FEC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADF62077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADF62077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39971 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYNV-0003Oh-1Z
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jRYMb-0002Wt-A3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jRYMa-0001xA-Rb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:41:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jRYMY-0001ut-Vk; Thu, 23 Apr 2020 05:41:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id g14so4941147otg.10;
 Thu, 23 Apr 2020 02:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0xshtJGFmIVpnTFVR1yoPS4cLrAg5tMlLKvvDBmyaBo=;
 b=F/6NkKUWHzfro7TRRrjXexMtA912l6kc60qelB2UW2Xka6XCN7JFM/RREZcJyKgobl
 F3JOSaeQ4brT3O0OV4KgMnBJikyTNZAgFgG4/j5n8pnu3BM+Gd526NBfF7AXYF46LbUS
 stFXZCq4+QfUwps3eeEJD819w7fQHS0SLoHVVWPVqjrDlsaoFIzEzF+U/uxrhVjvh3mY
 x39/Qla1IIRrt3WLFFtIGte/0CjezIuvtzA2OFZMELYIsOAGNO4BcLhhwoP6u+xpwLNZ
 /KHDd1Znr1VR5+Yy57cxG6h2FAyEClc2bkKVTDt0jxfaR6bIMn8JUmh6gZ3BawTEl3sI
 b2CA==
X-Gm-Message-State: AGi0PuaM2qqCxjObmQA+WmuCaFigVoLQAXAqu1Rit7mFsUTLXYiJZre9
 v1H9RzEgtU+DpvNXfOq2ea82CMDRSTJceJ2r7mg=
X-Google-Smtp-Source: APiQypKTQ38CBvNiS1ye67LjCvLSobpQz2r7lRaV8eZql0rvRTNiYFUv9xr52OJnF3F+KkW9Y9d08tEkvTKshSMobHg=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr2367854oig.54.1587634901058; 
 Thu, 23 Apr 2020 02:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200423090118.11199-1-geert+renesas@glider.be>
 <20200423090118.11199-4-geert+renesas@glider.be>
 <5dbfd026-3807-b122-ce60-1339a5252fca@amsat.org>
In-Reply-To: <5dbfd026-3807-b122-ce60-1339a5252fca@amsat.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2020 11:41:29 +0200
Message-ID: <CAMuHMdWf2RfGvSizXKonmAB84kPyAPwZ3mF1PayK_mdn=wwRkw@mail.gmail.com>
Subject: Re: [PATCH QEMU v2 3/5] Add a GPIO backend using libgpiod
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.65;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-ot1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:41:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 209.85.210.65
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Bartosz Golaszewski <bartekgola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Thanks for your comments!

On Thu, Apr 23, 2020 at 11:28 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 4/23/20 11:01 AM, Geert Uytterhoeven wrote:
> > Add a GPIO controller backend, to connect virtual GPIOs on the guest to
> > physical GPIOs on the host.  This allows the guest to control any
> > external device connected to the physical GPIOs.
> >
> > Features and limitations:
> >   - The backend uses libgpiod on Linux,
> >   - For now only GPIO outputs are supported,
> >   - The number of GPIO lines mapped is limited to the number of GPIO
> >     lines available on the virtual GPIO controller.
> >
> > Future work:
> >   - GPIO inputs,
> >   - GPIO line configuration,
> >   - Optimizations for controlling multiple GPIO lines at once,
> >   - ...
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- /dev/null
> > +++ b/backends/gpiodev.c
> > @@ -0,0 +1,94 @@
> > +/*
> > + * QEMU GPIO Backend
> > + *
> > + * Copyright (C) 2018-2020 Glider bv
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include <errno.h>
>
> <errno.h> probably not needed.

It is indeed included by one of the other header files.
What is the QEMU policy w.r.t. that?

>
> > +#include <gpiod.h>
>
> Please move this one...
>
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/config-file.h"
> > +#include "qemu/cutils.h"

I forgot to remove the two above...

> > +#include "qemu/error-report.h"
> > +#include "qemu/module.h"
> > +#include "qemu/option.h"

... and the two above.

> > +#include "qapi/error.h"
> > +
> > +#include "sysemu/gpiodev.h"
> > +
> > +#include "hw/irq.h"
> > +#include "hw/qdev-core.h"
>
> ... here:
>
> #include <gpiod.h>

OK.

> > --- a/configure
> > +++ b/configure
> > @@ -509,6 +509,7 @@ libpmem=3D""
> >  default_devices=3D"yes"
> >  plugins=3D"no"
> >  fuzzing=3D"no"
> > +gpio=3D""
>
> Maybe name this feature 'libgpiod'?

Makes sense.

> >
> >  supported_cpu=3D"no"
> >  supported_os=3D"no"
> > @@ -1601,6 +1602,10 @@ for opt do
> >    ;;
> >    --gdb=3D*) gdb_bin=3D"$optarg"
> >    ;;
> > +  --disable-gpio) gpio=3D"no"
> > +  ;;
> > +  --enable-gpio) gpio=3D"yes"
>
> Ditto: --enable-libgpiod, because else it seems rather confusing.

OK.

> > --- /dev/null
> > +++ b/include/sysemu/gpiodev.h
> > @@ -0,0 +1,12 @@
> > +/*
> > + * QEMU GPIO Backend
> > + *
> > + * Copyright (C) 2018-2020 Glider bv
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/typedefs.h"
>
> "qemu/typedefs.h" not needed in includes.

While removing that works, it does mean the header file is no longer
self-contained:

include/sysemu/gpiodev.h:10:23: error: unknown type name =E2=80=98DeviceSta=
te=E2=80=99

> > +
> > +void qemu_gpiodev_add(DeviceState *dev, const char *name, unsigned int=
 maxgpio,
> > +                      Error **errp);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

