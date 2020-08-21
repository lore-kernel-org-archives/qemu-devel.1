Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBAAC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEFE20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="m/Zx23Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEFE20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95T5-0007R4-Bg
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k94zZ-0007vU-JY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:13:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k94zW-0007nd-W2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:13:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id p14so1469278wmg.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KTJ84bLsfnq5pjvazwbe6znwCuqOyrGHCvam4hwbCsY=;
 b=m/Zx23Ecgop//COvbfMOKD1cuGyeMVNndSdIvbPtWhxOrE7J5FH1Q1hB/+GDvs+J1p
 LGNQyppMr/KiXqrilRPdpKGb+eG87Vb+dV0XAkl30VRKAn104r28ZZGpUa6o82Z4Xelm
 Gno9qkVYimSe0e3XGZjalzyhgd3Kt0KvsWCWh+1aHGI9GqEIxC2Ll7/GZ9wJ+Lq5OCam
 taaVMN97rRckPrPQNv/XBUqpwk04hT3Wc2D7ZyDDuPW+5geWGOBenOjSS9orde9kNd7z
 gJidYojYSk4crZd3pMQ6RsEPb6dBKwnlqIt7rNihf0w3OMCIC06uqYLWddC61ogPMcG6
 BeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KTJ84bLsfnq5pjvazwbe6znwCuqOyrGHCvam4hwbCsY=;
 b=syDCFok2dr9Sefs9fgybI3cebt2890g1cvgfQQqvQ7Y9jB8DwVhXn8LDDXpa+jy/nS
 5xyY+PMTfI/IFd6F/phSXGqqJuy0SskONrEGt1qjdTZVYUPBsJIj9vX7cqktJYc5tgeK
 23kw5aUskEtr/0hd3GUB8E/8X/CVCfrhkndBsnN2wfq4PL5us0FKbVBoKlYGXTQ6k2V0
 bQATvgthfn51KG3Kp8W/AOueVfEUF5/B2SKfEw6R40z6y1bBZkx4ytVmeeFyMJvv4Eqq
 m1skQB5KaToJBEzubTifiF2FXkZPe/52PYHSPrCLAwxliWfdJWhxt92CSsqqLWz6Jaqa
 vuXA==
X-Gm-Message-State: AOAM532SewZ6wy9e2dkOQZbgpTWYYKN5MGzdctg0rYIlgMJ1kYGKqsWs
 hhIvuEgw/zKYmg8WIFhc5CiEpbdiwBcobDTGkJ6ZJw==
X-Google-Smtp-Source: ABdhPJzs+Kx1Wufv1nYRjiy8lK1OIFPu4nSZXuYotkB90Q3GdnzK5UpmocjF2wMGpuPnM0XWpmQ+BYrBYn51sj2MB0s=
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr3272217wml.35.1598008428973; 
 Fri, 21 Aug 2020 04:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAARzgwyuL_joY_4wq8=WY7U=E67F2roPJ36kaQLJFRVqLgpGXg@mail.gmail.com>
 <96C3BCCD-7A5E-439D-8EDD-927D188C0946@anisinha.ca>
 <20200821111612.5b04bc5e@redhat.com>
In-Reply-To: <20200821111612.5b04bc5e@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 21 Aug 2020 16:43:37 +0530
Message-ID: <CAARzgwy17=msoLQ662VXfdMOLJd7=hBMpC6LNN_C5fvGgMM1YQ@mail.gmail.com>
Subject: Re: [PATCH V6] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 2:46 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 20 Aug 2020 22:11:41 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > > On Aug 20, 2020, at 9:11 PM, Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > > =EF=BB=BFOn Thu, Aug 20, 2020 at 7:37 PM Igor Mammedov <imammedo@redh=
at.com> wrote:
> > >>
> > >>> On Thu, 20 Aug 2020 14:51:56 +0530
> > >>> Ani Sinha <ani@anisinha.ca> wrote:
> > >>>
> > >>> We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx w=
ith which
> > >>> we can turn on or off PCI device hotplug on the root bus. This flag=
 can be
> > >>> used to prevent all PCI devices from getting hotplugged or unplugge=
d from the
> > >>> root PCI bus.
> > >>> This feature is targetted mostly towards Windows VMs. It is useful =
in cases
> > >>> where some hypervisor admins want to deploy guest VMs in a way so t=
hat the
> > >>> users of the guest OSes are not able to hot-eject certain PCI devic=
es from
> > >>> the Windows system tray. Laine has explained the use case here in d=
etail:
> > >>> https://www.redhat.com/archives/libvir-list/2020-February/msg00110.=
html
> > >>>
> > >>> Julia has resolved this issue for PCIE buses with the following com=
mit:
> > >>> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling opt=
ion")
> > >>>
> > >>> This commit attempts to introduce similar behavior for PCI root bus=
es used in
> > >>> i440fx machine types (although in this case, we do not have a per-s=
lot
> > >>> capability to turn hotplug on or off).
> > >>>
> > >>> Usage:
> > >>>   -global PIIX4_PM.acpi-root-pci-hotplug=3Doff
> > >>>
> > >>> By default, this option is enabled which means that hotplug is turn=
ed on for
> > >>> the PCI root bus.
> > >>>
> > >>> The previously existing flag 'acpi-pci-hotplug-with-bridge-support'=
 for PCI-PCI
