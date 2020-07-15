Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D47C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFF0206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZGMk67m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFF0206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhYH-0003SZ-4W
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvhXV-0002Yo-SN
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvhXS-0001jQ-S4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594820013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jr8QKmtfPbbWD0vxkBURdWo/tfIshqxe37G9jtYTb7g=;
 b=HZGMk67mAOz1/XBpY0uPObD0qKUJoFsYaVISlMoxwfRe7A1Co0Mfj0FQzJ2pU3QYnSKJIF
 VT2h9mHFs6mhRNYhns5PChkc9pjqru8971FLnHdiOz5JHRHmbeSI7o1QSuH92A1bmxRKg0
 4yzHAFYEi85sXqLmGdtmIRdrD5wrwj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-TlrZof5xMeSuC-q9wXSPdQ-1; Wed, 15 Jul 2020 09:33:31 -0400
X-MC-Unique: TlrZof5xMeSuC-q9wXSPdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0A468015FB;
 Wed, 15 Jul 2020 13:33:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21AB472E53;
 Wed, 15 Jul 2020 13:33:22 +0000 (UTC)
Date: Wed, 15 Jul 2020 15:33:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 5/5] hw/acpi/ich9: Enable ACPI PCI hot-plug
Message-ID: <20200715153321.3495e62d@redhat.com>
In-Reply-To: <20200714044553-mutt-send-email-mst@kernel.org>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-6-jusual@redhat.com>
 <20200713171718.141ec85a@redhat.com>
 <20200714044553-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 04:54:02 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 13, 2020 at 05:17:18PM +0200, Igor Mammedov wrote:
