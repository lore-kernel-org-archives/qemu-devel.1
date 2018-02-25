Received: from eggs.gnu.org ([2001:4830:134:3::10]:54583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eq3Ll-0001HL-AD
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 15:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eq3Lg-0000ZT-P8
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 15:56:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eq3Lg-0000ZC-K1
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 15:56:44 -0500
References: <151953467143.1042.1841095009900086023@bdbb90650ae5>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40ca37b5-e835-a8db-524e-92e9efc9c650@redhat.com>
Date: Sun, 25 Feb 2018 21:56:34 +0100
MIME-Version: 1.0
In-Reply-To: <151953467143.1042.1841095009900086023@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 RFC 0/3] util/uri.c: Coding style format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Cc: suhang16@mails.ucas.ac.cn, boxafox@163.com

On 25.02.2018 05:57, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
[...]
>   GEN     trace/generated-helpers.c
>   CC      mipsel-softmmu/trace/control-target.o
>   CC      ppc-softmmu/memory_mapping.o
>   CC      ppc-softmmu/dump.o
>   CC      ppc-softmmu/migration/ram.o
>   CC      ppc-softmmu/accel/accel.o
>   CC      ppc-softmmu/accel/stubs/hax-stub.o
>   CC      ppc-softmmu/accel/stubs/hvf-stub.o
>   CC      ppc-softmmu/accel/stubs/whpx-stub.o
>   CC      ppc-softmmu/accel/stubs/kvm-stub.o
>   CC      ppc-softmmu/accel/tcg/tcg-all.o
>   CC      ppc-softmmu/accel/tcg/cputlb.o
>   CC      ppc-softmmu/accel/tcg/tcg-runtime.o
>   CC      mipsel-softmmu/trace/generated-helpers.o
>   CC      ppc-softmmu/accel/tcg/tcg-runtime-gvec.o
>   LINK    mipsel-softmmu/qemu-system-mipsel
>   CC      ppc-softmmu/accel/tcg/cpu-exec.o
>   CC      ppc-softmmu/accel/tcg/cpu-exec-common.o
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:193: qemu-system-mipsel] Error 1
> make: *** [Makefile:404: subdir-mipsel-softmmu] Error 2
>   CC      ppc-softmmu/accel/tcg/translate-all.o
>   CC      sh4-softmmu/target/sh4/gdbstub.o
>   CC      ppc-softmmu/accel/tcg/translator.o
>   CC      ppc-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppc-softmmu/hw/block/virtio-blk.o
>   CC      ppc-softmmu/hw/block/vhost-user-blk.o
>   CC      ppc-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppc-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppc-softmmu/hw/core/generic-loader.o
>   CC      ppc-softmmu/hw/core/null-machine.o
>   CC      ppc-softmmu/hw/display/sm501.o
>   CC      ppc-softmmu/hw/display/vga.o
>   CC      ppc-softmmu/hw/display/virtio-gpu.o
>   CC      ppc-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppc-softmmu/hw/display/virtio-gpu-pci.o
>   GEN     trace/generated-helpers.c
>   CC      ppc-softmmu/hw/i2c/ppc4xx_i2c.o
>   CC      sh4-softmmu/trace/control-target.o
>   CC      ppc-softmmu/hw/misc/ivshmem.o
>   CC      ppc-softmmu/hw/misc/mmio_interface.o
>   CC      sh4-softmmu/trace/generated-helpers.o
>   CC      ppc-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppc-softmmu/hw/net/virtio-net.o
>   CC      ppc-softmmu/hw/net/vhost_net.o
>   LINK    sh4-softmmu/qemu-system-sh4
>   CC      ppc-softmmu/hw/net/fsl_etsec/etsec.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/registers.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/rings.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc-softmmu/hw/scsi/vhost-scsi-common.o
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:193: qemu-system-sh4] Error 1
> make: *** [Makefile:404: subdir-sh4-softmmu] Error 2
>   CC      ppc-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppc-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      ppc-softmmu/hw/timer/mc146818rtc.o
>   CC      ppc-softmmu/hw/vfio/common.o
>   CC      ppc-softmmu/hw/vfio/pci.o
>   CC      ppc-softmmu/hw/vfio/pci-quirks.o
>   CC      ppc-softmmu/hw/vfio/platform.o
>   CC      ppc-softmmu/hw/vfio/spapr.o
>   CC      ppc-softmmu/hw/virtio/virtio.o
>   CC      ppc-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppc-softmmu/hw/virtio/vhost.o
>   CC      ppc-softmmu/hw/virtio/vhost-backend.o
>   CC      ppc-softmmu/hw/virtio/vhost-user.o
>   CC      ppc-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppc-softmmu/hw/virtio/virtio-crypto.o
>   CC      ppc-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppc-softmmu/hw/ppc/ppc.o
>   CC      ppc-softmmu/hw/ppc/ppc_booke.o
>   CC      ppc-softmmu/hw/ppc/fdt.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      ppc-softmmu/hw/ppc/ppc405_uc.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppc-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppc-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      ppc-softmmu/hw/ppc/prep.o
>   CC      ppc-softmmu/hw/ppc/prep_systemio.o
>   CC      ppc-softmmu/hw/ppc/rs6000_mc.o
>   CC      ppc-softmmu/hw/ppc/mac_oldworld.o
>   CC      ppc-softmmu/hw/ppc/mac_newworld.o
>   CC      ppc-softmmu/hw/ppc/e500.o
>   CC      ppc-softmmu/hw/ppc/mpc8544ds.o
>   CC      ppc-softmmu/hw/ppc/e500plat.o
>   CC      ppc-softmmu/hw/ppc/mpc8544_guts.o
>   CC      ppc-softmmu/hw/ppc/ppce500_spin.o
>   CC      ppc-softmmu/hw/ppc/virtex_ml507.o
>   CC      ppc-softmmu/target/ppc/cpu-models.o
>   CC      ppc-softmmu/target/ppc/cpu.o
>   CC      ppc-softmmu/target/ppc/translate.o
>   CC      ppc-softmmu/target/ppc/machine.o
>   CC      ppc-softmmu/target/ppc/mmu_helper.o
>   CC      ppc-softmmu/target/ppc/mmu-hash32.o
>   CC      ppc-softmmu/target/ppc/monitor.o
>   CC      ppc-softmmu/target/ppc/arch_dump.o
>   CC      ppc-softmmu/target/ppc/kvm-stub.o
>   CC      ppc-softmmu/target/ppc/dfp_helper.o
>   CC      ppc-softmmu/target/ppc/excp_helper.o
>   CC      ppc-softmmu/target/ppc/fpu_helper.o
>   CC      ppc-softmmu/target/ppc/int_helper.o
>   CC      ppc-softmmu/target/ppc/timebase_helper.o
>   CC      ppc-softmmu/target/ppc/misc_helper.o
>   CC      ppc-softmmu/target/ppc/mem_helper.o
>   CC      ppc-softmmu/target/ppc/gdbstub.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/decContext.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/decNumber.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/dpd/decimal32.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/dpd/decimal64.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/dpd/decimal128.o
>   GEN     trace/generated-helpers.c
>   CC      ppc-softmmu/trace/control-target.o
>   CC      ppc-softmmu/gdbstub-xml.o
>   CC      ppc-softmmu/trace/generated-helpers.o
>   LINK    ppc-softmmu/qemu-system-ppc
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:193: qemu-system-ppc] Error 1
> make: *** [Makefile:404: subdir-ppc-softmmu] Error 2

 Hi Fam,

Patchew genereted some really weird errors here - linking failed without
any further explanation. Are there currently any known problems with the
build bot?

 Thomas
