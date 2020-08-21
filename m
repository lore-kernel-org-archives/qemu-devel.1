Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7EEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376DC20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/69O7ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376DC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96KX-0002Te-HO
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k96J1-00020b-Sy
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k96It-0001yB-Kw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598013474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWojwyek9WeWVa2Hqt29z+LZbgHC6bDMzg8Js02Q0ow=;
 b=e/69O7ZYNxC+qGwfP+tAn+ON3EcAVHZYimvyA4q9m0HgHLlH4ruPlKDr9ZPSjqhns3aZSd
 sdeVX3Kfx1xvVSMCZ2ZlOw2sKXNPRPA/9NqdV5D76r0fObeSzf6t3MDWmNLeCgQW8jAUVp
 R7JtqOMRrX/sOKKqxjY03vQked9h3nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350--M7j8ITCNjWImNG6SLVp6g-1; Fri, 21 Aug 2020 08:37:53 -0400
X-MC-Unique: -M7j8ITCNjWImNG6SLVp6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6558F80733D;
 Fri, 21 Aug 2020 12:37:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BAD960CD0;
 Fri, 21 Aug 2020 12:37:44 +0000 (UTC)
Date: Fri, 21 Aug 2020 14:37:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V6] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
Message-ID: <20200821143743.23a5ca88@redhat.com>
In-Reply-To: <CAARzgwy17=msoLQ662VXfdMOLJd7=hBMpC6LNN_C5fvGgMM1YQ@mail.gmail.com>
References: <CAARzgwyuL_joY_4wq8=WY7U=E67F2roPJ36kaQLJFRVqLgpGXg@mail.gmail.com>
 <96C3BCCD-7A5E-439D-8EDD-927D188C0946@anisinha.ca>
 <20200821111612.5b04bc5e@redhat.com>
 <CAARzgwy17=msoLQ662VXfdMOLJd7=hBMpC6LNN_C5fvGgMM1YQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 16:43:37 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> On Fri, Aug 21, 2020 at 2:46 PM Igor Mammedov <imammedo@redhat.com> wrote=
:
> >
> > On Thu, 20 Aug 2020 22:11:41 +0530
> > Ani Sinha <ani@anisinha.ca> wrote:
> > =20
> > > > On Aug 20, 2020, at 9:11 PM, Ani Sinha <ani@anisinha.ca> wrote:
> > > >
> > > > =EF=BB=BFOn Thu, Aug 20, 2020 at 7:37 PM Igor Mammedov <imammedo@re=
dhat.com> wrote: =20
> > > >> =20
> > > >>> On Thu, 20 Aug 2020 14:51:56 +0530
> > > >>> Ani Sinha <ani@anisinha.ca> wrote:
> > > >>>
> > > >>> We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx=
 with which
> > > >>> we can turn on or off PCI device hotplug on the root bus. This fl=
ag can be
> > > >>> used to prevent all PCI devices from getting hotplugged or unplug=
ged from the
> > > >>> root PCI bus.
> > > >>> This feature is targetted mostly towards Windows VMs. It is usefu=
l in cases
> > > >>> where some hypervisor admins want to deploy guest VMs in a way so=
 that the
> > > >>> users of the guest OSes are not able to hot-eject certain PCI dev=
ices from
> > > >>> the Windows system tray. Laine has explained the use case here in=
 detail:
