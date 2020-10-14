Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26E82173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miPImp/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26E82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkFY-0007nn-Jn
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kSkCx-0005sf-Az
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:04:59 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:37548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kSkCt-00012w-P7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:04:59 -0400
Received: by mail-ua1-x944.google.com with SMTP id c7so1332562uaq.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sL+HD1EI5GNweuK0E+da96cBxu6MKG1kUw8ElPM9GJg=;
 b=miPImp/6U+tNc3KYPwWvQ8WE1pIj67VFP53Tcb+PnFVNWMRk1XB5vjcVHuUqtDsFBo
 RbljaC+z3Uyajy0fdbT5nGwGKOVygJ5HOR584e00pdpcezkslFY0gcDGNpfg7aHxx0wo
 oiDYwrNEpLcO1uE83v1c/4svugK0pv3xaFj7q3e4XkvoHzqovQ/9Yh1FiPKOoF78YkJY
 Ja3irD+LlavoTZcBgu5Nz5DM//MfuREqc4LLZOGlNsOGgMOLFIpe+PsgGmOUmG7+K9m2
 mRbL6j9ue9RAarNV1GpmOYMyrpx/ZnFkF+yb2h8tRrSxQYZ4NEOranKu+KjUp2mesHqt
 Nj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sL+HD1EI5GNweuK0E+da96cBxu6MKG1kUw8ElPM9GJg=;
 b=BQtxh7UqwJVaVfkZt6xM6OFTbl4ZXtzvWd5zC1NOtvrPyFWqpDtNgTGXGFrGYOhxMd
 oC2BjVGZGVluXp10AtsUCq1xAL6bv6A/+8RhvEfDcXupAyAyrtj/6rmYmM/oYnXHygBB
 6RVx4kQUkUNLCz0Y4qc9nkAxZcCjsJOtVTxNyI2rpDIYrgHNZgweRrd2DyWesQBZejg4
 Clwhs5PQM64n2uFtAvJY6xzXevDOKDdi+R8MAjtwaljq4jJVO2+y5YFjV5bZ6BybRpe4
 RIg2itGlAdATnzNS4LlSgTs1dJrzVKtKSNX1bxXlBnCsc8qUpfFU96ngRJRRBQrt6+Mg
 iWpw==
X-Gm-Message-State: AOAM533bgAe5xz8jFa2KHRc7TPiJGoD7FTiZD3zqNIAPaA3tAn61r082
 4idTRDdqn2tr7HvHNb+0jhjV45AwvQ/ooT/oOtCTYA==
X-Google-Smtp-Source: ABdhPJzL8DpDxVjWwaxRUHUyMRtxlH+fiAbFuI2kp+pkKztvUJLWKylQ0bUyK3kcJRAsTqaU2rT08ddAnWMwQYYh9gk=
X-Received: by 2002:ab0:3b0f:: with SMTP id n15mr347887uaw.82.1602695093930;
 Wed, 14 Oct 2020 10:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201013151631.30678-1-shashi.mallela@linaro.org>
 <20201013151631.30678-3-shashi.mallela@linaro.org>
 <20201014093119.inq2ut2srps2zfme@xora-monster>
In-Reply-To: <20201014093119.inq2ut2srps2zfme@xora-monster>
From: Shashi Mallela <shashi.mallela@linaro.org>
Date: Wed, 14 Oct 2020 13:04:43 -0400
Message-ID: <CAC15JE2hMrzpWWF-bS-fshoYx+BPehwxqJi-7uMUXSOj+Uh3GQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
To: Graeme Gregory <graeme@nuviainc.com>
Content-Type: multipart/alternative; boundary="000000000000c1ecb405b1a48776"
Received-SPF: pass client-ip=2607:f8b0:4864:20::944;
 envelope-from=shashi.mallela@linaro.org; helo=mail-ua1-x944.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Leif Lindholm <leif@nuviainc.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c1ecb405b1a48776
Content-Type: text/plain; charset="UTF-8"

This was added as a placeholder for the virt requirement suggested by Maxim
earlier.Agreed that this fdt otherwise has no significance for sbsa-ref
platform nor is being used by ACPI table created for wdt.

-Shashi

