Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F16C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B1D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJRtjGjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B1D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBpO-0003wp-2f
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jlBol-0003Ov-Bn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:39:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jlBoj-0000OT-E6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592314796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkXoip2LxJrp5LiciovIRUJ+y4HDoBImCYbawwPimpU=;
 b=bJRtjGjUgIqc8+rPxSy2jwR1QQOsGTK55BlUME3B0BWTMBNF8KDfGcsBLVi/fXYpXPfJi7
 JuKhEoawBN+WNkpI4D2UA6Ac/3xNmkjri10ck4UaV2CgXax4bVQ8P0rsnvj1TtQh0NyrBw
 V2f0k91D0cNVI1pWsNF8ScXreFc7PqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-BBFma2SPMLOsFZ8vdMveGw-1; Tue, 16 Jun 2020 09:39:52 -0400
X-MC-Unique: BBFma2SPMLOsFZ8vdMveGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3F08100A8FC;
 Tue, 16 Jun 2020 13:39:50 +0000 (UTC)
Received: from localhost (unknown [10.40.208.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31F587930D;
 Tue, 16 Jun 2020 13:39:44 +0000 (UTC)
Date: Tue, 16 Jun 2020 15:39:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V3] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Message-ID: <20200616153942.79155fe8@redhat.com>
In-Reply-To: <CAARzgwwKwdYW0BK4-W2=q=g3cN4BZfPN6p8QqvgAsqJ7tifHtA@mail.gmail.com>
References: <1592310699-58916-1-git-send-email-ani.sinha@nutanix.com>
 <20200616151735.17a84340@redhat.com>
 <CAARzgwwKwdYW0BK4-W2=q=g3cN4BZfPN6p8QqvgAsqJ7tifHtA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 18:50:13 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> On Tue, Jun 16, 2020 at 6:47 PM Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue, 16 Jun 2020 12:31:39 +0000
> > Ani Sinha <ani.sinha@nutanix.com> wrote:
> >  
> > > Currently, the option use_acpi_pci_hotplug is being used to control  
> > device  
> > > hotplug capability using ACPI for slots of cold plugged bridges. Hence,  
> > we  
> > > are renaming this option to better reflect what it actually does.
> > >
> > > Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> > > ---  
> >
> > what was wrong with v2?  
> 
> 
> i removed the change-id string.
ok, usually we cary on ACK on resping if changes were trivial
and drop them if there was a non trivial change so it could be reviewed again.
Anyways, patch looks good so:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> 
> 
> > Also for the future,
> > can you add under --- line change log please?
> >  
> > >  hw/acpi/piix4.c | 21 +++++++++++----------
> > >  1 file changed, 11 insertions(+), 10 deletions(-)  
> 
> 
> It's already here.

I've meant something like:

Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
---
 vX: - I might be blind and don't see changelog ...

> 
> 
> > >
> > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > index 85c199b..7de44bc 100644
> > > --- a/hw/acpi/piix4.c
> > > +++ b/hw/acpi/piix4.c
> > > @@ -77,7 +77,7 @@ typedef struct PIIX4PMState {
> > >      Notifier powerdown_notifier;
> > >
> > >      AcpiPciHpState acpi_pci_hotplug;
> > > -    bool use_acpi_pci_hotplug;
> > > +    bool use_acpi_hotplug_bridge;
> > >
> > >      uint8_t disable_s3;
> > >      uint8_t disable_s4;
> > > @@ -204,16 +204,17 @@ static const VMStateDescription vmstate_pci_status  
> > = {  
> > >      }
> > >  };
> > >
> > > -static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int  
> > version_id)  
> > > +static bool vmstate_test_use_acpi_hotplug_bridge(void *opaque, int  
> > version_id)  
> > >  {
> > >      PIIX4PMState *s = opaque;
> > > -    return s->use_acpi_pci_hotplug;
> > > +    return s->use_acpi_hotplug_bridge;
> > >  }
> > >
> > > -static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int  
> > version_id)  
> > > +static bool vmstate_test_no_use_acpi_hotplug_bridge(void *opaque,
> > > +                                                    int version_id)
> > >  {
> > >      PIIX4PMState *s = opaque;
> > > -    return !s->use_acpi_pci_hotplug;
> > > +    return !s->use_acpi_hotplug_bridge;
> > >  }
> > >
> > >  static bool vmstate_test_use_memhp(void *opaque)
> > > @@ -290,11 +291,11 @@ static const VMStateDescription vmstate_acpi = {
> > >          VMSTATE_STRUCT_TEST(
> > >  
> > acpi_pci_hotplug.acpi_pcihp_pci_status[ACPI_PCIHP_BSEL_DEFAULT],  
> > >              PIIX4PMState,
> > > -            vmstate_test_no_use_acpi_pci_hotplug,
> > > +            vmstate_test_no_use_acpi_hotplug_bridge,
> > >              2, vmstate_pci_status,
> > >              struct AcpiPciHpPciStatus),
> > >          VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug, PIIX4PMState,
> > > -                            vmstate_test_use_acpi_pci_hotplug),
> > > +                            vmstate_test_use_acpi_hotplug_bridge),
> > >          VMSTATE_END_OF_LIST()
> > >      },
> > >      .subsections = (const VMStateDescription*[]) {
> > > @@ -528,7 +529,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn,  
> > uint32_t smb_io_base,  
> > >      s->smi_irq = smi_irq;
> > >      s->smm_enabled = smm_enabled;
> > >      if (xen_enabled()) {
> > > -        s->use_acpi_pci_hotplug = false;
> > > +        s->use_acpi_hotplug_bridge = false;
> > >      }
> > >
> > >      qdev_init_nofail(dev);
> > > @@ -593,7 +594,7 @@ static void  
> > piix4_acpi_system_hot_add_init(MemoryRegion *parent,  
> > >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> > >
> > >      acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > > -                    s->use_acpi_pci_hotplug);
> > > +                    s->use_acpi_hotplug_bridge);
> > >
> > >      s->cpu_hotplug_legacy = true;
> > >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > > @@ -631,7 +632,7 @@ static Property piix4_pm_properties[] = {
> > >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState,  
> > disable_s4, 0),  
> > >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> > >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",  
> > PIIX4PMState,  
> > > -                     use_acpi_pci_hotplug, true),
> > > +                     use_acpi_hotplug_bridge, true),
> > >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > >                       acpi_memory_hotplug.is_enabled, true),
> > >      DEFINE_PROP_END_OF_LIST(),  
> >
> >  


