Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1F820732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzps8UCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1F820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Kp-0000Df-7n
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k94TV-0000oq-2G
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:40:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21995
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k94TS-00044v-Sb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598006441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJZ9FsH3chA9j6O/OLigpCHlZ7Xyd+hU4t3/uxb/C7I=;
 b=Tzps8UCIeOhSja8/xxOXt9TT+Efr4lw9oBfgqeWzns/2qnCg94ZJsJk2PTAQ6FyccGzARp
 tO53crFo8bx3xuqdXEoHvU0EKOVO9Bp58DVLg1Rh1z9tRbua/ZaGOeIGnReII5AdgGISIm
 NTeGTSLlGQvekDIboXLsnW3mBgH3aTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-_zEe0EPiN9WG3BLTenEMPQ-1; Fri, 21 Aug 2020 06:40:37 -0400
X-MC-Unique: _zEe0EPiN9WG3BLTenEMPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B6281F02C;
 Fri, 21 Aug 2020 10:40:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5335E19D6C;
 Fri, 21 Aug 2020 10:40:27 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:40:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V6] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
Message-ID: <20200821124026.656d5a81@redhat.com>
In-Reply-To: <20200821111612.5b04bc5e@redhat.com>
References: <CAARzgwyuL_joY_4wq8=WY7U=E67F2roPJ36kaQLJFRVqLgpGXg@mail.gmail.com>
 <96C3BCCD-7A5E-439D-8EDD-927D188C0946@anisinha.ca>
 <20200821111612.5b04bc5e@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 11:16:12 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Aug 2020 22:11:41 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>=20
> > > On Aug 20, 2020, at 9:11 PM, Ani Sinha <ani@anisinha.ca> wrote:
> > >=20
> > > =EF=BB=BFOn Thu, Aug 20, 2020 at 7:37 PM Igor Mammedov <imammedo@redh=
at.com> wrote:   =20
> > >>    =20
> > >>> On Thu, 20 Aug 2020 14:51:56 +0530
> > >>> Ani Sinha <ani@anisinha.ca> wrote:
> > >>>=20
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
> > >>>=20
> > >>> Julia has resolved this issue for PCIE buses with the following com=
mit:
> > >>> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling opt=
ion")
> > >>>=20
> > >>> This commit attempts to introduce similar behavior for PCI root bus=
es used in
> > >>> i440fx machine types (although in this case, we do not have a per-s=
lot
> > >>> capability to turn hotplug on or off).
> > >>>=20
> > >>> Usage:
> > >>>   -global PIIX4_PM.acpi-root-pci-hotplug=3Doff
> > >>>=20
> > >>> By default, this option is enabled which means that hotplug is turn=
ed on for
> > >>> the PCI root bus.
> > >>>=20
> > >>> The previously existing flag 'acpi-pci-hotplug-with-bridge-support'=
 for PCI-PCI
> > >>> bridges remain as is and can be used along with this new flag to co=
ntrol PCI
> > >>> hotplug on PCI bridges.
> > >>>=20
> > >>> This change has been tested using a Windows 2012R2 server guest ima=
ge and also
> > >>> with a Windows 2019 server guest image on a Ubuntu 18.04 host using=
 the latest
> > >>> master qemu from upstream (v5.1.0 tag).
> > >>>=20
> > >>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > >>> ---
> > >>> hw/acpi/piix4.c      |  8 ++++++--
> > >>> hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
> > >>> 2 files changed, 25 insertions(+), 9 deletions(-)
> > >>>=20
> > >>> Change Log:
> > >>> V5..V6: specified upstream master tag information off which this pa=
tch is
> > >>> based off of.
> > >>>=20
> > >>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > >>> index 26bac4f16c..4f436e5bf3 100644
> > >>> --- a/hw/acpi/piix4.c
> > >>> +++ b/hw/acpi/piix4.c
> > >>> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > >>>=20
> > >>>     AcpiPciHpState acpi_pci_hotplug;
> > >>>     bool use_acpi_hotplug_bridge;
> > >>> +    bool use_acpi_root_pci_hotplug;
> > >>>=20
> > >>>     uint8_t disable_s3;
> > >>>     uint8_t disable_s4;   =20
> > >>    =20
> > >>> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(Memo=
ryRegion *parent,
> > >>>                           "acpi-gpe0", GPE_LEN);
> > >>>     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> > >>>=20
> > >>> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > >>> -                    s->use_acpi_hotplug_bridge);
> > >>> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug=
)
> > >>> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, pare=
nt,
> > >>> +                        s->use_acpi_hotplug_bridge);   =20
> > >> If intent was to disable hardware part of ACPI hotplug,
> > >> then this hunk is not enough. I'd say it introduces bug since you ar=
e leaving
> > >> device_add/del route open and "_E01" AML code around trying to acces=
s no longer
> > >> described/present io ports.
> > >>=20
> > >> Without this hunk patch is fine, as a means to hide hotplug from Win=
dows.
> > >>=20
> > >> If you'd like to disable hw part, you will need to consider case whe=
re hotplug is
> > >> disabled completly and block all related AML and block device_add|de=
l.
> > >> So it would be a bit more than above hunk.   =20
> > >=20
> > > Ok maybe I will just remove it.

That's what I'd do, so that mostly AML part will be merged first and
then work on properly disabling hw parts as a separate patch.

Also Julia might borrow "acpi-root-pci-hotplug" for here q35 work.

> > >    =20
> > >>=20
> > >>    =20
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
> > >>>=20

[...]


