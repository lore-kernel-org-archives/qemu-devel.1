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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7EEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B06A21556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOFRDONx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B06A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j93ti-00071b-7H
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j93sX-0006Sj-V9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j93sW-0003qL-9m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:30:17 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j93sW-0003q1-3u; Tue, 03 Mar 2020 04:30:16 -0500
Received: by mail-yw1-xc44.google.com with SMTP id 10so2752783ywv.5;
 Tue, 03 Mar 2020 01:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RBkYK0b4Jo7TJfxyF64+AtWQgf8FOwClva0H9lRrml4=;
 b=NOFRDONxJGmbQ92IGucWtyVDN4R7FnlvG45e/um865kQ1BLcGjfx/6VbR5oSKJyXRZ
 hs0fb4VFozDQpX81E7plWG8xABeQ9gDAvVM7nrARm96CIZXK+d40iy4H3y6BfmOY9cvH
 FW0TtIb6d/bcgXK4SXUuJtG1XcPmLFPLjIjAYQBisCdFLaVIZDovKlfWoLFBSyII9CUn
 vyynPuKboTcgjmUI96Se0Eh+m6UHveV3whO85HfvqsOSUapwHUt61iPF5GJGxEXpUgPN
 d1KtYcmpvsIzxcRj63DGX+6c6qlQyFAe8xbX0dpM2cd8yGHrauR5qZEzHlvmichmHXJ4
 oddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RBkYK0b4Jo7TJfxyF64+AtWQgf8FOwClva0H9lRrml4=;
 b=EBx/ju0iOCfxBm/R8HDtVzCB0cgXs8pzkdxUP+us/ISPyVopHuMq6kXsDvnebPGkq6
 upPJ6k9Mdv6JUGDZi0cs6dUvmOzaiy1nUxXUlJv5xCKY6hjKB7qmfdIY6+j/7mc/exRt
 LT/w1vr4uTfue5syAUnprijdIkGoYHuJ3a6zqBT7ULClHf4X8Tyj9UthUWGnjM+VF5Ay
 lQPHrj2vbgQOWMDfgPZbfNfgWgWHDNB6bcJdYYc9wdekBd0N76dO6XZHotBZYKN/0VOw
 8E4VslXU8AmyYcz1NqnzS/mMl2Dh770aanJOD+40PZA3EglH8MaDTPC+YVtglvf4apr/
 260w==
X-Gm-Message-State: ANhLgQ2N1yZ0xIr2OBEltADS5N8FZo4jb9n2XnrZCfawy179fykwCMZu
 8FXubYuFRD0UJYL9I6zetrESLZuLRo5dihOJirg=
X-Google-Smtp-Source: ADFU+vvC+NM9XzCwbQSsCa5JWniWxiy7BLV/Vb6Szt/g2J/ONpnA7zmbL20rXKDTeB5oEuB6g2dhd+7uoZaovIm2ljI=
X-Received: by 2002:a25:d5:: with SMTP id 204mr2897432yba.154.1583227814715;
 Tue, 03 Mar 2020 01:30:14 -0800 (PST)
MIME-Version: 1.0
References: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKNw6bwiWKbT=0_Yy4CZNrnSjUtyU_TL0G2HMq1WKstK4g@mail.gmail.com>
 <CAEUhbmUi=6JyQhEeh0348XgDwhkybC-OJ+ErD=RrgrtS7dNsGg@mail.gmail.com>
 <CAKmqyKO3imGENC7eOY9F+K_1B-qVQyzBC2xMqMBi9OGX2g7i3g@mail.gmail.com>
In-Reply-To: <CAKmqyKO3imGENC7eOY9F+K_1B-qVQyzBC2xMqMBi9OGX2g7i3g@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 3 Mar 2020 17:30:04 +0800
Message-ID: <CAEUhbmXsCegWiVHi4ygB-mS0Mu64Zsds42Ss29ojd0HtfGbk9A@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sifive_u: Add a "serial" property for board
 serial number
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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

