Received: from eggs.gnu.org ([2001:4830:134:3::10]:45470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWP1n-00053O-Tt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWP1m-0004IV-3H
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:35:15 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWP1l-0004IJ-Sc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:35:14 -0400
Received: by mail-ot0-x241.google.com with SMTP id p95-v6so8163879ota.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:35:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152968508595.888.6631795618045211665@d39dc562802a>
References: <20180622125814.345274-1-eblake@redhat.com>
	<152968508595.888.6631795618045211665@d39dc562802a>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 17:34:52 +0100
Message-ID: <CAFEAcA9rdG4uAVgVe16_prsZ50Wic9+BMSmeZ+E7=uJ75WE=8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Silence gcc false positive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Fam -- looks like patchew has got confused somehow...

On 22 June 2018 at 17:31,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20180622125814.345274-1-eblake@redhat.com
> Subject: [Qemu-devel] [PATCH] nbd/server: Silence gcc false positive

This is the report email for this nbd patch (and it's following
up to the nbd patch email)...

> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  t [tag update]            patchew/20180620120620.12806-1-yongbok.kim@mips.com -> patchew/20180620120620.12806-1-yongbok.kim@mips.com
>  * [new tag]               patchew/20180622125814.345274-1-eblake@redhat.com -> patchew/20180622125814.345274-1-eblake@redhat.com
> Switched to a new branch 'test'
> 6489e4b10c Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180622' into staging
> 10e84d2504 xen: Don't use memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()
> aea21afaef vl.c: Don't zero-initialize statics for serial_hds
> fea64baeab target/arm: Strict alignment for ARMv6-M and ARMv8-M Baseline

...but the patches it seems to actually be testing are from my
latest target-arm pull request ?

> 12c583c45b target/arm: Introduce ARM_FEATURE_M_MAIN
> 42fc936a30 hw/arm/mps2-tz.c: Instantiate MPCs
> b03e0d28a2 hw/arm/iotkit: Wire up MPC interrupt lines
> 985db83c4a hw/arm/iotkit: Instantiate MPC
> 769d3448af hw/misc/iotkit-secctl.c: Implement SECMPCINTSTATUS
> cdf0c49a6a hw/misc/tz_mpc.c: Honour the BLK_LUT settings in translate
> 7790999ca7 hw/misc/tz-mpc.c: Implement correct blocked-access behaviour
> fa6dd4bba5 hw/misc/tz-mpc.c: Implement registers
> d3cb43aea7 hw/misc/tz-mpc.c: Implement the Arm TrustZone Memory Protection Controller
> 80c3703588 xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F
> 60e383fc83 target-arm: Add the Cortex-R5F
> 6603ff9f6b hw/arm/virt: Increase max_cpus to 512
> ad37e0623f hw/arm/virt: Use 256MB ECAM region by default
> 08e38e7a7e hw/arm/virt: Add virt-3.0 machine type
> d844e5a9a5 hw/arm/virt: Add a new 256MB ECAM region
> 82ca568747 hw/arm/virt: Register two redistributor regions when necessary
> f3a20d2d88 hw/arm/virt-acpi-build: Advertise one or two GICR structures
> 0bd011094d hw/arm/virt: GICv3 DT node with one or two redistributor regions
> b095e84e4f hw/intc/arm_gicv3_kvm: Get prepared to handle multiple redist regions
> 77737a0dc0 hw/intc/arm_gicv3: Introduce redist-region-count array property
> 356069f49b target/arm: Allow KVM device address overwriting
> 0d9ee1e956 linux-headers: Update to kernel mainline commit b357bf602
> e9eb7de541 target-arm: fix a segmentation fault due to illegal memory access
> a2bd1a2dce target/arm: Minor cleanup for ARMv6-M 32-bit instructions
> 787260735f hw/intc/arm_gicv3: fix an extra left-shift when reading IPRIORITYR
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/29: hw/intc/arm_gicv3: fix an extra left-shift when reading IPRIORITYR...
> Checking PATCH 2/29: target/arm: Minor cleanup for ARMv6-M 32-bit instructions...
> Checking PATCH 3/29: target-arm: fix a segmentation fault due to illegal memory access...
> Checking PATCH 4/29: linux-headers: Update to kernel mainline commit b357bf602...
> Checking PATCH 5/29: target/arm: Allow KVM device address overwriting...
> Checking PATCH 6/29: hw/intc/arm_gicv3: Introduce redist-region-count array property...
> Checking PATCH 7/29: hw/intc/arm_gicv3_kvm: Get prepared to handle multiple redist regions...
> Checking PATCH 8/29: hw/arm/virt: GICv3 DT node with one or two redistributor regions...
> Checking PATCH 9/29: hw/arm/virt-acpi-build: Advertise one or two GICR structures...
> Checking PATCH 10/29: hw/arm/virt: Register two redistributor regions when necessary...
> Checking PATCH 11/29: hw/arm/virt: Add a new 256MB ECAM region...
> Checking PATCH 12/29: hw/arm/virt: Add virt-3.0 machine type...
> Checking PATCH 13/29: hw/arm/virt: Use 256MB ECAM region by default...
> Checking PATCH 14/29: hw/arm/virt: Increase max_cpus to 512...
> Checking PATCH 15/29: target-arm: Add the Cortex-R5F...
> Checking PATCH 16/29: xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F...
> Checking PATCH 17/29: hw/misc/tz-mpc.c: Implement the Arm TrustZone Memory Protection Controller...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #86:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 504 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 18/29: hw/misc/tz-mpc.c: Implement registers...
> Checking PATCH 19/29: hw/misc/tz-mpc.c: Implement correct blocked-access behaviour...
> Checking PATCH 20/29: hw/misc/tz_mpc.c: Honour the BLK_LUT settings in translate...
> Checking PATCH 21/29: hw/misc/iotkit-secctl.c: Implement SECMPCINTSTATUS...
> ERROR: spaces required around that '*' (ctx:VxV)
> #92: FILE: hw/misc/iotkit-secctl.c:711:
> +    .subsections = (const VMStateDescription*[]) {
>                                              ^
>
> total: 1 errors, 0 warnings, 100 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 22/29: hw/arm/iotkit: Instantiate MPC...
> Checking PATCH 23/29: hw/arm/iotkit: Wire up MPC interrupt lines...
> Checking PATCH 24/29: hw/arm/mps2-tz.c: Instantiate MPCs...
> Checking PATCH 25/29: target/arm: Introduce ARM_FEATURE_M_MAIN...
> Checking PATCH 26/29: target/arm: Strict alignment for ARMv6-M and ARMv8-M Baseline...
> Checking PATCH 27/29: vl.c: Don't zero-initialize statics for serial_hds...
> Checking PATCH 28/29: xen: Don't use memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()...
> Checking PATCH 29/29: Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180622' into staging...
> === OUTPUT END ===
>
> Test command exited with code: 1

thanks
-- PMM
