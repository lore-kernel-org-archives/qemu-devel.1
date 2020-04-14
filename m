Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2D0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7BF20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7BF20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOFxj-00015n-8B
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jOFx3-0000Yv-Qr
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jOFx2-0006N0-En
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:25:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:47520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jOFx2-0006Ma-9M
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jOFx0-0001oa-Uc
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E20512E80E7
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2020 07:19:20 -0000
From: JS <1872644@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: js1943
X-Launchpad-Bug-Reporter: JS (js1943)
X-Launchpad-Bug-Modifier: JS (js1943)
Message-Id: <158684876015.5950.10208526082243977591.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1872644] [NEW] MacOS host qemu-system-x86_64 -cpu host not
 working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3b0c1df82d8171a7ba68ced9e2c8b75988016957
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
Reply-To: Bug 1872644 <1872644@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

MacOS: 10.15.4
uname -a: Linux door 4.15.0-96-generic #97-Ubuntu SMP Wed Apr 1 03:25:46 UT=
C 2020 x86_64 x86_64 x86_64 GNU/Linux

I am using qemu on mac host, with ubuntu client.

I used to have "-cpu host" in my qemu command as follow:-

qemu-system-x86_64 \
-no-user-config \
-nodefaults \
-name u64d01 \
-show-cursor \
-M q35,accel=3Dhvf,usb=3Doff,vmport=3Doff \
-cpu host \
-m 8192M \
-smp 4 \
-rtc base=3Dutc,clock=3Dhost \
-device virtio-blk-pci,drive=3Dssd1 \
-drive id=3Dssd1,file=3D/Users/js/code/vm/qemu/u64d01.qcow2,if=3Dnone,forma=
t=3Dqcow2 \
-device virtio-net-pci,netdev=3Dnic1,mac=3D52:54:98:76:54:33 \
-netdev user,id=3Dnic1,ipv4=3Don,ipv6=3Don,hostname=3Du64d01,hostfwd=3Dtcp:=
:2222-:22 \
-device virtio-tablet-pci \
-device virtio-vga \
-device ich9-intel-hda,id=3Dsnd,msi=3Don \
-device hda-output,id=3Dsnd-codec0,bus=3Dsnd.0,cad=3D0,audiodev=3Dsnd0 \
-audiodev coreaudio,id=3Dsnd0

Base on log of one of the vm, it was definitely working on
2020-01-17(base on journal inside vm), with qemu 4.2.0, which I
installed with brew.

The only way to make it work is to remove "-cpu host".

Already tried with 4.1.1, 4.2 and 5.0rc2. Same result.

To reproduce, try above with a Ubuntu 18.04 installation cd. Client will
crash during kernel loading.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "kernel_boot_crash.txt"
   https://bugs.launchpad.net/bugs/1872644/+attachment/5353690/+files/kerne=
l_boot_crash.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872644

Title:
  MacOS host qemu-system-x86_64 -cpu host not working

Status in QEMU:
  New

Bug description:
  MacOS: 10.15.4
  uname -a: Linux door 4.15.0-96-generic #97-Ubuntu SMP Wed Apr 1 03:25:46 =
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

  I am using qemu on mac host, with ubuntu client.

  I used to have "-cpu host" in my qemu command as follow:-

  qemu-system-x86_64 \
  -no-user-config \
  -nodefaults \
  -name u64d01 \
  -show-cursor \
  -M q35,accel=3Dhvf,usb=3Doff,vmport=3Doff \
  -cpu host \
  -m 8192M \
  -smp 4 \
  -rtc base=3Dutc,clock=3Dhost \
  -device virtio-blk-pci,drive=3Dssd1 \
  -drive id=3Dssd1,file=3D/Users/js/code/vm/qemu/u64d01.qcow2,if=3Dnone,for=
mat=3Dqcow2 \
  -device virtio-net-pci,netdev=3Dnic1,mac=3D52:54:98:76:54:33 \
  -netdev user,id=3Dnic1,ipv4=3Don,ipv6=3Don,hostname=3Du64d01,hostfwd=3Dtc=
p::2222-:22 \
  -device virtio-tablet-pci \
  -device virtio-vga \
  -device ich9-intel-hda,id=3Dsnd,msi=3Don \
  -device hda-output,id=3Dsnd-codec0,bus=3Dsnd.0,cad=3D0,audiodev=3Dsnd0 \
  -audiodev coreaudio,id=3Dsnd0

  Base on log of one of the vm, it was definitely working on
  2020-01-17(base on journal inside vm), with qemu 4.2.0, which I
  installed with brew.

  The only way to make it work is to remove "-cpu host".

  Already tried with 4.1.1, 4.2 and 5.0rc2. Same result.

  To reproduce, try above with a Ubuntu 18.04 installation cd. Client
  will crash during kernel loading.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872644/+subscriptions