> > On Thu,  9 Jul 2020 00:46:15 +0200
> > Julia Suvorova <jusual@redhat.com> wrote:
> >   
> > > Add acpi_pcihp to ich9_pm and use ACPI PCI hot-plug by default.
> > > 
> > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > ---
> > >  include/hw/acpi/ich9.h |  3 +++
> > >  hw/acpi/ich9.c         | 45 ++++++++++++++++++++++++++++++++++++++++++
> > >  hw/acpi/pcihp.c        |  3 ++-
> > >  hw/i386/pc.c           |  4 +++-
> > >  4 files changed, 53 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> > > index 28a53181cb..d345da6b74 100644
> > > --- a/include/hw/acpi/ich9.h
> > > +++ b/include/hw/acpi/ich9.h
> > > @@ -24,6 +24,7 @@
> > >  #include "hw/acpi/acpi.h"
> > >  #include "hw/acpi/cpu_hotplug.h"
> > >  #include "hw/acpi/cpu.h"
> > > +#include "hw/acpi/pcihp.h"
> > >  #include "hw/acpi/memory_hotplug.h"
> > >  #include "hw/acpi/acpi_dev_interface.h"
> > >  #include "hw/acpi/tco.h"
> > > @@ -53,6 +54,8 @@ typedef struct ICH9LPCPMRegs {
> > >      AcpiCpuHotplug gpe_cpu;
> > >      CPUHotplugState cpuhp_state;
> > >  
> > > +    bool use_acpi_pci_hotplug;  
> > a bit outdated naming,
> > see 0affda043675c7619248a924a89bfd3781759f63, and rename it to match piix4
> >   
> > > +    AcpiPciHpState acpi_pci_hotplug;
> > >      MemHotplugState acpi_memory_hotplug;
> > >  
> > >      uint8_t disable_s3;
> > > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > > index 0fdd736da4..e0291373f2 100644
> > > --- a/hw/acpi/ich9.c
> > > +++ b/hw/acpi/ich9.c
> > > @@ -265,6 +265,7 @@ static void pm_reset(void *opaque)
> > >      }
> > >      pm->smi_en_wmask = ~0;
> > >  
> > > +    acpi_pcihp_reset(&pm->acpi_pci_hotplug);
> > >      acpi_update_sci(&pm->acpi_regs, pm->irq);
> > >  }
> > >  
> > > @@ -303,6 +304,17 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
> > >      pm->enable_tco = true;
> > >      acpi_pm_tco_init(&pm->tco_regs, &pm->io);
> > >  
> > > +    if (pm->use_acpi_pci_hotplug) {
> > > +        acpi_pcihp_init(OBJECT(lpc_pci),
> > > +                        &pm->acpi_pci_hotplug,
> > > +                        pci_get_bus(lpc_pci),
> > > +                        pci_address_space_io(lpc_pci),
> > > +                        true);
> > > +        qbus_set_hotplug_handler(BUS(pci_get_bus(lpc_pci)),
> > > +                                 OBJECT(lpc_pci),
> > > +                                 &error_abort);
> > > +    }
> > > +
> > >      pm->irq = sci_irq;
> > >      qemu_register_reset(pm_reset, pm);
> > >      pm->powerdown_notifier.notify = pm_powerdown_req;
> > > @@ -374,6 +386,20 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
> > >      s->pm.enable_tco = value;
> > >  }
> > >  
> > > +static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
> > > +{
> > > +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> > > +
> > > +    return s->pm.use_acpi_pci_hotplug;
> > > +}
> > > +
> > > +static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value,
> > > +                                               Error **errp)
> > > +{
> > > +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> > > +
> > > +    s->pm.use_acpi_pci_hotplug = value;
> > > +}
> > >  void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> > >  {
> > >      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
> > > @@ -382,6 +408,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> > >      pm->disable_s3 = 0;
> > >      pm->disable_s4 = 0;
> > >      pm->s4_val = 2;
> > > +    pm->use_acpi_pci_hotplug = true;  
> > 
> > I'm not sure about making crutch on by default though.
> > 
> > Does linux guests work fine with native hotplug or
> > does it have the same issues as Windows?
> > 
> > Also you had an idea how to workaround native hotplug issues
> > on QEMU side.
> > Can you dump here a quick summary why it didn't work out
> > in the end?  
> 
> To help out with that a bit:
> 
> I think native hotplug just does not match what management needs from
> QEMU. QEMU wants what ACPI calls a "VCR-style" ejection where
> eject happens automatically after software allows it.
> 
> Native hotplug is designed with a human in the loop.
> 
> Things like multi-second delay after an eject request,
> inability to differentiate between power down and eject,
> ability to power device back up after power down
> are all architectural in hative hotplug.
> 
> Interface is also designed such that there are subtle races making it
> hard not to loose hotplug events are also harmless on bare-metal since a
> human can just press the eject button again, but with causes no end of
> issues for us.

that is a generic excuse for adding ACPI hotplug to q35,
but what I've asked for, is to document (for history reasons) alternative
ideas that were explored to make native unplug work despite spec issues.
That would be also a good justification for ACPI approach showing that
we've exhausted any other approach before resorting to ACPI hotplug

Jilia had an idea about 'caching' unplug req and depending on cached value
behave differently on power off event. Which looked to me as a thing that
might solve unplug issue.

> I agree it's a good idea to include the motivation here or in the commit
> log, though.
> 
> >   
> > >  
> > >      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> > >                                     &pm->pm_io_base, OBJ_PROP_FLAG_READ);
> > > @@ -405,6 +432,9 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> > >      object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
> > >                               ich9_pm_get_enable_tco,
> > >                               ich9_pm_set_enable_tco);
> > > +    object_property_add_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> > > +                             ich9_pm_get_acpi_pci_hotplug,
> > > +                             ich9_pm_set_acpi_pci_hotplug);
> > >  }
> > >  
> > >  void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> > > @@ -412,6 +442,11 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >  {
> > >      ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
> > >  
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > > +        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
> > > +        return;
> > > +    }
> > > +
> > >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> > >          !lpc->pm.acpi_memory_hotplug.is_enabled)
> > >          error_setg(errp,
> > > @@ -437,6 +472,9 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >          } else {
> > >              acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
> > >          }
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > > +        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> > > +                                  dev, errp);
> > >      } else {
> > >          error_setg(errp, "acpi: device plug request for not supported device"
> > >                     " type: %s", object_get_typename(OBJECT(dev)));
> > > @@ -457,6 +495,10 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> > >                 !lpc->pm.cpu_hotplug_legacy) {
> > >          acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
> > >                                     dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > > +        acpi_pcihp_device_unplug_request_cb(hotplug_dev,
> > > +                                            &lpc->pm.acpi_pci_hotplug,
> > > +                                            dev, errp);
> > >      } else {
> > >          error_setg(errp, "acpi: device unplug request for not supported device"
> > >                     " type: %s", object_get_typename(OBJECT(dev)));
> > > @@ -474,6 +516,9 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
> > >                 !lpc->pm.cpu_hotplug_legacy) {
> > >          acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > > +        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> > > +                                    dev, errp);
> > >      } else {
> > >          error_setg(errp, "acpi: device unplug for not supported device"
> > >                     " type: %s", object_get_typename(OBJECT(dev)));
> > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > index 3d4ee3af72..d905d1b8f2 100644
> > > --- a/hw/acpi/pcihp.c
> > > +++ b/hw/acpi/pcihp.c
> > > @@ -110,7 +110,8 @@ static void acpi_set_pci_info(void)
> > >      }
> > >      bsel_is_set = true;
> > >  
> > > -    bus = find_i440fx(); /* TODO: Q35 support */
> > > +    bus = find_host();
> > > +
> > >      if (bus) {
> > >          /* Scan all PCI buses. Set property to enable acpi based hotplug. */
> > >          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 143ac1c354..21c6eb779e 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -96,7 +96,9 @@
> > >  #include "fw_cfg.h"
> > >  #include "trace.h"
> > >  
> > > -GlobalProperty pc_compat_5_0[] = {};
> > > +GlobalProperty pc_compat_5_0[] = {
> > > +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
> > > +};
> > >  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
> > >  
> > >  GlobalProperty pc_compat_4_2[] = {  
> 


