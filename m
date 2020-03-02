Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81064C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5AF21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6qYTj3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5AF21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8v6p-0005Tn-G8
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j8v64-0004s9-2O
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j8v62-0006x8-HO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:07:40 -0500
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:34961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j8v62-0006wX-BT; Mon, 02 Mar 2020 19:07:38 -0500
Received: by mail-vs1-xe43.google.com with SMTP id u26so1245979vsg.2;
 Mon, 02 Mar 2020 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pxmi9V+EV7M2r8A2RvtIR6kdq4BRtjt6KmNSkeUEWE0=;
 b=G6qYTj3ziRpSUNU69U+vs7hJzRt7wIhbnuQlB3FiQmNhoB7v/X1Rmpa+XHuJJSvCla
 irc6M4jMJvNZemJf9FIOD+7IxznR5e2tYZJa6m4cZJRLeseOEBF/9L2BIuAYkVKH8eUK
 sXxrijztS9zYXAFMZtjY6z0oMVIUcenY2G2Wws7uGgSLpHthHtdkdgAK+5QRol8oCa/y
 l/PQMde6jaYOtxYodIot6y7z+0x9QPVEtQaJJO4Bg823LguntqJ/U1s+JVgFkRMVjuEY
 fpF5ZK8guLsXF3S+mun2s7C+rgXvzsGChw4Rq5khF2JjMyajNtUdM0NORnDaCb7S9cLc
 KK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pxmi9V+EV7M2r8A2RvtIR6kdq4BRtjt6KmNSkeUEWE0=;
 b=bwsfMQZM88luu8k//7+X9clncTJDnlfjw6qowpXx39Nl8+w1R3v/SmesNJfG/2Z37p
 uryCxej4+JCFz2vQTgqxqBUmdTdHcTCbS5CG4j5bYk8+8e/fO/2FKe5BO/Wk5d6Ev5Uf
 hlCfPFBzQbSLOHZYTk0lbueL88QocRQg30DPfUQpHHsBGVgg4TZLUhw0f+0XcURCzkTp
 Ub3kn8niQ2nhBs/ieu8DHcySDsnB0URtPThIkVf8FtlzN6yIkZ7z5liT/h8mKsc11XnW
 cjGCUokSCbd1JTdiEEw053Ka6/mO6hB05TD4bezgDlROx4RzYmEPmhpmzWIqBtJOTaCW
 XoEQ==
X-Gm-Message-State: ANhLgQ2kB1G0FccGyRxijSCqJmomoVK/LKEJqa2N1OqV29fHGiCvOBjm
 QagWviMzj3oGMSDJTJ3sFEbBwRUK4YWYOEcGZxM=
X-Google-Smtp-Source: ADFU+vsYKpSaEIaT6xzbhR7HuWJCMsMB9vH1Xv8kh/nW1oGiRPXb7ML3KKPFV7S+0Gh+9HnPSc69znWbWo+grpHZn1M=
X-Received: by 2002:a05:6102:3c2:: with SMTP id
 n2mr966350vsq.172.1583194056784; 
 Mon, 02 Mar 2020 16:07:36 -0800 (PST)
MIME-Version: 1.0
References: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKNw6bwiWKbT=0_Yy4CZNrnSjUtyU_TL0G2HMq1WKstK4g@mail.gmail.com>
 <CAEUhbmUi=6JyQhEeh0348XgDwhkybC-OJ+ErD=RrgrtS7dNsGg@mail.gmail.com>
In-Reply-To: <CAEUhbmUi=6JyQhEeh0348XgDwhkybC-OJ+ErD=RrgrtS7dNsGg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Mar 2020 15:59:58 -0800
Message-ID: <CAKmqyKO3imGENC7eOY9F+K_1B-qVQyzBC2xMqMBi9OGX2g7i3g@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sifive_u: Add a "serial" property for board
 serial number
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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

