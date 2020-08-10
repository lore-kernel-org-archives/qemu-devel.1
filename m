Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF156C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654422078D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Jb2lqsvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654422078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Dp-0001al-MF
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k59Cf-0000dY-Ch
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:55:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k59Cc-0002w3-Re
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:55:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so8682686wmi.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ia05M1MTQ8L9YZc61/7Vf/Iw3NENAl3xnJ184Um4CH8=;
 b=Jb2lqsvNjMel9KcagCyPA8S73zknP3+MV1Ag8mr5+nukTzjeH/bPSkAv/GTZJ+f0qy
 0N38RTJsc147/yoQ+iJyzwapRvIFWwOq/v+s1PILChmUJOR9YllbvbLO78HLdaNqeg+7
 jzR3JdmEX2fOJ2oPrBA23ET9wdZKZNxOlo+h6Y1XhsSDogrxpeoDQBTFNQV7mh6sqrS4
 RxGSAtPA5JaBvYjEhCvDBKbI4sO3ZMVehwD9LaVJ6Kx7x9NfIuEQzonJkIf5FCBVZsEU
 rbREbztfucirl+7dkSR4lvhWZnwAzJs//a7d7XOhKkxQlKu6+NRAEGmozefWVg7GWC/W
 uqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ia05M1MTQ8L9YZc61/7Vf/Iw3NENAl3xnJ184Um4CH8=;
 b=K/j73XInMEM3ajenpMaWIO97zfGLLlGzAjpOIwJteV+wPE3A71GiyEdR+UW5ArUpyV
 atYizCS3eiv0G3b0RorpnbLsqOzZei7LWYdY08CEEba7m0EV0j7yh8qGfp1rRdfHqFFE
 muH2b1D/4+cVKqazDClFfYDU63Xw+rqeWx8ukdXzG/ofIV2fWAMC+l2Kesg1SV9peRUV
 BfhK2VZ/QaQvq+8H53m701rM/LeEzm5PdND+zc+lSdfuWpnAtBosT14Z5jP+Zkcw6NEn
 alAmJ0x3SwK0Cgwo87tVSaIDVmRvUUV3kEcWiPC4BeNcg60iW3UDBqd3kOhHTpc3EeYT
 Lt3A==
X-Gm-Message-State: AOAM533KVabIDYEn/D48ufDeXa2bbfEgpBgwgo5MTes8u6IT6UmwfY2Z
 2xS/uL1LaTlisR3CVgAXhG28V9SB1dCYKGQmGDLBTw==
X-Google-Smtp-Source: ABdhPJxu8Q/zeKmC9d0PpCc3JQPeqtTmoGTldzUsbDE6muilASHauVGc4TMrNfmivnHhvQqEr+LqHnB8qakg6Ef36hg=
X-Received: by 2002:a1c:df02:: with SMTP id w2mr28146906wmg.137.1597071304739; 
 Mon, 10 Aug 2020 07:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
 <20200810104602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200810104602-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 10 Aug 2020 20:24:53 +0530
Message-ID: <CAARzgwwsuzw9rcQzu3MF7KZO8F+0PHMs3hCsiSPJCXJS-dEkhw@mail.gmail.com>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cce38505ac8723c2"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cce38505ac8723c2
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 10, 2020 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:
> > We introduce a new global flag for PIIX with which we can
> > turn on or off PCI device hotplug. This flag can be used
> > to prevent all PCI devices from getting hotplugged/unplugged
> > on the PCI bus. The new options disables all hotpluh HW
> > initialization code as well as the ACPI AMLs.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> Well we have a flag like this for pci bridges, right?
> So all that's left is an option to disable hotplug
> for the pci root, right?
> Wouldn't that be better than disabling it globally?


The idea is to have just one option to disable all hotplug globally. But if
you want to have two flags one for the bridges and one for the pci root, we
can certainly look into it.


