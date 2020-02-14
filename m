Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F0EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC80824696
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC80824696
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dsZ-000727-PT
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j2dro-0006W3-Uo
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j2drn-0000gf-93
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:31:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:49924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j2drn-0000eb-2u
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:30:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j2drk-0006E8-VG
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 16:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C131E2E80D2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 16:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2020 16:22:58 -0000
From: =?utf-8?b?TWljaGFsIFByw612b3puw61r?= <1863333@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mprivozn
X-Launchpad-Bug-Reporter: =?utf-8?q?Michal_Pr=C3=ADvozn=C3=ADk_=28mprivozn?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Michal_Pr=C3=ADvozn=C3=ADk_=28mprivozn?=
 =?utf-8?q?=29?=
Message-Id: <158169737821.29590.14612222914203628319.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1863333] [NEW] Assigning NVMe disk to a domain causes
 VFIO_MAP_DMA errors
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f3812db3352ae91fdeec29fa65ce91eec3488195
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1863333 <1863333@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I'm seeing some errors when assigning my NVMe disk to qemu. This is the
full command line:


/home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64 \
-name guest=3Dfedora,debug-threads=3Don \
-S \
-object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/do=
main-2-fedora/master-key.aes \
-machine pc-i440fx-4.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
-cpu host \
-m size=3D4194304k,slots=3D16,maxmem=3D1099511627776k \
-overcommit mem-lock=3Doff \
-smp 4,sockets=3D1,dies=3D1,cores=3D2,threads=3D2 \
-object iothread,id=3Diothread1 \
-object iothread,id=3Diothread2 \
-object iothread,id=3Diothread3 \
-object iothread,id=3Diothread4 \
-mem-prealloc \
-mem-path /hugepages2M/libvirt/qemu/2-fedora \
-numa node,nodeid=3D0,cpus=3D0,mem=3D4096 \
-uuid 63840878-0deb-4095-97e6-fc444d9bc9fa \
-no-user-config \
-nodefaults \
-chardev socket,id=3Dcharmonitor,fd=3D31,server,nowait \
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
-rtc base=3Dutc \
-no-shutdown \
-global PIIX4_PM.disable_s3=3D0 \
-global PIIX4_PM.disable_s4=3D0 \
-boot menu=3Don,strict=3Don \
-device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 \
-device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x4 \
-device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 \
-blockdev '{"driver":"file","filename":"/var/lib/libvirt/images/fedora.qcow=
2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}=
' \
-blockdev '{"node-name":"libvirt-2-format","read-only":false,"discard":"unm=
ap","driver":"qcow2","file":"libvirt-2-storage","backing":null}' \
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Dd=
rive-scsi0-0-0-0,drive=3Dlibvirt-2-format,id=3Dscsi0-0-0-0,bootindex=3D1 \
-blockdev '{"driver":"nvme","device":"0000:02:00.0","namespace":1,"node-nam=
e":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"raw"=
,"file":"libvirt-1-storage"}' \
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Dlibvirt-1-=
format,id=3Dvirtio-disk0 \
-netdev tap,fd=3D33,id=3Dhostnet0,vhost=3Don,vhostfd=3D34 \
-device virtio-net-pci,host_mtu=3D9000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52=
:54:00:a4:6f:91,bus=3Dpci.0,addr=3D0x3 \
-chardev pty,id=3Dcharserial0 \
-device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
-chardev socket,id=3Dcharchannel0,fd=3D35,server,nowait \
-device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0=
,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
-spice port=3D5900,addr=3D0.0.0.0,disable-ticketing,seamless-migration=3Don=
 \
-device virtio-vga,id=3Dvideo0,virgl=3Don,max_outputs=3D1,bus=3Dpci.0,addr=
=3D0x2 \
-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny \
-msg timestamp=3Don

And these are the errors I see:

2020-02-14T09:06:18.183167Z qemu-system-x86_64: VFIO_MAP_DMA failed: Invali=
d argument
2020-02-14T09:10:49.753767Z qemu-system-x86_64: VFIO_MAP_DMA failed: Cannot=
 allocate memory
2020-02-14T09:11:04.530344Z qemu-system-x86_64: VFIO_MAP_DMA failed: No spa=
ce left on device
2020-02-14T09:11:04.531087Z qemu-system-x86_64: VFIO_MAP_DMA failed: No spa=
ce left on device
2020-02-14T09:11:04.531230Z qemu-system-x86_64: VFIO_MAP_DMA failed: No spa=
ce left on device


I'm doing nothing with the disk inside the guest, but:

  # dd if=3D/dev/vda of=3D/dev/null status=3Dprogress

