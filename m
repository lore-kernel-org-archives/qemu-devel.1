Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E17C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE05B20644
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE05B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzsb-0001KC-Em
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iAzoy-00077I-N7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iAzow-0008KN-Ch
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iAzow-0008KF-3r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 238B410CC1F8;
 Thu, 19 Sep 2019 17:02:17 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-45.rdu2.redhat.com
 [10.10.121.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A29A5C1D4;
 Thu, 19 Sep 2019 17:02:08 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM at default
 SMBASE address
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190917130708.10281-1-imammedo@redhat.com>
 <20190917130708.10281-2-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <561f4440-7c06-10d7-80ce-bbfa810fec59@redhat.com>
Date: Thu, 19 Sep 2019 19:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190917130708.10281-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 17:02:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: yingwen.chen@intel.com, Brijesh Singh <brijesh.singh@amd.com>,
 devel@edk2.groups.io, phillip.goerl@oracle.com, alex.williamson@redhat.com,
 jiewen.yao@intel.com, jun.nakajima@intel.com, michael.d.kinney@intel.com,
 pbonzini@redhat.com, boris.ostrovsky@oracle.com, rfc@edk2.groups.io,
 joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

(+Brijesh)

long-ish pondering ahead, with a question at the end.

On 09/17/19 15:07, Igor Mammedov wrote:
> Use commit (2f295167e0 q35/mch: implement extended TSEG sizes) for
> inspiration and (ab)use reserved register in config space at 0x9c
> offset [*] to extend q35 pci-host with ability to use 128K at
> 0x30000 as SMRAM and hide it (like TSEG) from non-SMM context.
>
> Usage:
>   1: write 0xff in the register
>   2: if the feature is supported, follow up read from the register
>      should return 0x01. At this point RAM at 0x30000 is still
>      available for SMI handler configuration from non-SMM context
>   3: writing 0x02 in the register, locks SMBASE area, making its contents
>      available only from SMM context. In non-SMM context, reads return
>      0xff and writes are ignored. Further writes into the register are
>      ignored until the system reset.

I haven't written any OVMF code for this yet, but I've spent a few hours
thinking about it. Progress! :)

So, this looks really promising.

I'm commenting now for summarizing my thoughts before I write the --
initially minimal -- counterpart patches in OVMF.

There is one complication that deserves this separate email, and that's
SEV's effect on the SMM save state map. It is the topic of the following
edk2 commit range:

  1  61a044c6c15f OvmfPkg/MemEncryptSevLib: find pages of initial SMRAM
                  save state map
  2  86defc2c2575 OvmfPkg/PlatformPei: SEV: allocate pages of initial
                  SMRAM save state map
  3  5ef3b66fec13 OvmfPkg/SmmCpuFeaturesLib: SEV: encrypt+free pages of
                  init. save state map
  4  5e2e5647b9fb OvmfPkg/AmdSevDxe: decrypt the pages of the initial
                  SMRAM save state map

For performing the initial SMBASE relocation, QEMU+KVM have to read the
save state map from guest RAM. For that, under SEV, the guest RAM has to
be decrypted before, and re-encrypted after. Meanwhile, the guest RAM
(while decrypted) should not leak other (unrelated) information to the
hypervisor.

Therefore the above edk2 commits implement the following procedure:

(a.1) in OvmfPkg/PlatformPei, the page in which the save state map
      exists, is allocated away from other firmware components

(a.2) in AmdSevDxe, which runs early in the DXE phase (via APRIORI DXE
      file), we decrypt the page in question

(a.3) PiSmmCpuDxeSmm, after it performs the initial SMBASE relocation,
      calls a hook in SmmCpuFeaturesLib -- and in that hook, we
      re-encrypt the page, and also release (free) it for other uses
      (firmware and OS both)

Clearly, the above conflicts (or at least intersects) with reserving
128KB (32 pages) at 0x3_0000, i.e. at [0x3_0000..0x4_FFFF], forever,
from the OS. (That area is going to be locked to SMM, and so the OS
should see from the UEFI memmap that it should not touch it.) The
conflict exists because the save state map is in the last kilobyte of
page#15 (from said pages #0..#31) -- the save state map is at
[0x3_FC00..0x3_FFFF].

So here's my plan:

(b.1) In PlatformPei, probe the QEMU feature by writing 0xFF to register
      0x9C, and reading back 0x01. If the feature is available, then:

(b.1.1) set a new dynamic PCD to TRUE

(b.1.2) allocate away (as reserved memory) the range
        [0x3_0000..0x4_FFFF]

(b.2) In PlatformPei, conditionalize the current, SEV-specific,
      allocation of the save state map, on the PCD being FALSE.
      (Modifying (a.1).) This will prevent a conflicting
      double-allocation (double coverage by memory allocation HOBs)

