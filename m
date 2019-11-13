Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0228F21D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUlVB/3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0228F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUpV4-0006RZ-33
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 05:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUpUM-00061d-UK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUpUJ-0004dl-P9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:03:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUpSN-0003Ei-Hz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573639258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOTN8ekZ17X99xqCTDmNPV84C2+rxgie37KnBK92xvc=;
 b=YUlVB/3+dOLlXfd55OoueDOaaq0bho0KlJuu7lEK6zY3WpBWM5ih/RVM6KhOGSCEoSqtQe
 16yYMCd2LCoXuJsr3yGsyCyPV8tW7HHazsJfdx3Wnu7vz9YGyJoVmAG6ZBnu4PxRmif1eC
 RE/UvWZZxprhdyAwZkWtaSwrdK9iWU4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-74Ymh4zAPmasf2W333RW1g-1; Wed, 13 Nov 2019 05:00:57 -0500
Received: by mail-qk1-f200.google.com with SMTP id o11so157375qkk.7
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 02:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=acQt0M5Xm2JbcVmHMxoovLJCO6oPHGgYnX4i26Kjus8=;
 b=qD8UA8tr/r8R7Qij7Qu2KQyMwpx+e/kq6r0Q8TGPbPQFlDbltvwqfj4895TfZ9lvHc
 K3f9EstgafdH5Uv2cTMhdAL7by5AaVZ9o89y8e4gKd+8A/yvSJbgyZ7weFDvtTO+Usrb
 GSDfFacn88MUjVzM+dEWLbGy298odxYADx9V+QIraT9x0bgUGDlCt6MThisNKJJBjj5j
 bTUs24dSurhRAcuueJq39S96raaI9nQflye7XtSkfmcMCV6bi7vKHMUsYd2yfMIUezMO
 ABNHKW6l/NIJdBVljp+JA8Kb3KMUIlTqJk8Xg11nTaM7Mij9Ysz20Myrzqg8k7yYxmCW
 mmBA==
X-Gm-Message-State: APjAAAWmrcCKizaV9zna0J9OJ+6YAEbSzaLg/R9NWPn8E6hnRK9OkKcD
 BBrYi/QtTiZLoLxYbAp//9obyYm1i5Pzyh66yu5dJbpUG2jL+eYPkeVK/nMceJRdmCZt/hDg1AL
 EE0cMjuL5f+qAjQE=
X-Received: by 2002:a05:620a:12a3:: with SMTP id
 x3mr1656268qki.336.1573639256360; 
 Wed, 13 Nov 2019 02:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFFY6WRC6ahs8DMpVWywXWWeEHAC/ax/DgZ0TqKmapUWIqA1Wgw201cKOU8VtVMssAV6eEsw==
X-Received: by 2002:a05:620a:12a3:: with SMTP id
 x3mr1656247qki.336.1573639255953; 
 Wed, 13 Nov 2019 02:00:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id b54sm1053456qta.38.2019.11.13.02.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 02:00:55 -0800 (PST)
Date: Wed, 13 Nov 2019 05:00:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: virtio,iommu_platform=on
Message-ID: <20191113045747-mutt-send-email-mst@kernel.org>
References: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
 <20191112014821-mutt-send-email-mst@kernel.org>
 <7ac95a46-b2ae-005b-1907-5302d5b0a39d@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <7ac95a46-b2ae-005b-1907-5302d5b0a39d@ozlabs.ru>
X-MC-Unique: 74Ymh4zAPmasf2W333RW1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 03:44:28PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 12/11/2019 18:08, Michael S. Tsirkin wrote:
> > On Tue, Nov 12, 2019 at 02:53:49PM +1100, Alexey Kardashevskiy wrote:
> >> Hi!
> >>
> >> I am enabling IOMMU for virtio in the pseries firmware (SLOF) and seei=
ng
> >> problems, one of them is SLOF does SCSI bus scan, then it stops the
> >> virtio-scsi by clearing MMIO|IO|BUSMASTER from PCI_COMMAND (as SLOF
> >> stopped using the devices) and when this happens, I see unassigned
> >> memory access (see below) which happens because disabling busmaster
> >> disables IOMMU and QEMU cannot access the rings to do some shutdown. A=
nd
> >> when this happens, the device does not come back even if SLOF re-enabl=
es it.
> >=20
> > In fact clearing bus master should disable ring access even
> > without the IOMMU.
> > Once you do this you should not wait for rings to be processed,
> > it is safe to assume they won't be touched again and just
> > free up any buffers that have not been used.
> >=20
> > Why don't you see this without IOMMU?
>=20
> Because without IOMMU, virtio can always access rings, it does not need
> bus master address space for that.

Right and that's a bug in virtio scsi. E.g. virtio net checks
bus mastering before each access.
Which is all well and good, but we can't just break the world
so I guess we first need to fix SLOF, and then add
a compat property. And maybe keep it broken for
legacy ...

