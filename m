Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9FC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB9620714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv95TKr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB9620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbMg-000209-Jh
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHbL5-00007h-3o
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHbL2-0000Un-Hb
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:51:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jHbL2-0000TL-9B; Thu, 26 Mar 2020 18:51:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id c81so9328438wmd.4;
 Thu, 26 Mar 2020 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bhTcQqH9tF1B8Clb+MOxQ675dIzJZl4HSKXWL0fidL0=;
 b=bv95TKr701jZE9PSPU/l1wScN+vW1d+bir4wHxHz1FZqsrP50zwgdq8rqeU1wu6Zz5
 xECq3WB7FcUqis3UsQg/GbBX21GgpbShHRRYqlcxFjUH+htqzBR1jma2aLYeMyyxFvsh
 H0MF0zTp/1ML/q+dQ96UY2cGtbXSE/3QO3cGvyAfPa2LLu3WxDlsYfybD1Ql4TsIm46g
 2XrA58Awt3NtpyGD9KecuYFiJ0ZOy9V+PhtVQujH/i4wHTbOHbsxN0Rkm6/LkYK3gdkx
 8KUTsI5LVxFOXT9COHa9KQ6xV5j2LRIrdsdJhMtNvbuI7P/0tgzvjRF/V1qoJ4w0bM1g
 bDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bhTcQqH9tF1B8Clb+MOxQ675dIzJZl4HSKXWL0fidL0=;
 b=lLSmq+pattOGXaGIPRr+s4jgPh8LUz+m2V2ZWBb3HLteAhVRR9GZn2jEbx1xJweLf2
 ukWPI/ZH6fd5KrvWfHQxfOcebQ3GOVeOr3JSzRbAC+O9iqOJUCPajXpOzHUQy6U+z+Ls
 Tx5iPY2Q2Rdu46oo5rLXhOhXo9PQMrOD7lxZ1MWVgzDPBeT409PQ0F7hI+9/hHOTcy4D
 7kC71xcw74Rd9u5i2XcufNO5EiIk3qRl91WW5GbSACcIZtbH83lNJ6VV8ApKKQ+jPfAU
 6yrdp0tUA4Px9oVmkV864fi0dlxUILfhbf9i+TOa0aOcRw4/4D9BN86QOUZeVigeNDOZ
 EGmQ==
X-Gm-Message-State: ANhLgQ3H4SAJmBz4ORBCCiVYWnAugHM6Jc8PCIOweQELvcyV+EKREicy
 MEYcV7sgHGZOXYrqtOxNxXCqNG9aanSTDIUovZw=
X-Google-Smtp-Source: ADFU+vukP335mXUnyTLUPay5BWNxcZVi6zTZr++/elPeQgti18549Q8/+lHhONcY0EjnoeupA9XmSns35m0VS5Etyms=
X-Received: by 2002:a5d:65c4:: with SMTP id e4mr5281981wrw.147.1585263057127; 
 Thu, 26 Mar 2020 15:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-9-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-9-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 27 Mar 2020 00:50:41 +0200
Message-ID: <CAHiYmc5WNE_044D0eTZnEbe-EfTBD1z0mH=RBOBpv265V7OOUQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 08/12] hw/mips/boston: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000654ec605a1c9d17d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000654ec605a1c9d17d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

