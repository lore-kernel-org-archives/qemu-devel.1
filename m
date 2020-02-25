Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A5C35DF2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 05:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CC424683
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOZUUmA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CC424683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6SNY-0002oE-TG
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 00:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j6SMx-0002MT-F5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j6SMt-0006QZ-8g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:02:55 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j6SMt-0006QH-3U; Tue, 25 Feb 2020 00:02:51 -0500
Received: by mail-yw1-xc43.google.com with SMTP id 192so6648508ywy.0;
 Mon, 24 Feb 2020 21:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dUfWyb4cW6U+R2QC2dfg53WZphb8Myv6rhJaDKQEJgk=;
 b=ZOZUUmA6sHQEABEKQ4fj19bfsL7L4myVsCrsKcK6o98DdpAxeuXDJoN9Ix4l5juGQs
 JSGhG0u+twuqQkbnGkxK+c4G9O/AhxHT80n9Rl54VjA0yDE6WFXjuSUIhw0HMpDga5In
 sfLVoI+8zaB8h6cFT3jPB1nU8EKmINjeIG4sBt5tlfZ7fhS3W6nB/Q+sqi6iQPTbkjFo
 fcGUuEu7G3u9m80vZ9Hng9+O+uU+NSJRpat96WOWg7aLPuswhwxrQEnoEXdEtgKxlFbZ
 S/4g30boJ9EBug+InXkaj+e6bOamSgTD5wbfSB4L/vfbP9Gw8lOQuBS+DyKLZ9jsAhT1
 /SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dUfWyb4cW6U+R2QC2dfg53WZphb8Myv6rhJaDKQEJgk=;
 b=lnAYlQzqSyRA6BjXpBMG4afzGuioXxrd5Dp/HmQMn2atzCWYQ902t40SjGtmbVg22P
 fSdCPwR2HALOM8Tu3csu+nND3d0GvWJ/T2G5B048hVgv8cDIiwAQBecML/BQJsvz8AGh
 0h1mhFeYSlOikmzd8gNW1g3deIAEkg8+c4o67E/Tl4q0vPfTyQsDbfFqov+qJbi6WjeR
 BrAxvCaiKZx2Mvht2PHDR046C6Zwgmtp9OTV1y16Ddq4ewoYp36RQHKrvRJTgwqi4vfp
 DC3VNmZRJpWrTbjoa09WTQEZyPemQOdgMFhnlb8uKu0OWaXgv+LC1ixU5C3+30MSvb2j
 Tyfw==
X-Gm-Message-State: APjAAAWh1g3M8Y8P+VUGcc77HdMqGdTiU5SZzSLNcrLNNw9pZ5xr8Eb3
 yIU+SSl5JgXM8X1h4XQkuACsi5ug1PyyjpPFbyo=
X-Google-Smtp-Source: APXvYqwAEPF9s5j2iNNINrs6oBxCSRd3s7TJKCLtzqcFnBvAlRe4GUd563EyxQ2rvYIJw4SjEX2y1sSfdha8QuHy4U0=
X-Received: by 2002:a25:38c2:: with SMTP id
 f185mr21580308yba.490.1582606970169; 
 Mon, 24 Feb 2020 21:02:50 -0800 (PST)
MIME-Version: 1.0
References: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKNw6bwiWKbT=0_Yy4CZNrnSjUtyU_TL0G2HMq1WKstK4g@mail.gmail.com>
In-Reply-To: <CAKmqyKNw6bwiWKbT=0_Yy4CZNrnSjUtyU_TL0G2HMq1WKstK4g@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 25 Feb 2020 13:02:39 +0800
Message-ID: <CAEUhbmUi=6JyQhEeh0348XgDwhkybC-OJ+ErD=RrgrtS7dNsGg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sifive_u: Add a "serial" property for board
 serial number
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Tue, Feb 25, 2020 at 5:14 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Sun, Feb 16, 2020 at 5:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > At present the board serial number is hard-coded to 1, and passed
> > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > the serial number to generate a unique MAC address for the on-chip
> > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > created and connected to the same subnet, they all have the same
> > MAC address hence it creates a unusable network.
> >
> > A new "serial" property is introduced to specify the board serial
> > number. When not given, the default serial number 1 is used.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > ---
> >
> > Changes in v2:
> > - Move setting OTP serial number property from riscv_sifive_u_soc_init()
> >   to riscv_sifive_u_soc_realize(), to fix the 'check-qtest-riscv' error.
> >   I am not really sure why doing so could fix the 'make check' error.
> >   The v1 patch worked fine and nothing seems wrong.
> >
> >  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
> >  include/hw/riscv/sifive_u.h |  1 +
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 0e12b3c..ca561d3 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -34,6 +34,7 @@
> >  #include "qemu/log.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > +#include "qapi/visitor.h"
> >  #include "hw/boards.h"
> >  #include "hw/loader.h"
> >  #include "hw/sysbus.h"
> > @@ -434,7 +435,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
> >                            TYPE_SIFIVE_U_PRCI);
> >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> >                            TYPE_SIFIVE_U_OTP);
> > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> >                            TYPE_CADENCE_GEM);
> >  }
> > @@ -453,6 +453,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
> >      s->start_in_flash = value;
> >  }
> >
> > +static void sifive_u_get_serial(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> > +}
> > +
> > +static void sifive_u_set_serial(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>
> This is a little confusing. Maybe it's worth adding a comment that
> opaque is s->serial?

Yes, I can add a comment.

>
> Either that or change opaque to be SiFiveUState *s and then access
> serial via the struct.

Do you mean something like this?

Calling object_property_add() with opaque as NULL, not &s->serial:

object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
                        sifive_u_set_serial, NULL, NULL, NULL);

Then in the sifive_u_get_serial() or sifive_u_set_serial(), replace
opaque with RISCV_U_MACHINE(obj)->serial.

Wow, it looks we have designed so flexible APIs :)

>
> > +}
> > +
> >  static void riscv_sifive_u_machine_instance_init(Object *obj)
> >  {
> >      SiFiveUState *s = RISCV_U_MACHINE(obj);
> > @@ -464,11 +476,17 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
> >                                      "Set on to tell QEMU's ROM to jump to " \
> >                                      "flash. Otherwise QEMU will jump to DRAM",
> >                                      NULL);
> > +
> > +    s->serial = OTP_SERIAL;
> > +    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
> > +                        sifive_u_set_serial, NULL, &s->serial, NULL);
> > +    object_property_set_description(obj, "serial", "Board serial number", NULL);
> >  }
> >
> >  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> >  {
> >      MachineState *ms = MACHINE(qdev_get_machine());
> > +    SiFiveUState *us = RISCV_U_MACHINE(ms);
>
> I don't think the Soc should access the machine like this. What if we
> use this Soc on a different machine?
>

Yes, agree. The v1 patch does this in the riscv_sifive_u_init(), but
it could not pass the "make check". See the changelog I mentioned. Do
you know how to fix the "make check" properly? The issue is quite
strange. The v1 patch worked perfectly OK and I did not observe any
crash during my normal use, but with "make check" QEMU RISC-V crashes
with the v1 patch.

> There should be a SoC "serial" property that is set before realise as well.
>

v1 patch: http://patchwork.ozlabs.org/patch/1196127/

Regards,
Bin