>=20
> > It's a bug I think, probably there to work around buggy guests.
> >=20
> > So pls fix this in SLOF and then hopefully we can drop the
> > work arounds and have clearing bus master actually block DMA.
>=20
>=20
> Laszlo suggested writing 0 to the status but this does not seem helping,
> with both ioeventfd=3Dtrue/false. It looks like setting/clearing busmaste=
r
> bit confused memory region caches in QEMU's virtio. I am confused which
> direction to keep digging to, any suggestions? Thanks,
>=20

to clarify you reset after setting bus master? right?


>=20
> >=20
> >> Hacking SLOF to not clear BUSMASTER makes virtio-scsi work but it is
> >> hardly a right fix.
> >>
> >> Is this something expected? Thanks,
> >>
> >>
> >> Here is the exact command line:
> >>
> >> /home/aik/pbuild/qemu-garrison2-ppc64/ppc64-softmmu/qemu-system-ppc64 =
\
> >>
> >> -nodefaults \
> >>
> >> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> >>
> >> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> >>
> >> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
> >>
> >> -nographic \
> >>
> >> -vga none \
> >>
> >> -enable-kvm \
> >> -m 2G \
> >>
> >> -device
> >> virtio-scsi-pci,id=3Dvscsi0,iommu_platform=3Don,disable-modern=3Doff,d=
isable-legacy=3Don
> >> \
> >> -drive id=3DDRIVE0,if=3Dnone,file=3Dimg/u1804-64le.qcow2,format=3Dqcow=
2 \
> >>
> >> -device scsi-disk,id=3Dscsi-disk0,drive=3DDRIVE0 \
> >>
> >> -snapshot \
> >>
> >> -smp 1 \
> >>
> >> -machine pseries \
> >>
> >> -L /home/aik/t/qemu-ppc64-bios/ \
> >>
> >> -trace events=3Dqemu_trace_events \
> >>
> >> -d guest_errors \
> >>
> >> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh59518 \
> >>
> >> -mon chardev=3DSOCKET0,mode=3Dcontrol
> >>
> >>
> >>
> >> Here is the backtrace:
> >>
> >> Thread 5 "qemu-system-ppc" hit Breakpoint 8, unassigned_mem_accepts
> >> (opaque=3D0x0, addr=3D0x5802, size=3D0x2, is_write=3D0x0, attrs=3D...)=
 at /home/
> >> aik/p/qemu/memory.c:1275
> >> 1275        return false;
> >> #0  unassigned_mem_accepts (opaque=3D0x0, addr=3D0x5802, size=3D0x2,
> >> is_write=3D0x0, attrs=3D...) at /home/aik/p/qemu/memory.c:1275
> >> #1  0x00000000100a8ac8 in memory_region_access_valid (mr=3D0x1105c230
> >> <io_mem_unassigned>, addr=3D0x5802, size=3D0x2, is_write=3D0x0, attrs=
=3D...) at
> >> /home/aik/p/qemu/memory.c:1377
> >> #2  0x00000000100a8c88 in memory_region_dispatch_read (mr=3D0x1105c230
> >> <io_mem_unassigned>, addr=3D0x5802, pval=3D0x7ffff550d410, op=3DMO_16,
> >> attrs=3D...) at /home/aik/p/qemu/memory.c:1418
> >> #3  0x000000001001cad4 in address_space_lduw_internal_cached_slow
> >> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0,
> >> endian=3DDEVICE_LITTLE_ENDIAN) at /home/aik/p/qemu/memory_ldst.inc.c:2=
11
> >> #4  0x000000001001cc84 in address_space_lduw_le_cached_slow
> >> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0) at
> >> /home/aik/p/qemu/memory_ldst.inc.c:249
> >> #5  0x000000001019bd80 in address_space_lduw_le_cached
> >> (cache=3D0x7fff68036fa0, addr=3D0x2, attrs=3D..., result=3D0x0) at
> >> /home/aik/p/qemu/include/exec/memory_ldst_cached.inc.h:56
> >> #6  0x000000001019c10c in lduw_le_phys_cached (cache=3D0x7fff68036fa0,
> >> addr=3D0x2) at /home/aik/p/qemu/include/exec/memory_ldst_phys.inc.h:91
> >> #7  0x000000001019d86c in virtio_lduw_phys_cached (vdev=3D0x118b9110,
> >> cache=3D0x7fff68036fa0, pa=3D0x2) at
> >> /home/aik/p/qemu/include/hw/virtio/virtio-access.h:166
> >> #8  0x000000001019e648 in vring_avail_idx (vq=3D0x118c2720) at
> >> /home/aik/p/qemu/hw/virtio/virtio.c:302
> >> #9  0x000000001019f5bc in virtio_queue_split_empty (vq=3D0x118c2720) a=
t
> >> /home/aik/p/qemu/hw/virtio/virtio.c:581
> >> #10 0x000000001019f838 in virtio_queue_empty (vq=3D0x118c2720) at
> >> /home/aik/p/qemu/hw/virtio/virtio.c:612
> >> #11 0x00000000101a8fa8 in virtio_queue_host_notifier_aio_poll
> >> (opaque=3D0x118c2798) at /home/aik/p/qemu/hw/virtio/virtio.c:3389
> >> #12 0x000000001092679c in run_poll_handlers_once (ctx=3D0x11212e40,
> >> timeout=3D0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:520
> >> #13 0x0000000010926aec in try_poll_mode (ctx=3D0x11212e40,
> >> timeout=3D0x7ffff550d7d8) at /home/aik/p/qemu/util/aio-posix.c:607
> >> #14 0x0000000010926c2c in aio_poll (ctx=3D0x11212e40, blocking=3D0x1) =
at
> >> /home/aik/p/qemu/util/aio-posix.c:639
> >> #15 0x000000001091fe0c in aio_wait_bh_oneshot (ctx=3D0x11212e40,
> >> cb=3D0x1016f35c <virtio_scsi_dataplane_stop_bh>, opaque=3D0x118b9110) =
at
> >> /home/aik/p/qemu/util/aio-wait.c:71
> >> #16 0x000000001016fa60 in virtio_scsi_dataplane_stop (vdev=3D0x118b911=
0)
> >> at /home/aik/p/qemu/hw/scsi/virtio-scsi-dataplane.c:211
> >> #17 0x0000000010684740 in virtio_bus_stop_ioeventfd (bus=3D0x118b9098)=
 at
