Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA59C76194
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3872B218BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz6pC/5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3872B218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hperm-0004bM-0b
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 16:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44077)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hperV-0003lx-C0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hperU-0007yL-BI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:24:45 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hperU-0007xH-1T; Mon, 22 Jul 2019 16:24:44 -0400
Received: by mail-lj1-x244.google.com with SMTP id v18so38812700ljh.6;
 Mon, 22 Jul 2019 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aASIKu82owQqIq30MUZDVz4IQPUWJZWB3czwtpxx0/U=;
 b=Rz6pC/5zozlJfj0kg0y/m4zbAatmse3BuwjK84oufjrbUoyIslUpp3Q0vNJ1s1jN6H
 wvKPcTwy5KrILwShYUVWJOaOoGdnlHjLBvftsVEf4oS2xmku+tHZJg+QM+oUhgEHuizD
 ajfyrQPtaxR6k2GXit0q8hCE5UnBxiPmiZFTtiiMeGzph0AMRGMtq7nQOO4RFR2faiHI
 5sAVJ/caD+GXrPvFuygdq8MmQyVK6pNfspNakeB5At2P3aAWoZ8TsYsJfPA/EobW9rFh
 GtgkbHqMH8S3a+UwdYJS4jKTgaX6eOcmSSIQdIUHly7z/Xorw4NZEprLVmbceuPmZNGa
 JeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aASIKu82owQqIq30MUZDVz4IQPUWJZWB3czwtpxx0/U=;
 b=GmhEPv5stKHOiSB+fwvT1aoPusOMUqqbVpz255I4wPMbm3dOIB5MpZzJosPv6tq+Mk
 15dEZ5c5cQTZGydejaCZeqXKdKUiJELEYQCpieCzNp2MPexANqUGnu+VqXS3+RzWkXU5
 gOQXMSBjjK6k2Yf3hfDqxgEqaJaptu1Wm6jBijZGKTSHNECDqvPXmMtzIdY+OnNKRAVD
 ETsENLabSPeys5JGRb23kQ3ackvdBenqftCYJgGxpB3VX9E8si6Cx/ptuNArRGJErL8U
 SL8jbRd9GnJIxF0NogbY2v09ihAqXDzm/WTaRaU/9wcKH9S+PvRO71zh/H6g/4vCg/n1
 LMsg==
X-Gm-Message-State: APjAAAVnDQ7mvN+4wvcZw3RTVYwwFfDw93bT2d0jATBXnwbwTIkKFFJ8
 jlGFLXEe08n9riPVrJXoU5IjPlMrfo8M51J4XOg=
X-Google-Smtp-Source: APXvYqyXQ5BYYP2zrM6Xzh8mTxRdVNc1ERygyiJb9KFTTIH4xkjDZPVNumv2rpPpGUXdrjZYi6thKqJMr+v2YkRtMiY=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr37742624ljg.119.1563827081966; 
 Mon, 22 Jul 2019 13:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKNnkToYf3Y025Hpv1e8jazMVjxhjAaOBtn0ajcHSFaTUA@mail.gmail.com>
 <mhng-d801380f-1010-4ee3-a3ee-d6f16159474e@palmer-si-x1c4>
In-Reply-To: <mhng-d801380f-1010-4ee3-a3ee-d6f16159474e@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jul 2019 13:21:15 -0700
Message-ID: <CAKmqyKMuyL=JhFL5=OwJBv25Vz=iknuDUJVvZu5ChQ4MUC+73A@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv/boot: Fixup the RISC-V
 firmware warning
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 22, 2019 at 12:09 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 22 Jul 2019 11:22:43 PDT (-0700), alistair23@gmail.com wrote:
> > On Sat, Jul 20, 2019 at 2:30 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> On 7/19/19 8:05 PM, Alistair Francis wrote:
> >> > Fix a typo in the warning message displayed to users, don't print th=
e
> >> > message when running inside qtest and don't mention a specific QEMU
> >> > version for the deprecation.
> >> >
> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > ---
> >> >  hw/riscv/boot.c | 12 ++++++++----
> >> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> >> > index 5dee63011b..4b32ab1d26 100644
> >> > --- a/hw/riscv/boot.c
> >> > +++ b/hw/riscv/boot.c
> >> > @@ -26,6 +26,7 @@
> >> >  #include "hw/riscv/boot.h"
> >> >  #include "hw/boards.h"
> >> >  #include "elf.h"
> >> > +#include "sysemu/qtest.h"
> >> >
> >> >  #if defined(TARGET_RISCV32)
> >> >  # define KERNEL_BOOT_ADDRESS 0x80400000
> >> > @@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *=
machine,
> >> >           * In the future this defaul will change to loading the pre=
built
> >> >           * OpenSBI firmware. Let's warn the user and then continue.
> >> >          */
> >> > -        warn_report("No -bios option specified. Not loading a firmw=
are.");
> >> > -        warn_report("This default will change in QEMU 4.3. Please u=
se the " \
> >> > -                    "-bios option to aviod breakages when this happ=
ens.");
> >> > -        warn_report("See QEMU's deprecation documentation for detai=
ls");
> >> > +        if (!qtest_enabled()) {
> >> > +            warn_report("No -bios option specified. Not loading a f=
irmware.");
> >> > +            warn_report("This default will change in a future QEMU =
release. " \
> >> > +                        "Please use the -bios option to avoid break=
ages when "\
> >> > +                        "this happens.");
> >> > +            warn_report("See QEMU's deprecation documentation for d=
etails");
> >>
> >> Maybe a final '.' in the last warning to be consistent with the previo=
us
> >> lines?
> >
> > Done in v2.
>
> I don't see a v2, did I miss it?

Just sent it.

Alistair

>
> >> Regardless:
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > Thanks!
> >
> > Alistair
> >
> >>
> >> > +        }
> >> >          return;
> >> >      }
> >> >
> >> >

