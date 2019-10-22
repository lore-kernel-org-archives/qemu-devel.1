Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0975E214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD0tY6Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0975E214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqoS-0001NQ-4g
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1iMqnL-0008Vv-SU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1iMqnH-0003lw-MK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:49:39 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
 id 1iMqlP-0003HR-9s; Tue, 22 Oct 2019 05:49:35 -0400
Received: by mail-io1-xd42.google.com with SMTP id z19so19673248ior.0;
 Tue, 22 Oct 2019 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z5nwDi4FvKIql2/B77bkolyYgv+OoJEY8Lh+8lXHXi4=;
 b=nD0tY6Y++u02mDyniTNZYZL/7UfJ1r60sekxxI0pTouHIBT2ioSNC/vh2fBXupr5aB
 s+dyj6kQ/BX0v6eqpeSUcZuj7epqxPCxvVqvUY1FD6usotCONqhyRk9sNsVA/S0iXFAE
 Zq/yUW01lbMh/H5F3P1yTmjdcHmZFw75VxcmggFhR0EsSGNmU7jBVoWnfC/n4xXDpQdH
 oPBv1l++xG5Dn3KI0MK1Cu10UVUsY7eq342J2bSumL+1wimc6fMjoCl0TGadaZYb1mcK
 IObvPZRu+mY/IBYFEafjmSjhPPzCP/wm9QkMc1nOcfXegIpTwHRgnhwX/jfqAqYQr/lz
 Wmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z5nwDi4FvKIql2/B77bkolyYgv+OoJEY8Lh+8lXHXi4=;
 b=KHiChv5JBgre4hIAHyn5KsECQlszR7OlHu+ZTc/beS3LBx2oovRtK5gvN4FW0nXpfg
 TJAshXui/Pf42Evrb9QXMXFUSh+EkQIoe8FbxRECLpjegEOcBzESkRKAUqp5ao+ByWjx
 uwethQsit5SR02rehzXz7/6LFzcYIx5hGP6IgeuqGLNFimkch0VR5iIHLSDeR8fL61O9
 reA/gigYRyjcj5Y4Gkey6iZLhCmJfSpyPcMETsONKnK1WQ7i+lik7n4oII1lZOkds6Di
 7wtze3+fbpbI9y+V5h10UnWGFSR0Zx2FY3i63/uodJcG7p3374LvcsSQL8kOAo6GKYQr
 8kJg==
X-Gm-Message-State: APjAAAX/NwhQC3UCO47JofxINcqVmVfgo9lsr1QF6NXrZiWAafNYa8c1
 CdZge1k9bS4N+4HrMO4qTOCes9KYdqH6HyYUKFlCkPQkXtkL0Q==
X-Google-Smtp-Source: APXvYqwmVqRuClsybTs6LMI6thmB5ni0MxhUxyoPXCZ/AQ47Gd4qTSynP+zicH/b2vFtG0XxofOIST4LJaxctOqyHEc=
X-Received: by 2002:a6b:b210:: with SMTP id b16mr2878824iof.72.1571737655336; 
 Tue, 22 Oct 2019 02:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-8-philmd@redhat.com>
 <CAKmqyKM23N2GFiLOtLtkoK=WnjkEzynj6ctHZgqYQZB87OiCeQ@mail.gmail.com>
In-Reply-To: <CAKmqyKM23N2GFiLOtLtkoK=WnjkEzynj6ctHZgqYQZB87OiCeQ@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 22 Oct 2019 11:47:24 +0200
Message-ID: <CACXAS8DiGW9NeOS1Ouknevn4+JnxMDi-UG9sCctd6=mzDiQYMg@mail.gmail.com>
Subject: Re: [PATCH 07/21] hw: Drop QOM ownership on
 memory_region_allocate_system_memory() calls
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Paul Burton <pburton@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Fabien Chouteau <chouteau@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 1:23 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Sun, Oct 20, 2019 at 4:10 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > All the memory_region_allocate_system_memory() calls are in the
> > board_init() code.  From the 58 calls in the repository, only
> > 4 set the 'owner' parameter. It is obvious we want the Machine
> > to be the owner of the RAM, so we want to use OBJECT(machine)
> > as owner. We can simplify a bit by passing MachineState to
> > memory_region_allocate_system_memory(). In preparation of this
> > refactor, first drop the 'owner' argument from these 4 uses.
> >
> >   $ git grep memory_region_allocate_system_memory hw/ | wc -l
> >   58
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

>
> Alistair
>
> > ---
> >  hw/alpha/typhoon.c | 2 +-
> >  hw/arm/raspi.c     | 2 +-
> >  hw/hppa/machine.c  | 2 +-
> >  hw/sparc/sun4m.c   | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> > index 179e1f7658..8489ec335c 100644
> > --- a/hw/alpha/typhoon.c
> > +++ b/hw/alpha/typhoon.c
> > @@ -851,7 +851,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **=
isa_bus,
> >
> >      /* Main memory region, 0x00.0000.0000.  Real hardware supports 32G=
B,
> >         but the address space hole reserved at this point is 8TB.  */
> > -    memory_region_allocate_system_memory(&s->ram_region, OBJECT(s), "r=
am",
> > +    memory_region_allocate_system_memory(&s->ram_region, NULL, "ram",
> >                                           ram_size);
> >      memory_region_add_subregion(addr_space, 0, &s->ram_region);
> >
> > diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> > index 615d755879..f76b6eaad3 100644
> > --- a/hw/arm/raspi.c
> > +++ b/hw/arm/raspi.c
> > @@ -182,7 +182,7 @@ static void raspi_init(MachineState *machine, int v=
ersion)
> >                              &error_abort, NULL);
> >
> >      /* Allocate and map RAM */
> > -    memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ra=
m",
> > +    memory_region_allocate_system_memory(&s->ram, NULL, "ram",
> >                                           machine->ram_size);
> >      /* FIXME: Remove when we have custom CPU address space support */
> >      memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ra=
m, 0);
> > diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> > index 953d454f48..dbe1ff0fe5 100644
> > --- a/hw/hppa/machine.c
> > +++ b/hw/hppa/machine.c
> > @@ -96,7 +96,7 @@ static void machine_hppa_init(MachineState *machine)
> >
> >      /* Main memory region. */
> >      ram_region =3D g_new(MemoryRegion, 1);
> > -    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
> > +    memory_region_allocate_system_memory(ram_region, NULL,
> >                                           "ram", ram_size);
> >      memory_region_add_subregion(addr_space, 0, ram_region);
> >
> > diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> > index 6c5a17a020..0bb7524655 100644
> > --- a/hw/sparc/sun4m.c
> > +++ b/hw/sparc/sun4m.c
> > @@ -788,7 +788,7 @@ static void ram_realize(DeviceState *dev, Error **e=
rrp)
> >      RamDevice *d =3D SUN4M_RAM(dev);
> >      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> >
> > -    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ra=
m",
> > +    memory_region_allocate_system_memory(&d->ram, NULL, "sun4m.ram",
> >                                           d->size);
> >      sysbus_init_mmio(sbd, &d->ram);
> >  }
> > --
> > 2.21.0
> >
> >



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

