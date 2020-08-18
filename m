Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1886C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0F5204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="qOD538d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0F5204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yj8-0007yq-VZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k7yiR-0007Y2-3Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:19:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k7yiO-0008I2-I8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:19:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id 88so17735479wrh.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tcu9f0LgvJVE3aFnufGvJv5JSNnOgbzj+pj1K9hGwTs=;
 b=qOD538d6mlfOUanRE9rA5OPjSBEgOvRlQ75P/+2rOSaUwt9oGyXuUExmfZmy5kZTlL
 KPQhws3H4ZpMaiT4dS2EHFiwFw2bOa0/xGClY5ajPXQQTu8iZIwJHSBXWyYxC1oZuFy5
 ns0ou9V53GW055pS8KV8EFu9IAgbgNsx9g8tdONy8VW3q5RXBePwjZdC/zb6+6DEK4kq
 LQhEbP+vM2Q3ErBklE6HBNPF594axblsAYutE+3LNDHGldxAbiZAw7DaUdfFhm6wcnxV
 zLmluORM8vYZ7TvPU3SOy10jyYWYDQ0/VSYplIOM+seF8qRzamCjXTQGe13evHlR5FjF
 QFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tcu9f0LgvJVE3aFnufGvJv5JSNnOgbzj+pj1K9hGwTs=;
 b=AoX2DmCstlJWt+GtW6rn2RbzHk1Z1ZcXBDYzXMsALHuh/cVhvnnjEaeGUsnCK28z+2
 MIiFoxOA8rlAPhtcLW8L9pZT+u6xoZXIwq/raSMTjnY1zn4a2NMuf9cV/zZq52kf4Qby
 tyZFYX6Nt7aOBthYfscmI5970MGroXq/fHlYv5+3+tV9ndWQQr37bbKgPCFput6dhnKc
 WKZLimVSuA+VZk+rY2SOBbnVuYohTCShBdErlikdlKuPngJSMabuaq6SK8BYqfw58+Ch
 j9V7USOQ+ebnyAZA7spx8OpXvBAJeaFNKRTeQUa09ghTKrBfCAbeaixwlIn101HIXxFX
 eu6Q==
X-Gm-Message-State: AOAM532XdqfN8IPNR5wturBPKLcWwiJR9bJPpQaN5z0GkzVSyiy8x/Ui
 L8OvglAiAE9VdHp10ZcINsDB1oj2LHi8l/U/uOkvgg==
X-Google-Smtp-Source: ABdhPJxNMiXEN8+WlmXe7RDNXRJ5K/CZoVUhnMFQQri5KXxQcHeOU2DpLLO8isW/U0XI9Wp5xuvl7URg6dhYCjBU2Pc=
X-Received: by 2002:adf:8282:: with SMTP id 2mr19243183wrc.76.1597745974582;
 Tue, 18 Aug 2020 03:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <1597151528-75766-1-git-send-email-ani@anisinha.ca>
 <CAARzgwxZNpiTLn8aome=tVxHe-ut=Pkbte=McUbr=B2xx6kRfQ@mail.gmail.com>
 <ffc51bbc-3aa1-ced3-60f2-033291fd1cdc@redhat.com>
In-Reply-To: <ffc51bbc-3aa1-ced3-60f2-033291fd1cdc@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 18 Aug 2020 15:49:23 +0530
Message-ID: <CAARzgwzk4i_PD_Emkj-TjgAFt3y=XmodeOfc2DzPXhcg_NK9bA@mail.gmail.com>
Subject: Re: [PATCH V2] Introduce a new flag for piix to disable root bus PCI
 hotplug
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000041b76505ad2439d1"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000041b76505ad2439d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is not a workaround, this is a feature we need badly. We have
discussed this at length. Igor suggested we have one additional global flag
to disable all pci hotplug. But then that leads to strange case when pci
hotplug on the bridges are enabled (we have a separate flag for that).
Hence, I think we can simply add another flag to disable hotplug just for
the pci root bus.

