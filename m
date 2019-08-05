Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9EAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBB92086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBB92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufCz-0008Se-Gj
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hufCW-0007wv-G8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hufCV-0004A4-CF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:47:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hufCS-00046f-NI; Mon, 05 Aug 2019 11:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39D853090FF4;
 Mon,  5 Aug 2019 15:47:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8115B60A97;
 Mon,  5 Aug 2019 15:46:54 +0000 (UTC)
Date: Mon, 5 Aug 2019 17:46:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190805174652.61e9852a@redhat.com>
In-Reply-To: <CAFEAcA-+z4t75VwfWG1ezJm=4zfdWH6nz1Oe75Zs953+vKMvdQ@mail.gmail.com>
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-4-shameerali.kolothum.thodi@huawei.com>
 <20190730172524.6cf566ed@Igors-MacBook-Pro>
 <5FC3163CFD30C246ABAA99954A238FA83F33D896@lhreml524-mbs.china.huawei.com>
 <20190805153045.60db7bf5@redhat.com>
 <CAFEAcA-+z4t75VwfWG1ezJm=4zfdWH6nz1Oe75Zs953+vKMvdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 05 Aug 2019 15:47:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 3/9] hw/acpi: Add ACPI Generic
 Event Device Support
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
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 14:42:38 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 5 Aug 2019 at 14:30, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Thu, 1 Aug 2019 08:36:33 +0000
> > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
> >  
> > > Hi Igor,
> > >  
> > > > -----Original Message-----  
> > > > > +static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
> > > > > +{
> > > > > +    AcpiGedState *s = ACPI_GED(dev);
> > > > > +
> > > > > +    assert(s->ged_base);
> > > > > +    acpi_ged_init(get_system_memory(), dev, &s->ged_state);  
> > > >
> > > > calling get_system_memory() from device code used to be a reason for
> > > > rejecting patch,
> > > > I'm not sure what suggest though.
> > > >
> > > > Maybe Paolo could suggest something.  
> > >
> > > How about using object_property_set_link()? Something like below.  
> > I'm afraid it doesn't help much. Issue here is that we are letting
> > device to manage whole address space (which should be managed by machine)
> > So I'd just keep get_system_memory() as is for now if there aren't any
> > objections.  
> 
> What are we trying to do with this device, and what does it need
> the system memory region for?
> 
> In this case, we seem to do:
> 
> +static void acpi_ged_init(MemoryRegion *as, DeviceState *dev, GEDState *ged_st)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +
> +    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops, ged_st,
> +                          TYPE_ACPI_GED, ACPI_GED_EVT_SEL_LEN);
> +    memory_region_add_subregion(as, s->ged_base, &ged_st->io);
> +    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "ged-irq", 1);
> +}
> 
> 
> This is definitely a bad idea -- devices should not add their
> own memory regions to the system memory MR. They should
> expose their MRs (by being a sysbus-device) and let the board
> code do the wiring up of the MRs into the right memory space
> at the right address.

it's not the only place in GED that is trying to add to system address
space, optionally if called acpi_memory_hotplug_init() will do the same,
then later we could add cpu hotplug memory region over there.

Perhaps we could use bus-less device plug code path,
in that case memory_region_init_io()/qdev_init_gpio_out_named()
should be moved to ged_initfn() and mapping part into specialized helper
(similar to pc_dimm_plug() ) that's called by board (from virt_machine_device_plug_cb)
callback during completing device realize stage, it would be something like:

virt.c:
   virt_machine_device_plug_cb()
      if dev == GED_TYPE
        machine_ged_plug_helper(system_memory)

generic_event_device.c:
   machine_ged_plug_helper(as, irq) // similar to sysbus_mmio_map() but ged specialized
      connect_irq()
      memory_region_add_subregion(as, ged->ged_base, &ged->io)
      if ged->memory-hotplug-support
          memory_region_add_subregion(as, ged->memhp_base , &ged->memhp_state.memhp_io)


in this case addresses could be normally hard-codded in board code if device is not optional
(as in patch 6/9: create_acpi_ged() )
or potentially they could come from CLI as -device parameters
(/me thinking about building blocks that allow to create machine from config)

sysbus device might be fine as shortcut if we are thinking about
only creating device during machine_init (although I have a reservations towards
sysbus interface (ex: caller of sysbus_mmio_map() has no clue when mapping N-th
region at some address)).


> thanks
> -- PMM


