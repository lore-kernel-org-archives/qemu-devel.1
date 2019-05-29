Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52714C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C6622CB8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C6622CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyv3-0002LL-Az
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:47:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hVysH-0000Uc-0H
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hVysF-0008WI-8W
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hVysF-0008Se-1l
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:44:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7F5E3082B71;
	Wed, 29 May 2019 13:44:01 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2623C600C4;
	Wed, 29 May 2019 13:43:57 +0000 (UTC)
Date: Wed, 29 May 2019 07:43:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190529074356.29ab0f7a@x1.home>
In-Reply-To: <20190528232626-mutt-send-email-mst@kernel.org>
References: <155786484688.13873.6037015630912983760.stgit@gimli.home>
	<20190528232626-mutt-send-email-mst@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 29 May 2019 13:44:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] q35: Revert to kernel irqchip
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
	peterx@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 23:30:20 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 14, 2019 at 02:14:41PM -0600, Alex Williamson wrote:
> > Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
> > the default for the pc-q35-4.0 machine type to use split irqchip, which
> > turned out to have disasterous effects on vfio-pci INTx support.  KVM
> > resampling irqfds are registered for handling these interrupts, but
> > these are non-functional in split irqchip mode.  We can't simply test
> > for split irqchip in QEMU as userspace handling of this interrupt is a
> > significant performance regression versus KVM handling (GeForce GPUs
> > assigned to Windows VMs are non-functional without forcing MSI mode or
> > re-enabling kernel irqchip).
> > 
> > The resolution is to revert the change in default irqchip mode in the
> > pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
> > branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
> > configurations for devices requiring legacy INTx support without
> > explicitly modifying the VM configuration to use kernel irqchip.
> > 
> > Link: https://bugs.launchpad.net/qemu/+bug/1826422
> > Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> OK I guess but it's really a kvm patch.
> So I'd like Paolo to review and merge if appropriate.
> 
> Can't say this makes me too happy. split irqchip
> has a bunch of advantages.

What exactly are those advantages relative to a our default QEMU
users?  I see lots of users assigning consumer class hardware and
seeing regressions.  They don't care about a theoretically improved
security attack surface at the cost of performance for legacy devices,
or especially functionality.  Should these users be our focus for the
default machine type?  I think we could make these sorts of compromises
in a legacy-free or virt/cloud/enterprise machine type, but for a
general purpose PC emulator, it doesn't seem a good match given the
issues we have currently.  Obviously users can continue to tune the q35
machine type on their own and enable split irqchip if it's important to
them.  Thanks,

Alex

> > ---
> >  hw/core/machine.c    |    3 +++
> >  hw/i386/pc.c         |    3 +++
> >  hw/i386/pc_q35.c     |   16 ++++++++++++++--
> >  include/hw/boards.h  |    3 +++
> >  include/hw/i386/pc.h |    3 +++
> >  5 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 5d046a43e3d2..e41e6698ac9f 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -24,6 +24,9 @@
> >  #include "hw/pci/pci.h"
> >  #include "hw/mem/nvdimm.h"
> >  
> > +GlobalProperty hw_compat_4_0_1[] = {};
> > +const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
> > +
> >  GlobalProperty hw_compat_4_0[] = {};
> >  const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
> >  
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index d98b737b8f3b..b5311e7e2bd5 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -115,6 +115,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
> >  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> >  static size_t pvh_start_addr;
> >  
> > +GlobalProperty pc_compat_4_0_1[] = {};
> > +const size_t pc_compat_4_0_1_len = G_N_ELEMENTS(pc_compat_4_0_1);
> > +
> >  GlobalProperty pc_compat_4_0[] = {};
> >  const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
> >  
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 37dd350511a9..dcddc6466200 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -357,7 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
> >      m->units_per_default_bus = 1;
> >      m->default_machine_opts = "firmware=bios-256k.bin";
> >      m->default_display = "std";
> > -    m->default_kernel_irqchip_split = true;
> > +    m->default_kernel_irqchip_split = false;
> >      m->no_floppy = 1;
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> > @@ -374,10 +374,22 @@ static void pc_q35_4_1_machine_options(MachineClass *m)
> >  DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
> >                     pc_q35_4_1_machine_options);
> >  
> > -static void pc_q35_4_0_machine_options(MachineClass *m)
> > +static void pc_q35_4_0_1_machine_options(MachineClass *m)
> >  {
> >      pc_q35_4_1_machine_options(m);
> >      m->alias = NULL;
> > +    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
> > +    compat_props_add(m->compat_props, pc_compat_4_0_1, pc_compat_4_0_1_len);
> > +}
> > +
> > +DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
> > +                   pc_q35_4_0_1_machine_options);
> > +
> > +static void pc_q35_4_0_machine_options(MachineClass *m)
> > +{
> > +    pc_q35_4_0_1_machine_options(m);
> > +    m->default_kernel_irqchip_split = true;
> > +    m->alias = NULL;
> >      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
> >      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
> >  }
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 6f7916f88f02..6ff02bf3e472 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -292,6 +292,9 @@ struct MachineState {
> >      } \
> >      type_init(machine_initfn##_register_types)
> >  
> > +extern GlobalProperty hw_compat_4_0_1[];
> > +extern const size_t hw_compat_4_0_1_len;
> > +
> >  extern GlobalProperty hw_compat_4_0[];
> >  extern const size_t hw_compat_4_0_len;
> >  
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 43df7230a22b..5d5636241e34 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
> >  int e820_get_num_entries(void);
> >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >  
> > +extern GlobalProperty pc_compat_4_0_1[];
> > +extern const size_t pc_compat_4_0_1_len;
> > +
> >  extern GlobalProperty pc_compat_4_0[];
> >  extern const size_t pc_compat_4_0_len;
> >    


