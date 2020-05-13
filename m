Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A248C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4BE20659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txg+VkJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4BE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxIa-0004No-Ab
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYxHu-0003yR-UP
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:43:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYxHs-0003AG-PK
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589399006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTc4TTQBab31VnWy2Zhn7LxDo0pMdp16Q2X1nrjSzW4=;
 b=Txg+VkJrQoNyPO1nyHpLArPELa7abEqCfjUo8OGn/OZXyWxTEnHwrUFw3im89NVheZyu5b
 VokLp+VuTXC6qgVn9Lbj7nkHZBmCnjZ7su/J1Xhic8GcvxBOdIXMy7lroHU+GlaIiJTSFk
 MuxE+vHo/aH+8Os8o1YxL+8GVvC9a7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-FMQZGMHkO86HHh1bhh3JTA-1; Wed, 13 May 2020 15:43:25 -0400
X-MC-Unique: FMQZGMHkO86HHh1bhh3JTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0899A8014D7;
 Wed, 13 May 2020 19:43:24 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E0491A923;
 Wed, 13 May 2020 19:43:15 +0000 (UTC)
Date: Wed, 13 May 2020 21:43:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200513214312.0dfa4752@redhat.com>
In-Reply-To: <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200511205352.05ff541a@redhat.com>
 <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 05:26:47 +0000
Ani Sinha <ani.sinha@nutanix.com> wrote:

