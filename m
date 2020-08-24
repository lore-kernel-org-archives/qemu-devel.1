Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5198C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A050206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="NzU1FJ4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A050206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAE0F-0008Kg-UA
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kADzI-0006xm-N4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:02:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kADzG-0008Ke-4D
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:02:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so3358748wrj.8
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+vqWYSNJ0LY8KO0ca8T7RfGtNqPStIgQcz/BRDlvLKc=;
 b=NzU1FJ4hFB1v05NQO5U2RbcAUrVwxifxRsvN0OF2gCoxS4nls6J6AbdyguGn/XSVmJ
 HXbhop1AMuUOsfP6RyG/k7lVMWUEAXCwo39666lESls/NNzijhkLnUQK2WG0T9/F0wL6
 V3tCd9CJ4SdoX8Onw2v4Ab/azhrkgeoxmxIky3p24YiyUPFUwFLGZvEU24n9JreneELW
 NaODiN6zpCg2Yo9EBCAParS5kL+cGV1THO3iUICeffmReYx9bpqEEYPVdpXP4RSAD1xB
 xIgPkzn4OH57/n7aXT3/hBkU8eh/mbARkSZJizfbjSwxvnMCFuCgzLztoEzzAVxAShmK
 Xshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+vqWYSNJ0LY8KO0ca8T7RfGtNqPStIgQcz/BRDlvLKc=;
 b=ciF14ZEy8DsSByfmw5wDE5JhIvPfz4gS++UnTEYOaXfdKMoAv6+r2ZFqS46sDPW0fb
 bETRszw8cGwnqMDYRqqYgtsKk2Msz1zd1gxPgSWbvPBqFmR9nwwFfZ/c+6RMJNSEKtL4
 tUTvDD69P9YBbTd4oht1PqE2tfdWSrqWdCPH9Ss2V1R55oUOizGsi9mR6Abiy58P/dEs
 h31wf43Mpvpoq98rMp1DpoQ9l+62m4WaGIFrZXL0SHPi9VLr8AJ3MwvoPcPpo2S8xx3D
 gWiQNEiMg0ayZzHo6g4Qn+48DMamQMZtu4eVdbvTpiJDO+k9cghLrNN/FRaakQbOlvfi
 /2Zg==
X-Gm-Message-State: AOAM531jyn+waqBlcX33U3HQvvrc/Krk5Q+yQXNSAV2ItKZSaO3Yq+te
 N5GzyHmlCDB/9MMnPQitv//NBtG+kf0au1mcxqmOaP6F2I8=
X-Google-Smtp-Source: ABdhPJz2elwxKQMD9qCrPPVezNCta28QQwMuoeOKiTcMoNnFtJN3jUSOLg9J1zmznSCLZh2UpuiATLjb1ogOId8m8Ek=
X-Received: by 2002:a5d:6942:: with SMTP id r2mr2406380wrw.76.1598281336199;
 Mon, 24 Aug 2020 08:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200821165403.26589-1-ani@anisinha.ca>
In-Reply-To: <20200821165403.26589-1-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 24 Aug 2020 20:32:04 +0530
Message-ID: <CAARzgwwrc0ioTsUibT1J2EiiW3QdOgFxyd4S5TtaFzPV+-JeBQ@mail.gmail.com>
Subject: Re: [PATCH V8] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004bc89405ada0dfe9"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004bc89405ada0dfe9
Content-Type: text/plain; charset="UTF-8"

Reminder to kindly review this patch.

On Fri, Aug 21, 2020 at 10:24 PM Ani Sinha <ani@anisinha.ca> wrote:

