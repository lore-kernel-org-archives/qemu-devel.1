Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AD9C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D53206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D53206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJJ0Q-0000Pz-Ay
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 11:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iJIZh-0004CY-7O
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iJIZe-00071T-EN
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:54450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iJIZe-000708-7r
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:40:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iJIZd-0003wz-Ar
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 14:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 510492E8074
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 14:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Oct 2019 14:35:38 -0000
From: Emanuele Faranda <black.silver@hotmail.it>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: black-silver
X-Launchpad-Bug-Reporter: Emanuele Faranda (black-silver)
X-Launchpad-Bug-Modifier: Emanuele Faranda (black-silver)
References: <157089035721.2099.14904442368526379360.malonedeb@wampee.canonical.com>
Message-Id: <157089093832.16222.11810665541417407395.malone@soybean.canonical.com>
Subject: [Bug 1847861] Re: Guest stuttering under high disk IO (virtio)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7fde03616b1dcd676b7faa68300e191ae8f485ea
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sat, 12 Oct 2019 11:06:39 -0400
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
Reply-To: Bug 1847861 <1847861@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You can find my libvirt XML attached. Here is the full qemu command
(taken from the ps output):

/usr/bin/qemu-system-x86_64 -name guest=3Dwin10,debug-threads=3Don -S
-object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-7-w=
in10
/master-key.aes -machine pc-q35-3.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-
guest-core=3Doff -cpu host,topoext=3Don,hv-time,hv-relaxed,hv-vapic,hv-
spinlocks=3D0x1fff -drive
file=3D/usr/share/ovmf/x64/OVMF_CODE.fd,if=3Dpflash,format=3Draw,unit=3D0,r=
eadonly=3Don
-drive
file=3D/var/lib/libvirt/qemu/nvram/win10_VARS.fd,if=3Dpflash,format=3Draw,u=
nit=3D1
-m 8192 -overcommit mem-lock=3Doff -smp 16,sockets=3D1,cores=3D8,threads=3D2
-object iothread,id=3Diothread1 -mem-prealloc -mem-path
/dev/hugepages/libvirt/qemu/7-win10 -numa
node,nodeid=3D0,cpus=3D0-7,mem=3D4096 -numa node,nodeid=3D1,cpus=3D8-15,mem=
=3D4096
-uuid d1c03f35-3846-4b76-a139-b798b497b95c -display none -no-user-config
-nodefaults -chardev socket,id=3Dcharmonitor,fd=3D34,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -=
no-
hpet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device pcie-root-
port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,add=
r=3D0x2
-device pcie-root-
port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x2.0x1 -device=
 pcie-
root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x2.0x2 -d=
evice
pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0=
x3
-device pcie-root-
port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x4 -device=
 pcie-
root-port,port=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x5 -d=
evice
pcie-root-port,port=3D0x16,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0=
x6
-device pcie-root-
port,port=3D0x17,chassis=3D8,id=3Dpci.8,bus=3Dpcie.0,addr=3D0x2.0x7 -device=
 pcie-
root-
port,port=3D0x18,chassis=3D9,id=3Dpci.9,bus=3Dpcie.0,multifunction=3Don,add=
r=3D0x3
-device pcie-root-
port,port=3D0x19,chassis=3D10,id=3Dpci.10,bus=3Dpcie.0,addr=3D0x3.0x1 -devi=
ce
pcie-pci-bridge,id=3Dpci.11,bus=3Dpci.3,addr=3D0x0 -device qemu-
xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device
lsi,id=3Dscsi0,bus=3Dpci.11,addr=3D0x1 -drive
file=3D/dev/nvme0n1p3,format=3Draw,if=3Dnone,id=3Ddrive-virtio-
disk0,cache=3Dnone,aio=3Dthreads -device virtio-blk-
pci,scsi=3Doff,bus=3Dpci.8,addr=3D0x0,drive=3Ddrive-virtio-disk0,id=3Dvirti=
o-
disk0,bootindex=3D1,write-cache=3Don -drive if=3Dnone,id=3Ddrive-
sata0-0-0,readonly=3Don -device ide-cd,bus=3Dide.0,drive=3Ddrive-
sata0-0-0,id=3Dsata0-0-0 -netdev tap,fd=3D37,id=3Dhostnet0,vhost=3Don,vhost=
fd=3D38
-device virtio-net-
pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:7c:10:fc,bus=3Dpci.1,addr=3D=
0x0
-chardev pty,id=3Dcharserial0 -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device vfio-
pci,host=3D41:00.0,id=3Dhostdev0,bus=3Dpci.4,addr=3D0x0 -device vfio-
pci,host=3D41:00.1,id=3Dhostdev1,bus=3Dpci.5,addr=3D0x0 -device virtio-ball=
oon-
pci,id=3Dballoon0,bus=3Dpci.6,addr=3D0x0 -object input-
linux,id=3Dmouse1,evdev=3D/dev/input/by-path/pci-0000:42:00.3-usb-0:3:1.0
-event-mouse -object input-linux,id=3Dkbd1,evdev=3D/dev/input/by-
path/pci-0000:42:00.3-usb-0:4:1.0-event-kbd,grab_all=3Don,repeat=3Don
-sandbox
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny
-msg timestamp=3Don