> > On May 12, 2020, at 12:23 AM, Igor Mammedov <imammedo@redhat.com> wrote=
:
> >  =20
> >>=20
> >> static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bu=
s,
> >> -                                         bool pcihp_bridge_en)
> >> +                                         bool pcihp_bridge_en,
> >> +                                         bool pcihup_bridge_en)
> >> {
> >>     Aml *dev, *notify_method =3D NULL, *method;
> >>     QObject *bsel;
> >> @@ -479,11 +484,14 @@ static void build_append_pci_bus_devices(Aml *pa=
rent_scope, PCIBus *bus,
> >>                 dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
> >>                 aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >>                 aml_append(dev, aml_name_decl("_ADR", aml_int(slot << =
16)));
> >> -                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >> -                aml_append(method,
> >> -                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SU=
N"))
> >> -                );
> >> -                aml_append(dev, method);
> >> +                if (pcihup_bridge_en || pci_bus_is_root(bus)) { =20
> >=20
> > so you are keeping unplug anyway in case of host bridge, so user will s=
ee
> > eject icon if device is in root bus? =20
>=20
> Yes, the user will see the eject option from system tray for devices plug=
ged into the root bus. The idea is that whereas we disallow some devices fr=
om hot-unplugging, other devices which are plugged into the root bus can be=
 hot plugged and unplugged. This leaves some room for flexibility across de=
vices and VMs.
>=20
> >=20
> > Other thing about this patch is that it only partially disable hotplug,
> > I'd rather do it the way hardware does i.e. full hotplug or no hotplug =
at all.
> > (like the other hypervisors have done it, to workaround this Windows 'f=
eature=E2=80=99) =20
>=20
> So the main objection against this patch is that with this option enabled=
, we are violating what real HW does and since we want emulated HW to mimic=
 real HW behavior as close as possible, we are breaking this assumption. Am=
 I correct?
Yep, from the very begining I was suggesting to use global hotplug/no hotpl=
ug switch.

> > which is possible is one puts device on pci bridge without hotplug, i.e=
.
> >=20
> > -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Doff =20
>=20
> right.
>=20
> >=20
> > that of cause leaves apci hotplug on and as you noticed earlier
> > Windows will offer to eject any device on root bus including directly
> > attached bridges. And currently there is no way to disable that. =20
>=20
> Right. However, I have tested that even though the PCI bridge shows up as=
 a device in the =E2=80=9Csafely remove HW=E2=80=9D option in the system tr=
ay, trying to eject a PCI bridge with devices attached will result in failu=
re with the error message =E2=80=9Cthis device is currently in use=E2=80=9D=
.
>
> > Will following hack work for you?
> > possible permutations
> > 1) ACPI hotplug everywhere
> > -global PIIX4_PM.acpi-pci-hotplug=3Don -global PIIX4_PM.acpi-pci-hotplu=
g-with-bridge-support=3Don -device pci-bridge,chassis_nr=3D1,shpc=3Ddoesnt_=
matter -device e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1=20
> >=20
> > 2) No hotplug at all
> > -global PIIX4_PM.acpi-pci-hotplug=3Doff -global PIIX4_PM.acpi-pci-hotpl=
ug-with-bridge-support=3Don -device pci-bridge,chassis_nr=3D1,shpc=3Doff -d=
evice e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1
> >=20
> > -global PIIX4_PM.acpi-pci-hotplug=3Doff -global PIIX4_PM.acpi-pci-hotpl=
ug-with-bridge-support=3Doff -device pci-bridge,chassis_nr=3D1,shpc=3Ddoesn=
t_matter  -device e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1 =20
>=20
> Given that my patch is not acceptable, I=E2=80=99d prefer the following i=
n the order of preference:
>=20
> (a) Have an option to disable hot ejection of PCI-PCI bridge so that Wind=
ows does not even show this HW in the =E2=80=9Csafely remove HW=E2=80=9D op=
tion. If we can do this then from OS perspective the GUI options will be sa=
me as what is available with PCIE/q35 - none of the devices will be hot eje=
ctable if the hot plug option is turned off from the PCIE slots where devic=
es are plugged into.
> I looked at the code. It seems to manipulate ACPI tables of the empty slo=
ts of the root bus where no devices are attached (see comment "/* add hotpl=
ug slots for non present devices */ =E2=80=9C). For cold plugged bridges, i=
t recurses down to scan the slots of the bridge. Is it possible to disable =
hot plug for the slot to which the bridge is attached?

I don't think it's possible to have per slot hotplug on conventional PCI ha=
rdware.
it's per bridge property.


> (b) Failing above, having a global option to disable all hot plug, includ=
ing the 32 slots of the root bus would be good. However, this does not give=
 us the flexibility we have with PCIE (that is, to hot plug a  device, we c=
an always plug it to a slot with hot plug enabled).

sounds fine to me, at least it will address problem.
Can you post a patch to that effect please?
/It should disable all AML related to hotplug and related hadware code/

As for a way to make it more felixible, theoretically it should be possible=
 to use SHPC on bridges.
So one could have a bridge with SHPC enabled to allow hotplug devices durin=
g runtime.
It's rummored that SHPC should be supported since Vista, but it doesn't wor=
k
(at least on QEMU with Windows 10 guest and I don't have a real machine to =
verify that).
That's something to explore (perhaps QEMU doesn't implement it completely s=
o Windows doesn't see it).=20
=20
>=20
> Thanks for looking into my requirement more seriously,
> ani
>=20
>=20
> >=20
> > 3) looks like SHPC kicks in, but it still needs to some bridge descript=
ion in ACPI that
> >   acpi-pci-hotplug-with-bridge-support provides, probably with this you=
 can individually flip hotplug on
> >   colplugged bridges using 'shpc' property (requires Vista or newer, te=
sted win10).
> >=20
> >   This needs some investigation so we could remove unsed AML and IO por=
ts, but I'm not really interested
> >   in PCI stuff. So if 1+2 works for you, I'll post formal patches. If #=
3 is required feel free
> >   to use this patch as a starting base to make it complete.=20
> >=20
> > -global PIIX4_PM.acpi-pci-hotplug=3Doff -global PIIX4_PM.acpi-pci-hotpl=
ug-with-bridge-support=3Don -device pci-bridge,chassis_nr=3D1,shpc=3Don -de=
vice e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1

above is a bug in patch below, look like ,shpc=3Don tricks code to belive t=
hat ACPI hotplug is present
and add AML for it.

