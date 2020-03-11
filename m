Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B29C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0382146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3MdO8zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0382146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxug-0006ra-FR
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jBxth-0006LP-Pa
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jBxta-0006wD-Tz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jBxta-0006ty-O9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583919799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwQLvp8nID728R3PoqAlnNmjfvYDEg377cPwoTh5Lks=;
 b=L3MdO8zdaIsF5/jOPfLe5zzZdO2iUUOdri8dRVF/24TZy06GTRrS/aL9AiKemEnaZ3FsZB
 eCZ+2GU58S6uqnF62hF073bObpbCQtXnQFrLnV8dkzxvakftg0IYEjupCdSO25t3gDa0fJ
 RZYRpoejM1mooxA6/MXYdS6ITMu+vOY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-WfbFiid8OWmuN_i-8Y62Gw-1; Wed, 11 Mar 2020 05:43:14 -0400
X-MC-Unique: WfbFiid8OWmuN_i-8Y62Gw-1
Received: by mail-wr1-f71.google.com with SMTP id b11so701491wru.21
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 02:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+1lRupAUghgPKQGfJ9BVnMqjkzpGtWQg5hnbjDyBl4o=;
 b=m0gTYRH5ZmUcbTZv8zR2RMJ20kzO6PHB8pmOUMi5JgtINrvLkvCW3RHnXjpHYEBMVC
 cBtBSNArMPC6CqyVf6h/JxFfxRHGZOtr/qvITkYlCgjRGfaKX18itHUw59uGr+qNY9oz
 r5XpEuDGJTOgjYkd16Z5TU7SD4riTUHY21tIPUvPggRYGmsMDdIU9/XuspaY0oyrAjag
 VKnLB4cKq5CVRDhqfnjpU+tylBjmTpg6yxLVlucqMsjMz84q/bXoGT5upjjTgosuQWan
 DoMzI9jGhqd736AeMXMc3X3RBMIPNbZbwhOc0VjeNtE9htVbQBDimd3d78kGc1SYrJGR
 xHrA==
X-Gm-Message-State: ANhLgQ2CPt2m6oXLFsp/8M2sRHvD9tZpUsxaLEJ5vXgs1zfyte7/kqUE
 OzkXaPRh7P37UdIc8QJ5APuLl4rnH5GQ7s8lhykm2QEn1qsPMVqfvg++kieY8NLr3eSlFUL1/2Q
 QjqTVecZnobZfNQc=
X-Received: by 2002:adf:806c:: with SMTP id 99mr3492707wrk.78.1583919792596;
 Wed, 11 Mar 2020 02:43:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtCKnkyIBh24kKLZ0i24CkeDRTZb1Now7aNhXH4bp+slJoPdxIuMRC4tIqxis9P+gcGYW1gPw==
X-Received: by 2002:adf:806c:: with SMTP id 99mr3492605wrk.78.1583919791564;
 Wed, 11 Mar 2020 02:43:11 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.186])
 by smtp.gmail.com with ESMTPSA id s7sm31598242wrm.13.2020.03.11.02.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 02:43:10 -0700 (PDT)
Subject: Re: [PATCH qemu v8 3/3] spapr: Implement Open Firmware client
 interface
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200310050733.29805-1-aik@ozlabs.ru>
 <20200310050733.29805-4-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7a4f200-7f02-1e71-2a52-3e03b00f8af5@redhat.com>
Date: Wed, 11 Mar 2020 10:43:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310050733.29805-4-aik@ozlabs.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 06:07, Alexey Kardashevskiy wrote:
> The PAPR platform which describes an OS environment that's presented by
> a combination of a hypervisor and firmware. The features it specifies
> require collaboration between the firmware and the hypervisor.
>=20
> Since the beginning, the runtime component of the firmware (RTAS) has
> been implemented as a 20 byte shim which simply forwards it to
> a hypercall implemented in qemu. The boot time firmware component is
> SLOF - but a build that's specific to qemu, and has always needed to be
> updated in sync with it. Even though we've managed to limit the amount
> of runtime communication we need between qemu and SLOF, there's some,
> and it has become increasingly awkward to handle as we've implemented
> new features.
>=20
> This implements a boot time OF client interface (CI) which is
> enabled by a new "x-vof" pseries machine option (stands for "Virtual Open
> Firmware). When enabled, QEMU implements the custom H_OF_CLIENT hcall
> which implements Open Firmware Client Interface (OF CI). This allows
> using a smaller stateless firmware which does not have to manage
> the device tree.
>=20
> The new "vof.bin" firmware image is included with source code under
> pc-bios/. It also includes RTAS blob.
>=20
> This implements a handful of CI methods just to get -kernel/-initrd
> working. In particular, this implements the device tree fetching and
> simple memory allocator - "claim" (an OF CI memory allocator) and updates
> "/memory@0/available" to report the client about available memory.
>=20
> This implements changing some device tree properties which we know how
> to deal with, the rest is ignored. To allow changes, this skips
> fdt_pack() when x-vof=3Don as not packing the blob leaves some room for
> appending.
>=20
> In absence of SLOF, this assigns "phandles" to device tree nodes to make
> device tree traversing work.
>=20
> When x-vof=3Don, this adds "/chosen" every time QEMU (re)builds a tree.
>=20
> This adds basic instances support which are managed by a hashmap
> ihandle -> [phandle].
>=20
> Before the guest started, the used memory is:
> 0..4000 - the initial firmware
> 10000..180000 - stack
>=20
> This OF CI does not implement "interpret".
>=20
> With this basic support, this can only boot into kernel directly.
> However this is just enough for the petitboot kernel and initradmdisk to
> boot from any possible source. Note this requires reasonably recent guest
> kernel with:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Ddf5be5be8735
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thank you very much Alexey!  At least, since it can run petitboot, it's
not completely useless.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> ---
>=20
> The example command line is:
>=20
> pbuild/qemu-killslof-localhost-ppc64/ppc64-softmmu/qemu-system-ppc64 \
> -nodefaults \
> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
> -nographic \
> -vga none \
> -machine pseries,x-vof=3Don,cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=
=3Dbroken,cap-ccf-assist=3Doff \
> -m 16G \
> -kernel pbuild/kernel-le-guest/vmlinux \
> -initrd pb/rootfs.cpio.xz \
> -device virtio-scsi-pci,id=3Dvscsi0 \
> -drive id=3DDRIVE0,if=3Dnone,file=3Dimg/f30le.qcow2,format=3Dqcow2 \
> -device scsi-hd,id=3Dscsi-hd0,drive=3DDRIVE0 \
> -enable-kvm \
> -bios p/qemu-killslof/pc-bios/vof.bin \
> -snapshot \
> -smp 8,threads=3D8 \
> -L /home/aik/t/qemu-ppc64-bios/ \
> -trace events=3Dqemu_trace_events \
> -d guest_errors \
> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh55056 \
> -mon chardev=3DSOCKET0,mode=3Dcontrol
>=20
>=20
> ---
> Changes:
> v8:
> * no read/write/seek
> * no @dev in instances
> * the machine flag is "x-vof" for now
>=20
> v7:
> * now we have a small firmware which loads at 0 as SLOF and starts from
> 0x100 as SLOF
> * no MBR/ELF/GRUB business in QEMU anymore
> * blockdev is a separate patch
> * networking is a separate patch
>=20
> v6:
> * borrowed a big chunk of commit log introduction from David
> * fixed initial stack pointer (points to the highest address of stack)
> * traces for "interpret" and others
> * disabled  translate_kernel_address() hack so grub can load (work in
> progress)
> * added "milliseconds" for grub
> * fixed "claim" allocator again
> * moved FDT_MAX_SIZE to spapr.h as spapr_of_client.c wants it too for CAS
> * moved the most code possible from spapr.c to spapr_of_client.c, such as
> RTAS, prom entry and FDT build/finalize
> * separated blobs
> * GRUB now proceeds to its console prompt (there are still other issues)
> * parse MBR/GPT to find PReP and load GRUB
>=20
> v5:
> * made instances keep device and chardev pointers
> * removed VIO dependencies
> * print error if RTAS memory is not claimed as it should have been
> * pack FDT as "quiesce"
>=20
> v4:
> * fixed open
> * validate ihandles in "call-method"
>=20
> v3:
> * fixed phandles allocation
> * s/__be32/uint32_t/ as we do not normally have __be32 type in qemu
> * fixed size of /chosen/stdout
> * bunch of renames
> * do not create rtas properties at all, let the client deal with it;
> instead setprop allows changing these in the FDT
> * no more packing FDT when bios=3Doff - nobody needs it and getprop does =
not
> work otherwise
> * allow updating initramdisk device tree properties (for zImage)
> * added instances
> * fixed stdout on OF's "write"
> * removed special handling for stdout in OF client, spapr-vty handles it
> instead
>=20
> v2:
> * fixed claim()
> * added "setprop"
> * cleaner client interface and RTAS blobs management
> * boots to petitboot and further to the target system
> * more trace points
> ---
>  hw/ppc/Makefile.objs     |    1 +
>  pc-bios/vof/Makefile     |   18 +
>  include/hw/ppc/spapr.h   |   19 +-
>  pc-bios/vof/vof.h        |   44 ++
>  hw/ppc/spapr.c           |   68 ++-
>  hw/ppc/spapr_hcall.c     |    6 +-
>  hw/ppc/spapr_of_client.c | 1094 ++++++++++++++++++++++++++++++++++++++
>  pc-bios/vof/bootmem.c    |   13 +
>  pc-bios/vof/ci.c         |  108 ++++
>  pc-bios/vof/libc.c       |   91 ++++
>  pc-bios/vof/main.c       |   22 +
>  hw/ppc/trace-events      |   21 +
>  pc-bios/README           |    2 +
>  pc-bios/vof.bin          |  Bin 0 -> 3680 bytes
>  pc-bios/vof/entry.S      |   51 ++
>  pc-bios/vof/l.lds        |   48 ++
>  16 files changed, 1592 insertions(+), 14 deletions(-)
>  create mode 100644 pc-bios/vof/Makefile
>  create mode 100644 pc-bios/vof/vof.h
>  create mode 100644 hw/ppc/spapr_of_client.c
>  create mode 100644 pc-bios/vof/bootmem.c
>  create mode 100644 pc-bios/vof/ci.c
>  create mode 100644 pc-bios/vof/libc.c
>  create mode 100644 pc-bios/vof/main.c
>  create mode 100755 pc-bios/vof.bin
>  create mode 100644 pc-bios/vof/entry.S
>  create mode 100644 pc-bios/vof/l.lds
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index c3d3cc56eb51..70aa7918ba8a 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o sp=
apr_rtas.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o spapr_nvdimm.o
> +obj-$(CONFIG_PSERIES) +=3D spapr_of_client.o
>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  obj-$(call land,$(CONFIG_PSERIES),$(CONFIG_LINUX)) +=3D spapr_pci_vfio.o=
 spapr_pci_nvlink2.o