Additional note: the performance of fio in the linux host is about 2x
the one on the guest:

fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --gtod_reduce=3D1
--name=3Dtest --filename=3D/dev/nvme0n1 --bs=3D4k --iodepth=3D64 --size=3D5=
12M
--readwrite=3Drandread

read: IOPS=3D279k, BW=3D1092MiB/s (1145MB/s)(512MiB/469msec)

** Attachment added: "win10.xml"
   https://bugs.launchpad.net/qemu/+bug/1847861/+attachment/5296726/+files/=
win10.xml

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847861

Title:
  Guest stuttering under high disk IO (virtio)

Status in QEMU:
  New

Bug description:
  Performing io intensive tasks on virtualized Windows causes the system
  to visually stutter. I can often reproduce the problem by running fio
  on windows:

  fio --randrepeat=3D1 --ioengine=3Dwindowsaio --direct=3D1 --gtod_reduce=
=3D1
  --name=3Dtest --filename=3D\\.\PhysicalDrive0 --bs=3D4k --iodepth=3D128
  --size=3D4G --readwrite=3Drandread

  While the fio command is running, moving the mouse pointer will be be
  laggy. The stuttering does not appear with iodepth <=3D 32 . The
  stuttering also manifests while playing games, the music and video
  pauses for a fraction of second in a playable but disturbing way.

  Here are my system specs:

  Host OS: archlinux
  Guest OS: Windows 10 Enterprise
  qemu version: qemu-git 8:v4.1.0.r1378.g98b2e3c9ab-1 (from AUR, compiled w=
ith -march=3Dnative)
  CPU: AMD Ryzen Threadripper 1900X 8-Core Processor
  Huge Pages: vm.nr_hugepages=3D4128
  Disk: nvme type=3Draw, io=3Dthreads bus=3Dvirtio
  GPU (passthrough): Radeon RX 570

  Here are some fio test results on my windows guest:

  [size=3D512M,iodepth=3D1 -> min=3D30k,avg=3D31k,stddev=3D508]
  [size=3D2G,iodepth=3D8 -> min=3D203k,avg=3D207k,stddev=3D2.3k]
  [size=3D2G,iodepth=3D16 -> min=3D320k,avg=3D330k,stddev=3D4.3k]
  [size=3D4G,iodepth=3D32 -> min=3D300k,avg=3D310k,stddev=3D4.8k]
  [size=3D4G,iodepth=3D64 -> min=3D278k,avg=3D366k,stddev=3D68.6k] -> STUTT=
ER
  [size=3D4G,iodepth=3D64 -> min=3D358k,avg=3D428k,stddev=3D52.6k] -> STUTT=
ER
  [size=3D4G,iodepth=3D128 -> min=3D92k,avg=3D217k,stddev=3D185k] -> STUTTER
  [size=3D4G,iodepth=3D128 -> min=3D241k,avg=3D257k,stddev=3D14k] -> same c=
onfig as above, but no stuttering

  The min and avg values are the bandwidth values reported in KB/s by
  fio. You can see that, when the stuttering occurs, the stardard
  deviation is high and the minimum bandwidth is way below the average.

  Additional note: the bandwidth reported with `fio` on my linux host is
  about 2x the one reported in the guest:

  sudo fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --gtod_reduce=
=3D1
  --name=3Dtest --filename=3D/dev/nvme0n1 --bs=3D4k --iodepth=3D64 --size=
=3D512M
  --readwrite=3Drandread

  read: IOPS=3D279k, BW=3D1092MiB/s (1145MB/s)(512MiB/469msec)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847861/+subscriptions