> >=20
> > ---
> >=20
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 964d6f5990..5f05b2cb87 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >=20
> >     AcpiPciHpState acpi_pci_hotplug;
> >     bool use_acpi_pci_hotplug;
> > +    bool use_acpi_pci_hotplug_on_bridges;
> >=20
> >     uint8_t disable_s3;
> >     uint8_t disable_s4;
> > @@ -207,13 +208,13 @@ static const VMStateDescription vmstate_pci_statu=
s =3D {
> > static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int version=
_id)
> > {
> >     PIIX4PMState *s =3D opaque;
> > -    return s->use_acpi_pci_hotplug;
> > +    return s->use_acpi_pci_hotplug_on_bridges;
> > }
> >=20
> > static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int vers=
ion_id)
> > {
> >     PIIX4PMState *s =3D opaque;
> > -    return !s->use_acpi_pci_hotplug;
> > +    return !s->use_acpi_pci_hotplug_on_bridges;
> > }
> >=20
> > static bool vmstate_test_use_memhp(void *opaque)
> > @@ -505,7 +506,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error =
**errp)
> >=20
> >     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> >                                    pci_get_bus(dev), s);
> > -    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_=
abort);
> >=20
> >     piix4_pm_add_propeties(s);
> > }
> > @@ -528,7 +528,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint3=
2_t smb_io_base,
> >     s->smi_irq =3D smi_irq;
> >     s->smm_enabled =3D smm_enabled;
> >     if (xen_enabled()) {
> > -        s->use_acpi_pci_hotplug =3D false;
> > +        s->use_acpi_pci_hotplug_on_bridges =3D false;
> >     }
> >=20
> >     qdev_init_nofail(dev);
> > @@ -593,7 +593,10 @@ static void piix4_acpi_system_hot_add_init(MemoryR=
egion *parent,
> >     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >=20
> >     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_pci_hotplug);
> > +                    s->use_acpi_pci_hotplug_on_bridges);
> > +    if (s->use_acpi_pci_hotplug) {
> > +        qbus_set_hotplug_handler(BUS(bus), OBJECT(s), &error_abort);
> > +    }
> >=20
> >     s->cpu_hotplug_legacy =3D true;
> >     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > @@ -632,6 +635,8 @@ static Property piix4_pm_properties[] =3D {
> >     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s=
4, 0),
> >     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMSta=
te,
> > +                     use_acpi_pci_hotplug_on_bridges, true),
> > +    DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
> >                      use_acpi_pci_hotplug, true),
> >     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                      acpi_memory_hotplug.is_enabled, true),
> >=20
> > ---
> >=20
> >  =20
> >> +                    method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZE=
D);
> >> +                    aml_append(method,
> >> +                               aml_call2("PCEJ", aml_name("BSEL"),
> >> +                                         aml_name("_SUN"))
> >> +                        );
> >> +                    aml_append(dev, method);
> >> +                }
> >>                 aml_append(parent_scope, dev);
> >>=20
> >>                 build_append_pcihp_notify_entry(notify_method, slot);
> >> @@ -537,12 +545,14 @@ static void build_append_pci_bus_devices(Aml *pa=
rent_scope, PCIBus *bus,
> >>             /* add _SUN/_EJ0 to make slot hotpluggable  */
> >>             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >>=20
> >> -            method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >> -            aml_append(method,
> >> -                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> >> -            );
> >> -            aml_append(dev, method);
> >> -
> >> +            if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> >> +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >> +                aml_append(method,
> >> +                           aml_call2("PCEJ", aml_name("BSEL"),
> >> +                                     aml_name("_SUN"))
> >> +                    );
> >> +                aml_append(dev, method);
> >> +            }
> >>             if (bsel) {
> >>                 build_append_pcihp_notify_entry(notify_method, slot);
> >>             }
> >> @@ -553,7 +563,8 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,
> >>              */
> >>             PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev=
));
> >>=20
> >> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_e=
n);
> >> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_e=
n,
> >> +                                         pcihup_bridge_en);
> >>         }
> >>         /* slot descriptor has been composed, add it into parent conte=
xt */
> >>         aml_append(parent_scope, dev);
> >> @@ -2196,7 +2207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
> >>         if (bus) {
> >>             Aml *scope =3D aml_scope("PCI0");
> >>             /* Scan all PCI buses. Generate tables to support hotplug.=
 */
> >> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge=
_en);
> >> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge=
_en,
> >> +                                         pm->pcihup_bridge_en);
> >>=20
> >>             if (TPM_IS_TIS_ISA(tpm)) {
> >>                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) { =20
>=20