>  # IBM PowerNV
> diff --git a/pc-bios/vof/Makefile b/pc-bios/vof/Makefile
> new file mode 100644
> index 000000000000..49f7e240eeff
> --- /dev/null
> +++ b/pc-bios/vof/Makefile
> @@ -0,0 +1,18 @@
> +all: build-all
> +
> +build-all: vof.bin
> +
> +%.o: %.S
> +=09cc -m32 -mbig-endian -c -o $@ $<
> +
> +%.o: %.c
> +=09cc -m32 -mbig-endian -c -fno-stack-protector -Wno-builtin-declaration=
-mismatch -o $@ $<
> +
> +vof.elf: entry.o main.o libc.o ci.o bootmem.o
> +=09ld -nostdlib -e_start -Tl.lds -EB -o $@ $^
> +
> +%.bin: %.elf
> +=09objcopy -O binary -j .text -j .data -j .toc -j .got2 $^ $@
> +
> +clean:
> +=09rm -f *.o *.bin *.elf *~
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 692e2d7c003b..a22deb25eeba 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -109,6 +109,11 @@ struct SpaprCapabilities {
>      uint8_t caps[SPAPR_CAP_NUM];
>  };
> =20
> +typedef struct {
> +    uint64_t start;
> +    uint64_t size;
> +} SpaprOfClaimed;
> +
>  /**
>   * SpaprMachineClass:
>   */
> @@ -165,6 +170,13 @@ struct SpaprMachineState {
>      long kernel_size;
>      bool kernel_le;
>      uint64_t kernel_addr;
> +    bool vof; /* Virtual Open Firmware */
> +    uint32_t rtas_base;
> +    GArray *claimed; /* array of SpaprOfClaimed */
> +    uint64_t claimed_base;
> +    GHashTable *of_instances; /* ihandle -> SpaprOfInstance */
> +    uint32_t of_instance_last;
> +    char *bootargs;
>      uint32_t initrd_base;
>      long initrd_size;
>      uint64_t rtc_offset; /* Now used only during incoming migration */
> @@ -532,7 +544,8 @@ struct SpaprMachineState {
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> +#define KVMPPC_H_OF_CLIENT      (KVMPPC_HCALL_BASE + 0x5)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_OF_CLIENT
> =20
>  /*
>   * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
> @@ -801,6 +814,10 @@ struct SpaprEventLogEntry {
>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space=
);
>  void spapr_events_init(SpaprMachineState *sm);
>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> +void spapr_setup_of_client(SpaprMachineState *spapr, target_ulong *stack=
_ptr);
> +void spapr_of_client_dt(SpaprMachineState *spapr, void *fdt);
> +void spapr_of_client_dt_finalize(SpaprMachineState *spapr);
> +void spapr_of_client_machine_init(SpaprMachineState *spapr);
>  void close_htab_fd(SpaprMachineState *spapr);
>  void spapr_setup_hpt(SpaprMachineState *spapr);
>  void spapr_free_hpt(SpaprMachineState *spapr);
> diff --git a/pc-bios/vof/vof.h b/pc-bios/vof/vof.h
> new file mode 100644
> index 000000000000..cd5989952a98
> --- /dev/null
> +++ b/pc-bios/vof/vof.h
> @@ -0,0 +1,44 @@
> +#include <stdarg.h>
> +
> +typedef unsigned char uint8_t;
> +typedef unsigned short uint16_t;
> +typedef unsigned long uint32_t;
> +typedef unsigned long long uint64_t;
> +#define NULL (0)
> +#define PROM_ERROR (-1u)
> +typedef unsigned char bool;
> +typedef unsigned long ihandle;
> +typedef unsigned long phandle;
> +#define false ((bool)0)
> +#define true ((bool)1)
> +typedef int size_t;
> +typedef void client(void);
> +
> +/* globals */
> +extern void _prom_entry(void); /* OF CI entry point (i.e. this firmware)=
 */
> +
> +void do_boot(unsigned long addr, unsigned long r3, unsigned long r4);
> +
> +/* libc */
> +int strlen(const char *s);
> +int strcmp(const char *s1, const char *s2);
> +void *memcpy(void *dest, const void *src, size_t n);
> +int memcmp(const void *ptr1, const void *ptr2, size_t n);
> +void *memmove(void *dest, const void *src, size_t n);
> +void *memset(void *dest, int c, size_t size);
> +
> +/* Prom */
> +typedef unsigned long prom_arg_t;
> +int call_prom(const char *service, int nargs, int nret, ...);
> +
> +/* CI wrappers */
> +void ci_panic(const char *str);
> +phandle ci_finddevice(const char *path);
> +uint32_t ci_getprop(phandle ph, const char *propname, void *prop, int le=
n);
> +ihandle ci_open(const char *path);
> +void ci_close(ihandle ih);
> +void *ci_claim(void *virt, uint32_t size, uint32_t align);
> +uint32_t ci_release(void *virt, uint32_t size);
> +
> +/* booting from -kernel */
> +void boot_from_memory(uint64_t initrd, uint64_t initrdsize);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8c245a812bd3..161f8842eb8c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -99,6 +99,7 @@
>  #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that =
*/
>  #define FW_MAX_SIZE             0x400000
>  #define FW_FILE_NAME            "slof.bin"
> +#define FW_FILE_NAME_VOF        "vof.bin"
>  #define FW_OVERHEAD             0x2800000
>  #define KERNEL_LOAD_ADDR        FW_MAX_SIZE
> =20
> @@ -1279,6 +1280,9 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
>      if (mc->nvdimm_supported) {
>          spapr_dt_persistent_memory(fdt);
>      }
> +    if (spapr->vof) {
> +        spapr_of_client_dt(spapr, fdt);
> +    }
> =20
>      return fdt;
>  }
> @@ -1681,24 +1685,41 @@ static void spapr_machine_reset(MachineState *mac=
hine)
>       */
>      fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
> =20
> +    /* Set up the entry state */
> +    first_ppc_cpu->env.gpr[5] =3D 0;
> +    if (spapr->vof) {
> +        target_ulong stack_ptr =3D 0;
> +
> +        spapr_setup_of_client(spapr, &stack_ptr);
> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
> +                                  stack_ptr, spapr->initrd_base,
> +                                  spapr->initrd_size);
> +    } else {
> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
> +                                  0, fdt_addr, 0);
> +    }
> +
>      fdt =3D spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
> =20
> -    rc =3D fdt_pack(fdt);
> -
> -    /* Should only fail if we've built a corrupted tree */
> -    assert(rc =3D=3D 0);
> -
> -    /* Load the fdt */
> -    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> -    cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
>      g_free(spapr->fdt_blob);
>      spapr->fdt_size =3D fdt_totalsize(fdt);
>      spapr->fdt_initial_size =3D spapr->fdt_size;
>      spapr->fdt_blob =3D fdt;
> =20
> -    /* Set up the entry state */
> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt_a=
ddr, 0);
> -    first_ppc_cpu->env.gpr[5] =3D 0;
> +    if (spapr->vof) {
> +        spapr_of_client_dt_finalize(spapr);
> +    } else {
> +        /* Load the fdt */
> +        rc =3D fdt_pack(spapr->fdt_blob);
> +        /* Should only fail if we've built a corrupted tree */
> +        assert(rc =3D=3D 0);
> +
> +        spapr->fdt_size =3D fdt_totalsize(spapr->fdt_blob);
> +        spapr->fdt_initial_size =3D spapr->fdt_size;
> +        cpu_physical_memory_write(fdt_addr, spapr->fdt_blob, spapr->fdt_=
size);
> +    }
> +
> +    qemu_fdt_dumpdtb(spapr->fdt_blob, spapr->fdt_size);
> =20
>      spapr->cas_reboot =3D false;
> =20
> @@ -3010,7 +3031,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      }
> =20
>      if (bios_name =3D=3D NULL) {
> -        bios_name =3D FW_FILE_NAME;
> +        bios_name =3D spapr->vof ? FW_FILE_NAME_VOF : FW_FILE_NAME;
>      }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (!filename) {
> @@ -3024,6 +3045,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      }
>      g_free(filename);
> =20
> +    if (spapr->vof) {
> +        spapr_of_client_machine_init(spapr);
> +    }
> +
>      /* FIXME: Should register things through the MachineState's qdev
>       * interface, this is a legacy from the sPAPREnvironment structure
>       * which predated MachineState but had a similar function */
> @@ -3253,6 +3278,20 @@ static void spapr_set_kernel_addr(Object *obj, Vis=
itor *v, const char *name,
>      visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>  }
> =20
> +static bool spapr_get_vof(Object *obj, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->vof;
> +}
> +
> +static void spapr_set_vof(Object *obj, bool value, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->vof =3D value;
> +}
> +
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3366,6 +3405,11 @@ static void spapr_instance_init(Object *obj)
>                                      " for -kernel is the default",
>                                      NULL);
>      spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
> +    object_property_add_bool(obj, "x-vof", spapr_get_vof, spapr_set_vof,=
 NULL);