> > >>> bridges remain as is and can be used along with this new flag to co=
ntrol PCI
> > >>> hotplug on PCI bridges.
> > >>>
> > >>> This change has been tested using a Windows 2012R2 server guest ima=
ge and also
> > >>> with a Windows 2019 server guest image on a Ubuntu 18.04 host using=
 the latest
> > >>> master qemu from upstream (v5.1.0 tag).
> > >>>
> > >>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > >>> ---
> > >>> hw/acpi/piix4.c      |  8 ++++++--
> > >>> hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
> > >>> 2 files changed, 25 insertions(+), 9 deletions(-)
> > >>>
> > >>> Change Log:
> > >>> V5..V6: specified upstream master tag information off which this pa=
tch is
> > >>> based off of.
> > >>>
> > >>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > >>> index 26bac4f16c..4f436e5bf3 100644
> > >>> --- a/hw/acpi/piix4.c
> > >>> +++ b/hw/acpi/piix4.c
> > >>> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > >>>
> > >>>     AcpiPciHpState acpi_pci_hotplug;
> > >>>     bool use_acpi_hotplug_bridge;
> > >>> +    bool use_acpi_root_pci_hotplug;
> > >>>
> > >>>     uint8_t disable_s3;
> > >>>     uint8_t disable_s4;
> > >>
> > >>> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(Memo=
ryRegion *parent,
> > >>>                           "acpi-gpe0", GPE_LEN);
> > >>>     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> > >>>
> > >>> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > >>> -                    s->use_acpi_hotplug_bridge);
> > >>> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug=
)
> > >>> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, pare=
nt,
> > >>> +                        s->use_acpi_hotplug_bridge);
> > >> If intent was to disable hardware part of ACPI hotplug,
> > >> then this hunk is not enough. I'd say it introduces bug since you ar=
e leaving
> > >> device_add/del route open and "_E01" AML code around trying to acces=
s no longer
> > >> described/present io ports.
> > >>
> > >> Without this hunk patch is fine, as a means to hide hotplug from Win=
dows.
> > >>
> > >> If you'd like to disable hw part, you will need to consider case whe=
re hotplug is
> > >> disabled completly and block all related AML and block device_add|de=
l.
> > >> So it would be a bit more than above hunk.
> > >
> > > Ok maybe I will just remove it.
> > >
> > >>
> > >>
> > >>>     s->cpu_hotplug_legacy =3D true;
> > >>>     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > >>> @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] =3D {
> > >>>     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2)=
,
> > >>>     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4P=
MState,
> > >>>                      use_acpi_hotplug_bridge, true),
> > >>> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > >>> +                     use_acpi_root_pci_hotplug, true),
> > >>>     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > >>>                      acpi_memory_hotplug.is_enabled, true),
> > >>>     DEFINE_PROP_END_OF_LIST(),
> > >>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > >>> index b7bcbbbb2a..19a1702ad1 100644
> > >>> --- a/hw/i386/acpi-build.c
> > >>> +++ b/hw/i386/acpi-build.c
> > >>> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> > >>>     bool s3_disabled;
> > >>>     bool s4_disabled;
> > >>>     bool pcihp_bridge_en;
> > >>> +    bool pcihp_root_en;
> > >>>     uint8_t s4_val;
> > >>>     AcpiFadtData fadt;
> > >>>     uint16_t cpu_hp_io_base;
> > >>> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *mach=
ine, AcpiPmInfo *pm)
> > >>>     pm->pcihp_bridge_en =3D
> > >>>         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge=
-support",
> > >>>                                  NULL);
> > >>> +    pm->pcihp_root_en =3D
> > >>> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NUL=
L);
> > >>> +
> > >>> }
> > >>>
> > >>> static void acpi_get_misc_info(AcpiMiscInfo *info)
> > >>> @@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry(A=
ml *method, int slot)
> > >>> }
> > >>>
> > >>> static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus =
*bus,
> > >>> -                                         bool pcihp_bridge_en)
> > >>> +                                         bool pcihp_bridge_en,
> > >>> +                                         bool pcihp_root_en)
> > >>> {
> > >>>     Aml *dev, *notify_method =3D NULL, *method;
> > >>>     QObject *bsel;
> > >>>     PCIBus *sec;
> > >>>     int i;
> > >>> +    bool root_bus =3D pci_bus_is_root(bus);
> > >>> +    bool root_pcihp_disabled =3D (root_bus && !pcihp_root_en);
> > >>>
> > >>>     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PR=
OP_BSEL, NULL);
> > >>> -    if (bsel) {
> > >>> +    if (bsel && !root_pcihp_disabled) {
> > >>
> > >> have you considered to make bus not hotpluggable,
> > >> which should make it not to have bsel, and hence skip this branch wi=
thout
> > >> root_pcihp_disabled?
> > >>
> > >> see: acpi_set_bsel()
> > >>
> > >>
> > >> maybe you can drop pcihp_root_en and use bsel instead of it then.
> > >>
> > >> it also should block device_add/del route.
> > >
> > > This is a good idea. Therefore, I tried this:
> > >
> > > --- a/hw/acpi/piix4.c
> > > +++ b/hw/acpi/piix4.c
> > > @@ -28,6 +28,7 @@
> > > #include "hw/pci/pci.h"
> > > #include "hw/qdev-properties.h"
> > > #include "hw/acpi/acpi.h"
> > > +#include "hw/pci/pci_bus.h"
> > > #include "sysemu/runstate.h"
> > > #include "sysemu/sysemu.h"
> > > #include "sysemu/xen.h"
> > > @@ -507,7 +508,9 @@ static void piix4_pm_realize(PCIDevice *dev, Erro=
r **errp)
> > >
> > >     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> > >                                    pci_get_bus(dev), s);
> > > -    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
> > > +    if (s->use_acpi_root_pci_hotplug ||
> > > +        !pci_bus_is_root(pci_get_bus(dev)))
> > > +        qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
> > >
> > >     piix4_pm_add_propeties(s);
> > > }
> > >
> > >
> > > but this does not seem to be working. I am out of ideas as to why it
> > > wouldn't work :(
> >
> > By that I mean the devices attached to bridges also seems to be disable=
d from hotplug from within Windows. I do not understand why that would be t=
he case when the pci_bus_is_root() should be false for the secondary buses.
> >
> >  Any ideas?
> Looking at acpi_set_pci_info() and debugging it might help.