> > > >>> https://www.redhat.com/archives/libvir-list/2020-February/msg0011=
0.html
> > > >>>
> > > >>> Julia has resolved this issue for PCIE buses with the following c=
ommit:
> > > >>> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling o=
ption")
> > > >>>
> > > >>> This commit attempts to introduce similar behavior for PCI root b=
uses used in
> > > >>> i440fx machine types (although in this case, we do not have a per=
-slot
> > > >>> capability to turn hotplug on or off).
> > > >>>
> > > >>> Usage:
> > > >>>   -global PIIX4_PM.acpi-root-pci-hotplug=3Doff
> > > >>>
> > > >>> By default, this option is enabled which means that hotplug is tu=
rned on for
> > > >>> the PCI root bus.
> > > >>>
> > > >>> The previously existing flag 'acpi-pci-hotplug-with-bridge-suppor=
t' for PCI-PCI
> > > >>> bridges remain as is and can be used along with this new flag to =
control PCI
> > > >>> hotplug on PCI bridges.
> > > >>>
> > > >>> This change has been tested using a Windows 2012R2 server guest i=
mage and also
> > > >>> with a Windows 2019 server guest image on a Ubuntu 18.04 host usi=
ng the latest
> > > >>> master qemu from upstream (v5.1.0 tag).
> > > >>>
> > > >>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > >>> ---
> > > >>> hw/acpi/piix4.c      |  8 ++++++--
> > > >>> hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
> > > >>> 2 files changed, 25 insertions(+), 9 deletions(-)
> > > >>>
> > > >>> Change Log:
> > > >>> V5..V6: specified upstream master tag information off which this =
patch is
> > > >>> based off of.
> > > >>>
> > > >>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > >>> index 26bac4f16c..4f436e5bf3 100644
> > > >>> --- a/hw/acpi/piix4.c
> > > >>> +++ b/hw/acpi/piix4.c
> > > >>> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > > >>>
> > > >>>     AcpiPciHpState acpi_pci_hotplug;
> > > >>>     bool use_acpi_hotplug_bridge;
> > > >>> +    bool use_acpi_root_pci_hotplug;
> > > >>>
> > > >>>     uint8_t disable_s3;
> > > >>>     uint8_t disable_s4; =20
> > > >> =20
> > > >>> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(Me=
moryRegion *parent,
> > > >>>                           "acpi-gpe0", GPE_LEN);
> > > >>>     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> > > >>>
> > > >>> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent=
,
> > > >>> -                    s->use_acpi_hotplug_bridge);
> > > >>> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotpl=
ug)
> > > >>> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, pa=
rent,
> > > >>> +                        s->use_acpi_hotplug_bridge); =20
> > > >> If intent was to disable hardware part of ACPI hotplug,
> > > >> then this hunk is not enough. I'd say it introduces bug since you =
are leaving
> > > >> device_add/del route open and "_E01" AML code around trying to acc=
ess no longer
> > > >> described/present io ports.
> > > >>
> > > >> Without this hunk patch is fine, as a means to hide hotplug from W=
indows.
> > > >>
> > > >> If you'd like to disable hw part, you will need to consider case w=
here hotplug is
> > > >> disabled completly and block all related AML and block device_add|=
del.
> > > >> So it would be a bit more than above hunk. =20
> > > >
> > > > Ok maybe I will just remove it.
> > > > =20
> > > >>
> > > >> =20
> > > >>>     s->cpu_hotplug_legacy =3D true;
> > > >>>     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > > >>> @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] =3D {
> > > >>>     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, =
2),
> > > >>>     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX=
4PMState,
> > > >>>                      use_acpi_hotplug_bridge, true),
> > > >>> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > > >>> +                     use_acpi_root_pci_hotplug, true),
> > > >>>     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > > >>>                      acpi_memory_hotplug.is_enabled, true),
> > > >>>     DEFINE_PROP_END_OF_LIST(),
> > > >>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > >>> index b7bcbbbb2a..19a1702ad1 100644
> > > >>> --- a/hw/i386/acpi-build.c
> > > >>> +++ b/hw/i386/acpi-build.c
> > > >>> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> > > >>>     bool s3_disabled;
> > > >>>     bool s4_disabled;
> > > >>>     bool pcihp_bridge_en;
> > > >>> +    bool pcihp_root_en;
> > > >>>     uint8_t s4_val;
> > > >>>     AcpiFadtData fadt;
> > > >>>     uint16_t cpu_hp_io_base;
> > > >>> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *ma=
chine, AcpiPmInfo *pm)
> > > >>>     pm->pcihp_bridge_en =3D
> > > >>>         object_property_get_bool(obj, "acpi-pci-hotplug-with-brid=
ge-support",
> > > >>>                                  NULL);
> > > >>> +    pm->pcihp_root_en =3D
> > > >>> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", N=
ULL);
> > > >>> +
> > > >>> }
> > > >>>
> > > >>> static void acpi_get_misc_info(AcpiMiscInfo *info)
> > > >>> @@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry=
(Aml *method, int slot)
> > > >>> }
> > > >>>
> > > >>> static void build_append_pci_bus_devices(Aml *parent_scope, PCIBu=
s *bus,
> > > >>> -                                         bool pcihp_bridge_en)
> > > >>> +                                         bool pcihp_bridge_en,
> > > >>> +                                         bool pcihp_root_en)
> > > >>> {
> > > >>>     Aml *dev, *notify_method =3D NULL, *method;
> > > >>>     QObject *bsel;
> > > >>>     PCIBus *sec;
> > > >>>     int i;
> > > >>> +    bool root_bus =3D pci_bus_is_root(bus);
> > > >>> +    bool root_pcihp_disabled =3D (root_bus && !pcihp_root_en);
> > > >>>
> > > >>>     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_=
PROP_BSEL, NULL);
> > > >>> -    if (bsel) {
> > > >>> +    if (bsel && !root_pcihp_disabled) { =20
> > > >>
> > > >> have you considered to make bus not hotpluggable,
> > > >> which should make it not to have bsel, and hence skip this branch =
without
> > > >> root_pcihp_disabled?
> > > >>
> > > >> see: acpi_set_bsel()
> > > >>
> > > >>
> > > >> maybe you can drop pcihp_root_en and use bsel instead of it then.
> > > >>
> > > >> it also should block device_add/del route. =20
> > > >
> > > > This is a good idea. Therefore, I tried this:
> > > >
> > > > --- a/hw/acpi/piix4.c
> > > > +++ b/hw/acpi/piix4.c
> > > > @@ -28,6 +28,7 @@
> > > > #include "hw/pci/pci.h"
> > > > #include "hw/qdev-properties.h"
> > > > #include "hw/acpi/acpi.h"
> > > > +#include "hw/pci/pci_bus.h"
> > > > #include "sysemu/runstate.h"
> > > > #include "sysemu/sysemu.h"
> > > > #include "sysemu/xen.h"
> > > > @@ -507,7 +508,9 @@ static void piix4_pm_realize(PCIDevice *dev, Er=
ror **errp)
> > > >
> > > >     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> > > >                                    pci_get_bus(dev), s);
> > > > -    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
> > > > +    if (s->use_acpi_root_pci_hotplug ||
> > > > +        !pci_bus_is_root(pci_get_bus(dev)))
> > > > +        qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s))=
;
> > > >
> > > >     piix4_pm_add_propeties(s);
> > > > }
> > > >
> > > >
> > > > but this does not seem to be working. I am out of ideas as to why i=
t
> > > > wouldn't work :( =20
> > >
> > > By that I mean the devices attached to bridges also seems to be disab=
led from hotplug from within Windows. I do not understand why that would be=
 the case when the pci_bus_is_root() should be false for the secondary buse=