On Wed, 14 Oct 2020 at 05:31, Graeme Gregory <graeme@nuviainc.com> wrote:

> On Tue, Oct 13, 2020 at 11:16:31AM -0400, Shashi Mallela wrote:
> > Included the newly implemented SBSA generic watchdog device model into
> > SBSA platform
> >
> > Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
> > ---
> >  hw/arm/sbsa-ref.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index 9c3a893bedfd..97ed41607119 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -30,6 +30,7 @@
> >  #include "exec/hwaddr.h"
> >  #include "kvm_arm.h"
> >  #include "hw/arm/boot.h"
> > +#include "hw/arm/fdt.h"
> >  #include "hw/block/flash.h"
> >  #include "hw/boards.h"
> >  #include "hw/ide/internal.h"
> > @@ -40,6 +41,7 @@
> >  #include "hw/qdev-properties.h"
> >  #include "hw/usb.h"
> >  #include "hw/char/pl011.h"
> > +#include "hw/watchdog/wdt_sbsa_gwdt.h"
> >  #include "net/net.h"
> >  #include "qom/object.h"
> >
> > @@ -64,6 +66,9 @@ enum {
> >      SBSA_GIC_DIST,
> >      SBSA_GIC_REDIST,
> >      SBSA_SECURE_EC,
> > +    SBSA_GWDT,
> > +    SBSA_GWDT_REFRESH,
> > +    SBSA_GWDT_CONTROL,
> >      SBSA_SMMU,
> >      SBSA_UART,
> >      SBSA_RTC,
> > @@ -104,6 +109,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
> >      [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
> >      [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
> >      [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
> > +    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
> > +    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
> >      [SBSA_UART] =               { 0x60000000, 0x00001000 },
> >      [SBSA_RTC] =                { 0x60010000, 0x00001000 },
> >      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> > @@ -133,6 +140,8 @@ static const int sbsa_ref_irqmap[] = {
> >      [SBSA_SECURE_UART_MM] = 9,
> >      [SBSA_AHCI] = 10,
> >      [SBSA_EHCI] = 11,
> > +    [SBSA_SMMU] = 12, /* ... to 15 */
> > +    [SBSA_GWDT] = 16,
> >  };
> >
> >  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> > @@ -141,6 +150,30 @@ static uint64_t
> sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> >      return arm_cpu_mp_affinity(idx, clustersz);
> >  }
> >
> > +static void create_wdt_fdt(SBSAMachineState *sms)
> > +{
> > +    char *nodename;
> > +    const char compat[] = "arm,sbsa-gwdt";
> > +
> > +    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> > +    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> > +    int irq = sbsa_ref_irqmap[SBSA_GWDT];
> > +
> > +    nodename = g_strdup_printf("/watchdog@%" PRIx64, rbase);
> > +    qemu_fdt_add_subnode(sms->fdt, nodename);
> > +
> > +    qemu_fdt_setprop(sms->fdt, nodename, "compatible",
> > +                             compat, sizeof(compat));
> > +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> > +                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE,
> > +                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE);
> > +    qemu_fdt_setprop_cells(sms->fdt, nodename, "interrupts",
> > +                                GIC_FDT_IRQ_TYPE_PPI, irq,
> > +                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> > +    qemu_fdt_setprop_cell(sms->fdt, nodename, "timeout-sec", 30);
> > +    g_free(nodename);
> > +}
> > +
>
> Is this actually used anywhere? I ask because SBSA-ref is not a FDT
> booting machine and only uses FDT to transfer some dynamic info to
> arm-tf/edk2 and is not a full description tree. Your ACPI patch in
> edk2 certainly does not use this info.
>
> Graeme
>
>
> >  /*
> >   * Firmware on this machine only uses ACPI table to load OS, these
> limited
> >   * device tree nodes are just to let firmware know the info which
> varies from
> > @@ -219,6 +252,7 @@ static void create_fdt(SBSAMachineState *sms)
> >
> >          g_free(nodename);
> >      }
> > +    create_wdt_fdt(sms);
> >  }
> >
> >  #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
> > @@ -447,6 +481,20 @@ static void create_rtc(const SBSAMachineState *sms)
> >      sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic,
> irq));
> >  }
> >
> > +static void create_wdt(const SBSAMachineState *sms)
> > +{
> > +    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> > +    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> > +    DeviceState *dev = qdev_new(TYPE_WDT_SBSA_GWDT);
> > +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> > +    int irq = sbsa_ref_irqmap[SBSA_GWDT];
> > +
> > +    sysbus_realize_and_unref(s, &error_fatal);
> > +    sysbus_mmio_map(s, 0, rbase);
> > +    sysbus_mmio_map(s, 1, cbase);
> > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
> > +}
> > +
> >  static DeviceState *gpio_key_dev;
> >  static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
> >  {
> > @@ -730,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
> >
> >      create_rtc(sms);
> >
> > +    create_wdt(sms);
> > +
> >      create_gpio(sms);
> >
> >      create_ahci(sms);
> > --
> > 2.18.4
> >
> >
>

--000000000000c1ecb405b1a48776
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This was added as a placeholder for the virt requirem=
ent suggested by=20
Maxim earlier.Agreed that this fdt otherwise has no significance for=20
sbsa-ref platform nor is being used by ACPI table created for wdt.</div><di=
v><br></div><div>-Shashi<br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, 14 Oct 2020 at 05:31, Graeme Greg=
ory &lt;<a href=3D"mailto:graeme@nuviainc.com">graeme@nuviainc.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, O=
ct 13, 2020 at 11:16:31AM -0400, Shashi Mallela wrote:<br>
&gt; Included the newly implemented SBSA generic watchdog device model into=
<br>
&gt; SBSA platform<br>
&gt; <br>
&gt; Signed-off-by: Shashi Mallela &lt;<a href=3D"mailto:shashi.mallela@lin=
aro.org" target=3D"_blank">shashi.mallela@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/sbsa-ref.c | 50 +++++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 50 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c<br>
&gt; index 9c3a893bedfd..97ed41607119 100644<br>
&gt; --- a/hw/arm/sbsa-ref.c<br>
&gt; +++ b/hw/arm/sbsa-ref.c<br>
&gt; @@ -30,6 +30,7 @@<br>
&gt;=C2=A0 #include &quot;exec/hwaddr.h&quot;<br>
&gt;=C2=A0 #include &quot;kvm_arm.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/arm/boot.h&quot;<br>
&gt; +#include &quot;hw/arm/fdt.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/block/flash.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/boards.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/ide/internal.h&quot;<br>
&gt; @@ -40,6 +41,7 @@<br>
&gt;=C2=A0 #include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/usb.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/char/pl011.h&quot;<br>
&gt; +#include &quot;hw/watchdog/wdt_sbsa_gwdt.h&quot;<br>
&gt;=C2=A0 #include &quot;net/net.h&quot;<br>
&gt;=C2=A0 #include &quot;qom/object.h&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -64,6 +66,9 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SBSA_GIC_DIST,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SBSA_GIC_REDIST,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SBSA_SECURE_EC,<br>
&gt; +=C2=A0 =C2=A0 SBSA_GWDT,<br>
&gt; +=C2=A0 =C2=A0 SBSA_GWDT_REFRESH,<br>
&gt; +=C2=A0 =C2=A0 SBSA_GWDT_CONTROL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SBSA_SMMU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SBSA_UART,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SBSA_RTC,<br>
&gt; @@ -104,6 +109,8 @@ static const MemMapEntry sbsa_ref_memmap[] =3D {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_GIC_DIST] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ 0x40060000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_GIC_REDIST] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{ 0x40080000, 0x04000000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_SECURE_EC] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 { 0x50000000, 0x00001000 },<br>
&gt; +=C2=A0 =C2=A0 [SBSA_GWDT_REFRESH] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x5=
0010000, 0x00001000 },<br>
&gt; +=C2=A0 =C2=A0 [SBSA_GWDT_CONTROL] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x5=
0011000, 0x00001000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_UART] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ 0x60000000, 0x00001000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_RTC] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 { 0x60010000, 0x00001000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_GPIO] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ 0x60020000, 0x00001000 },<br>
&gt; @@ -133,6 +140,8 @@ static const int sbsa_ref_irqmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_SECURE_UART_MM] =3D 9,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_AHCI] =3D 10,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_EHCI] =3D 11,<br>
&gt; +=C2=A0 =C2=A0 [SBSA_SMMU] =3D 12, /* ... to 15 */<br>
&gt; +=C2=A0 =C2=A0 [SBSA_GWDT] =3D 16,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, =
int idx)<br>
&gt; @@ -141,6 +150,30 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMach=
ineState *sms, int idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return arm_cpu_mp_affinity(idx, clustersz);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void create_wdt_fdt(SBSAMachineState *sms)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 char *nodename;<br>
&gt; +=C2=A0 =C2=A0 const char compat[] =3D &quot;arm,sbsa-gwdt&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hwaddr rbase =3D sbsa_ref_memmap[SBSA_GWDT_REFRESH].bas=
e;<br>
&gt; +=C2=A0 =C2=A0 hwaddr cbase =3D sbsa_ref_memmap[SBSA_GWDT_CONTROL].bas=
e;<br>
&gt; +=C2=A0 =C2=A0 int irq =3D sbsa_ref_irqmap[SBSA_GWDT];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nodename =3D g_strdup_printf(&quot;/watchdog@%&quot; PR=
Ix64, rbase);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_add_subnode(sms-&gt;fdt, nodename);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop(sms-&gt;fdt, nodename, &quot;compatibl=
e&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compat, sizeof(compat));<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_sized_cells(sms-&gt;fdt, nodename, &qu=
ot;reg&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02, rbase, 2, SBSA_GWDT_RMM=
IO_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02, cbase, 2, SBSA_GWDT_CMM=
IO_SIZE);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(sms-&gt;fdt, nodename, &quot;int=
errupts&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIC_FDT_IRQ_TYPE_PPI, irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIC_FDT_IRQ_FLAGS_LEVEL_HI);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cell(sms-&gt;fdt, nodename, &quot;time=
out-sec&quot;, 30);<br>
&gt; +=C2=A0 =C2=A0 g_free(nodename);<br>
&gt; +}<br>
&gt; +<br>
<br>
Is this actually used anywhere? I ask because SBSA-ref is not a FDT<br>
booting machine and only uses FDT to transfer some dynamic info to<br>
arm-tf/edk2 and is not a full description tree. Your ACPI patch in<br>
edk2 certainly does not use this info.<br>
<br>
Graeme<br>
<br>
<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Firmware on this machine only uses ACPI table to load OS=
, these limited<br>
&gt;=C2=A0 =C2=A0* device tree nodes are just to let firmware know the info=
 which varies from<br>
&gt; @@ -219,6 +252,7 @@ static void create_fdt(SBSAMachineState *sms)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(nodename);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 create_wdt_fdt(sms);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)<br>
&gt; @@ -447,6 +481,20 @@ static void create_rtc(const SBSAMachineState *sm=
s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_create_simple(&quot;pl031&quot;, base, qdev=
_get_gpio_in(sms-&gt;gic, irq));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void create_wdt(const SBSAMachineState *sms)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 hwaddr rbase =3D sbsa_ref_memmap[SBSA_GWDT_REFRESH].bas=
e;<br>
&gt; +=C2=A0 =C2=A0 hwaddr cbase =3D sbsa_ref_memmap[SBSA_GWDT_CONTROL].bas=
e;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev =3D qdev_new(TYPE_WDT_SBSA_GWDT);<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *s =3D SYS_BUS_DEVICE(dev);<br>
&gt; +=C2=A0 =C2=A0 int irq =3D sbsa_ref_irqmap[SBSA_GWDT];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(s, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(s, 0, rbase);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(s, 1, cbase);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms-&gt;gic, =
irq));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static DeviceState *gpio_key_dev;<br>
&gt;=C2=A0 static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)<br=
>
&gt;=C2=A0 {<br>
&gt; @@ -730,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_rtc(sms);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 create_wdt(sms);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_gpio(sms);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_ahci(sms);<br>
&gt; -- <br>
&gt; 2.18.4<br>
&gt; <br>
&gt; <br>
</blockquote></div>

--000000000000c1ecb405b1a48776--