All my efforts in this space have failed to work :( I am feeling a
little frustrated and out of ideas. I am inclined to resend V2 with
the suggestions you suggested for the final patch unless you have
better ideas.

>
> >
> > >
> > >>
> > >>
> > >>>         uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel))=
;
> > >>>
> > >>>         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel=
_val)));
> > >>> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *p=
arent_scope, PCIBus *bus,
> > >>>         bool bridge_in_acpi;
> > >>>
> > >>>         if (!pdev) {
> > >>> +            /* skip if pci hotplug for the root bus is disabled */
> > >>> +            if (root_pcihp_disabled)
> > >>> +                continue;
> > >>>             if (bsel) { /* add hotplug slots for non present device=
s */
> > >>>                 dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
> > >>>                 aml_append(dev, aml_name_decl("_SUN", aml_int(slot)=
));
> > >>> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *p=
arent_scope, PCIBus *bus,
> > >>>             method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);
> > >>>             aml_append(method, aml_return(aml_int(s3d)));
> > >>>             aml_append(dev, method);
> > >>> -        } else if (hotplug_enabled_dev) {
> > >>> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
> > >>>             /* add _SUN/_EJ0 to make slot hotpluggable  */
> > >>>             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> > >>>
> > >>> @@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Aml =
*parent_scope, PCIBus *bus,
> > >>>              */
> > >>>             PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(p=
dev));
> > >>>
> > >>> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridg=
e_en);
> > >>> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridg=
e_en,
> > >>> +                                         pcihp_root_en);
> > >>>         }
> > >>>         /* slot descriptor has been composed, add it into parent co=
ntext */
> > >>>         aml_append(parent_scope, dev);
> > >>>     }
> > >>>
> > >>> -    if (bsel) {
> > >>> +    if (bsel && !root_pcihp_disabled) {
> > >>>         aml_append(parent_scope, notify_method);
> > >>>     }
> > >>>
> > >>> @@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml *p=
arent_scope, PCIBus *bus,
> > >>>     method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > >>>
> > >>>     /* If bus supports hotplug select it and notify about local eve=
nts */
> > >>> -    if (bsel) {
> > >>> +    if (bsel && !root_pcihp_disabled) {
> > >>>         uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel))=
;
> > >>>
> > >>>         aml_append(method, aml_store(aml_int(bsel_val), aml_name("B=
NUM")));
> > >>> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker,
> > >>>         if (bus) {
> > >>>             Aml *scope =3D aml_scope("PCI0");
> > >>>             /* Scan all PCI buses. Generate tables to support hotpl=
ug. */
> > >>> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bri=
dge_en);
> > >>> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bri=
dge_en,
> > >>> +                                         pm->pcihp_root_en);
> > >>>
> > >>>             if (TPM_IS_TIS_ISA(tpm)) {
> > >>>                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
> > >>
> >
>

