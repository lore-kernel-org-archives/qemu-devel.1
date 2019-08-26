Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCFDC3A5A4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D4620874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D4620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2HwS-0006ku-V6
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i2HoS-0001XT-RV
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i2HoR-0007ia-Ij
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:53736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i2HoR-0007gR-Co
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:25:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i2HoN-0002ca-Ly
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 16:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9E8D92E80D2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 16:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Aug 2019 16:16:32 -0000
From: Idar Lund <1839060@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: idarlund spheenik
X-Launchpad-Bug-Reporter: Martin Schrodt (spheenik)
X-Launchpad-Bug-Modifier: Idar Lund (idarlund)
References: <156507518934.25260.15982229597694445610.malonedeb@soybean.canonical.com>
Message-Id: <156683619283.2637.2069544007858832453.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19031";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 98664d38b098c7f47cb59ff92f8647f39ab19d98
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839060] Re: HDA device non functional in Windows
 10 1903
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
Reply-To: Bug 1839060 <1839060@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've got the same issue. Had to rollback to 1809.

The working driver is named:
10.0.17763.1 (WinBuild.160101.0800) from 14th sept 2018

The non-working driver is:
10.0.18362.1 (WinBuild.160101.0800) from 18th march 2019

My versions (both tested):
$ /opt/qemu4/bin/qemu-system-x86_64 --version
QEMU emulator version 4.1.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
$ qemu-system-x86_64 --version
QEMU emulator version 3.1.1 (qemu-3.1.1-2.fc30)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers


My qemu startup line is:
/path/to/correct/qemu-system-x86_64 \
-runas idarlund \
-name win10,process=3Dwin10 \
-machine type=3Dq35,accel=3Dkvm,kernel_irqchip=3Don \
-cpu host,kvm=3Doff,hv_vendor_id=3D1234567890ab,hv_vapic,hv_time,hv_relaxed=
,hv_spinlocks=3D0x1fff,l3-cache=3Don,-hypervisor,migratable=3Dno,+invtsc \
-smp 12,sockets=3D1,cores=3D12,threads=3D1 \
-m 24G \
-rtc clock=3Dhost,base=3Dlocaltime \
-vga none \
-nographic \
-serial none \
-parallel none \
-usb \
-soundhw hda \
-device vfio-pci,host=3D2a:00.0,multifunction=3Don \
-object input-linux,id=3Dmouse1,evdev=3D/dev/input/by-id/usb-Logitech_Gamin=
g_Mouse_G402_6D8A12705348-event-mouse \
-object input-linux,id=3Dkbd1,evdev=3D/dev/input/by-id/usb-Logitech_HID_com=
pliant_keyboard-event-kbd,grab_all=3Don,repeat=3Don \
-device ivshmem-plain,memdev=3Divshmem,bus=3Dpcie.0 \
-object memory-backend-file,id=3Divshmem,share=3Don,mem-path=3D/dev/shm/loo=
king-glass,size=3D128M \
-audiodev pa,id=3Dpa1,server=3D/run/user/1000/pulse/native \
-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/OVMF/OVMF_CODE.f=
d \
-drive if=3Dpflash,format=3Draw,file=3D/tmp/my_vars.fd \
-boot order=3Ddc \
-drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Dqcow2,aio=3Dthreads,fil=
e=3D/var/lib/libvirt/images/windowstest.qcow2 \
-netdev type=3Dbridge,id=3Dnet0,br=3Dvirbr1 \
-device e1000,netdev=3Dnet0,mac=3D00:16:3e:00:08:02

I'm not sure if this bug report should be reported to qemu tho. We
should probably file a bug report to Microsoft as well.

** Also affects: fedora
   Importance: Undecided
       Status: New

** No longer affects: fedora

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839060

Title:
  HDA device non functional in Windows 10 1903

Status in QEMU:
  New

Bug description:
  I made the update to 1903, and the HDA device stopped working.

  The driver says the device is working correctly, but it does not.
  When I try to open the Windows sound configuration, the dialog hangs and =
never shows it's content.

  Several people reported this back in May:

  https://windowsreport.com/windows-10-v1903-ich6-ich9-virtio/

  I can confirm I have exactly the same problem.

  Host is Arch Linux, current (5.2.5) kernel, QEMU 4.0.

  I enabled HDA debug output and compared an older, working Windows
  version to 1903, but could not see the difference. The driver seems to
  issue the same verbs.

  I am happy to provide additional information if needed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839060/+subscriptions

