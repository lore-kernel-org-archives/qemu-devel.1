Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiGVE-0006Mv-GO
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiGVB-0005oB-Cp
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:54:40 -0400
Date: Wed, 25 Jul 2018 11:54:26 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, radoslaw.biernacki@linaro.org, leif.lindholm@linaro.org, ard.biesheuvel@linaro.org

On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware, for supporting
> firmware and OS development for pysical Aarch64 machines.
> 
> This patch introduces new machine type 'Enterprise' with main features:
>  - Based on 'virt' machine type.
>  - Re-designed memory map.
>  - EL2 and EL3 are enabled by default.
>  - GIC version 3 by default.
>  - AHCI controller attached to system bus, and then CDROM and hard disc
>    can be added to it.
>  - EHCI controller attached to system bus, with USB mouse and key board
>    installed by default.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>  - No virtio functions enabled, since this is to emulate real hardware.

In the last review it was pointed out that using virtio-pci should still
be "real" enough, so there's not much reason to avoid it. Well, unless
there's some concern as to what drivers are available in the firmware and
guest kernel. But that concern usually only applies to legacy firmwares
and kernels, and therefore shouldn't apply to AArch64.

>  - No paravirtualized fw_cfg device either.
> 
> Arm Trusted Firmware and UEFI porting to this are done accordingly.
>

How will UEFI get the ACPI tables from QEMU without fw-cfg? I didn't
see any sort of reserved ROM region in the patch for them.

Thanks,
drew