On Tue, Aug 18, 2020 at 3:46 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi,
>
>
>
> On 8/18/20 11:54 AM, Ani Sinha wrote:
>
> > Igor etc, I just tested this patch using a Windows 2012 R2 image and
>
> > it seems to be working. Any feedbacks on this patch?
>
> >
>
> > On Tue, Aug 11, 2020 at 6:42 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> >>
>
> >> We introduce a new global flag for PIIX with which we can turn on or
> off PCI
>
> >> device hotplug on the root bus. This flag can be used to prevent all P=
CI
>
> >> devices from getting hotplugged or unplugged from the root PCI bus.
>
> >>
>
> >> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> >> ---
>
> >>  hw/acpi/piix4.c      |  3 +++
>
> >>  hw/i386/acpi-build.c | 20 ++++++++++++++++----
>
> >>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> >>
>
> >> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>
> >> index 26bac4f..94ec35a 100644
>
> >> --- a/hw/acpi/piix4.c
>
> >> +++ b/hw/acpi/piix4.c
>
> >> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>
> >>
>
> >>      AcpiPciHpState acpi_pci_hotplug;
>
> >>      bool use_acpi_hotplug_bridge;
>
> >> +    bool use_acpi_root_pci_hotplug;
>
> >>
>
> >>      uint8_t disable_s3;
>
> >>      uint8_t disable_s4;
>
> >> @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] =3D {
>
> >>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>
> >>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",
> PIIX4PMState,
>
> >>                       use_acpi_hotplug_bridge, true),
>
> >> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
>
> >> +                     use_acpi_root_pci_hotplug, true),
>
>
>
> From what I understood here, this file is already pretty twisted
>
> and Igor doesn't want more workarounds:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg690564.html
>
>
>
> =C2=AF\_(=E3=83=84)_/=C2=AF
>
>
>
> >>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>
> >>                       acpi_memory_hotplug.is_enabled, true),
>
> >>      DEFINE_PROP_END_OF_LIST(),
>
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>
> >> index b7bcbbb..a82e5c1 100644
>
> >> --- a/hw/i386/acpi-build.c
>
> >> +++ b/hw/i386/acpi-build.c
>
> >> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>
> >>      bool s3_disabled;
>
> >>      bool s4_disabled;
>
> >>      bool pcihp_bridge_en;
>
> >> +    bool pcihp_root_en;
>
> >>      uint8_t s4_val;
>
> >>      AcpiFadtData fadt;
>
> >>      uint16_t cpu_hp_io_base;
>
> >> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine=
,
> AcpiPmInfo *pm)
>
> >>      pm->pcihp_bridge_en =3D
>
> >>          object_property_get_bool(obj,
> "acpi-pci-hotplug-with-bridge-support",
>
> >>                                   NULL);
>
> >> +    pm->pcihp_root_en =3D
>
> >> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
>
> >> +
>
> >>  }
>
> >>
>
> >>  static void acpi_get_misc_info(AcpiMiscInfo *info)
>
> >> @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Aml
> *method, int slot)
>
> >>  }
>
> >>
>
> >>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus
> *bus,
>
> >> -                                         bool pcihp_bridge_en)
>
> >> +                                         bool pcihp_bridge_en,
>
> >> +                                         bool pcihp_root_en)
>
> >>  {
>
> >>      Aml *dev, *notify_method =3D NULL, *method;
>
> >>      QObject *bsel;
>
> >>      PCIBus *sec;
>
> >>      int i;
>
> >> +    bool root_bus =3D pci_bus_is_root(bus);
>
> >> +    bool root_pcihp_disabled =3D (root_bus && !pcihp_root_en);
>
> >>
>
> >>      bsel =3D object_property_get_qobject(OBJECT(bus),
> ACPI_PCIHP_PROP_BSEL, NULL);
>
> >>      if (bsel) {
>
> >> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
>
> >>          bool bridge_in_acpi;
>
> >>
>
> >>          if (!pdev) {
>
> >> +            /* skip if pci hotplug for the root bus is disabled */
>
> >> +            if (root_pcihp_disabled)
>
> >> +                continue;
>
> >>              if (bsel) { /* add hotplug slots for non present devices =
*/
>
> >>                  dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>
> >>                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)))=
;
>
> >> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
>
> >>              method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);
>
> >>              aml_append(method, aml_return(aml_int(s3d)));
>
> >>              aml_append(dev, method);
>
> >> -        } else if (hotplug_enabled_dev) {
>
> >> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
>
> >>              /* add _SUN/_EJ0 to make slot hotpluggable  */
>
> >>              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>
> >>
>
> >> @@ -439,7 +449,8 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
>
> >>               */
>
> >>              PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pde=
v));
>
> >>
>
> >> -            build_append_pci_bus_devices(dev, sec_bus,
> pcihp_bridge_en);
>
> >> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_e=
n,
>
> >> +                                         pcihp_root_en);
>
> >>          }
>
> >>          /* slot descriptor has been composed, add it into parent
> context */
>
> >>          aml_append(parent_scope, dev);
>
> >> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
>
> >>          if (bus) {
>
> >>              Aml *scope =3D aml_scope("PCI0");
>
> >>              /* Scan all PCI buses. Generate tables to support hotplug=
.
> */
>
> >> -            build_append_pci_bus_devices(scope, bus,
> pm->pcihp_bridge_en);
>
> >> +            build_append_pci_bus_devices(scope, bus,
> pm->pcihp_bridge_en,
>
> >> +                                         pm->pcihp_root_en);
>
> >>
>
> >>              if (TPM_IS_TIS_ISA(tpm)) {
>
> >>                  if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>
> >> --
>
> >> 2.7.4
>
> >>
>
> >
>
>
>
>

--00000000000041b76505ad2439d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">This is not a workaround, this is a feature we need =
badly. We have discussed this at length. Igor suggested we have one additio=
nal global flag to disable all pci hotplug. But then that leads to strange =
case when pci hotplug on the bridges are enabled (we have a separate flag f=
or that). Hence, I think we can simply add another flag to disable hotplug =
just for the pci root bus.=C2=A0</div></div><div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 18, 2020 at 3:46 PM =
Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
padding-left:1ex;border-left-color:rgb(204,204,204)">Hi,<br><br><br><br>On =
8/18/20 11:54 AM, Ani Sinha wrote:<br><br>&gt; Igor etc, I just tested this=
 patch using a Windows 2012 R2 image and<br><br>&gt; it seems to be working=
. Any feedbacks on this patch?<br><br>&gt; <br><br>&gt; On Tue, Aug 11, 202=
0 at 6:42 PM Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=3D"_bl=
ank">ani@anisinha.ca</a>&gt; wrote:<br><br>&gt;&gt;<br><br>&gt;&gt; We intr=
oduce a new global flag for PIIX with which we can turn on or off PCI<br><b=
r>&gt;&gt; device hotplug on the root bus. This flag can be used to prevent=
 all PCI<br><br>&gt;&gt; devices from getting hotplugged or unplugged from =
the root PCI bus.<br><br>&gt;&gt;<br><br>&gt;&gt; Signed-off-by: Ani Sinha =
&lt;<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@anisinha.ca</a=
>&gt;<br><br>&gt;&gt; ---<br><br>&gt;&gt;=C2=A0 hw/acpi/piix4.c=C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +++<br><br>&gt;&gt;=C2=A0 hw/i386/acpi-build.c | 20 ++=
++++++++++++++----<br><br>&gt;&gt;=C2=A0 2 files changed, 19 insertions(+),=
 4 deletions(-)<br><br>&gt;&gt;<br><br>&gt;&gt; diff --git a/hw/acpi/piix4.=
c b/hw/acpi/piix4.c<br><br>&gt;&gt; index 26bac4f..94ec35a 100644<br><br>&g=
t;&gt; --- a/hw/acpi/piix4.c<br><br>&gt;&gt; +++ b/hw/acpi/piix4.c<br><br>&=
gt;&gt; @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {<br><br>&gt;&gt;<br>=
<br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 AcpiPciHpState acpi_pci_hotplug;<br><br>&g=
t;&gt;=C2=A0 =C2=A0 =C2=A0 bool use_acpi_hotplug_bridge;<br><br>&gt;&gt; +=
=C2=A0 =C2=A0 bool use_acpi_root_pci_hotplug;<br><br>&gt;&gt;<br><br>&gt;&g=
t;=C2=A0 =C2=A0 =C2=A0 uint8_t disable_s3;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=
=A0 uint8_t disable_s4;<br><br>&gt;&gt; @@ -635,6 +636,8 @@ static Property=
 piix4_pm_properties[] =3D {<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PRO=
P_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),<br><br>&gt;&gt;=C2=
=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-pci-hotplug-with-bridge-suppo=
rt&quot;, PIIX4PMState,<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_acpi_hotplug_bridge, tr=
ue),<br><br>&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-root-pci-ho=
tplug&quot;, PIIX4PMState,<br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_acpi_root_pci_hotplug, tru=
e),<br><br><br><br>From what I understood here, this file is already pretty=
 twisted<br><br>and Igor doesn&#39;t want more workarounds:<br><br><a href=
=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg690564.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-devel@n=
ongnu.org/msg690564.html</a><br><br><br><br>=C2=AF\_(=E3=83=84)_/=C2=AF<br>=
<br><br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;memory-hotp=
lug-support&quot;, PIIX4PMState,<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_memory_hotplug=
.is_enabled, true),<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_=
LIST(),<br><br>&gt;&gt; diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-bu=
ild.c<br><br>&gt;&gt; index b7bcbbb..a82e5c1 100644<br><br>&gt;&gt; --- a/h=
w/i386/acpi-build.c<br><br>&gt;&gt; +++ b/hw/i386/acpi-build.c<br><br>&gt;&=
gt; @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {<br><br>&gt;&gt;=C2=A0 =C2=
=A0 =C2=A0 bool s3_disabled;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 bool s4_di=
sabled;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 bool pcihp_bridge_en;<br><br>&g=
t;&gt; +=C2=A0 =C2=A0 bool pcihp_root_en;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=
=A0 uint8_t s4_val;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 AcpiFadtData fadt;<=
br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t cpu_hp_io_base;<br><br>&gt;&gt=
; @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, A=
cpiPmInfo *pm)<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 pm-&gt;pcihp_bridge_en =
=3D<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_get_b=
ool(obj, &quot;acpi-pci-hotplug-with-bridge-support&quot;,<br><br>&gt;&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br><br>&gt;&gt; =
+=C2=A0 =C2=A0 pm-&gt;pcihp_root_en =3D<br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 object_property_get_bool(obj, &quot;acpi-root-pci-hotplug&quot;,=
 NULL);<br><br>&gt;&gt; +<br><br>&gt;&gt;=C2=A0 }<br><br>&gt;&gt;<br><br>&g=