(b.3) In AmdSevDxe, don't touch the decryption of the save state map
      (a.2)

(b.4) in the SmmCpuFeaturesLib hook, preserve the re-encryption of the
      save state map (part of (a.3))

(b.5) in the SmmCpuFeaturesLib hook, conditionalize the freeing of the
      save state map, on the PCD being FALSE. (Modifying (a.3).) This
      will prevent a hole from being punched in the allocation that
      covers [0x3_0000..0x4_FFFF], and the entire allocation will
      survive into OS runtime.

The above steps ensure that, while the decrypt/encrypt steps prevail,
the save state map allocations will be ingested by the larger, and
longer-term,  [0x3_0000..0x4_FFFF] allocation.

Furthermore:

(b.6) Extend SmmAccessDxe to write 0x02 to register 0x9C, in an
      EFI_DXE_MM_READY_TO_LOCK_PROTOCOL notification callback, if the
      PCD is true. This will cause the [0x3_0000..0x4_FFFF] area to be
      locked down at the same time with the rest of SMRAM (i.e., TSEG).

(b.7) Extend SmmAccessDxe to save S3 boot script opcodes for writing
      0x02 to register 0x9C, if the PCD is true. This makes sure that
      the above lockdown will occur also during S3 resume, before the OS
      is reached. (The S3 boot script is executed *after* SMBASE
      relocation and TSEG locking, during S3 resume.)

Considering (b.6) and (b.7), the "lockdown on normal boot" (from (b.6))
could actually be merged into (b.5) -- we don't necessarily have to
delay the normal boot lockdown of [0x3_0000..0x4_FFFF] until platform
BDS signals EFI_DXE_MM_READY_TO_LOCK_PROTOCOL; we could do it right
after initial SMBASE relocation.

However: I'd really like to keep (b.6) and (b.7) together, in the same
driver, and (b.7) is really inappropriate for PiSmmCpuDxeSmm (into which
SmmCpuFeaturesLib is linked). For writing S3 boot script opcodes in
(b.7), we need another protocol notify (on EFI_S3_SAVE_STATE_PROTOCOL),
and sneaking that kind of callback into PiSmmCpuDxeSmm sounds really
bad. Hence I plan to add both (b.6) and (b.7) to SmmAccessDxe.

I'll report back with my findings; just wanted to give a heads-up (to
myself as well :))

Finally: can you please remind me why we lock down 128KB (32 pages) at
0x3_0000, and not just half of that? What do we need the range at
[0x4_0000..0x4_FFFF] for?

Thanks!
Laszlo


