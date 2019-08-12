Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC39C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7DF20665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7DF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAg2-00057u-Ib
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hxAfY-0004d2-2x
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hxAfW-0005ND-Gz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hxAfT-0005Kg-Bt; Mon, 12 Aug 2019 09:47:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E90EA307F5E4;
 Mon, 12 Aug 2019 13:47:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7F75C1D4;
 Mon, 12 Aug 2019 13:47:17 +0000 (UTC)
Date: Mon, 12 Aug 2019 15:47:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190812154716.44a6aff8@redhat.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F34B396@lhreml524-mbs.china.huawei.com>
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-8-shameerali.kolothum.thodi@huawei.com>
 <20190806152136.3afbfb4b@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F34B396@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 12 Aug 2019 13:47:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 7/9] hw/arm/virt-acpi-build: Add
 PC-DIMM in SRAT
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 16:02:39 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Igor,
> 
> > -----Original Message-----
> > From: Qemu-devel
> > [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=huawei.com@nongn
> > u.org] On Behalf Of Igor Mammedov
> > Sent: 06 August 2019 14:22
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> > ard.biesheuvel@linaro.org; shannon.zhaosl@gmail.com;
> > qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> > <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> > sebastien.boeuf@intel.com; lersek@redhat.com
> > Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 7/9] hw/arm/virt-acpi-build: Add
> > PC-DIMM in SRAT
> > 
> > On Fri, 26 Jul 2019 11:45:17 +0100
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >   
> > > Generate Memory Affinity Structures for PC-DIMM ranges.
> > >
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/arm/virt-acpi-build.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 018b1e326d..75657caa36 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -518,6 +518,7 @@ build_srat(GArray *table_data, BIOSLinker *linker,  
> > VirtMachineState *vms)  
> > >      int i, srat_start;
> > >      uint64_t mem_base;
> > >      MachineClass *mc = MACHINE_GET_CLASS(vms);
> > > +    MachineState *ms = MACHINE(vms);
> > >      const CPUArchIdList *cpu_list =  
> > mc->possible_cpu_arch_ids(MACHINE(vms));  
> > >
> > >      srat_start = table_data->len;
> > > @@ -543,6 +544,14 @@ build_srat(GArray *table_data, BIOSLinker *linker,  
> > VirtMachineState *vms)  
> > >          }
> > >      }
> > >
> > > +    if (ms->device_memory) {
> > > +        numamem = acpi_data_push(table_data, sizeof *numamem);
> > > +        build_srat_memory(numamem, ms->device_memory->base,
> > > +  
> > memory_region_size(&ms->device_memory->mr),  
> > > +                          nb_numa_nodes - 1,
> > > +                          MEM_AFFINITY_HOTPLUGGABLE |  
> > MEM_AFFINITY_ENABLED);  
> > > +    }
> > > +
> > >      build_header(linker, table_data, (void *)(table_data->data +  
> > srat_start),  
> > >                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
> > >  }  
> > 
> > missing entry in
> >   tests/bios-tables-test-allowed-diff.h  
> 
> I can't find any SRAT file in tests/data/acpi/virt. Arm/virt doesn't have much
> tests in bios-tables-test.c. So does it make any difference?
acpi tests for arm/virt are new and are enabled only since 4.1,
now it should be trivial to add extra cases for code you are adding.
Since you're touching her SRAT, I'd suggest to enable 'numamem' and 'memhp'
tests with this series (for example see: test_acpi_piix4_tcg_numamem/test_acpi_piix4_tcg_memhp).

> > PS:
> > I don't really know what ARM guest kernel expects but on x86 we had to enable
> > numa
> > for guest to figure out max_possible_pfn
> > (see: in linux.git: 8dd330300197 / ec941c5ffede).  
> 
> From whatever I can find, doesn't look like there is any special handling of
> max_possible_pfn in ARM64 world. The variable seems to be only updated
> in acpi_numa_memory_affinity_init()
> 
> https://elixir.bootlin.com/linux/v5.3-rc3/source/drivers/acpi/numa.c#L298

problem was that drivers (stub dma ops) (guest booted with RAM below 4Gb)
were breaking when they received RAM buffers above 4Gb. To fix it we needed
to turn on swiotlb if possible max PFN could be above 4Gb.
That's where SRAT played its role to let guest know what possible max PFN
could be.

> Is there any way to test this in Guest to see whether this is actually a problem?
from my x86 experience:
1. for linux:
  * start guest with RAM that not goes over 4Gb PFN mark (for example with -m 1Gb)
     and native drivers (not virtio ones see linux.git commit message ec941c5ffede4)
  * hotplug RAM to go over 4Gb boundary
  * stress test drivers (that should trigger various issues)
    (on x64 it were ATA and various usb drivers leading to data corruption and not
     working mouse in guests)

2. for Windows guests memory hotplug doesn't work at all unless NUMA is enabled. 

Based on above I'd assume, we need to turn on numa for ARM as well if
memhp is enabled since SRAT is the only way of describing max possible RAM end
to the guest OS.

> Thanks,
> Shameer
> 
> > It's worth to check if we might need a patch for turning on NUMA
> > (how to do it in QEMU see: auto_enable_numa_with_memhp)  
> 


