Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B7A20674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+L8SF0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B7A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSA3-0001Y5-6M
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iUS93-0000zE-Qo
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iUS90-0000ha-Cn
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:07:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iUS90-0000ej-8v
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573549645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2yMtfegfgcrZLvMPywVDFoMeBCj2HIux92CvQtz0XA=;
 b=R+L8SF0ythKgttQ/vd2UC/hI9/V65gokswYthHb7omXVt2B69SwwlkCbJcCbYwwz3k/piV
 MhpQknTDK/oa3VZseKlMuBW3ntEBbyMYKfNhfdxFO6vrrTnACpcFwZNHHKF94kJIN5cRKt
 WEvCHaoJsB0j5F/bKOHLTBZfNoeoKTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Up68VqPkMIqsz5hyxMkt7A-1; Tue, 12 Nov 2019 04:06:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AABD100729C;
 Tue, 12 Nov 2019 09:06:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-207.ams2.redhat.com
 [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9E1F61075;
 Tue, 12 Nov 2019 09:06:11 +0000 (UTC)
Subject: Re: virtio,iommu_platform=on
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9204f8a7-0dfa-b689-7f97-5997d3298fdd@redhat.com>
Date: Tue, 12 Nov 2019 10:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Up68VqPkMIqsz5hyxMkt7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 04:53, Alexey Kardashevskiy wrote:
> Hi!
>=20
> I am enabling IOMMU for virtio in the pseries firmware (SLOF) and seeing
> problems, one of them is SLOF does SCSI bus scan, then it stops the
> virtio-scsi by clearing MMIO|IO|BUSMASTER from PCI_COMMAND (as SLOF
> stopped using the devices) and when this happens, I see unassigned
> memory access (see below) which happens because disabling busmaster
> disables IOMMU and QEMU cannot access the rings to do some shutdown. And
> when this happens, the device does not come back even if SLOF re-enables =
it.
>=20
> Hacking SLOF to not clear BUSMASTER makes virtio-scsi work but it is
> hardly a right fix.
>=20
> Is this something expected? Thanks,

Can you perform a virtio reset (write 0 to the virtio-scsi-pci device's
virtio status register) in SLOF, before clearing PCI_COMMAND?

Thanks,
Laszlo


>=20
>=20
> Here is the exact command line:
>=20
> /home/aik/pbuild/qemu-garrison2-ppc64/ppc64-softmmu/qemu-system-ppc64 \
>=20
> -nodefaults \
>=20
> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
>=20
> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
>=20
> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
>=20
> -nographic \
>=20
> -vga none \
>=20
> -enable-kvm \
> -m 2G \
>=20
> -device
> virtio-scsi-pci,id=3Dvscsi0,iommu_platform=3Don,disable-modern=3Doff,disa=
ble-legacy=3Don
> \
> -drive id=3DDRIVE0,if=3Dnone,file=3Dimg/u1804-64le.qcow2,format=3Dqcow2 \
>=20
> -device scsi-disk,id=3Dscsi-disk0,drive=3DDRIVE0 \
>=20
> -snapshot \
>=20
> -smp 1 \
>=20
> -machine pseries \
>=20
> -L /home/aik/t/qemu-ppc64-bios/ \
>=20
> -trace events=3Dqemu_trace_events \
>=20
> -d guest_errors \
>=20
> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh59518 \
>=20
> -mon chardev=3DSOCKET0,mode=3Dcontrol
>=20
>=20
>=20
> Here is the backtrace:
>=20
> Thread 5 "qemu-system-ppc" hit Breakpoint 8, unassigned_mem_accepts
> (opaque=3D0x0, addr=3D0x5802, size=3D0x2, is_write=3D0x0, attrs=3D...) at=
 /home/
> aik/p/qemu/memory.c:1275
> 1275        return false;
> #0  unassigned_mem_accepts (opaque=3D0x0, addr=3D0x5802, size=3D0x2,
> is_write=3D0x0, attrs=3D...) at /home/aik/p/qemu/memory.c:1275
> #1  0x00000000100a8ac8 in memory_region_access_valid (mr=3D0x1105c230
> <io_mem_unassigned>, addr=3D0x5802, size=3D0x2, is_write=3D0x0, attrs=3D.=
..) at
> /home/aik/p/qemu/memory.c:1377
> #2  0x00000000100a8c88 in memory_region_dispatch_read (mr=3D0x1105c230
> <io_mem_unassigned>, addr=3D0x5802, pval=3D0x7ffff550d410, op=3DMO_16,
> attrs=3D...) at /home/aik/p/qemu/memory.c:1418
> #3  0x000000001001cad4 in address_space_lduw_internal_cached_slow
> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0,
> endian=3DDEVICE_LITTLE_ENDIAN) at /home/aik/p/qemu/memory_ldst.inc.c:211
> #4  0x000000001001cc84 in address_space_lduw_le_cached_slow
> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0) at
> /home/aik/p/qemu/memory_ldst.inc.c:249
> #5  0x000000001019bd80 in address_space_lduw_le_cached
> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0) at
> /home/aik/p/qemu/include/exec/memory_ldst_cached.inc.h:56
> #6  0x000000001019c10c in lduw_le_phys_cached (cache=3D0x7fff68036fa0,
> addr=3D0x2) at /home/aik/p/qemu/include/exec/memory_ldst_phys.inc.h:91
> #7  0x000000001019d86c in virtio_lduw_phys_cached (vdev=3D0x118b9110,
> cache=3D0x7fff68036fa0, pa=3D0x2) at
> /home/aik/p/qemu/include/hw/virtio/virtio-access.h:166
> #8  0x000000001019e648 in vring_avail_idx (vq=3D0x118c2720) at
> /home/aik/p/qemu/hw/virtio/virtio.c:302
> #9  0x000000001019f5bc in virtio_queue_split_empty (vq=3D0x118c2720) at
> /home/aik/p/qemu/hw/virtio/virtio.c:581
> #10 0x000000001019f838 in virtio_queue_empty (vq=3D0x118c2720) at
> /home/aik/p/qemu/hw/virtio/virtio.c:612
> #11 0x00000000101a8fa8 in virtio_queue_host_notifier_aio_poll
> (opaque=3D0x118c2798) at /home/aik/p/qemu/hw/virtio/virtio.c:3389
> #12 0x000000001092679c in run_poll_handlers_once (ctx=3D0x11212e40,
> timeout=3D0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:520
> #13 0x0000000010926aec in try_poll_mode (ctx=3D0x11212e40,
> timeout=3D0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:607
> #14 0x0000000010926c2c in aio_poll (ctx=3D0x11212e40, blocking=3D0x1) at
> /home/aik/p/qemu/util/aio-posix.c:639
> #15 0x000000001091fe0c in aio_wait_bh_oneshot (ctx=3D0x11212e40,
> cb=3D0x1016f35c <virtio_scsi_dataplane_stop_bh>, opaque=3D0x118b9110) at
> /home/aik/p/qemu/util/aio-wait.c:71
> #16 0x000000001016fa60 in virtio_scsi_dataplane_stop (vdev=3D0x118b9110)
> at /home/aik/p/qemu/hw/scsi/virtio-scsi-dataplane.c:211
> #17 0x0000000010684740 in virtio_bus_stop_ioeventfd (bus=3D0x118b9098) at
> /home/aik/p/qemu/hw/virtio/virtio-bus.c:245
> #18 0x0000000010688290 in virtio_pci_stop_ioeventfd (proxy=3D0x118b0fa0)
> at /home/aik/p/qemu/hw/virtio/virtio-pci.c:292
> #19 0x00000000106891e8 in virtio_write_config (pci_dev=3D0x118b0fa0,
> address=3D0x4, val=3D0x100100, len=3D0x4) at
> /home/aik/p/qemu/hw/virtio/virtio-pci.c:613
> #20 0x00000000105b7228 in pci_host_config_write_common
> (pci_dev=3D0x118b0fa0, addr=3D0x4, limit=3D0x100, val=3D0x100100, len=3D0=
x4) at
> /home/aik/p/qemu/hw/pci/pci_host.c:81
> #21 0x00000000101f7bdc in finish_write_pci_config (spapr=3D0x11217200,
> buid=3D0x800000020000000, addr=3D0x4, size=3D0x4, val=3D0x100100,
> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:192
> #22 0x00000000101f7cec in rtas_ibm_write_pci_config (cpu=3D0x11540df0,
> spapr=3D0x11217200, token=3D0x2017, nargs=3D0x5, args=3D0x7e7533cc, nret=
=3D0x1,
> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:216
> #23 0x00000000101f5860 in spapr_rtas_call (cpu=3D0x11540df0,
> spapr=3D0x11217200, token=3D0x2017, nargs=3D0x5, args=3D0x7e7533cc, nret=
=3D0x1,
> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_rtas.c:416
> #24 0x00000000101ee214 in h_rtas (cpu=3D0x11540df0, spapr=3D0x11217200,
> opcode=3D0xf000, args=3D0x7ffff4cf0030) at
> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:1214
> #25 0x00000000101f0524 in spapr_hypercall (cpu=3D0x11540df0,
> opcode=3D0xf000, args=3D0x7ffff4cf0030) at
> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:2014
> #26 0x000000001033bff0 in kvm_arch_handle_exit (cs=3D0x11540df0,
> run=3D0x7ffff4cf0000) at /home/aik/p/qemu/target/ppc/kvm.c:1684
> #27 0x00000000100cc7c8 in kvm_cpu_exec (cpu=3D0x11540df0) at
> /home/aik/p/qemu/accel/kvm/kvm-all.c:2391
> #28 0x000000001008edf8 in qemu_kvm_cpu_thread_fn (arg=3D0x11540df0) at
> /home/aik/p/qemu/cpus.c:1318
> #29 0x000000001092c704 in qemu_thread_start (args=3D0x11588d90) at
> /home/aik/p/qemu/util/qemu-thread-posix.c:519
> #30 0x00007ffff7b58070 in start_thread (arg=3D0x7ffff550ebf0) at
> pthread_create.c:335
> #31 0x00007ffff7aa3a70 in clone () at
> ../sysdeps/unix/sysv/linux/powerpc/powerpc64/clone.S:96
> (gdb)
>=20


