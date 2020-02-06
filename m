Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C0C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDDF20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDDF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izmJy-0005II-W4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1izmJO-0004rE-2p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1izmJM-0003Ow-E3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:55:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:56946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1izmJM-0003NG-8J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:55:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1izmJJ-00078n-Py
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 18:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C0AB62E80C0
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 18:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Feb 2020 18:48:11 -0000
From: Alex Williamson <alex.l.williamson@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson chrs-hoy
X-Launchpad-Bug-Reporter: Chris Hoy (chrs-hoy)
X-Launchpad-Bug-Modifier: Alex Williamson (alex-l-williamson)
References: <158096626936.9041.17441916407484515612.malonedeb@chaenomeles.canonical.com>
Message-Id: <158101489130.26751.4263158539825062006.malone@soybean.canonical.com>
Subject: [Bug 1862110] Re: qemu in script is not parsing properly
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 45ba8132b77d5f9bb0e339a0730fd0ec941d56da
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
Reply-To: Bug 1862110 <1862110@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Your script is broken, you cannot mix continued lines, blank lines, and
comments.  Take for instance this example:

---
#!/bin/bash

echo Hello \
World

echo Hello \

World

echo Hello \

# Earth

World
---

Which results in:

$ ./hello.sh =

Hello World
Hello
./hello.sh: line 8: World: command not found
Hello
./hello.sh: line 14: World: command not found

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1862110

Title:
  qemu in script is not parsing properly

Status in QEMU:
  New

Bug description:
  Bug Report:
  >>qemu-system-x86_64 --version: QEMU emulator version 4.2.0
  >>Arch-linux version 2020.02.01
  I was following a tutorial on how to make a windows vm and i have encount=
ered and issue in the settings of my script I have listed below.

  The commented code directly above the uncommented qemu instance would
  boot the Windows screen but the issue arises when I try to reach the
  same code block under the commented setting lines which takes me to
  the default SeaBIOS loader.

  #!/bin/bash

  vmname=3D"windows10vm"

  if ps -ef | grep qemu-system-x86_64 | grep -q multifunction=3Don; then
  echo "A passthrough VM is already running." &
  exit 1

  else

  # use pulseaudio

  export QEMU_AUDIO_DRV=3Dpa
  export QEMU_PA_SAMPLES=3D8192
  export QEMU_AUDIO_TIMER_PERIOD=3D99
  export QEMU_PA_SERVER=3D/run/user/1000/pulse/native

  cp /usr/share/ovmf/x64/OVMF_VARS.fd /tmp/my_vars.fd

  #qemu-system-x86_64 \
  #-drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D.../IMGs/=
win.img \
  #-drive file=3D.../ISOs/Win10_1909_English_x64.iso,index=3D1,media=3Dcdro=
m \

  qemu-system-x86_64 \

  #-name $vmname,process=3D$vmname \
  #-machine type=3Dq35,accel=3Dkvm \
  #-cpu host,kvm=3Doff \
  #-smp 4,sockets=3D1,cores=3D3,threads=3D1 \
  #-m 8G \
  #-balloon none \
  #-rtc clock=3Dhost,base=3Dlocaltime \
  #-vga none \
  #-nographic \
  #-serial none \
  #-parallel none \
  #-soundhw hda \
  #-usb \
  #-device usb-host,vendorid=3D...,productid=3D... \
  #-device usb-host,vendorid=3D...,productid=3D... \
  #-device vfio-pci,host=3D...,multifunction=3Don \
  #-device vfio-pci,host=3D... \
  #-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/ovmf/x64/OVMF=
_VARS.fd \
  #-drive if=3Dpflash,format=3Draw,file=3D/tmp/my_vars.fd \
  #-boot order=3D dc \

  -drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D.../IMGs/w=
in.img \
  -drive file=3D.../ISOs/Win10_1909_English_x64.iso,index=3D1,media=3Dcdrom=
 \
  -drive file=3D.../ISOs/virtio-0.1.171.iso,index=3D2,media=3Dcdrom \

  #-netdev type=3Dtap,id=3Dnet0,ifname=3Dvmtap0,vhost=3Don \
  #-device virtio-net-pci,netdev=3Dnet0,mac=3D... \

  exit 0

  fi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1862110/+subscriptions