t;&gt;=C2=A0 static void acpi_get_misc_info(AcpiMiscInfo *info)<br><br>&gt;=
&gt; @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Aml =
*method, int slot)<br><br>&gt;&gt;=C2=A0 }<br><br>&gt;&gt;<br><br>&gt;&gt;=
=C2=A0 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *=
bus,<br><br>&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bool pcihp_bridge_en)<br><br>&gt;&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool pcihp_bridg=
e_en,<br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bool pcihp_root_en)<br><br>&gt;&gt;=C2=A0 {<br><br>&gt;=
&gt;=C2=A0 =C2=A0 =C2=A0 Aml *dev, *notify_method =3D NULL, *method;<br><br=
>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 QObject *bsel;<br><br>&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 PCIBus *sec;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br><br>&gt;&=
gt; +=C2=A0 =C2=A0 bool root_bus =3D pci_bus_is_root(bus);<br><br>&gt;&gt; =
+=C2=A0 =C2=A0 bool root_pcihp_disabled =3D (root_bus &amp;&amp; !pcihp_roo=
t_en);<br><br>&gt;&gt;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 bsel =3D object_=
property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);<br><br>&gt;&=
gt;=C2=A0 =C2=A0 =C2=A0 if (bsel) {<br><br>&gt;&gt; @@ -361,6 +368,9 @@ sta=
tic void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,<br><b=
r>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool bridge_in_acpi;<br><br>&g=
t;&gt;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pdev) {<br><b=
r>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* skip if pci hotplu=
g for the root bus is disabled */<br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (root_pcihp_disabled)<br><br>&gt;&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br><br>&gt;&gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bsel) { /* add hotplug slots =
for non present devices */<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D aml_device(&quot;S%.02X&quot;, PCI_=
DEVFN(slot, 0));<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 aml_append(dev, aml_name_decl(&quot;_SUN&quot;, aml_in=
t(slot)));<br><br>&gt;&gt; @@ -419,7 +429,7 @@ static void build_append_pci=
_bus_devices(Aml *parent_scope, PCIBus *bus,<br><br>&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_method(&quot;_S3D&quot;, =
0, AML_NOTSERIALIZED);<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 aml_append(method, aml_return(aml_int(s3d)));<br><br>&gt;&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(dev, method);<b=
r><br>&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (hotplug_enabled_dev)=
 {<br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (hotplug_enabled_=
dev &amp;&amp; !root_pcihp_disabled) {<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* add _SUN/_EJ0 to make slot hotpluggable=C2=
=A0 */<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_=
append(dev, aml_name_decl(&quot;_SUN&quot;, aml_int(slot)));<br><br>&gt;&gt=
;<br><br>&gt;&gt; @@ -439,7 +449,8 @@ static void build_append_pci_bus_devi=
ces(Aml *parent_scope, PCIBus *bus,<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRI=
DGE(pdev));<br><br>&gt;&gt;<br><br>&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);<=
br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_pci=
_bus_devices(dev, sec_bus, pcihp_bridge_en,<br><br>&gt;&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcihp_root_en);<=
br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br>&gt;&gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* slot descriptor has been composed, add it in=
to parent context */<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_=
append(parent_scope, dev);<br><br>&gt;&gt; @@ -1818,7 +1829,8 @@ build_dsdt=
(GArray *table_data, BIOSLinker *linker,<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (bus) {<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Aml *scope =3D aml_scope(&quot;PCI0&quot;);<br><br>&gt;&g=
t;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Scan all PCI buses. G=
enerate tables to support hotplug. */<br><br>&gt;&gt; -=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 build_append_pci_bus_devices(scope, bus, pm-&gt;pcihp=
_bridge_en);<br><br>&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bui=
ld_append_pci_bus_devices(scope, bus, pm-&gt;pcihp_bridge_en,<br><br>&gt;&g=
t; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pm-&gt;pcihp_root_en);<br><br>&gt;&gt;<br><br>&gt;&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TPM_IS_TIS_ISA(tpm)) {<br><br>&gt;&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (misc-&gt=
;tpm_version =3D=3D TPM_VERSION_2_0) {<br><br>&gt;&gt; --<br><br>&gt;&gt; 2=
.7.4<br><br>&gt;&gt;<br><br>&gt; <br><br><br><br></blockquote></div></div>

--00000000000041b76505ad2439d1--