(the disk appears as /dev/vda in the guest). Surprisingly, I do not see
these errors when I use the traditional PCI assignment (-device vfio-
pci). My versions of kernel and qemu:

moe ~ # uname -r
5.4.15-gentoo
moe ~ # /home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64 --=
version
QEMU emulator version 4.2.50 (v4.2.0-1439-g5d6542bea7-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863333

Title:
  Assigning NVMe disk to a domain causes VFIO_MAP_DMA errors

Status in QEMU:
  New

Bug description:
  I'm seeing some errors when assigning my NVMe disk to qemu. This is
  the full command line:

  =

  /home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64 \
  -name guest=3Dfedora,debug-threads=3Don \
  -S \
  -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-2-fedora/master-key.aes \
  -machine pc-i440fx-4.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
  -cpu host \
  -m size=3D4194304k,slots=3D16,maxmem=3D1099511627776k \
  -overcommit mem-lock=3Doff \
  -smp 4,sockets=3D1,dies=3D1,cores=3D2,threads=3D2 \
  -object iothread,id=3Diothread1 \
  -object iothread,id=3Diothread2 \
  -object iothread,id=3Diothread3 \
  -object iothread,id=3Diothread4 \
  -mem-prealloc \
  -mem-path /hugepages2M/libvirt/qemu/2-fedora \
  -numa node,nodeid=3D0,cpus=3D0,mem=3D4096 \
  -uuid 63840878-0deb-4095-97e6-fc444d9bc9fa \
  -no-user-config \
  -nodefaults \
  -chardev socket,id=3Dcharmonitor,fd=3D31,server,nowait \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dutc \
  -no-shutdown \
  -global PIIX4_PM.disable_s3=3D0 \
  -global PIIX4_PM.disable_s4=3D0 \
  -boot menu=3Don,strict=3Don \
  -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 \
  -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x4 \
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 \
  -blockdev '{"driver":"file","filename":"/var/lib/libvirt/images/fedora.qc=
ow2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap=
"}' \
  -blockdev '{"node-name":"libvirt-2-format","read-only":false,"discard":"u=
nmap","driver":"qcow2","file":"libvirt-2-storage","backing":null}' \
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=
=3Ddrive-scsi0-0-0-0,drive=3Dlibvirt-2-format,id=3Dscsi0-0-0-0,bootindex=3D=
1 \
  -blockdev '{"driver":"nvme","device":"0000:02:00.0","namespace":1,"node-n=
ame":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"ra=
w","file":"libvirt-1-storage"}' \
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Dlibvirt-=
1-format,id=3Dvirtio-disk0 \
  -netdev tap,fd=3D33,id=3Dhostnet0,vhost=3Don,vhostfd=3D34 \
  -device virtio-net-pci,host_mtu=3D9000,netdev=3Dhostnet0,id=3Dnet0,mac=3D=
52:54:00:a4:6f:91,bus=3Dpci.0,addr=3D0x3 \
  -chardev pty,id=3Dcharserial0 \
  -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
  -chardev socket,id=3Dcharchannel0,fd=3D35,server,nowait \
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
  -spice port=3D5900,addr=3D0.0.0.0,disable-ticketing,seamless-migration=3D=
on \
  -device virtio-vga,id=3Dvideo0,virgl=3Don,max_outputs=3D1,bus=3Dpci.0,add=
r=3D0x2 \
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 \
  -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourc=
econtrol=3Ddeny \
  -msg timestamp=3Don

  And these are the errors I see:

  2020-02-14T09:06:18.183167Z qemu-system-x86_64: VFIO_MAP_DMA failed: Inva=
lid argument
  2020-02-14T09:10:49.753767Z qemu-system-x86_64: VFIO_MAP_DMA failed: Cann=
ot allocate memory
  2020-02-14T09:11:04.530344Z qemu-system-x86_64: VFIO_MAP_DMA failed: No s=
pace left on device
  2020-02-14T09:11:04.531087Z qemu-system-x86_64: VFIO_MAP_DMA failed: No s=
pace left on device
  2020-02-14T09:11:04.531230Z qemu-system-x86_64: VFIO_MAP_DMA failed: No s=
pace left on device

  =

  I'm doing nothing with the disk inside the guest, but:

    # dd if=3D/dev/vda of=3D/dev/null status=3Dprogress

  (the disk appears as /dev/vda in the guest). Surprisingly, I do not
  see these errors when I use the traditional PCI assignment (-device
  vfio-pci). My versions of kernel and qemu:

  moe ~ # uname -r
  5.4.15-gentoo
  moe ~ # /home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64 =
--version
  QEMU emulator version 4.2.50 (v4.2.0-1439-g5d6542bea7-dirty)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863333/+subscriptions