> We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with
> which
>
> we can turn on or off PCI device hotplug on the root bus. This flag can be
>
> used to prevent all PCI devices from getting hotplugged or unplugged from
> the
>
> root PCI bus.
>
> This feature is targetted mostly towards Windows VMs. It is useful in cases
>
> where some hypervisor admins want to deploy guest VMs in a way so that the
>
> users of the guest OSes are not able to hot-eject certain PCI devices from
>
> the Windows system tray. Laine has explained the use case here in detail:
>
> https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
>
>
>
> Julia has resolved this issue for PCIE buses with the following commit:
>
> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
>
>
>
> This commit attempts to introduce similar behavior for PCI root buses used
> in
>
> i440fx machine types (although in this case, we do not have a per-slot
>
> capability to turn hotplug on or off).
>
>
>
> Usage:
>
>    -global PIIX4_PM.acpi-root-pci-hotplug=off
>
>
>
> By default, this option is enabled which means that hotplug is turned on
> for
>
> the PCI root bus.
>
>
>
> The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for
> PCI-PCI
>
> bridges remain as is and can be used along with this new flag to control
> PCI
>
> hotplug on PCI bridges.
>
>
>
> This change has been tested using a Windows 2012R2 server guest image and
> also
>
> with a Windows 2019 server guest image on a Ubuntu 18.04 host using the
> latest
>
> master qemu from upstream.
>
>
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> ---
>
>  hw/acpi/pcihp.c         | 23 ++++++++++++++++++++++-
>
>  hw/acpi/piix4.c         |  5 ++++-
>
>  include/hw/acpi/pcihp.h |  2 +-
>
>  3 files changed, 27 insertions(+), 3 deletions(-)
>
>
>
> Change Log:
>
> V7..V8: Cosmetic. Removed extra new line in the patch. Rebased to latest
>
> upstream master and retested with both versions of Windows.
>
>
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>
> index 9e31ab2da4..39b1f74442 100644
>
> --- a/hw/acpi/pcihp.c
>
> +++ b/hw/acpi/pcihp.c
>
> @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
>
>      }
>
>  }
>
>
>
> +static void acpi_pcihp_disable_root_bus(void)
>
> +{
>
> +    static bool root_hp_disabled;
>
> +    PCIBus *bus;
>
> +
>
> +    if (root_hp_disabled) {
>
> +        return;
>
> +    }
>
> +
>
> +    bus = find_i440fx();
>
> +    if (bus) {
>
> +        /* setting the hotplug handler to NULL makes the bus
> non-hotpluggable */
>
> +        qbus_set_hotplug_handler(BUS(bus), NULL);
>
> +    }
>
> +    root_hp_disabled = true;
>
> +    return;
>
> +}
>
> +
>
>  static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
>
>  {
>
>      AcpiPciHpFind *find = opaque;
>
> @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>
>      }
>
>  }
>
>
>
> -void acpi_pcihp_reset(AcpiPciHpState *s)
>
> +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
>
>  {
>
> +    if (acpihp_root_off) {
>
> +        acpi_pcihp_disable_root_bus();
>
> +    }
>
>      acpi_set_pci_info();
>
>      acpi_pcihp_update(s);
>
>  }
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>
> index 26bac4f16c..e6163bb6ce 100644
>
> --- a/hw/acpi/piix4.c
>
> +++ b/hw/acpi/piix4.c
>
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>
>
>
>      AcpiPciHpState acpi_pci_hotplug;
>
>      bool use_acpi_hotplug_bridge;
>
> +    bool use_acpi_root_pci_hotplug;
>
>
>
>      uint8_t disable_s3;
>
>      uint8_t disable_s4;
>
> @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
>
>          pci_conf[0x5B] = 0x02;
>
>      }
>
>      pm_io_space_update(s);
>
> -    acpi_pcihp_reset(&s->acpi_pci_hotplug);
>
> +    acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
>
>  }
>
>
>
>  static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
>
> @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
>
>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>
>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>
>                       use_acpi_hotplug_bridge, true),
>
> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
>
> +                     use_acpi_root_pci_hotplug, true),
>
>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>
>                       acpi_memory_hotplug.is_enabled, true),
>
>      DEFINE_PROP_END_OF_LIST(),
>
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>
> index 8bc4a4c01d..02f4665767 100644
>
> --- a/include/hw/acpi/pcihp.h
>
> +++ b/include/hw/acpi/pcihp.h
>
> @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler
> *hotplug_dev,
>
>                                           Error **errp);
>
>
>
>  /* Called on reset */
>
> -void acpi_pcihp_reset(AcpiPciHpState *s);
>
> +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
>
>
>
>  extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
>
>
>
> --
>
> 2.17.1
>
>
>
>

