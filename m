Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F58DC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 21:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0A321537
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 21:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7EGymSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0A321537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdhmb-0006e0-GX
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 17:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdhk0-0005Uq-IH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdhjz-0003dY-5B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:03:36 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdhjq-0003PS-0r; Wed, 19 Jun 2019 17:03:29 -0400
Received: by mail-lj1-x242.google.com with SMTP id m23so536250lje.12;
 Wed, 19 Jun 2019 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nhvb1xNnaxOCt74u1oVKsx4vkjdfV+cnmA4aS9DBrCA=;
 b=Y7EGymSQKdVonxwR3B3UdurwDPhsIwNjZ+7XSuCISzkKVX/MAiBTuFba6GrjD8lieg
 +P0EyuN00CquUUaIwAC51FIzk3A15L+3tpjxMMjuC8Fk6dvXztujk1sEGw2yzMlgjTEh
 AcFF9rgqOdeSuOqSdJbG3y6c1MY5TfbtRK9b1RQ7N2WepJmJTPduXVFpfrW70vea0OL9
 sB/FvYtYfoKWBNjPMVHfHED+WOlojljcJsBzkpdWQhsmhFtGHl8S687k0OdoAzEY7GuN
 uB6+EIg5Wj7JsOLNC5dMFtq6LIBYspSkGVOclEmH2WlZ15MhT0r8saP3R1FVg1ajSUQ8
 XFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nhvb1xNnaxOCt74u1oVKsx4vkjdfV+cnmA4aS9DBrCA=;
 b=svttEbY+0xdhPjHlhqGbsmD8r+wNMygaWVVzlumriitKE7ht6N/YCtRmk7NSRdv0Ho
 d18vrS9RU+fZYfmGAYZC9NmC4cCADVWWnI6K7C5mf60fFX7Z4jjwNofLmLr3QmD0SseV
 jRVb7vhsx51V6z5MNuqHEW47S7HgwXpt3P5gUZ9KbgbvHYAHSk8cp0Bq8rV93fp4/p34
 U8jAjSfndaA5MDjS4wvOX7pKg7Ki/gkrVw2NO7QZQ5krL5jh/Dvt618A70+HTXE+qrfn
 N7+6dh/bi+FLkmSBFjDFmm9sa5I5JWPBm5wj0XteSB0ZWa2a1ElvTFHSVnat5zFQr2tx
 Dy/w==
X-Gm-Message-State: APjAAAUj1nVVBUek9kkxQQL6j/39NZ879P+Gwl/MSBQL0zzRPrUlShAs
 JNjTdnaHqGCyZmvv2aaA3ViZvF/AfJ0nm0sbkpU=
X-Google-Smtp-Source: APXvYqxfPXlZlF7TrSQVbARv9zk4bPgNHt6L9ax4lQEOTbHlRIdoXPv1yd1Ar3bqpYCO/IIZas+BY+BCSJ4ANrr7ljA=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr17213246lja.94.1560978197339; 
 Wed, 19 Jun 2019 14:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <e718da8df07915765217dece609255b6ad196955.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmUz5xHqhuEvDWHBTpKN+k3uuNPQxNCGFWOfR21hMhWtPw@mail.gmail.com>
 <CANnJOVH34B0efKNSjNHD5ZmuWqAsybsmiwFXEQYvTye+oJBV=A@mail.gmail.com>
 <CAEUhbmU_fjS4-DeZwnC7u4gQc3h44m4yYQ7vUA3-N0Wk64z5uw@mail.gmail.com>
In-Reply-To: <CAEUhbmU_fjS4-DeZwnC7u4gQc3h44m4yYQ7vUA3-N0Wk64z5uw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 14:00:28 -0700
Message-ID: <CAKmqyKPsKs70kGpkGbpoO+QvA_8zkhc_39HHY41+3eJGXYfyng@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 2/5] hw/riscv: Add support
 for loading a firmware
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Behrens <fintelia@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 8:30 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jun 19, 2019 at 11:26 PM Jonathan Behrens <fintelia@gmail.com> wr=
ote:
> >
> > I was actually just writing up the same thing.  Shifting all the addres=
ses in the ELF file by 2 or 4MB is somewhat surprising behavior, especially=
 because this will apply to segments that are mapped even at much higher ad=
dresses. If you want a segment aligned to a 1GB superpage boundary you now =
need to place it slightly below so that it will be bumped up to the right p=
lace. Further, ANDing all addresses with 0x7fffffff makes it impossible to =
map anything beyond the first 2GB of RAM.
> >
>
> Yes, current kernel_translate() logic is tightly coupled to the kernel
> entry VA, and if we link kernel at some other address it will just
> fail.

I thought this was required but it looks like it isn't. I have remove
the kernel_translate() function.

>
> > Jonathan
> >
> > On Wed, Jun 19, 2019 at 11:16 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> On Wed, Jun 19, 2019 at 8:53 AM Alistair Francis
> >> <alistair.francis@wdc.com> wrote:
> >> >
> >> > Add support for loading a firmware file for the virt machine and the
> >> > SiFive U. This can be run with the following command:
> >> >
> >> >     qemu-system-riscv64 -machine virt -bios fw_jump.elf -kernel vmli=
nux
> >> >
> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > ---
> >> >  hw/riscv/boot.c         | 41 ++++++++++++++++++++++++++++++++++++++=
+--
> >> >  hw/riscv/sifive_e.c     |  2 +-
> >> >  hw/riscv/sifive_u.c     |  6 +++++-
> >> >  hw/riscv/spike.c        |  6 +++---
> >> >  hw/riscv/virt.c         |  7 ++++++-
> >> >  include/hw/riscv/boot.h |  4 +++-
> >> >  6 files changed, 57 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> >> > index 62f94aaf8a..392ca0cb2e 100644
> >> > --- a/hw/riscv/boot.c
> >> > +++ b/hw/riscv/boot.c
> >> > @@ -23,13 +23,50 @@
> >> >  #include "exec/cpu-defs.h"
> >> >  #include "hw/loader.h"
> >> >  #include "hw/riscv/boot.h"
> >> > +#include "hw/boards.h"
> >> >  #include "elf.h"
> >> >
> >> > -target_ulong riscv_load_kernel(const char *kernel_filename)
> >> > +#if defined(TARGET_RISCV32)
> >> > +# define KERNEL_BOOT_ADDRESS 0x80400000
> >> > +#else
> >> > +# define KERNEL_BOOT_ADDRESS 0x80200000
> >> > +#endif
> >> > +
> >> > +static uint64_t kernel_translate(void *opaque, uint64_t addr)
> >> > +{
> >> > +    MachineState *machine =3D opaque;
> >> > +
> >> > +    /*
> >> > +     * If the user specified a firmware move the kernel to the offs=
et
> >> > +     * start address.
> >> > +     */
> >>
> >> Why?

Removed.

> >>
> >> > +    if (machine->firmware) {
> >> > +        return (addr & 0x7fffffff) + KERNEL_BOOT_ADDRESS;
> >>
> >> So with both "-bios" and "-kernel", the kernel address will be moved
> >> to another address other than 0x80200000 (for 64-bit). This does not
> >> look good to me.
> >>
>
> So why not simply return KERNEL_BOOT_ADDRESS in kernel_translate()?

That's what I am doing now.

Alistair

>
> Regards,
> Bin

