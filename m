Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3594C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57FF218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57FF218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7P9q-0004Jo-Iv
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 15:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i7P8v-0003rM-0j
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i7P8r-0002Gx-MR
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i7P8q-0002CD-6f
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:16:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABEA1307D985;
 Mon,  9 Sep 2019 19:15:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-196.ams2.redhat.com
 [10.36.116.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A81C210018F8;
 Mon,  9 Sep 2019 19:15:45 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
 <20190905154925.30478-1-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dbe8cc44-ef30-3104-2bd3-6a6fe4438ada@redhat.com>
Date: Mon, 9 Sep 2019 21:15:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190905154925.30478-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 09 Sep 2019 19:15:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: lpc: allow to lock down 128K RAM at
 default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 09/05/19 17:49, Igor Mammedov wrote:
> lpc already has SMI negotiation feature, extend it by adding
> optin ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT to supported features.
>
> Writing this bit into "etc/smi/requested-features" fw_cfg file,
> tells QEMU to alias 0x30000,128K RAM range into SMRAM address
> space and mask this region from normal RAM address space
> (reads return 0xff and writes are ignored, i.e. guest code
> should be able to deal with not usable 0x30000,128K RAM range
> once ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT is activated).
>
> To make negotiated change effective, guest should read
> "etc/smi/features-ok" fw_cfg file, which activates negotiated
> features and locks down negotiating capabilities until hard reset.
>
> Flow for initializing SMI handler on guest side:
>  1. set SMI handler entry point at default SMBASE location
>  2. check that host supports ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT
>     in "etc/smi/supported-features" and set if supported set
>     it in "etc/smi/requested-features"
>  3. read "etc/smi/features-ok", if returned value is 1
>     negotiated at step 2 features are activated successfully.

Tying the [0x30000+128K) lockdown to the broadcast SMI negotiation is a
simplification for QEMU, but it is a complication for OVMF.

(This QEMU patch ties those things together in effect because
"etc/smi/features-ok" can be selected for lockdown only once.)

In OVMF, at least 6 modules are involved in SMM setup. Here I'm only
going to list some steps for 4 modules (skipping
"OvmfPkg/SmmAccess/SmmAccess2Dxe.inf" and
"UefiCpuPkg/CpuIo2Smm/CpuIo2Smm.inf").


(1) The "OvmfPkg/SmmControl2Dxe/SmmControl2Dxe.inf" driver is launched,
and it produces the EFI_SMM_CONTROL2_PROTOCOL.

EFI_SMM_CONTROL2_PROTOCOL.Trigger() is the standard / abstract method
for synchronously raising an SMI. The OVMF implementation writes to IO
port 0xB2.

Because OVMF exposes this protocol to the rest of the firmware, it first
negotiates SMI broadcast, if QEMU offers it. The idea is that, without
negotiating SMI broadcast (if it's available), EFI_SMM_CONTROL2_PROTOCOL
is not fully configured, and should not be exposed. (Because, Trigger()
wouldn't work properly). Incomplete / halfway functional protocols are
not to be published.

That is, we have

(1a) negotiate SMI broadcast
(1b) install EFI_SMM_CONTROL2_PROTOCOL.


(2) Dependent on EFI_SMM_CONTROL2_PROTOCOL, the SMM IPL (Initial Program
Load -- "MdeModulePkg/Core/PiSmmCore/PiSmmIpl.inf") is launched.

This module
(2a) registers a callback for EFI_SMM_CONFIGURATION_PROTOCOL,
(2b) loads the SMM Core ("MdeModulePkg/Core/PiSmmCore/PiSmmCore.inf")
     into SMRAM and starts it.


(3) The SMM Core launches the SMM processor driver
("UefiCpuPkg/PiSmmCpuDxeSmm/PiSmmCpuDxeSmm.inf").

The SMM processor driver
(3a) performs the initial SMBASE relocation,
(3b) and then installs EFI_SMM_CONFIGURATION_PROTOCOL.

(Side remark: the SMM processor driver does not use IO port 0xB2 (it
does not call Trigger()); it uses LAPIC accesses. This is by design (PI
spec); Trigger() is supposed to be called  after the relocation is done,
and not for starting the relocation.)


(4) The SMM IPL's callback fires. It uses EFI_SMM_CONFIGURATION_PROTOCOL
to connect the platform-independent SMM entry point (= central
high-level SMI handler), which is in the SMM Core, into the low-level
(CPU-specific) SMI handler in the SMM processor driver.

At this point, SMIs are considered fully functional. General drivers
that are split into privileged (SMM) and unprivileged (runtime DXE)
halves, such as the variable service driver, can use
EFI_SMM_COMMUNICATION_PROTOCOL to submit messages to the privileged
(SMM) halves. And that boils down to EFI_SMM_CONTROL2_PROTOCOL.Trigger()
calls, which depends on SMI broadcast.

--*--

The present QEMU patch requires the firmware to (i) negotiate SMI
broadcast and to (ii) lock down [0x30000+128K) at the same time.

If OVMF does both in step (1a) -- i.e. where it currently negotiates the
broadcast --, then step (3a) breaks: because the initial SMBASE
relocation depends on RAM at [0x30000+128K).

In a theoretical ordering perspective, we could perhaps move the logic
from step (1a) between steps (3a) and (3b). There are two problems with
that:

- The platform logic from step (1a) doesn't belong in the SMM processor
driver (even if we managed to hook it in).

- In step (1b), we'd be installing a protocol
(EFI_SMM_CONTROL2_PROTOCOL) that is simply not set up correctly -- it's
incomplete.


Can QEMU offer this new "[0x30000+128K) lockdown" hardware feature in a
separate platform device? (Such as a PCI device with fixed
(QEMU-specified) B/D/F, and config space register(s).)

It would be less difficult to lock such hardware down in isolation: I
wouldn't even attempt to inject that action between steps (3a) and (3b),
but write it as a new, independent End-of-DXE handler, in
"OvmfPkg/SmmAccess/SmmAccess2Dxe.inf". (That driver already offers SMRAM
open/close/lock services.) I would also reserve the memory away at that
time -- I don't expect the firmware to keep anything that low.
(Allocations are generally served top-down.)

--*--

... I've done some testing too. Applying the QEMU patch on top of
89ea03a7dc83, my plan was:

- do not change OVMF, just see if it continues booting with the QEMU
patch

- then negotiate bit#1 too, in step (1a) -- this is when I'd expect (3a)
to break.

Unfortunately, the result is worse than that; even without negotiating
bit#1 (i.e. in the baseline test), the firmware crashes (reboots) in
step (3a). I've checked "info mtree", and all occurences of
"smbase-blackhole" and "smbase-blackhole" are marked [disabled]. I'm not
sure what's wrong with the baseline test (i.e. without negotiating
bit#1). If I drop the patch (build QEMU at 89ea03a7dc83), then things
work fine.

Thank you!
Laszlo

>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/i386/ich9.h | 11 ++++++--
>  hw/i386/pc.c           |  4 ++-
>  hw/i386/pc_q35.c       |  3 ++-
>  hw/isa/lpc_ich9.c      | 58 +++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 71 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index 72e803f6e2..c28685b753 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -12,11 +12,14 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ich9.h"
>  #include "hw/pci/pci_bus.h"
> +#include "qemu/units.h"
>
>  void ich9_lpc_set_irq(void *opaque, int irq_num, int level);
>  int ich9_lpc_map_irq(PCIDevice *pci_dev, int intx);
>  PCIINTxRoute ich9_route_intx_pin_to_irq(void *opaque, int pirq_pin);
> -void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_enabled);
> +void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_enabled,
> +                      MemoryRegion *system_memory, MemoryRegion *ram,
> +                      MemoryRegion *smram);
>  I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base);
>
>  void ich9_generate_smi(void);
> @@ -71,6 +74,8 @@ typedef struct ICH9LPCState {
>      uint8_t smi_features_ok;          /* guest-visible, read-only; selecting it
>                                         * triggers feature lockdown */
>      uint64_t smi_negotiated_features; /* guest-invisible, host endian */
> +    MemoryRegion smbase_blackhole;
> +    MemoryRegion smbase_window;
>
>      /* isa bus */
>      ISABus *isa_bus;
> @@ -248,5 +253,7 @@ typedef struct ICH9LPCState {
>
>  /* bit positions used in fw_cfg SMI feature negotiation */
>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
> -
> +#define ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT        1
> +#define ICH9_LPC_SMBASE_ADDR                    0x30000
> +#define ICH9_LPC_SMBASE_RAM_SIZE                (128 * KiB)
>  #endif /* HW_ICH9_H */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c14ed86439..99a98303eb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -119,7 +119,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>
> -GlobalProperty pc_compat_4_1[] = {};
> +GlobalProperty pc_compat_4_1[] = {
> +    { "ICH9-LPC", "x-smi-locked-smbase", "off" },
> +};
>  const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
>
>  GlobalProperty pc_compat_4_0[] = {};
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d4e8a1cb9f..50462686a0 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -292,7 +292,8 @@ static void pc_q35_init(MachineState *machine)
>                           0xff0104);
>
>      /* connect pm stuff to lpc */
> -    ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
> +    ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms), get_system_memory(),
> +        ram_memory, MEMORY_REGION(object_resolve_path("/machine/smram", NULL)));
>
>      if (pcms->sata_enabled) {
>          /* ahci and SATA device, for q35 1 ahci controller is built-in */
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 17c292e306..17a8cd1b51 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -359,6 +359,38 @@ static void ich9_set_sci(void *opaque, int irq_num, int level)
>      }
>  }
>
> +static uint64_t smbase_blackhole_read(void *ptr, hwaddr reg, unsigned size)
> +{
> +    return 0xffffffff;
> +}
> +
> +static void smbase_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
> +                                   unsigned width)
> +{
> +    /* nothing */
> +}
> +
> +static const MemoryRegionOps smbase_blackhole_ops = {
> +    .read = smbase_blackhole_read,
> +    .write = smbase_blackhole_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void ich9_lpc_smbase_locked_update(ICH9LPCState *lpc)
> +{
> +    bool en = lpc->smi_negotiated_features & ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT;
> +
> +    memory_region_transaction_begin();
> +    memory_region_set_enabled(&lpc->smbase_blackhole, en);
> +    memory_region_set_enabled(&lpc->smbase_window, en);
> +    memory_region_transaction_commit();
> +}
> +
>  static void smi_features_ok_callback(void *opaque)
>  {
>      ICH9LPCState *lpc = opaque;
> @@ -379,9 +411,13 @@ static void smi_features_ok_callback(void *opaque)
>      /* valid feature subset requested, lock it down, report success */
>      lpc->smi_negotiated_features = guest_features;
>      lpc->smi_features_ok = 1;
> +
> +    ich9_lpc_smbase_locked_update(lpc);
>  }
>
> -void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
> +void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled,
> +                      MemoryRegion *system_memory,  MemoryRegion *ram,
> +                      MemoryRegion *smram)
>  {
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(lpc_pci);
>      qemu_irq sci_irq;
> @@ -413,6 +449,20 @@ void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
>                                   &lpc->smi_features_ok,
>                                   sizeof lpc->smi_features_ok,
>                                   true);
> +
> +        memory_region_init_io(&lpc->smbase_blackhole, OBJECT(lpc),
> +                              &smbase_blackhole_ops, NULL,
> +                              "smbase-blackhole", ICH9_LPC_SMBASE_RAM_SIZE);
> +        memory_region_set_enabled(&lpc->smbase_blackhole, false);
> +        memory_region_add_subregion_overlap(system_memory, ICH9_LPC_SMBASE_ADDR,
> +                                            &lpc->smbase_blackhole, 1);
> +
> +
> +        memory_region_init_alias(&lpc->smbase_window, OBJECT(lpc),
> +            "smbase-window", ram,
> +             ICH9_LPC_SMBASE_ADDR, ICH9_LPC_SMBASE_RAM_SIZE);
> +        memory_region_set_enabled(&lpc->smbase_window, false);
> +        memory_region_add_subregion(smram, 0x30000, &lpc->smbase_window);
>      }
>
>      ich9_lpc_reset(DEVICE(lpc));
> @@ -508,6 +558,7 @@ static int ich9_lpc_post_load(void *opaque, int version_id)
>      ich9_lpc_pmbase_sci_update(lpc);
>      ich9_lpc_rcba_update(lpc, 0 /* disabled ICH9_LPC_RCBA_EN */);
>      ich9_lpc_pmcon_update(lpc);
> +    ich9_lpc_smbase_locked_update(lpc);
>      return 0;
>  }
>
> @@ -567,6 +618,8 @@ static void ich9_lpc_reset(DeviceState *qdev)
>      memset(lpc->smi_guest_features_le, 0, sizeof lpc->smi_guest_features_le);
>      lpc->smi_features_ok = 0;
>      lpc->smi_negotiated_features = 0;
> +
> +    ich9_lpc_smbase_locked_update(lpc);
>  }
>
>  /* root complex register block is mapped into memory space */
> @@ -697,6 +750,7 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>      qdev_init_gpio_out_named(dev, lpc->gsi, ICH9_GPIO_GSI, GSI_NUM_PINS);
>
>      isa_bus_irqs(isa_bus, lpc->gsi);
> +
>  }
>
>  static bool ich9_rst_cnt_needed(void *opaque)
> @@ -764,6 +818,8 @@ static Property ich9_lpc_properties[] = {
>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
>      DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
>                        ICH9_LPC_SMI_F_BROADCAST_BIT, true),
> +    DEFINE_PROP_BIT64("x-smi-locked-smbase", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>


