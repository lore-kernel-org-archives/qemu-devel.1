Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251CC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E052F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E052F2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuuNr-0001E0-4W
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 03:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuuMm-0000Ld-W8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuuMl-0001Wl-D0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:31:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:41510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuuMj-0001Rg-B5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:30:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuuMg-0002dH-Ga
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7C6CA2E80D3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jan 2020 08:16:06 -0000
From: Ildar <1860759@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ildar-users
X-Launchpad-Bug-Reporter: Ildar (ildar-users)
X-Launchpad-Bug-Modifier: Ildar (ildar-users)
Message-Id: <157985376657.5102.13233182944615356318.malonedeb@wampee.canonical.com>
Subject: [Bug 1860759] [NEW] [REGRESSION] option `-snapshot` ignored with
 blockdev
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8773996e09b039b1889b5b7548d7ffbbb70827ac
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
Reply-To: Bug 1860759 <1860759@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

After upgrade of qemu 3.1.0 =E2=86=92 4.2.0 I found that running with libvi=
rt doesn't honor `-snapshot` option anymore. I.e. disk images get modified.
Using `-hda` option honors `-snapshot`

So I made a test case without libvirt. Testcase using 4.2.0:

> qemu -hda tmp-16G.img -cdrom regular-rescue-latest-x86_64.iso -m 2G

This works fine and tmp-16G.img stays unmodified.

But:
> /usr/bin/qemu-system-x86_64 -name guest=3Dtest-linux,debug-threads=3Don -=
S -machine pc-i440fx-3.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=
=3Doff -cpu Broadwell-noTSX,vme=3Don,ss=3Don,f16c=3Don,rdrand=3Don,hypervis=
or=3Don,arat=3Don,tsc-adjust=3Don,xsaveopt=3Don,pdpe1gb=3Don,abm=3Don -m 20=
48 -overcommit mem-lock=3Doff -smp 3,sockets=3D3,cores=3D1,threads=3D1 -uui=
d d32a9191-f51d-4fae-a419-b73d85b49198 -no-user-config -nodefaults -rtc bas=
e=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -=
no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1=
 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0=
x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multi=
function=3Don,addr=3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=
=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,fi=
rstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -blockdev \{\"driver\":\"file\",\"fi=
lename\":\"/tmp/regular-rescue-latest-x86_64.iso\",\"node-name\":\"libvirt-=
2-storage\",\"auto-read-only\":true,\"discard\":\"unmap\"} -blockdev \{\"no=
de-name\":\"libvirt-2-format\",\"read-only\":true,\"driver\":\"raw\",\"file=
\":\"libvirt-2-storage\"} -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Dlibvi=
rt-2-format,id=3Dide0-0-0,bootindex=3D1 -blockdev \{\"driver\":\"file\",\"f=
ilename\":\"/tmp/tmp-2G.img\",\"node-name\":\"libvirt-1-storage\",\"auto-re=
ad-only\":true,\"discard\":\"unmap\"} -blockdev \{\"node-name\":\"libvirt-1=
-format\",\"read-only\":false,\"driver\":\"qcow2\",\"file\":\"libvirt-1-sto=
rage\",\"backing\":null} -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=
=3D0x7,drive=3Dlibvirt-1-format,id=3Dvirtio-disk0 -netdev user,id=3Dhostnet=
0 -device e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:ab:d8:29,bus=3Dp=
ci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3D=
charserial0,id=3Dserial0 -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vr=
am_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3D=
pci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -devi=
ce hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -device virtio-ball=
oon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6 -snapshot -sandbox on,obsolete=
=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg t=
imestamp=3Don

This modifies tmp-16G.img.

** Affects: qemu
     Importance: Undecided
         Status: New

** Bug watch added: Red Hat Bugzilla #508662
   https://bugzilla.redhat.com/show_bug.cgi?id=3D508662

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860759

Title:
  [REGRESSION] option `-snapshot` ignored with blockdev

Status in QEMU:
  New

Bug description:
  After upgrade of qemu 3.1.0 =E2=86=92 4.2.0 I found that running with lib=
virt doesn't honor `-snapshot` option anymore. I.e. disk images get modifie=
d.
  Using `-hda` option honors `-snapshot`

  So I made a test case without libvirt. Testcase using 4.2.0:

  > qemu -hda tmp-16G.img -cdrom regular-rescue-latest-x86_64.iso -m 2G

  This works fine and tmp-16G.img stays unmodified.

  But:
  > /usr/bin/qemu-system-x86_64 -name guest=3Dtest-linux,debug-threads=3Don=
 -S -machine pc-i440fx-3.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-co=
re=3Doff -cpu Broadwell-noTSX,vme=3Don,ss=3Don,f16c=3Don,rdrand=3Don,hyperv=
isor=3Don,arat=3Don,tsc-adjust=3Don,xsaveopt=3Don,pdpe1gb=3Don,abm=3Don -m =
2048 -overcommit mem-lock=3Doff -smp 3,sockets=3D3,cores=3D1,threads=3D1 -u=
uid d32a9191-f51d-4fae-a419-b73d85b49198 -no-user-config -nodefaults -rtc b=
ase=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet=
 -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=
=3D1 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0=
x5.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,m=
ultifunction=3Don,addr=3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,first=
port=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.=
0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -blockdev \{\"driver\":\"file\",=
\"filename\":\"/tmp/regular-rescue-latest-x86_64.iso\",\"node-name\":\"libv=
irt-2-storage\",\"auto-read-only\":true,\"discard\":\"unmap\"} -blockdev \{=
\"node-name\":\"libvirt-2-format\",\"read-only\":true,\"driver\":\"raw\",\"=
file\":\"libvirt-2-storage\"} -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Dl=
ibvirt-2-format,id=3Dide0-0-0,bootindex=3D1 -blockdev \{\"driver\":\"file\"=
,\"filename\":\"/tmp/tmp-2G.img\",\"node-name\":\"libvirt-1-storage\",\"aut=
o-read-only\":true,\"discard\":\"unmap\"} -blockdev \{\"node-name\":\"libvi=
rt-1-format\",\"read-only\":false,\"driver\":\"qcow2\",\"file\":\"libvirt-1=
-storage\",\"backing\":null} -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,=
addr=3D0x7,drive=3Dlibvirt-1-format,id=3Dvirtio-disk0 -netdev user,id=3Dhos=
tnet0 -device e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:ab:d8:29,bus=
=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,charde=
v=3Dcharserial0,id=3Dserial0 -device qxl-vga,id=3Dvideo0,ram_size=3D6710886=
4,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bu=
s=3Dpci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -=
device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -device virtio-=
balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6 -snapshot -sandbox on,obso=
lete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -m=
sg timestamp=3Don

  This modifies tmp-16G.img.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860759/+subscriptions

