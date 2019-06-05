Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8623C28CC3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 02:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5662075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 02:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5662075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYLer-0006rb-49
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 22:28:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYLdz-0006Tt-CQ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 22:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYLdw-0006r7-Sx
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 22:27:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYLdw-0006mr-Ml
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 22:27:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so4224669qkc.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 19:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=SNlD636p1SU81sHO9ZMS6Oi3b7Y1UfRCbT3yVTZ2Tec=;
	b=HMK/y70qYl7O2T6D0fNDr6TAX5XXkUyEF0r0ihkcT9SaFLLN4FspR3aI+fooDjkInA
	GjJFNnfKFZ2PZ0Kr+hTenG7GB/MYX+PVRzwXayuZTNPftfuLHlcT5iiloHkVwa5BSOuH
	XTFs6IQNpNLDm/RQVaGyU6fzUkVysSYzAvn6sXt2bWm/bhBT8FPvMjHIaZpK+0IyYtFm
	7YqknEtG9ZtzIHGJVAlY+Ofvt3jq9FC3Idew08iUJFsv3B1sAHH7/wMSGfUst/Ap93Nw
	Dax8CFtQDCZ2UWN0Q6ll3MWPb+dZMl2lLMx2r5EXG+XacpPvxvDByQuz0Smv9n7tPjVm
	BosA==
X-Gm-Message-State: APjAAAWnoGkfQYaK4DoBHvSIXKh+XUO6tby1rmnCbflvBP59JWAY/94V
	NZpAbKfeNJ333MWt0e7Qqee+7Q==
X-Google-Smtp-Source: APXvYqyeN4e0LAfEzKLHHLgBkug9Y6MGleRa1I/5WRnf9WSEV991nFD26c+yO7jPCwHIKVUGu7J5VA==
X-Received: by 2002:a37:696:: with SMTP id 144mr29003745qkg.250.1559701631915; 
	Tue, 04 Jun 2019 19:27:11 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	d123sm3655531qkb.94.2019.06.04.19.27.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 19:27:11 -0700 (PDT)
Date: Tue, 4 Jun 2019 22:27:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190604222700-mutt-send-email-mst@kernel.org>
References: <155968619555.19319.478535697621079640.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155968619555.19319.478535697621079640.stgit@gimli.home>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH v2] [for 4.0.1] q35: Revert to kernel
 irqchip
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
	qemu-stable@nongnu.org, pbonzini@redhat.com,
	mdroth@linux.vnet.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 04:12:24PM -0600, Alex Williamson wrote:
> Backport of QEMU v4.1 commit for stable v4.0.1 release
> 
> commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871
> Author: Alex Williamson <alex.williamson@redhat.com>
> Date:   Tue May 14 14:14:41 2019 -0600
> 
>     q35: Revert to kernel irqchip
> 
>     Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
>     the default for the pc-q35-4.0 machine type to use split irqchip, which
>     turned out to have disasterous effects on vfio-pci INTx support.  KVM
>     resampling irqfds are registered for handling these interrupts, but
>     these are non-functional in split irqchip mode.  We can't simply test
>     for split irqchip in QEMU as userspace handling of this interrupt is a
>     significant performance regression versus KVM handling (GeForce GPUs
>     assigned to Windows VMs are non-functional without forcing MSI mode or
>     re-enabling kernel irqchip).
> 
>     The resolution is to revert the change in default irqchip mode in the
>     pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
>     branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
>     configurations for devices requiring legacy INTx support without
>     explicitly modifying the VM configuration to use kernel irqchip.
> 
> Link: https://bugs.launchpad.net/qemu/+bug/1826422
> Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> Same code as v1, just updating the commit log as a formal backport of
> the merged 4.1 commit.
> 
>  hw/core/machine.c    |    3 +++
>  hw/i386/pc.c         |    3 +++
>  hw/i386/pc_q35.c     |   16 ++++++++++++++--
>  include/hw/boards.h  |    3 +++
>  include/hw/i386/pc.h |    3 +++
>  5 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 743fef28982c..5d046a43e3d2 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,6 +24,9 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> +GlobalProperty hw_compat_4_0[] = {};
> +const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
> +
>  GlobalProperty hw_compat_3_1[] = {
>      { "pcie-root-port", "x-speed", "2_5" },
>      { "pcie-root-port", "x-width", "1" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f2c15bf1f2c3..d98b737b8f3b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -115,6 +115,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>  
> +GlobalProperty pc_compat_4_0[] = {};
> +const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
> +
>  GlobalProperty pc_compat_3_1[] = {
>      { "intel-iommu", "dma-drain", "off" },
>      { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 372c6b73bebd..45cc29d1adb7 100644
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
> @@ -365,12 +365,24 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus = 288;
>  }
>  
> -static void pc_q35_4_0_machine_options(MachineClass *m)
> +static void pc_q35_4_0_1_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>  }
>  
> +DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
> +                   pc_q35_4_0_1_machine_options);
> +
> +static void pc_q35_4_0_machine_options(MachineClass *m)
> +{
> +    pc_q35_4_0_1_machine_options(m);
> +    m->default_kernel_irqchip_split = true;
> +    m->alias = NULL;
> +    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
> +    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
> +}
> +
>  DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
>                     pc_q35_4_0_machine_options);
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index e231860666a1..fe1885cbffa0 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -293,6 +293,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +extern GlobalProperty hw_compat_4_0[];
> +extern const size_t hw_compat_4_0_len;
> +
>  extern GlobalProperty hw_compat_3_1[];
>  extern const size_t hw_compat_3_1_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ca65ef18afb4..43df7230a22b 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
> +extern GlobalProperty pc_compat_4_0[];
> +extern const size_t pc_compat_4_0_len;
> +
>  extern GlobalProperty pc_compat_3_1[];
>  extern const size_t pc_compat_3_1_len;
>  