21:18 Sre, 25.03.2020. Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file
scripts/coccinelle/object_property_missing_error_propagate.cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in
object_property_set_int() hw/mips/boston.c:462:4]]
>   [[manual check required: error_propagate() might be missing in
object_property_set_str() hw/mips/boston.c:460:4]]
>
> Since the uses are inside a MachineClass::init() function,
> directly use &error_fatal instead of error_propagate().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/boston.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 98ecd25e8e..2e821ca7d6 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -425,121 +425,116 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t
bus_nr,
>  static void boston_mach_init(MachineState *machine)
>  {
>      DeviceState *dev;
>      BostonState *s;
> -    Error *err =3D NULL;
>      MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
>      MemoryRegion *sys_mem =3D get_system_memory();
>      XilinxPCIEHost *pcie2;
>      PCIDevice *ahci;
>      DriveInfo *hd[6];
>      Chardev *chr;
>      int fw_size, fit_err;
>      bool is_64b;
>
>      if ((machine->ram_size % GiB) ||
>          (machine->ram_size > (2 * GiB))) {
>          error_report("Memory size must be 1GB or 2GB");
>          exit(1);
>      }
>
>      dev =3D qdev_create(NULL, TYPE_MIPS_BOSTON);
>      qdev_init_nofail(dev);
>
>      s =3D BOSTON(dev);
>      s->mach =3D machine;
>
>      if (!cpu_supports_cps_smp(machine->cpu_type)) {
>          error_report("Boston requires CPUs which support CPS");
>          exit(1);
>      }
>
>      is_64b =3D cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
>
>      sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
>                            sizeof(s->cps), TYPE_MIPS_CPS);
>      object_property_set_str(OBJECT(&s->cps), machine->cpu_type,
"cpu-type",
> -                            &err);
> -    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus,
"num-vp", &err);
> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -
> -    if (err !=3D NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> -    }
> -
> +                            &error_fatal);
> +    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp"=
,
> +                            &error_fatal);
> +    object_property_set_bool(OBJECT(&s->cps), true, "realized",
&error_fatal);
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>
>      flash =3D  g_new(MemoryRegion, 1);
> -    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err)=
;
> +    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB,
> +                           &error_fatal);
>      memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
>
>      memory_region_add_subregion_overlap(sys_mem, 0x80000000,
machine->ram, 0);
>
>      ddr_low_alias =3D g_new(MemoryRegion, 1);
>      memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
>                               machine->ram, 0,
>                               MIN(machine->ram_size, (256 * MiB)));
>      memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
>
>      xilinx_pcie_init(sys_mem, 0,
>                       0x10000000, 32 * MiB,
>                       0x40000000, 1 * GiB,
>                       get_cps_irq(&s->cps, 2), false);
>
>      xilinx_pcie_init(sys_mem, 1,
>                       0x12000000, 32 * MiB,
>                       0x20000000, 512 * MiB,
>                       get_cps_irq(&s->cps, 1), false);
>
>      pcie2 =3D xilinx_pcie_init(sys_mem, 2,
>                               0x14000000, 32 * MiB,
>                               0x16000000, 1 * MiB,
>                               get_cps_irq(&s->cps, 0), true);
>
>      platreg =3D g_new(MemoryRegion, 1);
>      memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
>                            "boston-platregs", 0x1000);
>      memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0)=
;
>
>      s->uart =3D serial_mm_init(sys_mem, 0x17ffe000, 2,
>                               get_cps_irq(&s->cps, 3), 10000000,
>                               serial_hd(0), DEVICE_NATIVE_ENDIAN);
>
>      lcd =3D g_new(MemoryRegion, 1);
>      memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd",
0x8);
>      memory_region_add_subregion_overlap(sys_mem, 0x17fff000, lcd, 0);
>
>      chr =3D qemu_chr_new("lcd", "vc:320x240", NULL);
>      qemu_chr_fe_init(&s->lcd_display, chr, NULL);
>      qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
>                               boston_lcd_event, NULL, s, NULL, true);
>
>      ahci =3D
pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
>                                             PCI_DEVFN(0, 0),
>                                             true, TYPE_ICH9_AHCI);
>      g_assert(ARRAY_SIZE(hd) =3D=3D ahci_get_num_ports(ahci));
>      ide_drive_get(hd, ahci_get_num_ports(ahci));
>      ahci_ide_create_devs(ahci, hd);
>
>      if (machine->firmware) {
>          fw_size =3D load_image_targphys(machine->firmware,
>                                        0x1fc00000, 4 * MiB);
>          if (fw_size =3D=3D -1) {
>              error_report("unable to load firmware image '%s'",
>                            machine->firmware);
>              exit(1);
>          }
>      } else if (machine->kernel_filename) {
>          fit_err =3D load_fit(&boston_fit_loader, machine->kernel_filenam=
e,
s);
>          if (fit_err) {
>              error_report("unable to load FIT image");
>              exit(1);
>          }
>
>          gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
>                       s->kernel_entry, s->fdt_base, is_64b);
>      } else if (!qtest_enabled()) {
>          error_report("Please provide either a -kernel or -bios
argument");
>          exit(1);
>      }
>  }
> --
> 2.21.1
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

