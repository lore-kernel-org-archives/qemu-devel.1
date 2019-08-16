Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B79C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B67D2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B67D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUSX-0002Mr-S1
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUQu-0000dv-0y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUQs-00054y-PO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:52670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUQs-00054E-Jx
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUQr-0003fN-B7
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:05:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 524BB2E80CC
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:05:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 04:55:53 -0000
From: Thomas Huth <1826422@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=alex.l.williamson@gmail.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson saveriomiroddi th-huth
X-Launchpad-Bug-Reporter: Saverio Miroddi (saveriomiroddi)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155620554968.6380.13610580395862407350.malonedeb@chaenomeles.canonical.com>
Message-Id: <156593135329.22489.17924984318547873573.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 5db2adea9f61c7603218157dd64b3cc37c863cc8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826422] Re: Regression: QEMU 4.0 hangs the host
 (*bisect included*)
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
Reply-To: Bug 1826422 <1826422@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix has been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dc87759ce876a7a0b17c2b

** Changed in: qemu
       Status: In Progress =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826422

Title:
  Regression: QEMU 4.0 hangs the host (*bisect included*)

Status in QEMU:
  Fix Released

Bug description:
  The commit b2fc91db84470a78f8e93f5b5f913c17188792c8 seemingly
  introduced a regression on my system.

  When I start QEMU, the guest and the host hang (I need a hard reset to
  get back to a working system), before anything shows on the guest.

  I use QEMU with GPU passthrough (which worked perfectly until the
  commit above). This is the command I use:

  ```
  /path/to/qemu-system-x86_64
    -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.fd
    -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
    -enable-kvm
    -machine q35,accel=3Dkvm,mem-merge=3Doff
    -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinlocks=
=3D0x1fff,hv_vapic,hv_time
    -smp 4,cores=3D4,sockets=3D1,threads=3D1
    -m 10240
    -vga none
    -rtc base=3Dlocaltime
    -serial none
    -parallel none
    -usb
    -device usb-tablet
    -device vfio-pci,host=3D01:00.0,multifunction=3Don
    -device vfio-pci,host=3D01:00.1
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device virtio-scsi-pci,id=3Dscsi
    -drive file=3D/path/to/guest.img,id=3Dhdd1,format=3Dqcow2,if=3Dnone,cac=
he=3Dwriteback
    -device scsi-hd,drive=3Dhdd1
    -net nic,model=3Dvirtio
    -net user,smb=3D/path/to/shared
  ```

  If I run QEMU without GPU passthrough, it runs fine.

  Some details about my system:

  - O/S: Mint 19.1 x86-64 (it's based on Ubuntu 18.04)
  - Kernel: 4.15
  - `configure` options: `--target-list=3Dx86_64-softmmu --enable-gtk --ena=
ble-spice --audio-drv-list=3Dpa`
  - EDK2 version: 1a734ed85fda71630c795832e6d24ea560caf739 (20/Apr/2019)
  - CPU: i7-6700k
  - Motherboard: ASRock Z170 Gaming-ITX/ac
  - VGA: Gigabyte GTX 960 Mini-ITX

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826422/+subscriptions