--0000000000004bc89405ada0dfe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Reminder to kindly review this patch.</div></div><di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Aug 21, 2020 at 10:24 PM Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.c=
a">ani@anisinha.ca</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">We introduce a =
new global flag &#39;acpi-root-pci-hotplug&#39; for i440fx with which<br><b=
r>we can turn on or off PCI device hotplug on the root bus. This flag can b=
e<br><br>used to prevent all PCI devices from getting hotplugged or unplugg=
ed from the<br><br>root PCI bus.<br><br>This feature is targetted mostly to=
wards Windows VMs. It is useful in cases<br><br>where some hypervisor admin=
s want to deploy guest VMs in a way so that the<br><br>users of the guest O=
Ses are not able to hot-eject certain PCI devices from<br><br>the Windows s=
ystem tray. Laine has explained the use case here in detail:<br><br><a href=
=3D"https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html=
" rel=3D"noreferrer" target=3D"_blank">https://www.redhat.com/archives/libv=
ir-list/2020-February/msg00110.html</a><br><br><br><br>Julia has resolved t=
his issue for PCIE buses with the following commit:<br><br>530a0963184e57e7=
1a5b538 (&quot;pcie_root_port: Add hotplug disabling option&quot;)<br><br><=
br><br>This commit attempts to introduce similar behavior for PCI root buse=
s used in<br><br>i440fx machine types (although in this case, we do not hav=
e a per-slot<br><br>capability to turn hotplug on or off).<br><br><br><br>U=
sage:<br><br>=C2=A0 =C2=A0-global PIIX4_PM.acpi-root-pci-hotplug=3Doff<br><=
br><br><br>By default, this option is enabled which means that hotplug is t=
urned on for<br><br>the PCI root bus.<br><br><br><br>The previously existin=
g flag &#39;acpi-pci-hotplug-with-bridge-support&#39; for PCI-PCI<br><br>br=
idges remain as is and can be used along with this new flag to control PCI<=
br><br>hotplug on PCI bridges.<br><br><br><br>This change has been tested u=
sing a Windows 2012R2 server guest image and also<br><br>with a Windows 201=
9 server guest image on a Ubuntu 18.04 host using the latest<br><br>master =
qemu from upstream.<br><br><br><br>Signed-off-by: Ani Sinha &lt;<a href=3D"=
mailto:ani@anisinha.ca" target=3D"_blank">ani@anisinha.ca</a>&gt;<br><br>--=
-<br><br>=C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++++=
++++++++++++++++-<br><br>=C2=A0hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 5 ++++-<br><br>=C2=A0include/hw/acpi/pcihp.h |=C2=A0 2 +-<br>=
<br>=C2=A03 files changed, 27 insertions(+), 3 deletions(-)<br><br><br><br>=
Change Log:<br><br>V7..V8: Cosmetic. Removed extra new line in the patch. R=
ebased to latest<br><br>upstream master and retested with both versions of =
Windows.<br><br><br><br>diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c<br><=
br>index 9e31ab2da4..39b1f74442 100644<br><br>--- a/hw/acpi/pcihp.c<br><br>=
+++ b/hw/acpi/pcihp.c<br><br>@@ -104,6 +104,24 @@ static void acpi_set_pci_=
info(void)<br><br>=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0}<br><br><br><br>+stat=
ic void acpi_pcihp_disable_root_bus(void)<br><br>+{<br><br>+=C2=A0 =C2=A0 s=
tatic bool root_hp_disabled;<br><br>+=C2=A0 =C2=A0 PCIBus *bus;<br><br>+<br=
><br>+=C2=A0 =C2=A0 if (root_hp_disabled) {<br><br>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return;<br><br>+=C2=A0 =C2=A0 }<br><br>+<br><br>+=C2=A0 =C2=A0 bus =
=3D find_i440fx();<br><br>+=C2=A0 =C2=A0 if (bus) {<br><br>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* setting the hotplug handler to NULL makes the bus non-hotp=
luggable */<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qbus_set_hotplug_handler(BU=
S(bus), NULL);<br><br>+=C2=A0 =C2=A0 }<br><br>+=C2=A0 =C2=A0 root_hp_disabl=
ed =3D true;<br><br>+=C2=A0 =C2=A0 return;<br><br>+}<br><br>+<br><br>=C2=A0=
static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)<br><br>=
=C2=A0{<br><br>=C2=A0 =C2=A0 =C2=A0AcpiPciHpFind *find =3D opaque;<br><br>@=
@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)<br><br=
>=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0}<br><br><br><br>-void acpi_pcihp_reset=
(AcpiPciHpState *s)<br><br>+void acpi_pcihp_reset(AcpiPciHpState *s, bool a=
cpihp_root_off)<br><br>=C2=A0{<br><br>+=C2=A0 =C2=A0 if (acpihp_root_off) {=
<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_pcihp_disable_root_bus();<br><br>=
+=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0acpi_set_pci_info();<br><br>=C2=
=A0 =C2=A0 =C2=A0acpi_pcihp_update(s);<br><br>=C2=A0}<br><br>diff --git a/h=
w/acpi/piix4.c b/hw/acpi/piix4.c<br><br>index 26bac4f16c..e6163bb6ce 100644=
<br><br>--- a/hw/acpi/piix4.c<br><br>+++ b/hw/acpi/piix4.c<br><br>@@ -78,6 =
+78,7 @@ typedef struct PIIX4PMState {<br><br><br><br>=C2=A0 =C2=A0 =C2=A0A=
cpiPciHpState acpi_pci_hotplug;<br><br>=C2=A0 =C2=A0 =C2=A0bool use_acpi_ho=
tplug_bridge;<br><br>+=C2=A0 =C2=A0 bool use_acpi_root_pci_hotplug;<br><br>=
<br><br>=C2=A0 =C2=A0 =C2=A0uint8_t disable_s3;<br><br>=C2=A0 =C2=A0 =C2=A0=
uint8_t disable_s4;<br><br>@@ -324,7 +325,7 @@ static void piix4_pm_reset(D=
eviceState *dev)<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_conf[0x5B] =
=3D 0x02;<br><br>=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0pm_io_spa=
ce_update(s);<br><br>-=C2=A0 =C2=A0 acpi_pcihp_reset(&amp;s-&gt;acpi_pci_ho=
tplug);<br><br>+=C2=A0 =C2=A0 acpi_pcihp_reset(&amp;s-&gt;acpi_pci_hotplug,=
 !s-&gt;use_acpi_root_pci_hotplug);<br><br>=C2=A0}<br><br><br><br>=C2=A0sta=
tic void piix4_pm_powerdown_req(Notifier *n, void *opaque)<br><br>@@ -635,6=
 +636,8 @@ static Property piix4_pm_properties[] =3D {<br><br>=C2=A0 =C2=A0=
 =C2=A0DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),<br>=
<br>=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;acpi-pci-hotplug-with-bridge=
-support&quot;, PIIX4PMState,<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use_acpi_hotplug_bridge, true),<br><=
br>+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-root-pci-hotplug&quot;, PIIX4=
PMState,<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0use_acpi_root_pci_hotplug, true),<br><br>=C2=A0 =C2=A0 =
=C2=A0DEFINE_PROP_BOOL(&quot;memory-hotplug-support&quot;, PIIX4PMState,<br=
><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 acpi_memory_hotplug.is_enabled, true),<br><br>=C2=A0 =C2=A0 =C2=A0DE=
FINE_PROP_END_OF_LIST(),<br><br>diff --git a/include/hw/acpi/pcihp.h b/incl=
ude/hw/acpi/pcihp.h<br><br>index 8bc4a4c01d..02f4665767 100644<br><br>--- a=
/include/hw/acpi/pcihp.h<br><br>+++ b/include/hw/acpi/pcihp.h<br><br>@@ -67=
,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplu=
g_dev,<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Error **errp);<br><br><br><br>=C2=A0/* Called on reset */<br>=
<br>-void acpi_pcihp_reset(AcpiPciHpState *s);<br><br>+void acpi_pcihp_rese=
t(AcpiPciHpState *s, bool acpihp_root_off);<br><br><br><br>=C2=A0extern con=
st VMStateDescription vmstate_acpi_pcihp_pci_status;<br><br><br><br>-- <br>=
<br>2.17.1<br><br><br><br></blockquote></div></div>

--0000000000004bc89405ada0dfe9--

