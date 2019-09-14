Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61603C49ED6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 04:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B3A20693
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 04:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B3A20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8zjh-0007Jt-AY
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 00:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8zhE-0006Ew-Sk
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8zhB-0006DP-7y
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:30:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:39274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8zhB-00062l-2e
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:30:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8zh8-0008D1-Cv
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 49ED82E8084
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 04:29:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Sep 2019 04:17:25 -0000
From: Launchpad Bug Tracker <1606899@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: freddy77 janitor lersek th-huth
X-Launchpad-Bug-Reporter: Frediano Ziglio (freddy77)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160727115911.17233.55909.malonedeb@wampee.canonical.com>
Message-Id: <156843464539.4426.17925080327585241766.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6cbaa053ff08072e9b9b1df8e8832240f1da2de5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1606899] Re: virtio-vga does not let guest
 poweroff properly
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
Reply-To: Bug 1606899 <1606899@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1606899

Title:
  virtio-vga does not let guest poweroff properly

Status in QEMU:
  Expired

Bug description:
  I have a VM running rawhide (Fedora development) and I can't poweroff
  the machine when I enable virtio-vga. Reboot works correctly. Using
  QXL works also. The machine arrive to print the "Powering off" message
  (from Linux kernel) but then hangs.

  The command line is

  /usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name rawhide -machine
  pc-i440fx-2.3,accel=3Dkvm,usb=3Doff -cpu Haswell-noTSX -m 2048 -realtime
  mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid
  64216421-aec4-4ce4-aa52-aed9e4e31a1c -no-user-config -nodefaults
  -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/rawhide.monitor,serv=
er,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddiscard -no-
  hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
  PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device ich9-usb-
  ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 -device ich9-usb-
  uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x6
  -device ich9-usb-
  uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x6.0x1 -device =
ich9
  -usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x6.0x2 -de=
vice
  virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -drive
  file=3D/home/rawhide.qcow2,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqco=
w2
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-vi=
rtio-
  disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
  ide0-0-0,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-
  ide0-0-0,id=3Dide0-0-0 -netdev user,id=3Dhostnet0 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:fc:11:43,bus=3Dpci.0,addr=
=3D0x3
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/channel/target/rawh=
ide.org.qemu.guest_agent.0,server,nowait
  -device virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.gue=
st_agent.0
  -chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent -device
  virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0 -spice ipv4,addr=3D0.0.0.0,port=3D5900
  ,disable-ticketing,image-compression=3Dlz,seamless-migration=3Don
  ,streaming-video=3Dfilter -device virtio-vga,bus=3Dpci.0,addr=3D0x2 -devi=
ce
  intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1 -device virtio-balloon-
  pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don

  I though was due to Virgl but disabling it does not change.

  I'm using Qemu 2.6.0 from Fedora 24.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1606899/+subscriptions