s.
> > >
> > >  Any ideas? =20
> > Looking at acpi_set_pci_info() and debugging it might help. =20
>=20
> All my efforts in this space have failed to work :( I am feeling a
> little frustrated and out of ideas. I am inclined to resend V2 with
> the suggestions you suggested for the final patch unless you have
> better ideas.

That's why I've suggest to fix up this patch first, and work on hw part sep=
arately.

As for ideas, unfortunatly other than debugging it to see where it breaks,
I don't have any other suggestions.
(though that would require a bit more code studying about how ACPI PCI
hotplug works. If You have concrete questions about the code,
I might be able to clarify it for you.)


> > =20
> > > =20
> > > > =20
> > > >>
> > > >> =20
> > > >>>         uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel=
));
> > > >>>
> > > >>>         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bs=
el_val)));
> > > >>> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml =
*parent_scope, PCIBus *bus,
> > > >>>         bool bridge_in_acpi;
> > > >>>
> > > >>>         if (!pdev) {
> > > >>> +            /* skip if pci hotplug for the root bus is disabled =
*/
> > > >>> +            if (root_pcihp_disabled)
> > > >>> +                continue;
> > > >>>             if (bsel) { /* add hotplug slots for non present devi=
ces */
> > > >>>                 dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
> > > >>>                 aml_append(dev, aml_name_decl("_SUN", aml_int(slo=
t)));
> > > >>> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml =
*parent_scope, PCIBus *bus,
> > > >>>             method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);
> > > >>>             aml_append(method, aml_return(aml_int(s3d)));
> > > >>>             aml_append(dev, method);
> > > >>> -        } else if (hotplug_enabled_dev) {
> > > >>> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) =
{
> > > >>>             /* add _SUN/_EJ0 to make slot hotpluggable  */
> > > >>>             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)))=
;
> > > >>>
> > > >>> @@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Am=
l *parent_scope, PCIBus *bus,
> > > >>>              */
> > > >>>             PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE=
(pdev));
> > > >>>
> > > >>> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bri=
dge_en);
> > > >>> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bri=
dge_en,
> > > >>> +                                         pcihp_root_en);
> > > >>>         }
> > > >>>         /* slot descriptor has been composed, add it into parent =
context */
> > > >>>         aml_append(parent_scope, dev);
> > > >>>     }
> > > >>>
> > > >>> -    if (bsel) {
> > > >>> +    if (bsel && !root_pcihp_disabled) {
> > > >>>         aml_append(parent_scope, notify_method);
> > > >>>     }
> > > >>>
> > > >>> @@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml =
*parent_scope, PCIBus *bus,
> > > >>>     method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > > >>>
> > > >>>     /* If bus supports hotplug select it and notify about local e=
vents */
> > > >>> -    if (bsel) {
> > > >>> +    if (bsel && !root_pcihp_disabled) {
> > > >>>         uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel=
));
> > > >>>
> > > >>>         aml_append(method, aml_store(aml_int(bsel_val), aml_name(=
"BNUM")));
> > > >>> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *=
linker,
> > > >>>         if (bus) {
> > > >>>             Aml *scope =3D aml_scope("PCI0");
> > > >>>             /* Scan all PCI buses. Generate tables to support hot=
plug. */
> > > >>> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_b=
ridge_en);
> > > >>> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_b=
ridge_en,
> > > >>> +                                         pm->pcihp_root_en);
> > > >>>
> > > >>>             if (TPM_IS_TIS_ISA(tpm)) {
> > > >>>                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) { =
=20
> > > >> =20
> > > =20
> > =20
>=20