>
> *) https://www.mail-archive.com/qemu-devel@nongnu.org/msg455991.html
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/pci-host/q35.h | 10 +++++
>  hw/i386/pc.c              |  4 +-
>  hw/pci-host/q35.c         | 80 +++++++++++++++++++++++++++++++++++----
>  3 files changed, 86 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index b3bcf2e632..976fbae599 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -32,6 +32,7 @@
>  #include "hw/acpi/ich9.h"
>  #include "hw/pci-host/pam.h"
>  #include "hw/i386/intel_iommu.h"
> +#include "qemu/units.h"
>
>  #define TYPE_Q35_HOST_DEVICE "q35-pcihost"
>  #define Q35_HOST_DEVICE(obj) \
> @@ -54,6 +55,8 @@ typedef struct MCHPCIState {
>      MemoryRegion smram_region, open_high_smram;
>      MemoryRegion smram, low_smram, high_smram;
>      MemoryRegion tseg_blackhole, tseg_window;
> +    MemoryRegion smbase_blackhole, smbase_window;
> +    bool has_smram_at_smbase;
>      Range pci_hole;
>      uint64_t below_4g_mem_size;
>      uint64_t above_4g_mem_size;
> @@ -97,6 +100,13 @@ typedef struct Q35PCIHost {
>  #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY  0xffff
>  #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX    0xfff
>
> +#define MCH_HOST_BRIDGE_SMBASE_SIZE            (128 * KiB)
> +#define MCH_HOST_BRIDGE_SMBASE_ADDR            0x30000
> +#define MCH_HOST_BRIDGE_F_SMBASE               0x9c
> +#define MCH_HOST_BRIDGE_F_SMBASE_QUERY         0xff
> +#define MCH_HOST_BRIDGE_F_SMBASE_IN_RAM        0x01
> +#define MCH_HOST_BRIDGE_F_SMBASE_LCK           0x02
> +
>  #define MCH_HOST_BRIDGE_PCIEXBAR               0x60    /* 64bit register */
>  #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
>  #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bad866fe44..288d28358a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -119,7 +119,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>
> -GlobalProperty pc_compat_4_1[] = {};
> +GlobalProperty pc_compat_4_1[] = {
> +    { "mch", "smbase-smram", "off" },
> +};
>  const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
>
>  GlobalProperty pc_compat_4_0[] = {};
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 158d270b9f..c1bd9f78ae 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -275,20 +275,20 @@ static const TypeInfo q35_host_info = {
>   * MCH D0:F0
>   */
>
> -static uint64_t tseg_blackhole_read(void *ptr, hwaddr reg, unsigned size)
> +static uint64_t blackhole_read(void *ptr, hwaddr reg, unsigned size)
>  {
>      return 0xffffffff;
>  }
>
> -static void tseg_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned width)
> +static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
> +                            unsigned width)
>  {
>      /* nothing */
>  }
>
> -static const MemoryRegionOps tseg_blackhole_ops = {
> -    .read = tseg_blackhole_read,
> -    .write = tseg_blackhole_write,
> +static const MemoryRegionOps blackhole_ops = {
> +    .read = blackhole_read,
> +    .write = blackhole_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
> @@ -430,6 +430,46 @@ static void mch_update_ext_tseg_mbytes(MCHPCIState *mch)
>      }
>  }
>
> +static void mch_update_smbase_smram(MCHPCIState *mch)
> +{
> +    PCIDevice *pd = PCI_DEVICE(mch);
> +    uint8_t *reg = pd->config + MCH_HOST_BRIDGE_F_SMBASE;
> +    bool lck;
> +
> +    if (!mch->has_smram_at_smbase) {
> +        return;
> +    }
> +
> +    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
> +            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
> +        return;
> +    }
> +
> +    /*
> +     * default/reset state, discard written value
> +     * which will disable SMRAM balackhole at SMBASE
> +     */
> +    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
> +        *reg = 0x00;
> +    }
> +
> +    memory_region_transaction_begin();
> +    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> +        /* disable all writes */
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
> +            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        lck = true;
> +    } else {
> +        lck = false;
> +    }
> +    memory_region_set_enabled(&mch->smbase_blackhole, lck);
> +    memory_region_set_enabled(&mch->smbase_window, lck);
> +    memory_region_transaction_commit();
> +}
> +
>  static void mch_write_config(PCIDevice *d,
>                                uint32_t address, uint32_t val, int len)
>  {
> @@ -456,6 +496,10 @@ static void mch_write_config(PCIDevice *d,
>                         MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
>          mch_update_ext_tseg_mbytes(mch);
>      }
> +
> +    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
> +        mch_update_smbase_smram(mch);
> +    }
>  }
>
>  static void mch_update(MCHPCIState *mch)
> @@ -464,6 +508,7 @@ static void mch_update(MCHPCIState *mch)
>      mch_update_pam(mch);
>      mch_update_smram(mch);
>      mch_update_ext_tseg_mbytes(mch);
> +    mch_update_smbase_smram(mch);
>
>      /*
>       * pci hole goes from end-of-low-ram to io-apic.
> @@ -514,6 +559,9 @@ static void mch_reset(DeviceState *qdev)
>                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
>      }
>
> +    d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
> +    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
> +
>      mch_update(mch);
>  }
>
> @@ -563,7 +611,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
>      memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
>
>      memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
> -                          &tseg_blackhole_ops, NULL,
> +                          &blackhole_ops, NULL,
>                            "tseg-blackhole", 0);
>      memory_region_set_enabled(&mch->tseg_blackhole, false);
>      memory_region_add_subregion_overlap(mch->system_memory,
> @@ -575,6 +623,23 @@ static void mch_realize(PCIDevice *d, Error **errp)
>      memory_region_set_enabled(&mch->tseg_window, false);
>      memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
>                                  &mch->tseg_window);
> +
> +    memory_region_init_io(&mch->smbase_blackhole, OBJECT(mch), &blackhole_ops,
> +                          NULL, "smbase-blackhole",
> +                          MCH_HOST_BRIDGE_SMBASE_SIZE);
> +    memory_region_set_enabled(&mch->smbase_blackhole, false);
> +    memory_region_add_subregion_overlap(mch->system_memory,
> +                                        MCH_HOST_BRIDGE_SMBASE_ADDR,
> +                                        &mch->smbase_blackhole, 1);
> +
> +    memory_region_init_alias(&mch->smbase_window, OBJECT(mch),
> +                             "smbase-window", mch->ram_memory,
> +                             MCH_HOST_BRIDGE_SMBASE_ADDR,
> +                             MCH_HOST_BRIDGE_SMBASE_SIZE);
> +    memory_region_set_enabled(&mch->smbase_window, false);
> +    memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
> +                                &mch->smbase_window);
> +
>      object_property_add_const_link(qdev_get_machine(), "smram",
>                                     OBJECT(&mch->smram), &error_abort);
>
> @@ -601,6 +666,7 @@ uint64_t mch_mcfg_base(void)
>  static Property mch_props[] = {
>      DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
>                         16),
> +    DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>


