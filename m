Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED8C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 17:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81022084E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 17:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81022084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j31Wl-0002Xj-V6
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 12:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j31Va-0001zT-I2
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 12:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j31VZ-0002rF-4p
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 12:45:38 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j31VZ-0002r7-0g; Sat, 15 Feb 2020 12:45:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so5892085ywd.4;
 Sat, 15 Feb 2020 09:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T7wE1irl2ON1034v0znSxTSnyjo87y2hlNbaoaKoRIQ=;
 b=TZMu5C28VmSnQm6t/DJFz+eSh1cSE6bsGxzikzfJDviwSgfuPaEHVgYany/NiFq5ic
 x7tfn509Ekhlrx3UqbP7Sm2EHpvpGEPKy9fd0IMHhpu1jkVOeOtmwdLXKLKHlmf+THLq
 M17+A8shXu3I9PNRM4aDdYBM9+6WAQ3PZ9v9IglUn6efpprWXq6d+VxoYciz1Nd7K7TK
 RCeDlDqGUQcj6U0lKtG05z6+U1CaHyRJi5K8QmyRZ9uDoAxnkZKxmH+mIFvqpKqs+qYb
 vHxKKPu1NxRensZB8X6rvLjXSUkhoHgwyjZ80QA8afqgvofh0/M84nUjirTfG7Czy91/
 DXqQ==
X-Gm-Message-State: APjAAAVbdaDi2pXYzsjO9bvq8jIlzoRfN1OyGHtivQRGULSRm6hHXl/6
 zLc7wn+7FvcsF6CHIz8uss7Bf5zzYeLVaaTL8jg=
X-Google-Smtp-Source: APXvYqxq0dVan9Oybx0wK6NycbCqdeCPULwN/ZBwReP4ALw4nWVvYgHq/qAF0xCl71RjfYWaY9oz8zVlR4FOu2+IN0U=
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr6804476ywa.37.1581788736304; 
 Sat, 15 Feb 2020 09:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-13-f4bug@amsat.org>
 <CAFEAcA8e4NqwKPM6qx=vKm6NOz__=S90trhUuhaSNe_yJ8GeXg@mail.gmail.com>
 <0d72fad3-3eef-66ff-2162-f0c07ba01ff2@redhat.com>
In-Reply-To: <0d72fad3-3eef-66ff-2162-f0c07ba01ff2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 15 Feb 2020 18:45:25 +0100
Message-ID: <CAAdtpL7bNWiFU7OCtuQzjfXHXjD0U5AwwZ8Z3P3qyDEt+fWw=w@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] hw/arm/raspi: Use a unique
 raspi_machine_class_init() method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 3:16 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 2/13/20 2:59 PM, Peter Maydell wrote:
> > On Sat, 8 Feb 2020 at 16:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >>
> >> With the exception of the ignore_memory_transaction_failures
> >> flag set for the raspi2, both machine_class_init() methods
> >> are now identical. Merge them to keep a unique method.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >>   hw/arm/raspi.c | 31 ++++++-------------------------
> >>   1 file changed, 6 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> >> index 0537fc0a2d..bee6ca0a08 100644
> >> --- a/hw/arm/raspi.c
> >> +++ b/hw/arm/raspi.c
> >> @@ -294,7 +294,7 @@ static void raspi_machine_init(MachineState *machi=
ne)
> >>       setup_boot(machine, version, machine->ram_size - vcram_size);
> >>   }
> >>
> >> -static void raspi2_machine_class_init(ObjectClass *oc, void *data)
> >> +static void raspi_machine_class_init(ObjectClass *oc, void *data)
> >>   {
> >>       MachineClass *mc =3D MACHINE_CLASS(oc);
> >>       RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> >> @@ -311,41 +311,22 @@ static void raspi2_machine_class_init(ObjectClas=
s *oc, void *data)
> >>       mc->min_cpus =3D BCM283X_NCPUS;
> >>       mc->default_cpus =3D BCM283X_NCPUS;
> >>       mc->default_ram_size =3D board_ram_size(board_rev);
> >> -    mc->ignore_memory_transaction_failures =3D true;
> >> +    if (board_version(board_rev) =3D=3D 2) {
> >> +        mc->ignore_memory_transaction_failures =3D true;
> >> +    }
> >>   };
> >
> > This isn't really the correct condition here. What we want is:
> >   * for the board named 'raspi2' which was introduced before
> >     we added the transaction-failure support to Arm CPU emulation,
> >     disable signaling transaction failures
> >   * for any other board, leave it enabled (whether that new
> >     board is BCM2836 based or anything else)
> >
> > (This kind of follows on from my remark on patch 3: we should
> > be suspicious of anything that's conditional on board_version();
> > it should probably be testing something else.)
> >
> > The natural way to implement this is to have the .class_data
> > be a pointer to a struct which is in an array and defines
> > relevant per-class stuff, the same way we do in
> > bcm2836_register_types(). That way the struct can indicate
> > both the board revision number and also "is this a legacy
> > board that needs transaction-failures disabled?".
>
> IIUC Igor insists explaining that he doesn't accept anymore a
> ".class_data pointer to a struct which is in an array and defines
> relevant per-class stuff" and we should not use this pattern anymore.
>
> > The other approach here, as discussed on IRC, is that if
> > we're confident we really have all the devices in the SoC
> > either present or stubbed out with unimplemented-device
> > then we could disable ignore_memory_transaction_failures
> > for raspi2. (The flag is only there because I didn't want
> > to try to do the auditing and fielding of potential bug
> > reports if I changed the behaviour of a bunch of our
> > existing not-very-maintained board models: the real
> > correct behaviour in almost all cases would be to allow
> > transaction failures and just make sure we have stub devices
> > as needed.)
>
> Yes, the plan is to add all the unimplemented peripherals (patches
> ready, but out of scope of this series) and remove this flag.

I found my 'ready' patch, it is already merged as commit 00cbd5bd74b1 =3D)

    hw/arm/bcm2835: Add various unimplemented peripherals

    Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
    datasheet from February 06 2012:
    https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals=
.pdf

I'm successfully running U-boot and Linux on raspi0/1/2/3 so I guess
it is safe to remove ignore_memory_transaction_failures for the
raspi2.
It might be insufficient to run proprietary firmware (on the raspi2),
I have no idea if people use QEMU for that.

> > That said, this does give the right answer for our current boards,
> > so I'm ok with taking this series if you want to address this
> > in a followup patch.
>
> If you are OK, I prefer to address this in a later series than delaying
> this one more longer.
>
> Thanks!
>
>