On Tue, Mar 3, 2020 at 8:07 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 9:02 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Tue, Feb 25, 2020 at 5:14 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Sun, Feb 16, 2020 at 5:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > At present the board serial number is hard-coded to 1, and passed
> > > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > > the serial number to generate a unique MAC address for the on-chip
> > > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > > created and connected to the same subnet, they all have the same
> > > > MAC address hence it creates a unusable network.
> > > >
> > > > A new "serial" property is introduced to specify the board serial
> > > > number. When not given, the default serial number 1 is used.
> > > >
> > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > >
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Move setting OTP serial number property from riscv_sifive_u_soc_init()
> > > >   to riscv_sifive_u_soc_realize(), to fix the 'check-qtest-riscv' error.
> > > >   I am not really sure why doing so could fix the 'make check' error.
> > > >   The v1 patch worked fine and nothing seems wrong.
> > > >
> > > >  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
> > > >  include/hw/riscv/sifive_u.h |  1 +
> > > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > index 0e12b3c..ca561d3 100644
> > > > --- a/hw/riscv/sifive_u.c
> > > > +++ b/hw/riscv/sifive_u.c
> > > > @@ -34,6 +34,7 @@
> > > >  #include "qemu/log.h"
> > > >  #include "qemu/error-report.h"
> > > >  #include "qapi/error.h"
> > > > +#include "qapi/visitor.h"
> > > >  #include "hw/boards.h"
> > > >  #include "hw/loader.h"
> > > >  #include "hw/sysbus.h"
> > > > @@ -434,7 +435,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
> > > >                            TYPE_SIFIVE_U_PRCI);
> > > >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> > > >                            TYPE_SIFIVE_U_OTP);
> > > > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> > > >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> > > >                            TYPE_CADENCE_GEM);
> > > >  }
> > > > @@ -453,6 +453,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
> > > >      s->start_in_flash = value;
> > > >  }
> > > >
> > > > +static void sifive_u_get_serial(Object *obj, Visitor *v, const char *name,
> > > > +                                void *opaque, Error **errp)
> > > > +{
> > > > +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> > > > +}
> > > > +
> > > > +static void sifive_u_set_serial(Object *obj, Visitor *v, const char *name,
> > > > +                                void *opaque, Error **errp)
> > > > +{
> > > > +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> > >
> > > This is a little confusing. Maybe it's worth adding a comment that
> > > opaque is s->serial?
> >
> > Yes, I can add a comment.
> >
> > >
> > > Either that or change opaque to be SiFiveUState *s and then access
> > > serial via the struct.
> >
> > Do you mean something like this?
> >
> > Calling object_property_add() with opaque as NULL, not &s->serial:
> >
> > object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
> >                         sifive_u_set_serial, NULL, NULL, NULL);
> >
> > Then in the sifive_u_get_serial() or sifive_u_set_serial(), replace
> > opaque with RISCV_U_MACHINE(obj)->serial.
> >
> > Wow, it looks we have designed so flexible APIs :)
> >
> > >
> > > > +}
> > > > +
> > > >  static void riscv_sifive_u_machine_instance_init(Object *obj)
> > > >  {
> > > >      SiFiveUState *s = RISCV_U_MACHINE(obj);
> > > > @@ -464,11 +476,17 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
> > > >                                      "Set on to tell QEMU's ROM to jump to " \
> > > >                                      "flash. Otherwise QEMU will jump to DRAM",
> > > >                                      NULL);
> > > > +
> > > > +    s->serial = OTP_SERIAL;
> > > > +    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
> > > > +                        sifive_u_set_serial, NULL, &s->serial, NULL);
> > > > +    object_property_set_description(obj, "serial", "Board serial number", NULL);
> > > >  }
> > > >
> > > >  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > >      MachineState *ms = MACHINE(qdev_get_machine());
> > > > +    SiFiveUState *us = RISCV_U_MACHINE(ms);
> > >
> > > I don't think the Soc should access the machine like this. What if we
> > > use this Soc on a different machine?
> > >
> >
> > Yes, agree. The v1 patch does this in the riscv_sifive_u_init(), but
> > it could not pass the "make check". See the changelog I mentioned. Do
> > you know how to fix the "make check" properly? The issue is quite
> > strange. The v1 patch worked perfectly OK and I did not observe any
> > crash during my normal use, but with "make check" QEMU RISC-V crashes
> > with the v1 patch.
>
> I can reproduce the error and I have a fix. I'll send it as soon as I
> finish testing.
>
> Do you mind testing this branch:
> https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_serial.next
>

This seems to not adding "serial" as a property.

$ ./riscv64-softmmu/qemu-system-riscv64 -nographic -M sifive_u,help
sifive_u.start-in-flash=bool (Set on to tell QEMU's ROM to jump to
flash. Otherwise QEMU will jump to DRAM)
sifive_u.memory-backend=string (Set RAM backendValid value is ID of
hostmem based backend)
sifive_u.enforce-config-section=bool (Set on to enforce configuration
section migration)
sifive_u.initrd=string (Linux initial ramdisk file)
sifive_u.mem-merge=bool (Enable/disable memory merge support)
sifive_u.firmware=string (Firmware image)
sifive_u.dtb=string (Linux kernel device tree file)
sifive_u.suppress-vmdesc=bool (Set on to disable self-describing migration)
sifive_u.usb=bool (Set on/off to enable/disable usb)
sifive_u.kernel=string (Linux kernel image file)
sifive_u.dt-compatible=string (Overrides the "compatible" property of
the dt root node)
sifive_u.memory-encryption=string (Set memory encryption object to use)
sifive_u.dumpdtb=string (Dump current dtb to a file and quit)
sifive_u.append=string (Linux kernel command line)
sifive_u.dump-guest-core=bool (Include guest memory in a core dump)
sifive_u.phandle-start=int (The first phandle ID we may generate dynamically)
sifive_u.graphics=bool (Set on/off to enable/disable graphics emulation)

$ ./riscv64-softmmu/qemu-system-riscv64 -nographic -M sifive_u,serial=2
qemu-system-riscv64: Insufficient permission to perform this operation

Regards,
Bin

