Received: from eggs.gnu.org ([2001:4830:134:3::10]:48112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eblpc-00087h-L7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eblpX-00030O-Ie
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:24:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eblpX-0002x9-33
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:24:31 -0500
Date: Wed, 17 Jan 2018 13:22:37 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180117112236.GB29902@yuvallap>
References: <20180117095421.124787-1-marcel@redhat.com>
	<151618625186.575.2551702677886994143@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151618625186.575.2551702677886994143@5adcb62bf0d6>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 0/4] hw/pvrdma: PVRDMA device
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, famz@redhat.com, ehabkost@redhat.com, mst@redhat.com, cohuck@redhat.com, f4bug@amsat.org, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Wed, Jan 17, 2018 at 02:50:53AM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on ppc host. Please find the details belo=
w.
>=20
> Subject: [Qemu-devel] [PATCH V8 0/4] hw/pvrdma: PVRDMA device implement=
ation
> Type: series
> Message-id: 20180117095421.124787-1-marcel@redhat.com
>
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/decNumber=
.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      i386-softmmu/hw/display/virtio-gpu-pci.o
>   CC      unicore32-softmmu/target/unicore32/softmmu.o
>   CC      moxie-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      sh4eb-softmmu/hw/scsi/virtio-scsi.o
>   CC      sh4eb-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc-softmmu/hw/rdma/rdma_utils.o
>   CC      x86_64-softmmu/hw/rdma/rdma_utils.o
>   CC      mips64-softmmu/hw/misc/mips_cpc.o
>   CC      ppc-softmmu/hw/rdma/rdma_backend.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]

For v8 we omit the patch "pci/shpc: Move function to generic header file"
as it is already part of a pull-request made by Michael S. Tsirkin at Jan=
 16.

And this is the reason for the above failure.

Please ignore these build errors for now.

> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      arm-linux-user/target/arm/crypto_helper.o
>   CC      arm-softmmu/hw/display/omap_dss.o
>   CC      arm-softmmu/hw/display/omap_lcdc.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu.o
>   CC      sparc-softmmu/target/sparc/cpu.o
>   CC      mips-softmmu/hw/misc/mips_cmgcr.o
>   CC      ppc-linux-user/target/ppc/gdbstub.o
> make: *** [subdir-alpha-softmmu] Error 2
>   CC      sparc64-softmmu/hw/rdma/rdma_utils.o
>   CC      mips-softmmu/hw/misc/mips_cpc.o
>   CC      cris-softmmu/trace/generated-helpers.o
>   CC      sparc64-softmmu/hw/rdma/rdma_backend.o
>   CC      ppc64-linux-user/target/ppc/gdbstub.o
>   CC      mips64-softmmu/hw/misc/mips_itu.o
>   CC      microblaze-softmmu/trace/generated-helpers.o
>   CC      ppc64-linux-user/target/ppc/../../libdecnumber/decContext.o
>   CC      sparc-softmmu/target/sparc/fop_helper.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu-3d.o
>   GEN     trace/generated-helpers.c
>   CC      sparc-softmmu/target/sparc/cc_helper.o
>   CC      s390x-softmmu/hw/rdma/rdma_backend.o
>   CC      sparc-softmmu/target/sparc/win_helper.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/dpd/decim=
al32.o
>   CC      ppc-softmmu/hw/rdma/rdma_rm.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      mips-softmmu/hw/misc/mips_itu.o
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/dpd/decim=
al64.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64_be-linux-user/trace/generated-helpers.o
>   CC      mips64el-softmmu/hw/rdma/rdma_utils.o
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/dpd/decim=
al128.o
>   CC      mips64-softmmu/hw/misc/mmio_interface.o
>   CC      ppc64-linux-user/target/ppc/../../libdecnumber/decNumber.o
>   CC      xtensaeb-softmmu/target/xtensa/monitor.o
>   CC      ppcemb-softmmu/hw/rdma/rdma_backend.o
>   CC      ppc-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      m68k-softmmu/gdbstub-xml.o
>   CC      ppc-linux-user/target/ppc/../../libdecnumber/decContext.o
>   CC      sh4-softmmu/hw/rdma/rdma_rm.o
>   LINK    moxie-softmmu/qemu-system-moxie
>   CC      ppc-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      i386-softmmu/hw/display/virtio-vga.o
>   CC      arm-linux-user/trace/control-target.o
>   CC      mips-softmmu/hw/misc/mmio_interface.o
>   GEN     trace/generated-helpers.c
>   CC      ppc-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      sparc-softmmu/target/sparc/mmu_helper.o
>   CC      unicore32-softmmu/trace/control-target.o
>   CC      i386-softmmu/hw/intc/apic.o
>   CC      ppc64abi32-linux-user/trace/control-target.o
>   CC      ppc-softmmu/hw/rdma/vmw/pvrdma_main.o
>   CC      mips64el-softmmu/hw/rdma/rdma_backend.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sh4-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      arm-softmmu/hw/display/pxa2xx_lcd.o
>   CC      ppc64-linux-user/target/ppc/../../libdecnumber/dpd/decimal32.=
o
>   CC      ppc-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      arm-softmmu/hw/display/bcm2835_fb.o
>   LINK    microblaze-softmmu/qemu-system-microblaze
>   CC      i386-softmmu/hw/intc/apic_common.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mips-softmmu/hw/net/virtio-net.o
> make: *** [subdir-sh4eb-softmmu] Error 2
>   CC      mips-softmmu/hw/net/vhost_net.o
>   CC      ppc64-softmmu/hw/display/virtio-vga.o
>   CC      mips64-softmmu/hw/net/virtio-net.o
>   CC      sparc-softmmu/target/sparc/ldst_helper.o
>   CC      mips-softmmu/hw/rdma/rdma_utils.o
>   CC      ppc-linux-user/target/ppc/../../libdecnumber/decNumber.o
>   CC      s390x-softmmu/hw/rdma/rdma_rm.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      x86_64-softmmu/hw/rdma/rdma_backend.o
>   CC      x86_64-softmmu/hw/rdma/rdma_rm.o
>   CC      mips64el-softmmu/hw/rdma/rdma_rm.o
>   CC      mips64-softmmu/hw/net/vhost_net.o
>   CC      i386-softmmu/hw/intc/ioapic.o
>   CC      ppc64-softmmu/hw/i2c/ppc4xx_i2c.o
>   CC      arm-linux-user/gdbstub-xml.o
>   CC      sparc64-softmmu/hw/rdma/rdma_rm.o
>   CC      sparc64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      i386-softmmu/hw/isa/lpc_ich9.o
>   CC      arm-softmmu/hw/display/vga.o
>   CC      ppc64-softmmu/hw/intc/openpic_kvm.o
>   CC      i386-softmmu/hw/misc/ivshmem.o
>   CC      unicore32-softmmu/trace/generated-helpers.o
>   CC      mips64el-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      ppc64-softmmu/hw/intc/xics.o
>   CC      ppc64-linux-user/target/ppc/../../libdecnumber/dpd/decimal64.=
o
>   CC      ppc64-linux-user/target/ppc/../../libdecnumber/dpd/decimal128=
.o
>   CC      sparc-softmmu/target/sparc/int32_helper.o
>   CC      i386-softmmu/hw/misc/pvpanic.o
>   CC      ppcemb-softmmu/hw/rdma/rdma_rm.o
>   CC      sparc64-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      arm-softmmu/hw/display/virtio-gpu.o
>   CC      i386-softmmu/hw/misc/mmio_interface.o
>   CC      x86_64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      sh4-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      ppc-linux-user/target/ppc/../../libdecnumber/dpd/decimal32.o
>   CC      i386-softmmu/hw/net/virtio-net.o
>   CC      mips-softmmu/hw/rdma/rdma_backend.o
>   CC      mips64-softmmu/hw/rdma/rdma_utils.o
>   CC      xtensa-softmmu/trace/generated-helpers.o
>   CC      sparc64-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      ppc64abi32-linux-user/gdbstub-xml.o
>   CC      ppcemb-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      mips64-softmmu/hw/rdma/rdma_backend.o
>   CC      mipsn32el-linux-user/trace/generated-helpers.o
>   CC      sparc64-softmmu/hw/rdma/vmw/pvrdma_main.o
>   CC      xtensaeb-softmmu/target/xtensa/xtensa-isa.o
>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
>   CC      ppc64-softmmu/hw/intc/xics_kvm.o
>   CC      mips-softmmu/hw/rdma/rdma_rm.o
>   CC      ppc-linux-user/target/ppc/../../libdecnumber/dpd/decimal64.o
>   CC      ppc64-softmmu/hw/intc/xics_pnv.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      mips64el-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      s390x-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      s390x-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      xtensaeb-softmmu/target/xtensa/translate.o
>   LINK    unicore32-softmmu/qemu-system-unicore32
>   CC      mips64-softmmu/hw/rdma/rdma_rm.o
>   CC      mips64el-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      x86_64-softmmu/hw/rdma/vmw/pvrdma_cmd.o
> cc1: all warnings being treated as errors
>   CC      mips64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
>   CC      s390x-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
> make: *** [subdir-sh4-softmmu] Error 2
>   CC      m68k-softmmu/trace/generated-helpers.o
>   GEN     trace/generated-helpers.c
>   CC      arm-linux-user/trace/generated-helpers.o
>   CC      arm-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      ppc64-linux-user/trace/control-target.o
>   CC      xtensaeb-softmmu/target/xtensa/op_helper.o
>   CC      mips64-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      xtensaeb-softmmu/target/xtensa/helper.o
>   CC      x86_64-linux-user/trace/generated-helpers.o
>   CC      xtensaeb-softmmu/target/xtensa/cpu.o
>   CC      xtensaeb-softmmu/target/xtensa/gdbstub.o
>   CC      mips64el-softmmu/hw/rdma/vmw/pvrdma_main.o
>   GEN     trace/generated-helpers.c
>   CC      ppc64abi32-linux-user/trace/generated-helpers.o
>   CC      mips-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      sparc-softmmu/target/sparc/gdbstub.o
>   LINK    xtensa-softmmu/qemu-system-xtensa
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   GEN     trace/generated-helpers.c
> make: *** [subdir-ppc-softmmu] Error 2
>   CC      ppc-linux-user/target/ppc/../../libdecnumber/dpd/decimal128.o
>   LINK    cris-softmmu/qemu-system-cris
>   CC      ppc64-softmmu/hw/misc/ivshmem.o
>   CC      x86_64-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      xtensaeb-softmmu/trace/control-target.o
>   CC      mips-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips-softmmu/hw/rdma/vmw/pvrdma_main.o
>   CC      mips-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc64-softmmu/hw/misc/mmio_interface.o
>   CC      mips-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppcemb-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   GEN     trace/generated-helpers.c
>   CC      ppc-linux-user/trace/control-target.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      arm-softmmu/hw/display/virtio-gpu-pci.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
> cc1: all warnings being treated as errors
>   CC      aarch64-softmmu/hw/display/dpcd.o
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      mips64-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      ppc64-softmmu/hw/net/spapr_llan.o
>   CC      arm-softmmu/hw/dma/omap_dma.o
>   CC      ppc-linux-user/gdbstub-xml.o
> make: *** [subdir-sparc64-softmmu] Error 2
>   CC      mips-softmmu/hw/scsi/vhost-scsi.o
>   CC      mips-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      ppc64-softmmu/hw/net/xilinx_ethlite.o
>   CC      arm-softmmu/hw/dma/soc_dma.o
>   CC      sparc-softmmu/trace/control-target.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      i386-softmmu/hw/net/vhost_net.o
>   CC      ppc-linux-user/trace/generated-helpers.o
>   CC      ppc64-softmmu/hw/net/virtio-net.o
>   CC      i386-softmmu/hw/rdma/rdma_utils.o
>   CC      arm-softmmu/hw/dma/pxa2xx_dma.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      ppc64-linux-user/gdbstub-xml.o
>   CC      mips-softmmu/hw/scsi/vhost-user-scsi.o
> cc1: all warnings being treated as errors
> make: *** [subdir-s390x-softmmu] Error 2
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      i386-softmmu/hw/rdma/rdma_backend.o
>   CC      mips-softmmu/hw/timer/mips_gictimer.o
>   CC      ppcemb-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      xtensaeb-softmmu/trace/generated-helpers.o
>   CC      ppc64-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      i386-softmmu/hw/rdma/rdma_rm.o
>   CC      sparc-softmmu/trace/generated-helpers.o
>   CC      arm-softmmu/hw/dma/bcm2835_dma.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      ppc64-linux-user/trace/generated-helpers.o
>   CC      ppcemb-softmmu/hw/rdma/vmw/pvrdma_main.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      ppcemb-softmmu/hw/scsi/virtio-scsi.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      ppc64-softmmu/hw/net/fsl_etsec/etsec.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/registers.o
>   CC      arm-softmmu/hw/gpio/omap_gpio.o
> make: *** [subdir-x86_64-softmmu] Error 2
>   CC      i386-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      i386-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/rings.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc64-softmmu/hw/nvram/spapr_nvram.o
>   CC      arm-softmmu/hw/gpio/imx_gpio.o
> make: *** [subdir-mips64el-softmmu] Error 2
>   CC      i386-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      ppc64-softmmu/hw/rdma/rdma_utils.o
>   CC      arm-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      ppc64-softmmu/hw/rdma/rdma_backend.o
>   CC      ppc64-softmmu/hw/rdma/rdma_rm.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      i386-softmmu/hw/rdma/vmw/pvrdma_main.o
>   CC      ppc64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      arm-softmmu/hw/i2c/omap_i2c.o
>   CC      arm-softmmu/hw/input/pxa2xx_keypad.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      arm-softmmu/hw/input/tsc210x.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      ppc64-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      ppc64-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi.o
>   CC      i386-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      arm-softmmu/hw/intc/armv7m_nvic.o
>   CC      ppc64-softmmu/hw/rdma/vmw/pvrdma_main.o
>   CC      ppc64-softmmu/hw/scsi/spapr_vscsi.o
> make: *** [subdir-mips64-softmmu] Error 2
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
>   CC      i386-softmmu/hw/timer/mc146818rtc.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
> cc1: all warnings being treated as errors
>   CC      ppc64-softmmu/hw/scsi/vhost-scsi-common.o
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      ppc64-softmmu/hw/scsi/vhost-scsi.o
>   CC      arm-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      arm-softmmu/hw/intc/exynos4210_combiner.o
>   CC      ppc64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      ppc64-softmmu/hw/timer/mc146818rtc.o
>   CC      ppc64-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/intc/omap_intc.o
>   LINK    sparc-softmmu/qemu-system-sparc
>   CC      ppc64-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      arm-softmmu/hw/intc/bcm2835_ic.o
>   CC      ppc64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      ppc64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      arm-softmmu/hw/intc/bcm2836_control.o
>   CC      ppc64-softmmu/hw/vfio/spapr.o
>   CC      arm-softmmu/hw/intc/allwinner-a10-pic.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      arm-softmmu/hw/intc/aspeed_vic.o
>   CC      arm-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      arm-softmmu/hw/misc/ivshmem.o
>   CC      arm-softmmu/hw/misc/arm_sysctl.o
>   CC      arm-softmmu/hw/misc/cbus.o
>   CC      arm-softmmu/hw/misc/exynos4210_pmu.o
>   CC      arm-softmmu/hw/misc/exynos4210_clk.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      arm-softmmu/hw/misc/exynos4210_rng.o
>   CC      arm-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      arm-softmmu/hw/misc/imx31_ccm.o
>   CC      arm-softmmu/hw/misc/imx25_ccm.o
>   CC      arm-softmmu/hw/misc/imx6_ccm.o
>   LINK    s390x-linux-user/qemu-s390x
> make: *** [subdir-mips-softmmu] Error 2
>   CC      arm-softmmu/hw/misc/imx6_src.o
>   CC      arm-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>   CC      arm-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      arm-softmmu/hw/misc/omap_gpmc.o
>   CC      arm-softmmu/hw/misc/omap_l4.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      arm-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      arm-softmmu/hw/misc/omap_tap.o
>   CC      arm-softmmu/hw/misc/bcm2835_property.o
>   CC      arm-softmmu/hw/misc/bcm2835_mbox.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      arm-softmmu/hw/misc/bcm2835_rng.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
> make: *** [subdir-ppcemb-softmmu] Error 2
>   CC      arm-softmmu/hw/misc/zynq_slcr.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      arm-softmmu/hw/misc/zynq-xadc.o
>   CC      arm-softmmu/hw/misc/mps2-scc.o
>   CC      arm-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      arm-softmmu/hw/misc/aspeed_scu.o
>   CC      arm-softmmu/hw/misc/aspeed_sdmc.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      arm-softmmu/hw/misc/mmio_interface.o
>   CC      arm-softmmu/hw/misc/msf2-sysreg.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      arm-softmmu/hw/net/virtio-net.o
>   CC      arm-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/hw/pcmcia/pxa2xx.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      arm-softmmu/hw/rdma/rdma_utils.o
>   LINK    m68k-softmmu/qemu-system-m68k
>   CC      arm-softmmu/hw/rdma/rdma_backend.o
>   CC      arm-softmmu/hw/rdma/rdma_rm.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>   CC      arm-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      arm-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      arm-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      arm-softmmu/hw/rdma/vmw/pvrdma_main.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      aarch64-softmmu/hw/rdma/rdma_utils.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/rdma/rdma_backend.o
>   CC      arm-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      aarch64-softmmu/hw/rdma/rdma_rm.o
>   CC      aarch64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
>   CC      arm-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/rdma/vmw/pvrdma_cmd.o
>   CC      aarch64-softmmu/hw/rdma/vmw/pvrdma_qp_ops.o
>   CC      arm-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/rdma/vmw/pvrdma_main.o
> make: *** [subdir-i386-softmmu] Error 2
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      arm-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      arm-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      arm-softmmu/hw/ssi/imx_spi.o
>   CC      arm-softmmu/hw/timer/exynos4210_mct.o
>   CC      arm-softmmu/hw/timer/exynos4210_pwm.o
>   CC      arm-softmmu/hw/timer/exynos4210_rtc.o
>   CC      arm-softmmu/hw/timer/omap_gptimer.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      arm-softmmu/hw/timer/omap_synctimer.o
>   CC      arm-softmmu/hw/timer/pxa2xx_timer.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      arm-softmmu/hw/timer/digic-timer.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c: In f=
unction =E2=80=98create_qp_rings=E2=80=99:
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: implicit declaration of function =E2=80=98pow2roundup32=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
>      wqe_sz =3D pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
>      ^
> /var/tmp/patchew-tester-tmp-0kkotmms/src/hw/rdma/vmw/pvrdma_cmd.c:420:5=
: error: nested extern declaration of =E2=80=98pow2roundup32=E2=80=99 [-W=
error=3Dnested-externs]
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
> cc1: all warnings being treated as errors
> make[1]: *** [hw/rdma/vmw/pvrdma_cmd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   LINK    tricore-softmmu/qemu-system-tricore
> make: *** [subdir-arm-softmmu] Error 2
> make: *** [subdir-ppc64-softmmu] Error 2
>   LINK    xtensaeb-softmmu/qemu-system-xtensaeb
> make: *** [subdir-aarch64-softmmu] Error 2
>   LINK    mipsel-linux-user/qemu-mipsel
>   LINK    aarch64_be-linux-user/qemu-aarch64_be
>   LINK    x86_64-linux-user/qemu-x86_64
>   LINK    aarch64-linux-user/qemu-aarch64
>   LINK    mips-linux-user/qemu-mips
>   LINK    mips64-linux-user/qemu-mips64
>   LINK    mipsn32-linux-user/qemu-mipsn32
>   LINK    mipsn32el-linux-user/qemu-mipsn32el
>   LINK    mips64el-linux-user/qemu-mips64el
>   LINK    armeb-linux-user/qemu-armeb
>   LINK    arm-linux-user/qemu-arm
>   LINK    ppc64le-linux-user/qemu-ppc64le
>   LINK    ppc-linux-user/qemu-ppc
>   LINK    ppc64abi32-linux-user/qemu-ppc64abi32
>   LINK    ppc64-linux-user/qemu-ppc64
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