>
> > ---
> >  hw/acpi/piix4.c      |  8 ++++++--
> >  hw/i386/acpi-build.c | 20 ++++++++++++++------
> >  2 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 26bac4f..8b13e86 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> >      bool use_acpi_hotplug_bridge;
> > +    bool use_acpi_pci_hotplug;
> >
> >      uint8_t disable_s3;
> >      uint8_t disable_s4;
> > @@ -595,8 +596,9 @@ static void
> piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >                            "acpi-gpe0", GPE_LEN);
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +    if (s->use_acpi_pci_hotplug)
> > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > +                        s->use_acpi_hotplug_bridge);
> >
> >      s->cpu_hotplug_legacy = true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",
> PIIX4PMState,
> >                       use_acpi_hotplug_bridge, true),
> > +    DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
> > +                     use_acpi_pci_hotplug, true),
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                       acpi_memory_hotplug.is_enabled, true),
> >      DEFINE_PROP_END_OF_LIST(),
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbb..343b9b6 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> >      bool s3_disabled;
> >      bool s4_disabled;
> >      bool pcihp_bridge_en;
> > +    bool pcihp_en;
> >      uint8_t s4_val;
> >      AcpiFadtData fadt;
> >      uint16_t cpu_hp_io_base;
> > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine,
> AcpiPmInfo *pm)
> >      pm->pcihp_bridge_en =
> >          object_property_get_bool(obj,
> "acpi-pci-hotplug-with-bridge-support",
> >                                   NULL);
> > +    pm->pcihp_en =
> > +        object_property_get_bool(obj, "acpi-pci-hotplug", NULL);
> > +
> >  }
> >
> >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > @@ -337,14 +341,16 @@ static void build_append_pcihp_notify_entry(Aml
> *method, int slot)
> >  }
> >
> >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> > -                                         bool pcihp_bridge_en)
> > +                                         bool pcihp_bridge_en, bool
> pcihp_en)
> >  {
> >      Aml *dev, *notify_method = NULL, *method;
> > -    QObject *bsel;
> > +    QObject *bsel = NULL;
> >      PCIBus *sec;
> >      int i;
> >
> > -    bsel = object_property_get_qobject(OBJECT(bus),
> ACPI_PCIHP_PROP_BSEL, NULL);
> > +    if (pcihp_en)
> > +        bsel = object_property_get_qobject(OBJECT(bus),
> > +                                           ACPI_PCIHP_PROP_BSEL, NULL);
> >      if (bsel) {
> >          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> >
> > @@ -439,7 +445,8 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
> >               */
> >              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >
> > -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> > +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> > +                                         pcihp_en);
> >          }
> >          /* slot descriptor has been composed, add it into parent
> context */
> >          aml_append(parent_scope, dev);
> > @@ -468,7 +475,7 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
> >      }
> >
> >      /* Notify about child bus events in any case */
> > -    if (pcihp_bridge_en) {
> > +    if (pcihp_bridge_en && pcihp_en) {
> >          QLIST_FOREACH(sec, &bus->child, sibling) {
> >              int32_t devfn = sec->parent_dev->devfn;
> >
> > @@ -1818,7 +1825,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          if (bus) {
> >              Aml *scope = aml_scope("PCI0");
> >              /* Scan all PCI buses. Generate tables to support hotplug.
> */
> > -            build_append_pci_bus_devices(scope, bus,
> pm->pcihp_bridge_en);
> > +            build_append_pci_bus_devices(scope, bus,
> pm->pcihp_bridge_en,
> > +                                         pm->pcihp_en);
> >
> >              if (TPM_IS_TIS_ISA(tpm)) {
> >                  if (misc->tpm_version == TPM_VERSION_2_0) {
> > --
> > 2.7.4
>
>

--000000000000cce38505ac8723c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Aug 10, 2020 at 8:17 PM Michael S. Tsirkin &lt;<a h=
ref=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204=
,204,204)">On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:<br>
&gt; We introduce a new global flag for PIIX with which we can<br>
&gt; turn on or off PCI device hotplug. This flag can be used<br>
&gt; to prevent all PCI devices from getting hotplugged/unplugged<br>
&gt; on the PCI bus. The new options disables all hotpluh HW<br>
&gt; initialization code as well as the ACPI AMLs.<br>
&gt; <br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=
=3D"_blank">ani@anisinha.ca</a>&gt;<br>
<br>
Well we have a flag like this for pci bridges, right?<br>
So all that&#39;s left is an option to disable hotplug<br>
for the pci root, right?<br>
Wouldn&#39;t that be better than disabling it globally?</blockquote><div di=
r=3D"auto"><br></div><div dir=3D"auto">The idea is to have just one option =
to disable all hotplug globally. But if you want to have two flags one for =
the bridges and one for the pci root, we can certainly look into it.</div><=
div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-l=
eft:1ex;border-left-color:rgb(204,204,204)"><br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++++--<br>
&gt;=C2=A0 hw/i386/acpi-build.c | 20 ++++++++++++++------<br>
&gt;=C2=A0 2 files changed, 20 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br>
&gt; index 26bac4f..8b13e86 100644<br>
&gt; --- a/hw/acpi/piix4.c<br>
&gt; +++ b/hw/acpi/piix4.c<br>
&gt; @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 AcpiPciHpState acpi_pci_hotplug;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool use_acpi_hotplug_bridge;<br>
&gt; +=C2=A0 =C2=A0 bool use_acpi_pci_hotplug;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t disable_s3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t disable_s4;<br>
&gt; @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryR=
egion *parent,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acpi-gpe0&quot;, GPE_LEN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(parent, GPE_BASE, &amp=
;s-&gt;io_gpe);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 acpi_pcihp_init(OBJECT(s), &amp;s-&gt;acpi_pci_hotplug,=
 bus, parent,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 s-&gt;use_acpi_hotplug_bridge);<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;use_acpi_pci_hotplug)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_pcihp_init(OBJECT(s), &amp;s-&gt;acp=
i_pci_hotplug, bus, parent,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 s-&gt;use_acpi_hotplug_bridge);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;cpu_hotplug_legacy =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_add_bool(OBJECT(s), &quot;cpu-hotp=
lug-legacy&quot;,<br>
&gt; @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMStat=
e, s4_val, 2),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-pci-hotplug-with-bridg=
e-support&quot;, PIIX4PMState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0use_acpi_hotplug_bridge, true),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-pci-hotplug&quot;, PIIX4PMS=
tate,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0use_acpi_pci_hotplug, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;memory-hotplug-support&quot=
;, PIIX4PMState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0acpi_memory_hotplug.is_enabled, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c<br>
&gt; index b7bcbbb..343b9b6 100644<br>
&gt; --- a/hw/i386/acpi-build.c<br>
&gt; +++ b/hw/i386/acpi-build.c<br>
&gt; @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool s3_disabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool s4_disabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool pcihp_bridge_en;<br>
&gt; +=C2=A0 =C2=A0 bool pcihp_en;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t s4_val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AcpiFadtData fadt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t cpu_hp_io_base;<br>
&gt; @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine=
, AcpiPmInfo *pm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pm-&gt;pcihp_bridge_en =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_get_bool(obj, &quot;=
acpi-pci-hotplug-with-bridge-support&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt; +=C2=A0 =C2=A0 pm-&gt;pcihp_en =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_get_bool(obj, &quot;acpi-=
pci-hotplug&quot;, NULL);<br>
&gt; +<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void acpi_get_misc_info(AcpiMiscInfo *info)<br>
&gt; @@ -337,14 +341,16 @@ static void build_append_pcihp_notify_entry(Aml =
*method, int slot)<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void build_append_pci_bus_devices(Aml *parent_scope, PCIB=
us *bus,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bool pcihp_bridge_en)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bool pcihp_bridge_en, bool pcihp_en)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Aml *dev, *notify_method =3D NULL, *method;<br>
&gt; -=C2=A0 =C2=A0 QObject *bsel;<br>
&gt; +=C2=A0 =C2=A0 QObject *bsel =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 PCIBus *sec;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_=
PCIHP_PROP_BSEL, NULL);<br>
&gt; +=C2=A0 =C2=A0 if (pcihp_en)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bsel =3D object_property_get_qobject(OBJE=
CT(bus),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ACPI_PCIHP_PROP_BSEL, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (bsel) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t bsel_val =3D qnum_get_uint(=
qobject_to(QNum, bsel));<br>
&gt;=C2=A0 <br>
&gt; @@ -439,7 +445,8 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIBus *sec_bus =3D pc=
i_bridge_get_sec_bus(PCI_BRIDGE(pdev));<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_pci_bus_device=
s(dev, sec_bus, pcihp_bridge_en);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_pci_bus_device=
s(dev, sec_bus, pcihp_bridge_en,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pcihp_en);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* slot descriptor has been composed=
, add it into parent context */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(parent_scope, dev);<br>
&gt; @@ -468,7 +475,7 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Notify about child bus events in any case */<br=
>
&gt; -=C2=A0 =C2=A0 if (pcihp_bridge_en) {<br>
&gt; +=C2=A0 =C2=A0 if (pcihp_bridge_en &amp;&amp; pcihp_en) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIST_FOREACH(sec, &amp;bus-&gt;chil=
d, sibling) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t devfn =3D sec-=
&gt;parent_dev-&gt;devfn;<br>
&gt;=C2=A0 <br>
&gt; @@ -1818,7 +1825,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bus) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *scope =3D aml_sco=
pe(&quot;PCI0&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Scan all PCI buses.=
 Generate tables to support hotplug. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_pci_bus_device=
s(scope, bus, pm-&gt;pcihp_bridge_en);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_pci_bus_device=
s(scope, bus, pm-&gt;pcihp_bridge_en,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pm-&gt;pcihp_en);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TPM_IS_TIS_ISA(tpm=
)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (misc=
-&gt;tpm_version =3D=3D TPM_VERSION_2_0) {<br>
&gt; -- <br>
&gt; 2.7.4<br>
<br>
</blockquote></div></div>

--000000000000cce38505ac8723c2--