--000000000000654ec605a1c9d17d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">21:18 Sre, 25.03.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Running the coccinelle script produced:<br>
&gt;<br>
&gt; =C2=A0 $ spatch \<br>
&gt; =C2=A0 =C2=A0 --macro-file scripts/cocci-macro-file.h --include-header=
s \<br>
&gt; =C2=A0 =C2=A0 --sp-file scripts/coccinelle/object_property_missing_err=
or_propagate.cocci \<br>
&gt; =C2=A0 =C2=A0 --keep-comments --smpl-spacing --dir hw<br>
&gt;<br>
&gt; =C2=A0 [[manual check required: error_propagate() might be missing in =
object_property_set_int() hw/mips/boston.c:462:4]]<br>
&gt; =C2=A0 [[manual check required: error_propagate() might be missing in =
object_property_set_str() hw/mips/boston.c:460:4]]<br>
&gt;<br>
&gt; Since the uses are inside a MachineClass::init() function,<br>
&gt; directly use &amp;error_fatal instead of error_propagate().<br>
&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0hw/mips/boston.c | 17 ++++++-----------<br>
&gt; =C2=A01 file changed, 6 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/mips/boston.c b/hw/mips/boston.c<br>
&gt; index 98ecd25e8e..2e821ca7d6 100644<br>
&gt; --- a/hw/mips/boston.c<br>
&gt; +++ b/hw/mips/boston.c<br>
&gt; @@ -425,121 +425,116 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32=
_t bus_nr,<br>
&gt; =C2=A0static void boston_mach_init(MachineState *machine)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0DeviceState *dev;<br>
&gt; =C2=A0 =C2=A0 =C2=A0BostonState *s;<br>
&gt; -=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; =C2=A0 =C2=A0 =C2=A0MemoryRegion *flash, *ddr_low_alias, *lcd, *platre=
g;<br>
&gt; =C2=A0 =C2=A0 =C2=A0MemoryRegion *sys_mem =3D get_system_memory();<br>
&gt; =C2=A0 =C2=A0 =C2=A0XilinxPCIEHost *pcie2;<br>
&gt; =C2=A0 =C2=A0 =C2=A0PCIDevice *ahci;<br>
&gt; =C2=A0 =C2=A0 =C2=A0DriveInfo *hd[6];<br>
&gt; =C2=A0 =C2=A0 =C2=A0Chardev *chr;<br>
&gt; =C2=A0 =C2=A0 =C2=A0int fw_size, fit_err;<br>
&gt; =C2=A0 =C2=A0 =C2=A0bool is_64b;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if ((machine-&gt;ram_size % GiB) ||<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(machine-&gt;ram_size &gt; (2 * GiB)=
)) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Memory size must =
be 1GB or 2GB&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0dev =3D qdev_create(NULL, TYPE_MIPS_BOSTON);<br>
&gt; =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(dev);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0s =3D BOSTON(dev);<br>
&gt; =C2=A0 =C2=A0 =C2=A0s-&gt;mach =3D machine;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (!cpu_supports_cps_smp(machine-&gt;cpu_type)) {=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Boston requires C=
PUs which support CPS&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0is_64b =3D cpu_supports_isa(machine-&gt;cpu_type, =
ISA_MIPS64);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(OBJECT(machine), &quot;cps&q=
uot;, OBJECT(&amp;s-&gt;cps),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(s-&gt;cps), TYPE_MIPS_CPS);<br>
&gt; =C2=A0 =C2=A0 =C2=A0object_property_set_str(OBJECT(&amp;s-&gt;cps), ma=
chine-&gt;cpu_type, &quot;cpu-type&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;err);<br>
&gt; -=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;cps), machine=
-&gt;smp.cpus, &quot;num-vp&quot;, &amp;err);<br>
&gt; -=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;cps), true, =
&quot;realized&quot;, &amp;err);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s&quot;, error_get_pr=
etty(err));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;cps), machine=
-&gt;smp.cpus, &quot;num-vp&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;cps), true, =
&quot;realized&quot;, &amp;error_fatal);<br>
&gt; =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&amp;s-&gt;=
cps), 0, 0, 1);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0flash =3D=C2=A0 g_new(MemoryRegion, 1);<br>
&gt; -=C2=A0 =C2=A0 memory_region_init_rom(flash, NULL, &quot;boston.flash&=
quot;, 128 * MiB, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_rom(flash, NULL, &quot;boston.flash&=
quot;, 128 * MiB,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0x180=
00000, flash, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0x800=
00000, machine-&gt;ram, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0ddr_low_alias =3D g_new(MemoryRegion, 1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_init_alias(ddr_low_alias, NULL, &quo=
t;boston_low.ddr&quot;,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-&gt;ram, 0,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIN(machine-&gt;ram_size, (256 * MiB)));=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0, dd=
r_low_alias, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0xilinx_pcie_init(sys_mem, 0,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x10000000, 32 * MiB,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x40000000, 1 * GiB,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 get_cps_irq(&amp;s-&gt;cps, 2), false);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0xilinx_pcie_init(sys_mem, 1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x12000000, 32 * MiB,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x20000000, 512 * MiB,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 get_cps_irq(&amp;s-&gt;cps, 1), false);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0pcie2 =3D xilinx_pcie_init(sys_mem, 2,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x14000000, 32 * MiB,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x16000000, 1 * MiB,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_cps_irq(&amp;s-&gt;cps, 0), true);<b=
r>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0platreg =3D g_new(MemoryRegion, 1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_init_io(platreg, NULL, &amp;boston_p=
latreg_ops, s,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;boston-platregs&quot;, 0x1000);<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0x17f=
fd000, platreg, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0s-&gt;uart =3D serial_mm_init(sys_mem, 0x17ffe000,=
 2,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_cps_irq(&amp;s-&gt;cps, 3), 10000000=
,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_hd(0), DEVICE_NATIVE_ENDIAN);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0lcd =3D g_new(MemoryRegion, 1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_init_io(lcd, NULL, &amp;boston_lcd_o=
ps, s, &quot;boston-lcd&quot;, 0x8);<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(sys_mem, 0x17f=
ff000, lcd, 0);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0chr =3D qemu_chr_new(&quot;lcd&quot;, &quot;vc:320=
x240&quot;, NULL);<br>
&gt; =C2=A0 =C2=A0 =C2=A0qemu_chr_fe_init(&amp;s-&gt;lcd_display, chr, NULL=
);<br>
&gt; =C2=A0 =C2=A0 =C2=A0qemu_chr_fe_set_handlers(&amp;s-&gt;lcd_display, N=
ULL, NULL,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 boston_lcd_event, NULL, s, NULL, true);<=
br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0ahci =3D pci_create_simple_multifunction(&amp;PCI_=
BRIDGE(&amp;pcie2-&gt;root)-&gt;sec_bus,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PCI_DEVFN(0, 0),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 true, TYPE_ICH9_AHCI);<br>
&gt; =C2=A0 =C2=A0 =C2=A0g_assert(ARRAY_SIZE(hd) =3D=3D ahci_get_num_ports(=
ahci));<br>
&gt; =C2=A0 =C2=A0 =C2=A0ide_drive_get(hd, ahci_get_num_ports(ahci));<br>
&gt; =C2=A0 =C2=A0 =C2=A0ahci_ide_create_devs(ahci, hd);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (machine-&gt;firmware) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw_size =3D load_image_targphys(mach=
ine-&gt;firmware,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1fc0=
0000, 4 * MiB);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fw_size =3D=3D -1) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;una=
ble to load firmware image &#39;%s&#39;&quot;,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0machine-&gt;firmware);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0} else if (machine-&gt;kernel_filename) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fit_err =3D load_fit(&amp;boston_fit=
_loader, machine-&gt;kernel_filename, s);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fit_err) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;una=
ble to load FIT image&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_firmware(memory_region_get_ram_p=
tr(flash) + 0x7c00000,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 s-&gt;kernel_entry, s-&gt;fdt_base, is_64b);<br>
&gt; =C2=A0 =C2=A0 =C2=A0} else if (!qtest_enabled()) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Please provide ei=
ther a -kernel or -bios argument&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0}<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br></p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleks=
andar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
</p>

--000000000000654ec605a1c9d17d--

