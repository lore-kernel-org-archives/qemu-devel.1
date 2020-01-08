Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586AEC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 23:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CB6206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 23:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CB6206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50553 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipL2H-0005EH-8O
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 18:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipL1P-00042f-R4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipL1O-0001yR-MG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:45:55 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipL1O-0001x3-Ga
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:45:54 -0500
Received: by mail-yw1-f67.google.com with SMTP id l14so1567680ywj.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 15:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LaRxDyN9Zei6sp3dmKq6KngQ0uY+P1VAKUrl4l2nk/c=;
 b=Yey9rzJ4Vn5NObpFjjmUhQ4Hj2YkhDLMbj8GqRQV083T2o0xlb0dhP3KU6JkNUWatJ
 tpwZi7uoWvU8Ku7+VGBti7gfDNHXEgwBqWvG57dAjREprBhwtpj0n5sMIGSZQX2g289T
 HbjRJnOLVQLqtuh9Y18vlhrIRvas2Gll+SNieQcT1XNFvD8++guRJ/L7yCi6y7+oLHvU
 WoNTCLhoaXojcSiM0sDgLfmZX2Gy/k/pvJK5q/1CdR/uonYsSJTrOU3yrwTBYFM7aJ86
 OrjQ5dZZGyeXFRilPOU0VfiSyMpMRKblCApFLJ3YhrI4EBswc8hql3uyW28SaabjcovJ
 SYRQ==
X-Gm-Message-State: APjAAAXH/berh0KGlunJI4ATVnz4b41cABdRK29IHawrMa7fhcSRy7Ks
 i23yzzBhmIQrTAYjkkOCVWYQaQJxhgZO4CJx6Wc=
X-Google-Smtp-Source: APXvYqz8t8DwNXqrI59zJVTpdtb1fcPqKaBeBNE1Ne/k60rmpp+KlRgbtB9OueRMcbSShzFdBR8BW9VwUBlumBa7ioc=
X-Received: by 2002:a81:69c5:: with SMTP id e188mr5468616ywc.443.1578527153345; 
 Wed, 08 Jan 2020 15:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20200108181425.21485-1-f4bug@amsat.org>
 <20200108181425.21485-3-f4bug@amsat.org>
 <6997ceed-9a68-796c-f03d-02bfd7d76803@gmx.de>
In-Reply-To: <6997ceed-9a68-796c-f03d-02bfd7d76803@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 9 Jan 2020 00:45:42 +0100
Message-ID: <CAAdtpL4xOtGdpsa42=-xNBV-fMyj4=C2_WE03VwpxpfverLjBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/hppa/machine: Do not limit the RAM to 3840MB
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.67
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
Cc: Igor Mammedov <imammedo@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 8, 2020 at 10:39 PM Helge Deller <deller@gmx.de> wrote:
> On 08.01.20 19:14, Philippe Mathieu-Daud=C3=A9 wrote:
> > The hardware expects DIMM slots of 1 or 2 GB, allowing up to
> > 4 GB of memory. Accept the same amount of memory the hardware
> > can deal with.
> >
> > The CPU doesn't have access to the RAM mapped in the
> > [0xf0000000 - 0xf1000000] range because this is the PDC area
> > (Processor Dependent Code) where the firmware is loaded.
> > To keep this region with higher priority than the RAM, lower
> > the RAM priority. The PDC will overlap it.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/hppa/machine.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> > index 6775d879f8..d10c967d06 100644
> > --- a/hw/hppa/machine.c
> > +++ b/hw/hppa/machine.c
> > @@ -90,16 +90,15 @@ static void machine_hppa_init(MachineState *machine=
)
> >          g_free(name);
> >      }
> >
> > -    /* Limit main memory. */
> > -    if (ram_size > FIRMWARE_START) {
> > -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
> > -    }
> > -
> >      /* Main memory region. */
> > +    if (machine->ram_size > 4 * GiB) {
> > +        error_report("RAM size of 4GB or more is not supported");
> > +        exit(EXIT_FAILURE);
> > +    }
>
> My suggestion is to initially then limit it to max. 3GB, e.g.
> > +    if (machine->ram_size > 3 * GiB) {
> > +        error_report("RAM size of 3GB or more is not supported");
> > +        exit(EXIT_FAILURE);
>
> That way you don't need to work around the 4GB SeaBIOS limitation
> in your other RFC patch.

If you are happy with this outcome, I'm happy too, this is simpler :)

> So, people can start it with:
> qemu-system-hppa -m 3g -serial stdio
>
> Later then we can fix SeaBIOS, at least if 64bit support gets added later=
 on.

Agreed.

> >      ram_region =3D g_new(MemoryRegion, 1);
> >      memory_region_allocate_system_memory(ram_region, OBJECT(machine),
> >                                           "ram", ram_size);
>
> ^^^ here is still "ram_size". Do you need to change it?

No, because it is not modified, it still contains the size requested
from the user, and the size has been validated.
Hopefully it will simplify Igor series.

> > -    memory_region_add_subregion(addr_space, 0, ram_region);
> > +    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1)=
;
> >
> >      /* Init Dino (PCI host bus chip).  */
> >      pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
> >
>
> Helge

