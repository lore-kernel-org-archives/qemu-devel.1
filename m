Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D78C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01252072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="vJ71wOrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01252072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LT3-00086U-To
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8LSV-0007gH-KJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:36:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8LST-0001z9-TP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:36:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id c15so20961316wrs.11
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bV9sPa84JqhmgvpsqcKOlunm8UuOHXfs9gLZH4iKV1w=;
 b=vJ71wOrPdsfLGHqkg7qikExND5SwGSc0VTz1MtUG1m0sSMQlixatRq+YTcYbMOW9BW
 LPEgjVtu8y/51NAvBOSGC2pSA3heSAtFodybsMRIT2QoaHBliqvodb3jIVsn4h+GyyxD
 4wEJy2d5y1F204ZKhbSiO9m5B65oTuwDv+jbIvbvb8hgtlAmjGCYvT2iksNusjYxusQx
 /iYSTK3uESkfqqLWlRdNWNZ06unwdo1F7Rj56mCsYzAcAc1sk+PDdr32bqM+F3Z2zDXh
 1qXwhxBZFEwMjwN8fPzPp6DQIroMWEFJaR9dHKeJ7Kii8RyvdWcIYWSShIAgHAXNxxZ8
 l6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bV9sPa84JqhmgvpsqcKOlunm8UuOHXfs9gLZH4iKV1w=;
 b=CLaB8IfXxmab5chURxozZLgBBgiQz+4YH707sDaW0NdS/QCdul+unBwe27vNZtnKQ9
 6n535X0T/AU/rUfRSxKFy2seT4kAmrq2DlXukHLIgZlwOLtPz5xM+z/u1ztvA2o9Oh2j
 qJxtt2rNwoHI8AyF9kGHyhtJFPzDUnswB4HLGtyGj30RovwzGWbz73oaL9xt0qFjB1XS
 nqZ1iRLicPgTWl4weaNh2iJ117lYUs5I8OTmMvPO4PpwKgj2e/LXyIGq5mEjOGDCkKRn
 CgQA+oABM9oCc+NTJVjIwe17fPuzEJP/Ga2N0d3XfsAt78KEKeiXnoHI2SV6iFZ4NsQn
 H1OA==
X-Gm-Message-State: AOAM5328vg8sUCLtmMj24qN4OVkSxHvUTBvrxNOH9DJ/sOVU4JB5GO8p
 8/1WL0N8j8MkNwnDkPz5CmER6obrMTZ0yqsf8dSH/g==
X-Google-Smtp-Source: ABdhPJwL4oKAKhbidY/R3MkLoutXWWfEw2c4bamsIDeHaqpBNF+JXgJR+HpJ3H6lyBzid2u6Z8p/ndeWWxmwvDKkBqY=
X-Received: by 2002:a05:6000:118c:: with SMTP id
 g12mr24102648wrx.212.1597833400286; 
 Wed, 19 Aug 2020 03:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <1597151528-75766-1-git-send-email-ani@anisinha.ca>
 <20200819120002.51812273@redhat.com>
In-Reply-To: <20200819120002.51812273@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 19 Aug 2020 16:06:29 +0530
Message-ID: <CAARzgwx5mqiCh2OWn9+5aR7t5zH0wcxQKurYLb3=MKuq2zUjew@mail.gmail.com>
Subject: Re: [PATCH V2] Introduce a new flag for piix to disable root bus PCI
 hotplug
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
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

On Wed, Aug 19, 2020 at 3:30 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 11 Aug 2020 18:42:08 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > We introduce a new global flag for PIIX with which we can turn on or off PCI
> > device hotplug on the root bus. This flag can be used to prevent all PCI
> > devices from getting hotplugged or unplugged from the root PCI bus.
>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
>
> somewhere in intial versions there were mentionig why we are doing it
> (i.e for Windows sake because ...)
> I suggest to add it to commit message so reason for this won't be lost.
> Also giving example how to use option in commit message would be good.
>
> with this changes:
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks Igor, I have sent a V4 with your suggestions to the commit
message and some more
rework on the patch. The V4 has again been tested by me in the same
setup. Looks good so far.

>
>
>
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/acpi/piix4.c      |  3 +++
> >  hw/i386/acpi-build.c | 20 ++++++++++++++++----
> >  2 files changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 26bac4f..94ec35a 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> >      bool use_acpi_hotplug_bridge;
> > +    bool use_acpi_root_pci_hotplug;
> >
> >      uint8_t disable_s3;
> >      uint8_t disable_s4;
> > @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> >                       use_acpi_hotplug_bridge, true),
> > +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > +                     use_acpi_root_pci_hotplug, true),
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                       acpi_memory_hotplug.is_enabled, true),
> >      DEFINE_PROP_END_OF_LIST(),
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbb..a82e5c1 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> >      bool s3_disabled;
> >      bool s4_disabled;
> >      bool pcihp_bridge_en;
> > +    bool pcihp_root_en;
> >      uint8_t s4_val;
> >      AcpiFadtData fadt;
> >      uint16_t cpu_hp_io_base;
> > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> >      pm->pcihp_bridge_en =
> >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> >                                   NULL);
> > +    pm->pcihp_root_en =
> > +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
> > +
> >  }
> >
> >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
> >  }
> >
> >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> > -                                         bool pcihp_bridge_en)
> > +                                         bool pcihp_bridge_en,
> > +                                         bool pcihp_root_en)
> >  {
> >      Aml *dev, *notify_method = NULL, *method;
> >      QObject *bsel;
> >      PCIBus *sec;
> >      int i;
> > +    bool root_bus = pci_bus_is_root(bus);
> > +    bool root_pcihp_disabled = (root_bus && !pcihp_root_en);
> >
> >      bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> >      if (bsel) {
> > @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          bool bridge_in_acpi;
> >
> >          if (!pdev) {
> > +            /* skip if pci hotplug for the root bus is disabled */
> > +            if (root_pcihp_disabled)
> > +                continue;
> >              if (bsel) { /* add hotplug slots for non present devices */
> >                  dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
> >                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> > @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >              method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
> >              aml_append(method, aml_return(aml_int(s3d)));
> >              aml_append(dev, method);
> > -        } else if (hotplug_enabled_dev) {
> > +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
> >              /* add _SUN/_EJ0 to make slot hotpluggable  */
> >              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >
> > @@ -439,7 +449,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >               */
> >              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >
> > -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> > +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> > +                                         pcihp_root_en);
> >          }
> >          /* slot descriptor has been composed, add it into parent context */
> >          aml_append(parent_scope, dev);
> > @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          if (bus) {
> >              Aml *scope = aml_scope("PCI0");
> >              /* Scan all PCI buses. Generate tables to support hotplug. */
> > -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> > +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
> > +                                         pm->pcihp_root_en);
> >
> >              if (TPM_IS_TIS_ISA(tpm)) {
> >                  if (misc->tpm_version == TPM_VERSION_2_0) {
>