> >> /home/aik/p/qemu/hw/virtio/virtio-bus.c:245
> >> #18 0x0000000010688290 in virtio_pci_stop_ioeventfd (proxy=3D0x118b0fa=
0)
> >> at /home/aik/p/qemu/hw/virtio/virtio-pci.c:292
> >> #19 0x00000000106891e8 in virtio_write_config (pci_dev=3D0x118b0fa0,
> >> address=3D0x4, val=3D0x100100, len=3D0x4) at
> >> /home/aik/p/qemu/hw/virtio/virtio-pci.c:613
> >> #20 0x00000000105b7228 in pci_host_config_write_common
> >> (pci_dev=3D0x118b0fa0, addr=3D0x4, limit=3D0x100, val=3D0x100100, len=
=3D0x4) at
> >> /home/aik/p/qemu/hw/pci/pci_host.c:81
> >> #21 0x00000000101f7bdc in finish_write_pci_config (spapr=3D0x11217200,
> >> buid=3D0x800000020000000, addr=3D0x4, size=3D0x4, val=3D0x100100,
> >> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:192
> >> #22 0x00000000101f7cec in rtas_ibm_write_pci_config (cpu=3D0x11540df0,
> >> spapr=3D0x11217200, token=3D0x2017, nargs=3D0x5, args=3D0x7e7533cc, nr=
et=3D0x1,
> >> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_pci.c:216
> >> #23 0x00000000101f5860 in spapr_rtas_call (cpu=3D0x11540df0,
> >> spapr=3D0x11217200, token=3D0x2017, nargs=3D0x5, args=3D0x7e7533cc, nr=
et=3D0x1,
> >> rets=3D0x7e7533e0) at /home/aik/p/qemu/hw/ppc/spapr_rtas.c:416
> >> #24 0x00000000101ee214 in h_rtas (cpu=3D0x11540df0, spapr=3D0x11217200=
,
> >> opcode=3D0xf000, args=3D0x7ffff4cf0030) at
> >> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:1214
> >> #25 0x00000000101f0524 in spapr_hypercall (cpu=3D0x11540df0,
> >> opcode=3D0xf000, args=3D0x7ffff4cf0030) at
> >> /home/aik/p/qemu/hw/ppc/spapr_hcall.c:2014
> >> #26 0x000000001033bff0 in kvm_arch_handle_exit (cs=3D0x11540df0,
> >> run=3D0x7ffff4cf0000) at /home/aik/p/qemu/target/ppc/kvm.c:1684
> >> #27 0x00000000100cc7c8 in kvm_cpu_exec (cpu=3D0x11540df0) at
> >> /home/aik/p/qemu/accel/kvm/kvm-all.c:2391
> >> #28 0x000000001008edf8 in qemu_kvm_cpu_thread_fn (arg=3D0x11540df0) at
> >> /home/aik/p/qemu/cpus.c:1318
> >> #29 0x000000001092c704 in qemu_thread_start (args=3D0x11588d90) at
> >> /home/aik/p/qemu/util/qemu-thread-posix.c:519
> >> #30 0x00007ffff7b58070 in start_thread (arg=3D0x7ffff550ebf0) at
> >> pthread_create.c:335
> >> #31 0x00007ffff7aa3a70 in clone () at
> >> ../sysdeps/unix/sysv/linux/powerpc/powerpc64/clone.S:96
> >> (gdb)
> >>
> >> --=20
> >> Alexey
> >=20
>=20
> --=20
> Alexey


