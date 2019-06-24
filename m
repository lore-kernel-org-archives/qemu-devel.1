Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA8C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A837C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A837C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfIIy-0003SV-U7
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hfIGl-0001uy-6m
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hfIGj-00036R-7M
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:15:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:54310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hfIGh-0002z2-Bh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:15:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hfIGd-0003G7-Q0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:15:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B80292E80C7
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:15:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jun 2019 06:06:28 -0000
From: Alex <1833053@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: crash qemu spice usbredir
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gsanic hijacker-c
X-Launchpad-Bug-Reporter: Nikolay Kichukov (hijacker-c)
X-Launchpad-Bug-Modifier: Alex (gsanic)
References: <156076455835.24347.5065510387911666481.malonedeb@gac.canonical.com>
Message-Id: <156135638888.18276.13440248414787508100.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18989";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 40a6d0aff33a908fb7944dea56e09ce6f49d1419
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1833053] Re: qemu guest crashes on spice client
 USB redirected device removal
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
Reply-To: Bug 1833053 <1833053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
I have the same qemu behaviour. It happens every time I have unplugged phys=
ical usb device attached to guest from the host system. My device is USB GS=
M dongle. Some times it disconnects and reconnects again for unknown reason=
, may be power loss... With version 3.1.0 qemu (gentoo linux) this disconne=
cts had normal USB device disconnects in guest system. But with version 4.0=
.0 it gets guest VM to crash.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833053

Title:
  qemu guest crashes on spice client USB redirected device removal

Status in QEMU:
  New

Bug description:
  Hello,

  I am experiencing guest crashes, which cannot be reproduced at all
  times, but are pretty frequent (4 out of 5 tries it would crash). The
  guest crashes when a previously attached USB redirected device through
  SPICE has been removed by the client.

  Steps to reproduce:
  1.) Start windows 10 guest with display driver Spice
  2.) Connect to the console with remote-viewer spice://IP:PORT or via virt=
-viewer (tunnelled through SSH)
  3.) Attach a client USB device, for example storage device, iPhone or And=
roid phone
  4.) Observe the guest OS detects it and sets it up
  5.) Go back to 'USB device selection' and untick the USB device
  6.) Observe the guest VM crashed and the below assertion was printed in t=
he qemu log for this virtual machine:

  qemu-system-x86_64: /var/tmp/portage/app-emulation/qemu-4.0.0-r3/work/qem=
u-4.0.0/hw/usb/core.c:720: usb_ep_get: Assertion `dev !=3D NULL' failed.
  2019-06-17 09:25:09.160+0000: shutting down, reason=3Dcrashed

  =

  Versions of related packages on the host:
  app-emulation/qemu-4.0.0-r3
  app-emulation/spice-0.14.0-r2:0
  app-emulation/spice-protocol-0.12.14:0
  net-misc/spice-gtk-0.35:0
  Kernel: 5.1.7-gentoo on Intel x86_64 CPU

  Version of the spice-tools on the guest:
  virtio-win 0.1-126
  QXL 0.1-21
  mingw-vdagent-win 0.8.0

  QEMU command line (generated by libvirt):

  /usr/bin/qemu-system-x86_64 -name guest=3DW10VM,debug-threads=3Don -S
  -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-4=
1-W10VM
  /master-key.aes -machine pc-i440fx-2.12,accel=3Dkvm,usb=3Doff,vmport=3Doff
  ,dump-guest-core=3Doff -cpu
  qemu64,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff,hv_synic,hv_stim=
er
  -m 4500 -realtime mlock=3Doff -smp
  2,maxcpus=3D4,sockets=3D4,cores=3D1,threads=3D1 -uuid b39afae2-5085-4659-=
891c-
  b3c65e65af2e -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,fd=3D26,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -no-hpet -global kvm-
  pit.lost_tick_policy=3Ddelay -no-shutdown -global PIIX4_PM.disable_s3=3D1
  -global PIIX4_PM.disable_s4=3D1 -boot menu=3Doff,strict=3Don -device ich9
  -usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ich9-usb-
  uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x5
  -device ich9-usb-
  uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device =
ich9
  -usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -de=
vice
  virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x8 -device virtio-serial-
  pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive
  file=3D/libvirt/images/W10VM.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-
  scsi0-0-0-1,cache=3Dunsafe,discard=3Dunmap,detect-zeroes=3Dunmap -device
  scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Ddrive-
  scsi0-0-0-1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1,bootindex=3D1,writ=
e-
  cache=3Don -netdev tap,fd=3D28,id=3Dhostnet0,vhost=3Don,vhostfd=3D29 -dev=
ice
  virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:44:f6:21,bus=3Dpci.0,addr=
=3D0x3
  -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device
  virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -chardev socket,id=3Dcharchannel1,fd=3D30,server,nowait -device
  virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D3,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dorg.qemu.gue=
st_agent.0
  -chardev spiceport,id=3Dcharchannel2,name=3Dorg.spice-space.webdav.0
  -device virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D2,chardev=3Dcharchannel2,id=3Dchannel2,name=3Dorg.spice-
  space.webdav.0 -spice port=3D5901,addr=3D0.0.0.0,seamless-migration=3Don
  -device qxl-
  vga,id=3Dvideo0,ram_size=3D134217728,vram_size=3D134217728,vram64_size_mb=
=3D0,vgamem_mb=3D64,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
  -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D2 -device virti=
o-
  balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -sandbox
  on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny
  -msg timestamp=3Don

  =

  I have attempted to collect a backtrace, but will need direction as I am =
not sure on which thread to listen and where to set the breakpoint, 'thread=
 apply all backtrace' does not seem to work well with the qemu process...

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833053/+subscriptions

