Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7AC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A73820848
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A73820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20hO-0007KE-I2
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j20gc-0006oB-JW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j20gb-0008Oq-AW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:40:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:47508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j20gb-0008OI-5W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j20gZ-0006vM-JW
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 22:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8ED292E8074
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 22:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2020 22:33:40 -0000
From: Chris Hoy <1862887@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: builds
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chrs-hoy
X-Launchpad-Bug-Reporter: Chris Hoy (chrs-hoy)
X-Launchpad-Bug-Modifier: Chris Hoy (chrs-hoy)
References: <158149024287.24857.8410135131433041908.malonedeb@gac.canonical.com>
Message-Id: <158154682102.24991.10084721959749770485.malone@gac.canonical.com>
Subject: [Bug 1862887] Re: qemu does not load pulseaudio modules properly
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 99ef504ef35874ca0a514220657e8f42cb39f1f2
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
Reply-To: Bug 1862887 <1862887@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

EDIT: This is for Arch 2020.02.01

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1862887

Title:
  qemu does not load pulseaudio modules properly

Status in QEMU:
  New

Bug description:
  Hello,

  This is on Arch-linux(latest) and the qemu 4.2.0 version made from git cl=
one https://github.com/spheenik/qemu.git
  with:
   ./configure --prefix=3D/opt/qemu-test --python=3D/usr/bin/python2 --targ=
et-list=3Dx86_64-softmmu =

  --audio-drv-list=3Dpa --disable-werror
  added to the build.

  I've been workin on a passthrough Windows 10 vm this month and have been =
steadily seeing some promising progress. My block/issue at the moment is in=
tegrating the audio now that the GPU has been succesfully passed through. =

  I've been going back and forth between the audio options for Pulseaudio a=
nd cannot change the following issue:
  pulseaudio: pa_context_connect() failed
  pulseaudio: Reason: Connection refused
  pulseaudio: Failed to initialize PA contextlibusb: error [udev_hotplug_ev=
ent] ignoring udev action bind
  I leave my current operable build followed by some of the options that I =
have tried using to correct this despite the following errors not changing

  This is my current operable build:

  #!/bin/bash

  vmname=3D"windows10vm"

  if ps -ef | grep /opt/qemu-test/bin/qemu-system-x86_64 | grep -q multifun=
ction=3Don; then
  echo "A passthrough VM is already running." &
  exit 1

  else

  /opt/qemu-test/bin/qemu-system-x86_64 \
  -m 12G \
  -drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D.../win2.i=
mg \
  -drive file=3D.../Win10_1909_English_x64.iso,index=3D1,media=3Dcdrom \
  -drive file=3D.../virtio-win-0.1.171.iso,index=3D2,media=3Dcdrom \
  -boot order=3Ddc \
  -bios /usr/share/ovmf/x64/OVMF_CODE.fd \
  -name $vmname,process=3D$vmname \
  -machine type=3Dq35,accel=3Dkvm,vmport=3Doff \
  -cpu host,kvm=3Doff \
  -smp 3,sockets=3D1,cores=3D3,threads=3D1 \
  -device virtio-balloon \
  -rtc clock=3Dhost,base=3Dlocaltime \
  -vga none \
  -nographic \
  -serial none \
  -parallel none \
  -soundhw hda \
  -usb \
  -device usb-host,vendorid=3D...,productid=3D... \
  -device usb-host,vendorid=3D...,productid=3D... \
  -device usb-host,vendorid=3D...,productid=3D... \
  -device vfio-pci,host=3D...,multifunction=3Don \
  -device vfio-pci,host=3D... \
  -device e1000,netdev=3Dnet0 \
  -netdev user,id=3Dnet0,hostfwd=3Dtcp::...-:22 \

  Here's a list of setting combinations I had tried to resolve this:

  #export QEMU_AUDIO_DRV=3Dpa
  #QEMU_ALSA_DAC_BUFFER_SIZE=3D512 QEMU_ALSA_DAC_PERIOD_SIZE=3D170
  #export QEMU_PA_SAMPLES=3D8192 =

  #export QEMU_AUDIO_TIMER_PERIOD=3D99
  #export QEMU_PA_SERVER=3D/run/user/1000/pulse/native
  #export QEMU_PA_SINK=3Dalsa_output.usb-C-Media_Electronics_Inc._USB_Audio=
_Device-00.analog-stereo
  #export QEMU_PA_SOURCE=3Dinput

  -audiodev pa,id=3Dpa1,server=3Dserver=3D/run/user/1000/pulse/native

  At best I have removed an XDG_RUNTIME_DIR error but other than that
  this build has no audio compatability.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1862887/+subscriptions