On Mon, Feb 24, 2020 at 9:02 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Tue, Feb 25, 2020 at 5:14 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Sun, Feb 16, 2020 at 5:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > At present the board serial number is hard-coded to 1, and passed
> > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > the serial number to generate a unique MAC address for the on-chip
> > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > created and connected to the same subnet, they all have the same
> > > MAC address hence it creates a unusable network.
> > >
> > > A new "serial" property is introduced to specify the board serial
> > > number. When not given, the default serial number 1 is used.
> > >
> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > > - Move setting OTP serial number property from riscv_sifive_u_soc_init()
> > >   to riscv_sifive_u_soc_realize(), to fix the 'check-qtest-riscv' error.
> > >   I am not really sure why doing so could fix the 'make check' error.
> > >   The v1 patch worked fine and nothing seems wrong.
> > >
> > >  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
> > >  include/hw/riscv/sifive_u.h |  1 +
> > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > index 0e12b3c..ca561d3 100644
> > > --- a/hw/riscv/sifive_u.c
> > > +++ b/hw/riscv/sifive_u.c
> > > @@ -34,6 +34,7 @@
> > >  #include "qemu/log.h"
> > >  #include "qemu/error-report.h"
> > >  #include "qapi/error.h"
> > > +#include "qapi/visitor.h"
> > >  #include "hw/boards.h"
> > >  #include "hw/loader.h"
> > >  #include "hw/sysbus.h"
> > > @@ -434,7 +435,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
> > >                            TYPE_SIFIVE_U_PRCI);
> > >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> > >                            TYPE_SIFIVE_U_OTP);
> > > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> > >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> > >                            TYPE_CADENCE_GEM);
> > >  }
> > > @@ -453,6 +453,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
> > >      s->start_in_flash = value;
> > >  }
> > >
> > > +static void sifive_u_get_serial(Object *obj, Visitor *v, const char *name,
> > > +                                void *opaque, Error **errp)
> > > +{
> > > +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> > > +}
> > > +
> > > +static void sifive_u_set_serial(Object *obj, Visitor *v, const char *name,
> > > +                                void *opaque, Error **errp)
> > > +{
> > > +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> >
> > This is a little confusing. Maybe it's worth adding a comment that
> > opaque is s->serial?
>
> Yes, I can add a comment.
>
> >
> > Either that or change opaque to be SiFiveUState *s and then access
> > serial via the struct.
>
> Do you mean something like this?
>
> Calling object_property_add() with opaque as NULL, not &s->serial:
>
> object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
>                         sifive_u_set_serial, NULL, NULL, NULL);
>
> Then in the sifive_u_get_serial() or sifive_u_set_serial(), replace
> opaque with RISCV_U_MACHINE(obj)->serial.
>
> Wow, it looks we have designed so flexible APIs :)
>
> >
> > > +}
> > > +
> > >  static void riscv_sifive_u_machine_instance_init(Object *obj)
> > >  {
> > >      SiFiveUState *s = RISCV_U_MACHINE(obj);
> > > @@ -464,11 +476,17 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
> > >                                      "Set on to tell QEMU's ROM to jump to " \
> > >                                      "flash. Otherwise QEMU will jump to DRAM",
> > >                                      NULL);
> > > +
> > > +    s->serial = OTP_SERIAL;
> > > +    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
> > > +                        sifive_u_set_serial, NULL, &s->serial, NULL);
> > > +    object_property_set_description(obj, "serial", "Board serial number", NULL);
> > >  }
> > >
> > >  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      MachineState *ms = MACHINE(qdev_get_machine());
> > > +    SiFiveUState *us = RISCV_U_MACHINE(ms);
> >
> > I don't think the Soc should access the machine like this. What if we
> > use this Soc on a different machine?
> >
>
> Yes, agree. The v1 patch does this in the riscv_sifive_u_init(), but
> it could not pass the "make check". See the changelog I mentioned. Do
> you know how to fix the "make check" properly? The issue is quite
> strange. The v1 patch worked perfectly OK and I did not observe any
> crash during my normal use, but with "make check" QEMU RISC-V crashes
> with the v1 patch.

I can reproduce the error and I have a fix. I'll send it as soon as I
finish testing.

Do you mind testing this branch:
https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_serial.next

Alistair

>
> > There should be a SoC "serial" property that is set before realise as well.
> >
>
> v1 patch: http://patchwork.ozlabs.org/patch/1196127/
>
> Regards,
> Bin