> +    object_property_set_description(obj, "x-vof",
> +                                    "Enable Virtual Oepn Firmware", NULL=
);
> +    spapr->vof =3D false;
> +
>      /* The machine class defines the default interrupt controller mode *=
/
>      spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ae3b6c3f4cbd..69c867fb007a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1843,12 +1843,16 @@ target_ulong do_client_architecture_support(Power=
PCCPU *cpu,
>              spapr_setup_hpt(spapr);
>          }
> =20
> -        fdt =3D spapr_build_fdt(spapr, false, fdt_bufsize);
> +        fdt =3D spapr_build_fdt(spapr, spapr->vof, fdt_bufsize);
> =20
>          g_free(spapr->fdt_blob);
>          spapr->fdt_size =3D fdt_totalsize(fdt);
>          spapr->fdt_initial_size =3D spapr->fdt_size;
>          spapr->fdt_blob =3D fdt;
> +
> +        if (spapr->vof) {
> +            spapr_of_client_dt_finalize(spapr);
> +        }
>      }
> =20
>      if (spapr->cas_reboot) {
> diff --git a/hw/ppc/spapr_of_client.c b/hw/ppc/spapr_of_client.c
> new file mode 100644
> index 000000000000..b2958f1d5c79
> --- /dev/null
> +++ b/hw/ppc/spapr_of_client.c
> @@ -0,0 +1,1094 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include <sys/ioctl.h>
> +#include <termios.h>
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_vio.h"
> +#include "hw/ppc/fdt.h"
> +#include "hw/block/block.h"
> +#include "sysemu/block-backend.h"
> +#include "sysemu/sysemu.h"
> +#include "chardev/char-fe.h"
> +#include "qom/qom-qobject.h"
> +#include "elf.h"
> +#include "hw/ppc/ppc.h"
> +#include "hw/loader.h"
> +#include "trace.h"
> +
> +/*
> + * OF 1275 "nextprop" description suggests is it 32 bytes max but
> + * LoPAPR defines "ibm,query-interrupt-source-number" which is 33 chars =
long.
> + */
> +#define OF_PROPNAME_LEN_MAX 64
> +
> +/* Copied from SLOF, and 4K is definitely not enough for GRUB */
> +#define OF_STACK_SIZE       0x8000
> +
> +/* 0..10000 is reserved for the VOF fw */
> +#define OF_STACK_ADDR       0x10000
> +
> +/* RTAS + room for FWNMI log */
> +#define OF_RTAS_SIZE        2048
> +
> +#define ALIGN(x, a) (((x) + (a) - 1) & ~((a) - 1))
> +
> +typedef uint8_t SpaprOfNetBuffer[2048];
> +typedef struct {
> +    int head, tail, used;
> +    SpaprOfNetBuffer b[32];
> +} SpaprOfNetBuffers;
> +
> +typedef struct {
> +    char *params;
> +    char *path; /* the path used to open the instance */
> +    uint32_t phandle;
> +} SpaprOfInstance;
> +
> +/* Defined as Big Endian */
> +struct prom_args {
> +    uint32_t service;
> +    uint32_t nargs;
> +    uint32_t nret;
> +    uint32_t args[10];
> +};
> +
> +static void readstr(hwaddr pa, char *buf, int size)
> +{
> +    cpu_physical_memory_read(pa, buf, size);
> +    if (buf[size - 1] !=3D '\0') {
> +        buf[size - 1] =3D '\0';
> +        if (strlen(buf) =3D=3D size - 1) {
> +            trace_spapr_of_client_error_str_truncated(buf, size);
> +        }
> +    }
> +}
> +
> +static bool cmpservice(const char *s, size_t len,
> +                       unsigned nargs, unsigned nret,
> +                       const char *s1, size_t len1,
> +                       unsigned nargscheck, unsigned nretcheck)
> +{
> +    if (strcmp(s, s1)) {
> +        return false;
> +    }
> +    if ((nargscheck && (nargs !=3D nargscheck)) ||
> +        (nretcheck && (nret !=3D nretcheck))) {
> +        trace_spapr_of_client_error_param(s, nargscheck, nretcheck, narg=
s,
> +                                          nret);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void split_path(const char *fullpath, char **node, char **unit,
> +                       char **part)
> +{
> +    const char *c, *p =3D NULL, *u =3D NULL;
> +
> +    *node =3D *unit =3D *part =3D NULL;
> +
> +    if (fullpath[0] =3D=3D '\0') {
> +        *node =3D g_strdup(fullpath);
> +        return;
> +    }
> +
> +    for (c =3D fullpath + strlen(fullpath) - 1; c > fullpath; --c) {
> +        if (*c =3D=3D '/') {
> +            break;
> +        }
> +        if (*c =3D=3D ':') {
> +            p =3D c + 1;
> +            continue;
> +        }
> +        if (*c =3D=3D '@') {
> +            u =3D c + 1;
> +            continue;
> +        }
> +    }
> +
> +    if (p && u && p < u) {
> +        p =3D NULL;
> +    }
> +
> +    if (u && p) {
> +        *node =3D g_strndup(fullpath, u - fullpath - 1);
> +        *unit =3D g_strndup(u, p - u - 1);
> +        *part =3D g_strdup(p);
> +    } else if (!u && p) {
> +        *node =3D g_strndup(fullpath, p - fullpath - 1);
> +        *part =3D g_strdup(p);
> +    } else if (!p && u) {
> +        *node =3D g_strndup(fullpath, u - fullpath - 1);
> +        *unit =3D g_strdup(u);
> +    } else {
> +        *node =3D g_strdup(fullpath);
> +    }
> +}
> +
> +static void prop_format(char *tval, int tlen, const void *prop, int len)
> +{
> +    int i;
> +    const char *c;
> +    char *t;
> +    const char bin[] =3D "...";
> +
> +    for (i =3D 0, c =3D prop; i < len; ++i, ++c) {
> +        if (*c =3D=3D '\0' && i =3D=3D len - 1) {
> +            strncpy(tval, prop, tlen - 1);
> +            return;
> +        }
> +        if (*c < 0x20 || *c >=3D 0x80) {
> +            /* Not reliably printable string so assume it is binary */
> +            break;
> +        }
> +    }
> +
> +    /* Accidentally the binary will look like big endian (which it is) *=
/
> +    for (i =3D 0, c =3D prop, t =3D tval; i < len; ++i, ++c) {
> +        if (t >=3D tval + tlen - sizeof(bin) - 1 - 2 - 1) {
> +            strcpy(t, bin);
> +            return;
> +        }
> +        if (i && i % 4 =3D=3D 0 && i !=3D len - 1) {
> +            strcat(t, " ");
> +            ++t;
> +        }
> +        t +=3D sprintf(t, "%02X", *c & 0xFF);
> +    }
> +}
> +
> +static int of_client_fdt_path_offset(const void *fdt, const char *node,
> +                                     const char *unit)
> +{
> +    int offset;
> +
> +    offset =3D fdt_path_offset(fdt, node);
> +
> +    if (offset < 0 && unit) {
> +        char *tmp =3D g_strdup_printf("%s@%s", node, unit);
> +
> +        offset =3D fdt_path_offset(fdt, tmp);
> +        g_free(tmp);
> +    }
> +
> +    return offset;
> +}
> +
> +static uint32_t of_client_finddevice(const void *fdt, uint32_t nodeaddr)
> +{
> +    char *node, *unit, *part;
> +    char fullnode[1024];
> +    uint32_t ret =3D -1;
> +    int offset;
> +
> +    readstr(nodeaddr, fullnode, sizeof(fullnode));
> +
> +    split_path(fullnode, &node, &unit, &part);
> +    offset =3D of_client_fdt_path_offset(fdt, node, unit);
> +    if (offset >=3D 0) {
> +        ret =3D fdt_get_phandle(fdt, offset);
> +    }
> +    trace_spapr_of_client_finddevice(fullnode, ret);
> +    g_free(node);
> +    g_free(unit);
> +    g_free(part);
> +    return (uint32_t) ret;
> +}
> +
> +static uint32_t of_client_canon(const void *fdt, uint32_t devaddr,
> +                                uint32_t bufaddr, uint32_t buflen)
> +{
> +    char dev[1024];
> +    uint32_t ret;
> +
> +    /*
> +     * OF1275: "This service converts the possibly ambiguous device-spec=
ifier to
> +     * a fully qualified pathname, storing, atmost, buflen bytes as
> +     * a null-terminated string in the memory buffer starting at the add=
ress
> +     * buf."
> +     *
> +     * For now only only GRUB wanted this for "/vdevice/l-lan@71000001" =
which
> +     * is pretty full qualified, just return this.
> +     */
> +    readstr(devaddr, dev, sizeof(dev));
> +    ret =3D MIN(buflen, strlen(dev));
> +    cpu_physical_memory_write(bufaddr, dev, ret);
> +    trace_spapr_of_client_canon(dev);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_getprop(const void *fdt, uint32_t nodeph,
> +                                  uint32_t pname, uint32_t valaddr,
> +                                  uint32_t vallen)
> +{
> +    char propname[OF_PROPNAME_LEN_MAX + 1];
> +    uint32_t ret =3D 0;
> +    int proplen =3D 0;
> +    const void *prop;
> +    char trval[64] =3D "";
> +    int nodeoff =3D fdt_node_offset_by_phandle(fdt, nodeph);
> +
> +    readstr(pname, propname, sizeof(propname));
> +    if (strcmp(propname, "name") =3D=3D 0) {
> +        prop =3D fdt_get_name(fdt, nodeoff, &proplen);
> +        proplen +=3D 1;
> +    } else {
> +        prop =3D fdt_getprop(fdt, nodeoff, propname, &proplen);
> +    }
> +
> +    if (prop) {
> +        int cb =3D MIN(proplen, vallen);
> +
> +        cpu_physical_memory_write(valaddr, prop, cb);
> +        /*
> +         * OF1275 says:
> +         * "Size is either the actual size of the property, or =E2=80=93=
1 if name
> +         * does not exist", hence returning proplen instead of cb.
> +         */
> +        ret =3D proplen;
> +        prop_format(trval, sizeof(trval), prop, ret);
> +    } else {
> +        ret =3D -1;
> +    }
> +    trace_spapr_of_client_getprop(nodeph, propname, ret, trval);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_getproplen(const void *fdt, uint32_t nodeph,
> +                                     uint32_t pname)
> +{
> +    char propname[OF_PROPNAME_LEN_MAX + 1];
> +    uint32_t ret =3D 0;
> +    int proplen =3D 0;
> +    const void *prop;
> +    int nodeoff =3D fdt_node_offset_by_phandle(fdt, nodeph);
> +
> +    readstr(pname, propname, sizeof(propname));
> +    if (strcmp(propname, "name") =3D=3D 0) {
> +        prop =3D fdt_get_name(fdt, nodeoff, &proplen);
> +        proplen +=3D 1;
> +    } else {
> +        prop =3D fdt_getprop(fdt, nodeoff, propname, &proplen);
> +    }
> +
> +    if (prop) {
> +        ret =3D proplen;
> +    } else {
> +        ret =3D -1;
> +    }
> +    trace_spapr_of_client_getproplen(nodeph, propname, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_setprop(SpaprMachineState *spapr,
> +                                  uint32_t nodeph, uint32_t pname,
> +                                  uint32_t valaddr, uint32_t vallen)
> +{
> +    char propname[OF_PROPNAME_LEN_MAX + 1];
> +    uint32_t ret =3D -1;
> +    int offset;
> +    char trval[64] =3D "";
> +
> +    readstr(pname, propname, sizeof(propname));
> +    /*
> +     * We only allow changing properties which we know how to update on
> +     * the QEMU side.
> +     */
> +    if (vallen =3D=3D sizeof(uint32_t)) {
> +        uint32_t val32 =3D ldl_be_phys(first_cpu->as, valaddr);
> +
> +        if ((strcmp(propname, "linux,rtas-base") =3D=3D 0) ||
> +            (strcmp(propname, "linux,rtas-entry") =3D=3D 0)) {
> +            spapr->rtas_base =3D val32;
> +        } else if (strcmp(propname, "linux,initrd-start") =3D=3D 0) {
> +            spapr->initrd_base =3D val32;
> +        } else if (strcmp(propname, "linux,initrd-end") =3D=3D 0) {
> +            spapr->initrd_size =3D val32 - spapr->initrd_base;
> +        } else {
> +            goto trace_exit;
> +        }
> +    } else if (vallen =3D=3D sizeof(uint64_t)) {
> +        uint64_t val64 =3D ldq_be_phys(first_cpu->as, valaddr);
> +
> +        if (strcmp(propname, "linux,initrd-start") =3D=3D 0) {
> +            spapr->initrd_base =3D val64;
> +        } else if (strcmp(propname, "linux,initrd-end") =3D=3D 0) {
> +            spapr->initrd_size =3D val64 - spapr->initrd_base;
> +        } else {
> +            goto trace_exit;
> +        }
> +    } else if (strcmp(propname, "bootargs") =3D=3D 0) {
> +        char val[1024];
> +
> +        readstr(valaddr, val, sizeof(val));
> +        g_free(spapr->bootargs);
> +        spapr->bootargs =3D g_strdup(val);
> +    } else {
> +        goto trace_exit;
> +    }
> +
> +    offset =3D fdt_node_offset_by_phandle(spapr->fdt_blob, nodeph);
> +    if (offset >=3D 0) {
> +        uint8_t data[vallen];
> +
> +        cpu_physical_memory_read(valaddr, data, vallen);
> +        if (!fdt_setprop(spapr->fdt_blob, offset, propname, data, vallen=
)) {
> +            ret =3D vallen;
> +            prop_format(trval, sizeof(trval), data, ret);
> +        }
> +    }
> +
> +trace_exit:
> +    trace_spapr_of_client_setprop(nodeph, propname, trval, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_nextprop(const void *fdt, uint32_t phandle,
> +                                   uint32_t prevaddr, uint32_t nameaddr)
> +{
> +    int offset =3D fdt_node_offset_by_phandle(fdt, phandle);
> +    char prev[OF_PROPNAME_LEN_MAX + 1];
> +    const char *tmp;
> +
> +    readstr(prevaddr, prev, sizeof(prev));
> +    for (offset =3D fdt_first_property_offset(fdt, offset);
> +         offset >=3D 0;
> +         offset =3D fdt_next_property_offset(fdt, offset)) {
> +
> +        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> +            return 0;
> +        }
> +        if (prev[0] =3D=3D '\0' || strcmp(prev, tmp) =3D=3D 0) {
> +            if (prev[0] !=3D '\0') {
> +                offset =3D fdt_next_property_offset(fdt, offset);
> +                if (offset < 0) {
> +                    return 0;
> +                }
> +            }
> +            if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> +                return 0;
> +            }
> +
> +            cpu_physical_memory_write(nameaddr, tmp, strlen(tmp) + 1);
> +            return 1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t of_client_peer(const void *fdt, uint32_t phandle)
> +{
> +    int ret;
> +
> +    if (phandle =3D=3D 0) {
> +        ret =3D fdt_path_offset(fdt, "/");
> +    } else {
> +        ret =3D fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt, ph=
andle));
> +    }
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_child(const void *fdt, uint32_t phandle)
> +{
> +    int ret =3D fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt, p=
handle));
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_parent(const void *fdt, uint32_t phandle)
> +{
> +    int ret =3D fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt, p=
handle));
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const cha=
r *path)
> +{
> +    int offset;
> +    uint32_t ret =3D 0;
> +    SpaprOfInstance *inst =3D NULL;
> +    char *node, *unit, *part;
> +
> +    if (spapr->of_instance_last =3D=3D 0xFFFFFFFF) {
> +        /* We do not recycle ihandles yet */
> +        goto trace_exit;
> +    }
> +
> +    split_path(path, &node, &unit, &part);
> +
> +    offset =3D of_client_fdt_path_offset(spapr->fdt_blob, node, unit);
> +    if (offset < 0) {
> +        trace_spapr_of_client_error_unknown_path(path);
> +        goto trace_exit;
> +    }
> +
> +    inst =3D g_new0(SpaprOfInstance, 1);
> +    inst->phandle =3D fdt_get_phandle(spapr->fdt_blob, offset);
> +    g_assert(inst->phandle);
> +    ++spapr->of_instance_last;
> +
> +    inst->path =3D g_strdup(path);
> +    inst->params =3D part;
> +    g_hash_table_insert(spapr->of_instances,
> +                        GINT_TO_POINTER(spapr->of_instance_last),
> +                        inst);
> +    ret =3D spapr->of_instance_last;
> +
> +trace_exit:
> +    trace_spapr_of_client_open(path, inst ? inst->phandle : 0, ret);
> +    g_free(node);
> +    g_free(unit);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_open(SpaprMachineState *spapr, uint32_t pathad=
dr)
> +{
> +    char path[256];
> +
> +    readstr(pathaddr, path, sizeof(path));
> +
> +    return spapr_of_client_open(spapr, path);
> +}
> +
> +static void of_client_close(SpaprMachineState *spapr, uint32_t ihandle)
> +{
> +    if (!g_hash_table_remove(spapr->of_instances, GINT_TO_POINTER(ihandl=
e))) {
> +        trace_spapr_of_client_error_unknown_ihandle_close(ihandle);
> +    }
> +}
> +
> +static uint32_t of_client_instance_to_package(SpaprMachineState *spapr,
> +                                              uint32_t ihandle)
> +{
> +    gpointer instp =3D g_hash_table_lookup(spapr->of_instances,
> +                                         GINT_TO_POINTER(ihandle));
> +    uint32_t ret =3D -1;
> +
> +    if (instp) {
> +        ret =3D ((SpaprOfInstance *)instp)->phandle;
> +    }
> +    trace_spapr_of_client_instance_to_package(ihandle, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_package_to_path(const void *fdt, uint32_t phan=
dle,
> +                                          uint32_t buf, uint32_t len)
> +{
> +    uint32_t ret =3D -1;
> +    char tmp[256] =3D "";
> +
> +    if (0 =3D=3D fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phand=
le), tmp,
> +                          sizeof(tmp))) {
> +        tmp[sizeof(tmp) - 1] =3D 0;
> +        ret =3D MIN(len, strlen(tmp) + 1);
> +        cpu_physical_memory_write(buf, tmp, ret);
> +    }
> +
> +    trace_spapr_of_client_package_to_path(phandle, tmp, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_instance_to_path(SpaprMachineState *spapr,
> +                                           uint32_t ihandle, uint32_t bu=
f,
> +                                           uint32_t len)
> +{
> +    uint32_t ret =3D -1;
> +    uint32_t phandle =3D of_client_instance_to_package(spapr, ihandle);
> +    char tmp[256] =3D "";
> +
> +    if (phandle !=3D -1) {
> +        if (0 =3D=3D fdt_get_path(spapr->fdt_blob,
> +                              fdt_node_offset_by_phandle(spapr->fdt_blob=
,
> +                                                         phandle),
> +                              tmp, sizeof(tmp))) {
> +            tmp[sizeof(tmp) - 1] =3D 0;
> +            ret =3D MIN(len, strlen(tmp) + 1);
> +            cpu_physical_memory_write(buf, tmp, ret);
> +        }
> +    }
> +    trace_spapr_of_client_instance_to_path(ihandle, phandle, tmp, ret);
> +
> +    return ret;
> +}
> +
> +static void of_client_clamed_dump(GArray *claimed)
> +{
> +#ifdef DEBUG
> +    int i;
> +    SpaprOfClaimed c;
> +
> +    for (i =3D 0; i < claimed->len; ++i) {
> +        c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +        error_printf("CLAIMED %lx..%lx size=3D%ld\n", c.start, c.start +=
 c.size,
> +                     c.size);
> +    }
> +#endif
> +}
> +
> +static bool of_client_claim_avail(GArray *claimed, uint64_t virt, uint64=
_t size)
> +{
> +    int i;
> +    SpaprOfClaimed c;
> +
> +    for (i =3D 0; i < claimed->len; ++i) {
> +        c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +        if ((c.start <=3D virt && virt < c.start + c.size) ||
> +            (virt <=3D c.start && c.start < virt + size)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void of_client_claim_add(GArray *claimed, uint64_t virt, uint64_t=
 size)
> +{
> +    SpaprOfClaimed newclaim;
> +
> +    newclaim.start =3D virt;
> +    newclaim.size =3D size;
> +    g_array_append_val(claimed, newclaim);
> +}
> +
> +/*
> + * "claim" claims memory at @virt if @align=3D=3D0; otherwise it allocat=
es
> + * memory at the requested alignment.
> + */
> +static void of_client_dt_memory_available(void *fdt, GArray *claimed,
> +                                          uint64_t base);
> +
> +static uint64_t of_client_claim(SpaprMachineState *spapr, uint64_t virt,
> +                                uint64_t size, uint64_t align)
> +{
> +    uint64_t ret;
> +
> +    if (size =3D=3D 0) {
> +        ret =3D -1;
> +    } else if (align =3D=3D 0) {
> +        if (!of_client_claim_avail(spapr->claimed, virt, size)) {
> +            ret =3D -1;
> +        } else {
> +            ret =3D virt;
> +        }
> +    } else {
> +        spapr->claimed_base =3D ALIGN(spapr->claimed_base, align);
> +        while (1) {
> +            if (spapr->claimed_base >=3D spapr->rma_size) {
> +                error_report("Out of RMA memory for the OF client");
> +                return -1;
> +            }
> +            if (of_client_claim_avail(spapr->claimed, spapr->claimed_bas=
e,
> +                                      size)) {
> +                break;
> +            }
> +            spapr->claimed_base +=3D size;
> +        }
> +        ret =3D spapr->claimed_base;
> +    }
> +
> +    if (ret !=3D -1) {
> +        spapr->claimed_base =3D MAX(spapr->claimed_base, ret + size);
> +        of_client_claim_add(spapr->claimed, ret, size);
> +        /* The client reads "/memory@0/available" to know where it can c=
laim */
> +        of_client_dt_memory_available(spapr->fdt_blob, spapr->claimed,
> +                                      spapr->claimed_base);
> +    }
> +    trace_spapr_of_client_claim(virt, size, align, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_release(SpaprMachineState *spapr, uint64_t vir=
t,
> +                                  uint64_t size)
> +{
> +    uint32_t ret =3D -1;
> +    int i;
> +    GArray *claimed =3D spapr->claimed;
> +    SpaprOfClaimed c;
> +
> +    for (i =3D 0; i < claimed->len; ++i) {
> +        c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +        if (c.start =3D=3D virt && c.size =3D=3D size) {
> +            g_array_remove_index(claimed, i);
> +            ret =3D 0;
> +            break;
> +        }
> +    }
> +
> +    trace_spapr_of_client_release(virt, size, ret);
> +
> +    return ret;
> +}
> +
> +static void of_client_instantiate_rtas(SpaprMachineState *spapr, uint32_=
t base)
> +{
> +    error_report("The firmware should have instantiated RTAS");
> +    exit(1);
> +}
> +
> +static uint32_t of_client_call_method(SpaprMachineState *spapr,
> +                                      uint32_t methodaddr, uint32_t ihan=
dle,
> +                                      uint32_t param1, uint32_t param2,
> +                                      uint32_t param3, uint32_t param4,
> +                                      uint32_t *ret2)
> +{
> +    uint32_t ret =3D -1;
> +    char method[256] =3D "";
> +    SpaprOfInstance *inst =3D NULL;
> +
> +    if (!ihandle) {
> +        goto trace_exit;
> +    }
> +
> +    inst =3D (SpaprOfInstance *) g_hash_table_lookup(spapr->of_instances=
,
> +                                                   GINT_TO_POINTER(ihand=
le));
> +    if (!inst) {
> +        goto trace_exit;
> +    }
> +
> +    readstr(methodaddr, method, sizeof(method));
> +
> +    if (strcmp(inst->path, "/") =3D=3D 0) {
> +        if (strcmp(method, "ibm,client-architecture-support") =3D=3D 0) =
{
> +            ret =3D do_client_architecture_support(POWERPC_CPU(first_cpu=
), spapr,
> +                                                 param1, FDT_MAX_SIZE);
> +            *ret2 =3D 0;
> +        }
> +    } else if (strcmp(inst->path, "/rtas") =3D=3D 0) {
> +        if (strcmp(method, "instantiate-rtas") =3D=3D 0) {
> +            of_client_instantiate_rtas(spapr, param1);
> +            ret =3D 0;
> +            *ret2 =3D param1; /* rtasbase */
> +        }
> +    } else {
> +        trace_spapr_of_client_error_unknown_method(method);
> +    }
> +
> +trace_exit:
> +    trace_spapr_of_client_method(ihandle, method, param1, ret, *ret2);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_call_interpret(SpaprMachineState *spapr,
> +                                         uint32_t cmdaddr, uint32_t para=
m1,
> +                                         uint32_t param2, uint32_t *ret2=
)
> +{
> +    uint32_t ret =3D -1;
> +    char cmd[256] =3D "";
> +
> +    readstr(cmdaddr, cmd, sizeof(cmd));
> +    trace_spapr_of_client_interpret(cmd, param1, param2, ret, *ret2);
> +
> +    return ret;
> +}
> +
> +static void of_client_quiesce(SpaprMachineState *spapr)
> +{
> +    /* We could as well just free the blob as there is no use for it fro=
m now */
> +    int rc =3D fdt_pack(spapr->fdt_blob);
> +    /* Should only fail if we've built a corrupted tree */
> +    assert(rc =3D=3D 0);
> +
> +    spapr->fdt_size =3D fdt_totalsize(spapr->fdt_blob);
> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> +    of_client_clamed_dump(spapr->claimed);
> +}
> +
> +static target_ulong spapr_h_of_client(PowerPCCPU *cpu, SpaprMachineState=
 *spapr,
> +                                      target_ulong opcode, target_ulong =
*args)
> +{
> +    target_ulong of_client_args =3D ppc64_phys_to_real(args[0]);
> +    struct prom_args pargs =3D { 0 };
> +    char service[64];
> +    unsigned nargs, nret;
> +    int i, servicelen;
> +
> +    cpu_physical_memory_read(of_client_args, &pargs, sizeof(pargs));
> +    nargs =3D be32_to_cpu(pargs.nargs);
> +    nret =3D be32_to_cpu(pargs.nret);
> +    readstr(be32_to_cpu(pargs.service), service, sizeof(service));
> +    servicelen =3D strlen(service);
> +
> +    if (nargs >=3D ARRAY_SIZE(pargs.args)) {
> +        /* Bounds checking: something is just very wrong */
> +        return H_PARAMETER;
> +    }
> +
> +#define cmpserv(s, a, r) \
> +    cmpservice(service, servicelen, nargs, nret, (s), sizeof(s), (a), (r=
))
> +
> +    if (cmpserv("finddevice", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_finddevice(spapr->fdt_blob,
> +                                 be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("canon", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_canon(spapr->fdt_blob,
> +                            be32_to_cpu(pargs.args[0]),
> +                            be32_to_cpu(pargs.args[1]),
> +                            be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("getprop", 4, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_getprop(spapr->fdt_blob,
> +                              be32_to_cpu(pargs.args[0]),
> +                              be32_to_cpu(pargs.args[1]),
> +                              be32_to_cpu(pargs.args[2]),
> +                              be32_to_cpu(pargs.args[3]));
> +    } else if (cmpserv("getproplen", 2, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_getproplen(spapr->fdt_blob,
> +                                 be32_to_cpu(pargs.args[0]),
> +                                 be32_to_cpu(pargs.args[1]));
> +    } else if (cmpserv("setprop", 4, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_setprop(spapr,
> +                              be32_to_cpu(pargs.args[0]),
> +                              be32_to_cpu(pargs.args[1]),
> +                              be32_to_cpu(pargs.args[2]),
> +                              be32_to_cpu(pargs.args[3]));
> +    } else if (cmpserv("nextprop", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_nextprop(spapr->fdt_blob,
> +                               be32_to_cpu(pargs.args[0]),
> +                               be32_to_cpu(pargs.args[1]),
> +                               be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("peer", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_peer(spapr->fdt_blob,
> +                           be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("child", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_child(spapr->fdt_blob,
> +                            be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("parent", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_parent(spapr->fdt_blob,
> +                             be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("open", 1, 1)) {
> +        pargs.args[nargs] =3D of_client_open(spapr, be32_to_cpu(pargs.ar=
gs[0]));
> +    } else if (cmpserv("close", 1, 0)) {
> +        of_client_close(spapr, be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("instance-to-package", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_instance_to_package(spapr,
> +                                          be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("package-to-path", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_package_to_path(spapr->fdt_blob,
> +                                      be32_to_cpu(pargs.args[0]),
> +                                      be32_to_cpu(pargs.args[1]),
> +                                      be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("instance-to-path", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_instance_to_path(spapr,
> +                                       be32_to_cpu(pargs.args[0]),
> +                                       be32_to_cpu(pargs.args[1]),
> +                                       be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("claim", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_claim(spapr,
> +                            be32_to_cpu(pargs.args[0]),
> +                            be32_to_cpu(pargs.args[1]),
> +                            be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("release", 2, 0)) {
> +        pargs.args[nargs] =3D
> +            of_client_release(spapr,
> +                              be32_to_cpu(pargs.args[0]),
> +                              be32_to_cpu(pargs.args[1]));
> +    } else if (cmpserv("call-method", 0, 0)) {
> +        pargs.args[nargs] =3D
> +            of_client_call_method(spapr,
> +                                  be32_to_cpu(pargs.args[0]),
> +                                  be32_to_cpu(pargs.args[1]),
> +                                  be32_to_cpu(pargs.args[2]),
> +                                  be32_to_cpu(pargs.args[3]),
> +                                  be32_to_cpu(pargs.args[4]),
> +                                  be32_to_cpu(pargs.args[5]),
> +                                  &pargs.args[nargs + 1]);
> +    } else if (cmpserv("interpret", 0, 0)) {
> +        pargs.args[nargs] =3D
> +            of_client_call_interpret(spapr,
> +                                     be32_to_cpu(pargs.args[0]),
> +                                     be32_to_cpu(pargs.args[1]),
> +                                     be32_to_cpu(pargs.args[2]),
> +                                     &pargs.args[nargs + 1]);
> +    } else if (cmpserv("milliseconds", 0, 1)) {
> +        pargs.args[nargs] =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    } else if (cmpserv("quiesce", 0, 0)) {
> +        of_client_quiesce(spapr);
> +    } else if (cmpserv("exit", 0, 0)) {
> +        error_report("Stopped as the VM requested \"exit\"");
> +        vm_stop(RUN_STATE_PAUSED); /* Or qemu_system_guest_panicked(NULL=
); ? */
> +    } else {
> +        trace_spapr_of_client_error_unknown_service(service, nargs, nret=
);
> +        pargs.args[nargs] =3D -1;
> +    }
> +
> +    for (i =3D 0; i < nret; ++i) {
> +        pargs.args[nargs + i] =3D be32_to_cpu(pargs.args[nargs + i]);
> +    }
> +
> +    /* Copy what is needed as GRUB allocates only required minimum on st=
ack */
> +    cpu_physical_memory_write(of_client_args, &pargs,
> +                              sizeof(uint32_t) * (3 + nargs + nret));
> +
> +    return H_SUCCESS;
> +}
> +
> +static void of_instance_free(gpointer data)
> +{
> +    SpaprOfInstance *inst =3D (SpaprOfInstance *) data;
> +
> +    g_free(inst->params);
> +    g_free(inst->path);
> +    g_free(inst);
> +}
> +
> +void spapr_setup_of_client(SpaprMachineState *spapr, target_ulong *stack=
_ptr)
> +{
> +    if (spapr->claimed) {
> +        g_array_unref(spapr->claimed);
> +    }
> +    if (spapr->of_instances) {
> +        g_hash_table_unref(spapr->of_instances);
> +    }
> +
> +    spapr->claimed =3D g_array_new(false, false, sizeof(SpaprOfClaimed))=
;
> +    spapr->of_instances =3D g_hash_table_new_full(g_direct_hash, g_direc=
t_equal,
> +                                                NULL, of_instance_free);
> +
> +    *stack_ptr =3D of_client_claim(spapr, OF_STACK_ADDR, OF_STACK_SIZE,
> +                                 OF_STACK_SIZE);
> +    if (*stack_ptr =3D=3D -1) {
> +        error_report("Memory allocation for stack failed");
> +        exit(1);
> +    }
> +    /*
> +     * Stack grows downwards and we also reserve here space for
> +     * the minimum stack frame.
> +     */
> +    *stack_ptr +=3D OF_STACK_SIZE - 0x20;
> +
> +    if (spapr->kernel_size &&
> +        of_client_claim(spapr, spapr->kernel_addr,
> +                        spapr->kernel_size, 0) =3D=3D -1) {
> +        error_report("Memory for kernel is in use");
> +        exit(1);
> +    }
> +
> +    if (spapr->initrd_size &&
> +        of_client_claim(spapr, spapr->initrd_base,
> +                        spapr->initrd_size, 0) =3D=3D -1) {
> +        error_report("Memory for initramdisk is in use");
> +        exit(1);
> +    }
> +
> +    /*
> +     * We skip writing FDT as nothing expects it; OF client interface is
> +     * going to be used for reading the device tree.
> +     */
> +}
> +
> +static gint of_claimed_compare_func(gconstpointer a, gconstpointer b)
> +{
> +    return ((SpaprOfClaimed *)a)->start - ((SpaprOfClaimed *)b)->start;
> +}
> +
> +static void of_client_dt_memory_available(void *fdt, GArray *claimed,
> +                                          uint64_t base)
> +{
> +    int i, n, offset, proplen =3D 0;
> +    uint64_t *mem0_reg;
> +    struct { uint64_t start, size; } *avail;
> +
> +    if (!fdt || !claimed) {
> +        return;
> +    }
> +
> +    offset =3D fdt_path_offset(fdt, "/memory@0");
> +    _FDT(offset);
> +
> +    mem0_reg =3D (uint64_t *) fdt_getprop(fdt, offset, "reg", &proplen);
> +    if (!mem0_reg || proplen !=3D 2 * sizeof(uint64_t)) {
> +        return;
> +    }
> +
> +    g_array_sort(claimed, of_claimed_compare_func);
> +    of_client_clamed_dump(claimed);
> +
> +    avail =3D g_malloc0(sizeof(uint64_t) * 2 * claimed->len);
> +    for (i =3D 0, n =3D 0; i < claimed->len; ++i) {
> +        SpaprOfClaimed c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +
> +        avail[n].start =3D c.start + c.size;
> +        if (i < claimed->len - 1) {
> +            SpaprOfClaimed cn =3D g_array_index(claimed, SpaprOfClaimed,=
 i + 1);
> +
> +            avail[n].size =3D cn.start - avail[n].start;
> +        } else {
> +            avail[n].size =3D be64_to_cpu(mem0_reg[1]) - avail[n].start;
> +        }
> +
> +        if (avail[n].size) {
> +#ifdef DEBUG
> +            error_printf("AVAIL %lx..%lx size=3D%ld\n", avail[n].start,
> +                         avail[n].start + avail[n].size, avail[n].size);
> +#endif
> +            avail[n].start =3D cpu_to_be64(avail[n].start);
> +            avail[n].size =3D cpu_to_be64(avail[n].size);
> +            ++n;
> +        }
> +    }
> +    _FDT((fdt_setprop(fdt, offset, "available", avail,
> +                      sizeof(uint64_t) * 2 * n)));
> +    g_free(avail);
> +}
> +
> +void spapr_of_client_dt(SpaprMachineState *spapr, void *fdt)
> +{
> +    uint32_t phandle;
> +    int i, offset, proplen =3D 0;
> +    const void *prop;
> +    bool found =3D false;
> +    GArray *phandles =3D g_array_new(false, false, sizeof(uint32_t));
> +    const char *nodename;
> +    char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
> +    int aliases;
> +    aliases =3D fdt_add_subnode(fdt, 0, "aliases");
> +
> +    if (stdout_path) {
> +        fdt_setprop_string(fdt, aliases, "hvterm", stdout_path);
> +    }
> +
> +    /* Add options now, doing it at the end of this __func__ breaks it :=
-/ */
> +    offset =3D fdt_add_subnode(fdt, 0, "options");
> +    if (offset > 0) {
> +        struct winsize ws;
> +
> +        if (ioctl(1, TIOCGWINSZ, &ws) !=3D -1) {
> +            _FDT(fdt_setprop_cell(fdt, offset, "screen-#columns", ws.ws_=
col));
> +            _FDT(fdt_setprop_cell(fdt, offset, "screen-#rows", ws.ws_row=
));
> +        }
> +        _FDT(fdt_setprop_cell(fdt, offset, "real-mode?", 1));
> +    }
> +
> +    /* Add "disk" nodes to SCSI hosts */
> +    for (offset =3D fdt_next_node(fdt, -1, NULL), phandle =3D 1;
> +         offset >=3D 0;
> +         offset =3D fdt_next_node(fdt, offset, NULL), ++phandle) {
> +
> +        nodename =3D fdt_get_name(fdt, offset, NULL);
> +        if (strncmp(nodename, "scsi@", 5) =3D=3D 0 ||
> +            strncmp(nodename, "v-scsi@", 7) =3D=3D 0) {
> +            int disk_node_off =3D fdt_add_subnode(fdt, offset, "disk");
> +
> +            fdt_setprop_string(fdt, disk_node_off, "device_type", "block=
");
> +        }
> +    }
> +
> +    /* Find all predefined phandles */
> +    for (offset =3D fdt_next_node(fdt, -1, NULL);
> +         offset >=3D 0;
> +         offset =3D fdt_next_node(fdt, offset, NULL)) {
> +        prop =3D fdt_getprop(fdt, offset, "phandle", &proplen);
> +        if (prop && proplen =3D=3D sizeof(uint32_t)) {
> +            phandle =3D fdt32_ld(prop);
> +            g_array_append_val(phandles, phandle);
> +        }
> +    }
> +
> +    /* Assign phandles skipping the predefined ones */
> +    for (offset =3D fdt_next_node(fdt, -1, NULL), phandle =3D 1;
> +         offset >=3D 0;
> +         offset =3D fdt_next_node(fdt, offset, NULL), ++phandle) {
> +
> +        prop =3D fdt_getprop(fdt, offset, "phandle", &proplen);
> +        if (prop) {
> +            continue;
> +        }
> +        /* Check if the current phandle is not allocated already */
> +        for ( ; ; ++phandle) {
> +            for (i =3D 0, found =3D false; i < phandles->len; ++i) {
> +                if (phandle =3D=3D g_array_index(phandles, uint32_t, i))=
 {
> +                    found =3D true;
> +                    break;
> +                }
> +            }
> +            if (!found) {
> +                break;
> +            }
> +        }
> +        _FDT(fdt_setprop_cell(fdt, offset, "phandle", phandle));
> +    }
> +    g_array_unref(phandles);
> +
> +    of_client_dt_memory_available(fdt, spapr->claimed, spapr->claimed_ba=
se);
> +
> +    /* Advertise RTAS presense, the FW instantiates the RTAS blob */
> +    offset =3D fdt_path_offset(fdt, "/rtas");
> +    _FDT(offset);
> +    _FDT(fdt_setprop_cell(fdt, offset, "rtas-size", OF_RTAS_SIZE));
> +}
> +
> +void spapr_of_client_dt_finalize(SpaprMachineState *spapr)
> +{
> +    void *fdt =3D spapr->fdt_blob;
> +    char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
> +    int chosen =3D fdt_path_offset(fdt, "/chosen");
> +    size_t cb =3D 0;
> +    char *bootlist =3D get_boot_devices_list(&cb);
> +
> +    /*
> +     * SLOF-less setup requires an open instance of stdout for early
> +     * kernel printk. By now all phandles are settled so we can open
> +     * the default serial console.
> +     */
> +    if (stdout_path) {
> +        _FDT(fdt_setprop_cell(fdt, chosen, "stdout",
> +                              spapr_of_client_open(spapr, stdout_path)))=
;
> +        _FDT(fdt_setprop_cell(fdt, chosen, "stdin",
> +                              spapr_of_client_open(spapr, stdout_path)))=
;
> +    }
> +
> +    if (bootlist) {
> +        _FDT(fdt_setprop_string(fdt, chosen, "bootpath", bootlist));
> +        _FDT(fdt_setprop_string(fdt, chosen, "bootargs",
> +                                spapr->bootargs ? spapr->bootargs : ""))=
;
> +    }
> +}
> +
> +void spapr_of_client_machine_init(SpaprMachineState *spapr)
> +{
> +    spapr_register_hypercall(KVMPPC_H_OF_CLIENT, spapr_h_of_client);
> +}
> diff --git a/pc-bios/vof/bootmem.c b/pc-bios/vof/bootmem.c
> new file mode 100644
> index 000000000000..de7d5fc76431
> --- /dev/null
> +++ b/pc-bios/vof/bootmem.c
> @@ -0,0 +1,13 @@
> +#include "vof.h"
> +
> +void boot_from_memory(uint64_t initrd, uint64_t initrdsize)
> +{
> +=09uint64_t kern[2];
> +=09phandle chosen =3D ci_finddevice("/chosen");
> +
> +=09if (ci_getprop(chosen, "qemu,boot-kernel", kern, sizeof(kern)) !=3D
> +=09=09=09sizeof(kern))
> +=09=09return;
> +
> +=09do_boot(kern[0], initrd, initrdsize);
> +}
> diff --git a/pc-bios/vof/ci.c b/pc-bios/vof/ci.c
> new file mode 100644
> index 000000000000..4880b3d2047c
> --- /dev/null
> +++ b/pc-bios/vof/ci.c
> @@ -0,0 +1,108 @@
> +#include "vof.h"
> +
> +struct prom_args {
> +        uint32_t service;
> +        uint32_t nargs;
> +        uint32_t nret;
> +        uint32_t args[10];
> +};
> +
> +#define ADDR(x) (uint32_t)(x)
> +
> +extern uint32_t ci_entry(uint32_t params);
> +
> +extern unsigned long hv_rtas(unsigned long params);
> +extern unsigned int hv_rtas_size;
> +
> +bool prom_handle(struct prom_args *pargs)
> +{
> +=09void *rtasbase;
> +=09uint32_t rtassize =3D 0;
> +=09phandle rtas;
> +
> +=09if (strcmp("call-method", (void *)(unsigned long) pargs->service))
> +=09=09return false;
> +
> +=09if (strcmp("instantiate-rtas", (void *)(unsigned long) pargs->args[0]=
))
> +=09=09return false;
> +
> +=09rtas =3D ci_finddevice("/rtas");
> +=09ci_getprop(rtas, "rtas-size", &rtassize, sizeof(rtassize));
> +=09if (rtassize < hv_rtas_size)
> +=09=09return false;
> +
> +=09rtasbase =3D (void *)(unsigned long) pargs->args[2];
> +
> +=09memcpy(rtasbase, hv_rtas, hv_rtas_size);
> +=09pargs->args[pargs->nargs] =3D 0;
> +=09pargs->args[pargs->nargs + 1] =3D pargs->args[2];
> +
> +=09return true;
> +}
> +
> +void prom_entry(uint32_t args)
> +{
> +=09if (!prom_handle((void *)(unsigned long) args))
> +=09=09ci_entry(args);
> +}
> +
> +int call_prom(const char *service, int nargs, int nret, ...)
> +{
> +        int i;
> +        struct prom_args args;
> +        va_list list;
> +
> +        args.service =3D ADDR(service);
> +        args.nargs =3D nargs;
> +        args.nret =3D nret;
> +
> +        va_start(list, nret);
> +        for (i =3D 0; i < nargs; i++)
> +                args.args[i] =3D va_arg(list, prom_arg_t);
> +        va_end(list);
> +
> +        for (i =3D 0; i < nret; i++)
> +                args.args[nargs+i] =3D 0;
> +
> +        if (ci_entry((uint32_t)(&args)) < 0)
> +                return PROM_ERROR;
> +
> +        return (nret > 0) ? args.args[nargs] : 0;
> +}
> +
> +void ci_panic(const char *str)
> +{
> +=09call_prom("exit", 0, 0);
> +}
> +
> +phandle ci_finddevice(const char *path)
> +{
> +=09return call_prom("finddevice", 1, 1, path);
> +}
> +
> +uint32_t ci_getprop(phandle ph, const char *propname, void *prop, int le=
n)
> +{
> +=09return call_prom("getprop", 4, 1, ph, propname, prop, len);
> +}
> +
> +ihandle ci_open(const char *path)
> +{
> +=09return call_prom("open", 1, 1, path);
> +}
> +
> +void ci_close(ihandle ih)
> +{
> +=09call_prom("close", 1, 0, ih);
> +}
> +
> +void *ci_claim(void *virt, uint32_t size, uint32_t align)
> +{
> +=09uint32_t ret =3D call_prom("claim", 3, 1, ADDR(virt), size, align);
> +
> +=09return (void *) (unsigned long) ret;
> +}
> +
> +uint32_t ci_release(void *virt, uint32_t size)
> +{
> +=09return call_prom("release", 2, 1, ADDR(virt), size);
> +}
> diff --git a/pc-bios/vof/libc.c b/pc-bios/vof/libc.c
> new file mode 100644
> index 000000000000..8603aedcb32c
> --- /dev/null
> +++ b/pc-bios/vof/libc.c
> @@ -0,0 +1,91 @@
> +#include "vof.h"
> +
> +int strlen(const char *s)
> +{
> +=09int len =3D 0;
> +
> +=09while (*s !=3D 0) {
> +=09=09len +=3D 1;
> +=09=09s +=3D 1;
> +=09}
> +
> +=09return len;
> +}
> +
> +int strcmp(const char *s1, const char *s2)
> +{
> +        while (*s1 !=3D 0 && *s2 !=3D 0) {
> +                if (*s1 !=3D *s2)
> +                        break;
> +                s1 +=3D 1;
> +                s2 +=3D 1;
> +        }
> +
> +        return *s1 - *s2;
> +}
> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +        char *cdest;
> +        const char *csrc =3D src;
> +
> +        cdest =3D dest;
> +        while (n-- > 0) {
> +                *cdest++ =3D *csrc++;
> +        }
> +
> +        return dest;
> +}
> +
> +int memcmp(const void *ptr1, const void *ptr2, size_t n)
> +{
> +        const unsigned char *p1 =3D ptr1;
> +        const unsigned char *p2 =3D ptr2;
> +
> +        while (n-- > 0) {
> +                if (*p1 !=3D *p2)
> +                        return (*p1 - *p2);
> +                p1 +=3D 1;
> +                p2 +=3D 1;
> +        }
> +
> +        return 0;
> +}
> +
> +void *memmove(void *dest, const void *src, size_t n)
> +{
> +        char *cdest;
> +        const char *csrc;
> +        int i;
> +
> +        /* Do the buffers overlap in a bad way? */
> +        if (src < dest && src + n >=3D dest) {
> +                /* Copy from end to start */
> +                cdest =3D dest + n - 1;
> +                csrc =3D src + n - 1;
> +                for (i =3D 0; i < n; i++) {
> +                        *cdest-- =3D *csrc--;
> +                }
> +        }
> +        else {
> +                /* Normal copy is possible */
> +                cdest =3D dest;
> +                csrc =3D src;
> +                for (i =3D 0; i < n; i++) {
> +                        *cdest++ =3D *csrc++;
> +                }
> +        }
> +
> +        return dest;
> +}
> +
> +void *memset(void *dest, int c, size_t size)
> +{
> +        unsigned char *d =3D (unsigned char *)dest;
> +
> +        while (size-- > 0) {
> +                *d++ =3D (unsigned char)c;
> +        }
> +
> +        return dest;
> +}
> diff --git a/pc-bios/vof/main.c b/pc-bios/vof/main.c
> new file mode 100644
> index 000000000000..34299a9cc5ad
> --- /dev/null
> +++ b/pc-bios/vof/main.c
> @@ -0,0 +1,22 @@
> +#include "vof.h"
> +
> +
> +void do_boot(unsigned long addr, unsigned long _r3, unsigned long _r4)
> +{
> +=09register unsigned long r3 __asm__("r3") =3D _r3;
> +=09register unsigned long r4 __asm__("r4") =3D _r4;
> +=09register unsigned long r5 __asm__("r5") =3D (unsigned long) _prom_ent=
ry;
> +
> +=09((client *)(uint32_t)addr)();
> +}
> +
> +void entry_c(void)
> +{
> +=09register unsigned long r3 __asm__("r3");
> +=09register unsigned long r4 __asm__("r4");
> +=09register unsigned long r5 __asm__("r5");
> +=09uint64_t initrd =3D r3, initrdsize =3D r4;
> +
> +=09boot_from_memory(initrd, initrdsize);
> +=09ci_panic("*** No boot target ***\n");
> +}
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 9ea620f23c85..640d0649394d 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -21,6 +21,27 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
>  spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned mag=
ic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> =20
> +# spapr_client.c
> +spapr_of_client_error_str_truncated(const char *s, int len) "%s truncate=
d to %d"
> +spapr_of_client_error_param(const char *method, int nargscheck, int nret=
check, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
> +spapr_of_client_error_unknown_service(const char *service, int nargs, in=
t nret) "\"%s\" args=3D%d rets=3D%d"
> +spapr_of_client_error_unknown_method(const char *method) "\"%s\""
> +spapr_of_client_error_unknown_ihandle_close(uint32_t ih) "ih=3D0x%x"
> +spapr_of_client_error_unknown_path(const char *path) "\"%s\""
> +spapr_of_client_finddevice(const char *path, uint32_t ph) "\"%s\" =3D> p=
h=3D0x%x"
> +spapr_of_client_canon(const char *path) "\"%s\""
> +spapr_of_client_claim(uint32_t virt, uint32_t size, uint32_t align, uint=
32_t ret) "virt=3D0x%x size=3D0x%x align=3D0x%x =3D> 0x%x"
> +spapr_of_client_release(uint32_t virt, uint32_t size, uint32_t ret) "vir=
t=3D0x%x size=3D0x%x =3D> 0x%x"
> +spapr_of_client_method(uint32_t ihandle, const char *method, uint32_t pa=
ram, uint32_t ret, uint32_t ret2) "ih=3D0x%x \"%s\"(0x%x) =3D> 0x%x 0x%x"
> +spapr_of_client_getprop(uint32_t ph, const char *prop, uint32_t ret, con=
st char *val) "ph=3D0x%x \"%s\" =3D> len=3D%d [%s]"
> +spapr_of_client_getproplen(uint32_t ph, const char *prop, uint32_t ret) =
"ph=3D0x%x \"%s\" =3D> len=3D%d"
> +spapr_of_client_setprop(uint32_t ph, const char *prop, const char *val, =
uint32_t ret) "ph=3D0x%x \"%s\" [%s] =3D> len=3D%d"
> +spapr_of_client_open(const char *path, uint32_t ph, uint32_t ih) "%s ph=
=3D0x%x =3D> ih=3D0x%x"
> +spapr_of_client_interpret(const char *cmd, uint32_t param1, uint32_t par=
am2, uint32_t ret, uint32_t ret2) "[%s] 0x%x 0x%x =3D> 0x%x 0x%x"
> +spapr_of_client_package_to_path(uint32_t ph, const char *tmp, uint32_t r=
et) "ph=3D0x%x =3D> %s len=3D%d"
> +spapr_of_client_instance_to_path(uint32_t ih, uint32_t ph, const char *t=
mp, uint32_t ret) "ih=3D0x%x ph=3D0x%x =3D> %s len=3D%d"
> +spapr_of_client_instance_to_package(uint32_t ih, uint32_t ph) "ih=3D0x%x=
 =3D> ph=3D0x%x"
> +
>  # spapr_hcall_tpm.c
>  spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIu64
>  spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_o=
ut, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64", d=
ata_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
> diff --git a/pc-bios/README b/pc-bios/README
> index a71fb318b389..ea50fe54525d 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -16,6 +16,8 @@
>    https://github.com/aik/SLOF, and the image currently in qemu is
>    built from git tag qemu-slof-20200221.
> =20
> +- vof is a minimalistic firmware to work with -machine pseries,vof=3Don.
> +
>  - sgabios (the Serial Graphics Adapter option ROM) provides a means for
>    legacy x86 software to communicate with an attached serial console as
>    if a video card were attached.  The master sources reside in a subvers=
ion
> diff --git a/pc-bios/vof.bin b/pc-bios/vof.bin
> new file mode 100755
> index 0000000000000000000000000000000000000000..0606d9451c6bff39b32879c2a=
3369406a6a0d07d
> GIT binary patch
> literal 3680
> zcmd^BUuauZ82{2_+ue2@_aP6FMSANxX=3D=3D+V^r6wxq_aZW%u<<!iXBNzt}d80wap}x
> z#N4z}S8<TCJvivU2Pyj2hY5XKg&_s^u!ji|bnD&*d)b3vWu4dGckj6_{g=3Dh<(ZJ!H
> zob#RU_kF+b&$&eZ?_Xe@C~goH)*Xq?AW`(>B?=3DMUwAULA#>}I8bhdE6ZYf0j&qP62
> z;l6X}0rol?XtZA^HJ3P=3D?ZiPe{%~Ip(aYQR$lk+M_mu|YR!*v0DmkeA@{iPX`5v|8
> z0*A9F7ieE$t!^oBha7L*`MOjpkW^YAxpbWry+E?QKuWPor~L77wiqBO?{hBo>#hd2
> z$6uf}{V=3D(5l5=3DVDXJcdXfw7s7y`N<}YQ$4>$)nks0Lgxp2(y%%KF0su;=3DiJ^9e2qM
> zTO`;bhv?8H{d3(Fq5~Idv7ype_~x;3z_pkC@%zZZxLA9{+QaK<AJK_vqTsyoo9Xwl
> zaF+eu#m{wMc)+KZ`Ly|i{&v1M-Aja7W_^XPLc!oX1$n;$R~Bp8loz<&^QL{~Jz>W+
> z=3D#<!JTQ1*h#>AA#`vwN`mW}EzHm<_P4%pZ!Z1f<;Uc^|1E-&+s*~2^lqp=3Du4Jeo~j
> zOq=3D`%v95<NeMDC+e^h_3Va!BGW!t*vj9YwP;0OOBzKLtw0sH~1ckl*2*j9;o-0ru{
> z^&XsVxAj}jfoHNcV#dT{#&MQPutx<~-h6YP8?(9JJx5$8s^4cAyvJuEzwA9zo;kO3
> z9QL<aoP$#<7LxxU)>}DOgntTT6~=3D%a)IDpg;r=3DlGZ{cyL?yB+JQ#b2<Ca#1%u+6Ho
> zUf@SiXW(nFZ-3Vwc~pK1UJX6$%i9%o&OCXFoHLE#Ecyn8jm>ws=3Da_jrZ^ZyMa*eZ`
> zEaY5}^X(#c4LVRG&NE!+{s1W*tK{O|sL$)Njy;@xZ^oxfR~T31iWzI*WCRZ9gp9sw
> z%82{i<7D6t3K<vlcm{pS>zqS~z3dO7NA{Za&$hZaA6TZ?NA6<1kZrPLSq?ei5V5P)
> zr`N^1&{)~Ww!RBfI{OQ|B-R%;{=3DQ&ygMMcE9X9?t&%FsfQmyhPv<a-+z*<8;y1DZW
> znsNhc2>odo{V7_yOR17Uqo{=3DpILppNC>NZf#&Ur4a)d6H3sfpE&^P7lv{=3D4N-<1to
> z{<WS~VC#^mrD4pR2T{!Yt~jp-D9H7Jxf?MoW4{M8pNB-<a34%eL+;gSI)Iwyo*3f)
> z+zSUK<ZnF%?btw;_4oLD$p!m*idKvyKKIvyGb<*Fh~1OkA2B%{7Il230=3Dpe}T+<TA
> z-qZtGkq1ge9&FbY6}oP~AK8l4pTD#3<{L6+_R!(&`Z!PFgT(kEUv5>2VGa56#Q^6^
> z$0AXOPK28Aocigt3FM6<N>9y^8uU*-Wc~OqU<?N^9Ki5e7?0;TH-#V7a<PV9GI^14
> z?C&Auq8nUtttq;Jynll40=3D_EnU#h@=3D&bphFcJZ^(!rA<x0;igvHSjsHSb@VaV?LV%
> z&f7J_Y*o~CPvv*U)*dp^35?3`4i9)#!J{|-N;oUx=3Dmc(yh5P6i_764rZ{I<02|iz5
> z7FX<ea&2)8E3oT;-6pW#tC8Df;rF}nJA{6AYG*$y@;6}<a;OFUtPMHT4jjBgk6&b4
> zP^bKcDB=3Dxp>Da@W#`x$x3i@jcY~?rKoe!PnZ;KYJ+w*Uo&hlH8cfN^!{Ks*wUlFH)
> zy*NVYQFC*%+MiZGNT)MuCN}nwmQk^Fh~lwSs`Z?fIh#&Ua%4Oc8_6VN8Lf3J6C3Ay
> zC&YrM*74+L8uqkoGQ(#dCPxwp?bBo&n@~79mL8?_s5Zi9@l<-8W#g$>@*L(dEv3b<
> zb0U5g2P5=3D}cJ6!&ThscnHa4QA_zsc7L-axxql7Vwv5c{TeVjXnu)cwD6Qhi=3Dj&UF3
> NA;t#L5!^o_{R4q+IM@IH
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/pc-bios/vof/entry.S b/pc-bios/vof/entry.S
> new file mode 100644
> index 000000000000..39b333779514
> --- /dev/null
> +++ b/pc-bios/vof/entry.S
> @@ -0,0 +1,51 @@
> +#define LOAD32(rn, name)    \
> +=09lis     rn,name##@h;    \
> +=09ori     rn,rn,name##@l
> +
> +#define ENTRY(func_name)    \
> +=09.text;                  \
> +=09.align  2;              \
> +=09.globl  .func_name;     \
> +=09.func_name:             \
> +=09.globl  func_name;      \
> +=09func_name:
> +
> +#define KVMPPC_HCALL_BASE       0xf000
> +#define KVMPPC_H_RTAS           (KVMPPC_HCALL_BASE + 0x0)
> +#define KVMPPC_H_OF_CLIENT      (KVMPPC_HCALL_BASE + 0x5)
> +
> +=09. =3D 0x100 /* Do exactly as SLOF does */
> +
> +ENTRY(_start)
> +=09LOAD32(%r31, 0) /* Go 32bit mode */
> +=09mtmsrd %r31,0
> +=09LOAD32(2, __toc_start)
> +=09b entry_c
> +
> +ENTRY(_prom_entry)
> +=09LOAD32(2, __toc_start)
> +=09stdu    %r1,-112(%r1)
> +=09std     %r31,104(%r1)
> +=09mflr    %r31
> +=09bl prom_entry
> +=09nop
> +=09mtlr    %r31
> +=09ld      %r31,104(%r1)
> +=09addi    %r1,%r1,112
> +=09blr
> +
> +ENTRY(ci_entry)
> +=09mr=094,3
> +=09LOAD32(3,KVMPPC_H_OF_CLIENT)
> +=09sc=091
> +=09blr
> +
> +/* This is the actual RTAS blob copied to the OS at instantiate-rtas */
> +ENTRY(hv_rtas)
> +=09mr      %r4,%r3
> +=09LOAD32(3,KVMPPC_H_RTAS)
> +=09sc=091
> +=09blr
> +=09.globl hv_rtas_size
> +hv_rtas_size:
> +=09.long . - hv_rtas;
> diff --git a/pc-bios/vof/l.lds b/pc-bios/vof/l.lds
> new file mode 100644
> index 000000000000..10b557a81f78
> --- /dev/null
> +++ b/pc-bios/vof/l.lds
> @@ -0,0 +1,48 @@
> +OUTPUT_FORMAT("elf32-powerpc", "elf32-powerpc", "elf32-powerpc")
> +OUTPUT_ARCH(powerpc:common)
> +
> +/* set the entry point */
> +ENTRY ( __start )
> +
> +SECTIONS {
> +=09__executable_start =3D .;
> +
> +=09.text : {
> +=09=09*(.text)
> +=09}
> +
> +=09__etext =3D .;
> +
> +=09. =3D ALIGN(8);
> +
> +=09.data : {
> +=09=09*(.data)
> +=09=09*(.rodata .rodata.*)
> +=09=09*(.got1)
> +=09=09*(.sdata)
> +=09=09*(.opd)
> +=09}
> +
> +=09/* FIXME bss at end ??? */
> +
> +=09. =3D ALIGN(8);
> +=09__bss_start =3D .;
> +=09.bss : {
> +=09=09*(.sbss) *(.scommon)
> +=09=09*(.dynbss)
> +=09=09*(.bss)
> +=09}
> +
> +=09. =3D ALIGN(8);
> +=09__bss_end =3D .;
> +=09__bss_size =3D (__bss_end - __bss_start);
> +
> +=09. =3D ALIGN(256);
> +=09__toc_start =3D DEFINED (.TOC.) ? .TOC. : ADDR (.got) + 0x8000;
> +=09.got :
> +=09{
> +=09=09 *(.toc .got)
> +=09}
> +=09. =3D ALIGN(8);
> +=09__toc_end =3D .;
> +}
>=20


