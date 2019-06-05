Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24272C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E267F2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E267F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38081 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYS2C-0007hK-2w
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:16:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYS0W-0006VX-NB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYS0V-0003xy-CS
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:14:56 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:56569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hYS0V-0003ji-5Q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:14:55 -0400
Received: from player739.ha.ovh.net (unknown [10.108.42.145])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6761911561E
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 11:14:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player739.ha.ovh.net (Postfix) with ESMTPSA id 8FB526A0BD46;
	Wed,  5 Jun 2019 09:14:44 +0000 (UTC)
Date: Wed, 5 Jun 2019 11:14:43 +0200
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190605111443.0495bc3f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1559581843-3968-25-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
	<1559581843-3968-25-git-send-email-pbonzini@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9802647541046483406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegvddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.216
Subject: Re: [Qemu-devel] [PULL 24/24] q35: Revert to kernel irqchip
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
Cc: elohimes@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
	"Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Jun 2019 19:10:43 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> From: Alex Williamson <alex.williamson@redhat.com>
> 
> Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
> the default for the pc-q35-4.0 machine type to use split irqchip, which
> turned out to have disasterous effects on vfio-pci INTx support.  KVM
> resampling irqfds are registered for handling these interrupts, but
> these are non-functional in split irqchip mode.  We can't simply test
> for split irqchip in QEMU as userspace handling of this interrupt is a
> significant performance regression versus KVM handling (GeForce GPUs
> assigned to Windows VMs are non-functional without forcing MSI mode or
> re-enabling kernel irqchip).
> 
> The resolution is to revert the change in default irqchip mode in the
> pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
> branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
> configurations for devices requiring legacy INTx support without
> explicitly modifying the VM configuration to use kernel irqchip.
> 
> Link: https://bugs.launchpad.net/qemu/+bug/1826422
> Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Message-Id: <155786484688.13873.6037015630912983760.stgit@gimli.home>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/machine.c    |  3 +++
>  hw/i386/pc.c         |  3 +++
>  hw/i386/pc_q35.c     | 16 ++++++++++++++--
>  include/hw/boards.h  |  3 +++
>  include/hw/i386/pc.h |  3 +++
>  5 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 16ba667..f1a0f45 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,6 +24,9 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> +GlobalProperty hw_compat_4_0_1[] = {};
> +const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
> +
>  GlobalProperty hw_compat_4_0[] = {};
>  const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2632b73..edc240b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -110,6 +110,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>  
> +GlobalProperty pc_compat_4_0_1[] = {};
> +const size_t pc_compat_4_0_1_len = G_N_ELEMENTS(pc_compat_4_0_1);
> +
>  GlobalProperty pc_compat_4_0[] = {};
>  const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
>  

Do we hence need to add properties to both 4_0 and 4_0_1 ? Would it
make sense to introduce a PC_COMPAT_4_0_COMMON macro to avoid this
duplication ?

The question arose while reviewing this patch:

https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00409.html

> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 37dd350..dcddc64 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -357,7 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->units_per_default_bus = 1;
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
> -    m->default_kernel_irqchip_split = true;
> +    m->default_kernel_irqchip_split = false;
>      m->no_floppy = 1;
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> @@ -374,10 +374,22 @@ static void pc_q35_4_1_machine_options(MachineClass *m)
>  DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
>                     pc_q35_4_1_machine_options);
>  
> -static void pc_q35_4_0_machine_options(MachineClass *m)
> +static void pc_q35_4_0_1_machine_options(MachineClass *m)
>  {
>      pc_q35_4_1_machine_options(m);
>      m->alias = NULL;
> +    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
> +    compat_props_add(m->compat_props, pc_compat_4_0_1, pc_compat_4_0_1_len);
> +}
> +
> +DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
> +                   pc_q35_4_0_1_machine_options);
> +
> +static void pc_q35_4_0_machine_options(MachineClass *m)
> +{
> +    pc_q35_4_0_1_machine_options(m);
> +    m->default_kernel_irqchip_split = true;
> +    m->alias = NULL;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6f7916f..6ff02bf 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -292,6 +292,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +extern GlobalProperty hw_compat_4_0_1[];
> +extern const size_t hw_compat_4_0_1_len;
> +
>  extern GlobalProperty hw_compat_4_0[];
>  extern const size_t hw_compat_4_0_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 43df723..5d56362 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
> +extern GlobalProperty pc_compat_4_0_1[];
> +extern const size_t pc_compat_4_0_1_len;
> +
>  extern GlobalProperty pc_compat_4_0[];
>  extern const size_t pc_compat_4_0_len;
>  


