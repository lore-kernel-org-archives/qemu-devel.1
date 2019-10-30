Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15164CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 12:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A4820862
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 12:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A4820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPmph-0003Rt-Tz
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 08:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iPmox-0002sh-BH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 08:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iPmov-0004SV-Rh
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 08:11:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:53052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iPmov-0004R5-I1
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 08:11:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iPmos-0005c3-OW
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 12:11:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AD57C2E80CE
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 12:11:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2019 11:56:36 -0000
From: Matti Hameister <1847793@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: c-paetow dgilbert-h lersek mattihami psyhomb
 sej7278 xanclic
X-Launchpad-Bug-Reporter: Claus Paetow (c-paetow)
X-Launchpad-Bug-Modifier: Matti Hameister (mattihami)
References: <157080798335.681.12255731732435282400.malonedeb@chaenomeles.canonical.com>
Message-Id: <157243659639.29370.12703072921528821189.malone@soybean.canonical.com>
Subject: [Bug 1847793] Re: qemu 4.1.0 - Corrupt guest filesystem after new vm
 install
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0f1b936031251a4626e8f76b890b5922704f5eeb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1847793 <1847793@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have the same (related?) issue and wanted to add my experience with it. I=
 had 3 qemu qcow2 VM running on ArchLinux. I never used snapshots or someth=
ing like it. Just normal start&shutdown. 2 of these VMs were also ArchLinux=
 running on ext4. Both of these VMs had a data corruption inside the quest.=
 The data being corrupted were files I had not touched in month (large tar =
archives). One guest was running on a SSD with discard, the other VM was ru=
nning on a normal hard drive without any discard.
The last VM was a Windows 10 VM. While the VM was running fine, after "fixi=
ng" the image issues with qemu-img -r all hdd.qcow2 the Windows 10 installa=
tion was unbootable and beyond repair with normal Windows tools.

While the VMs are running I saw these lines printed by qemu (for all VMs
in question):

qcow2_free_clusters failed: Invalid argument
qcow2_free_clusters failed: Invalid argument
qcow2_free_clusters failed: Invalid argument

I recreated my VMs and I now chose btrfs as a filesystem. No issues yet
on the image. I also recreated the Windows 10 VM. It worked fine a
couple of days. Today I checked the image, after I saw the free_clusters
lines above again:

Many many lines like this:
Leaked cluster 260703 refcount=3D1 reference=3D0                           =
                        =

ERROR cluster 260739 refcount=3D0 reference=3D1 =

ERROR OFLAG_COPIED data cluster: l2_entry=3D800000038ec10000 refcount=3D0

638 errors were found on the image.
Data may be corrupted, or further writes to the image may corrupt it.

339 leaked clusters were found on the image.
This means waste of disk space, but no harm to data.
314734/4096000 =3D 7.68% allocated, 26.70% fragmented, 0.00% compressed clu=
sters
Image end offset: 21138374656

The installation itself still works but I don't know if there are any
silently corrupted files in there.

QEMU 4.1.0 from ArchLinux
Host-Filesystem is ext4
Start-Parameter (the same on all VMs):

qemu-system-x86_64 -cpu Haswell-noTSX -M q35 -enable-kvm -smp
4,cores=3D4,threads=3D1,sockets=3D1 -net nic,model=3Dvirtio -net
user,hostname=3DWindowsKVM.local -drive
if=3Dnone,id=3Dhd,file=3Dhdd.qcow2,discard=3Dunmap -device virtio-scsi-
pci,id=3Dscsi --enable-kvm -device scsi-hd,drive=3Dhd -m 4096 -drive
if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/ovmf/x64/OVMF_CODE.fd
-drive if=3Dpflash,format=3Draw,file=3D./OVMF_VARS.fd -vga std -drive
file=3DWindows10ISO/Windows.iso,index=3D0,media=3Dcdrom -drive file=3Dvirti=
o-
win-0.1.173.iso,index=3D1,media=3Dcdrom -no-quit

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847793

Title:
  qemu 4.1.0 - Corrupt guest filesystem after new vm install

Status in QEMU:
  New

Bug description:
  When I install a new vm with qemu 4.1.0 all the guest filesystems are
  corrupt. The first boot from the install dvd iso is ok and the
  installer work fine. But the guest system hangs after the installer
  finishes and I reboot the guest. I can see the grub boot menue but the
  system cannot load the initramfs.

  Testet with:
  - RedHat Enterprise Linux 7.5, 7.6 and 7.7 (RedHat uses xfs for the /boot=
 and / partition)
  Guided install with the graphical installer, no lvm selected.
  - Debian Stable/Buster (Debian uses ext4 for / and /home partition)
  Guidet install with the graphical installer and default options.

  Used commandline to create the vm disk image:
  qemu-img create -f qcow2 /volumes/disk2-part2/vmdisks/vmtest10-1.qcow2 20G

  Used qemu commandline for vm installation:
  #!/bin/sh
  # vmtest10 Installation
  #
  /usr/bin/qemu-system-x86_64  -cpu SandyBridge-IBRS \
      -soundhw hda \
      -M q35 \
      -k de \
      -vga qxl \
      -machine accel=3Dkvm \
      -m 4096 \
      -display gtk \
      -drive file=3D/volumes/disk2-part2/images/debian-10.0.0-amd64-DVD-1.i=
so,if=3Dide,media=3Dcdrom \
      -drive file=3D/volumes/disk2-part2/images/vmtest10-1.qcow2,if=3Dvirti=
o,media=3Ddisk,cache=3Dwriteback \
      -boot once=3Dd,menu=3Doff \
      -device virtio-net-pci,mac=3D52:54:00:2c:02:6c,netdev=3Dvlan0 \
      -netdev bridge,br=3Dbr0,id=3Dvlan0 \
      -rtc base=3Dlocaltime \
      -name "vmtest10" \
      -usb -device usb-tablet \
      -spice disable-ticketing \
      -device virtio-serial-pci \
      -device virtserialport,chardev=3Dspicechannel0,name=3Dcom.redhat.spic=
e.0 \
      -chardev spicevmc,id=3Dspicechannel0,name=3Dvdagent $*

  Host OS:
  Archlinux (last updated at 10.10.2019)
  Linux testing 5.3.5-arch1-1-ARCH #1 SMP PREEMPT Mon Oct 7 19:03:08 UTC 20=
19 x86_64 GNU/Linux
  No libvirt in use.

  =

  With qemu 4.0.0 it works fine without any errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847793/+subscriptions

