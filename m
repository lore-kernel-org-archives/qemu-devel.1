Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D1C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D82121019
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D82121019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTMWg-0007Xy-If
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:23:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTMUb-0006S7-Be
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTMUa-0007wa-5M
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:20:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:36170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hTMUZ-0007uP-Ve
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:20:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hTMUW-00069g-GY
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:20:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C38A2E80C9
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2019 08:14:13 -0000
From: Eunseok Choi <1829964@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: android-x86 leak virt-gpu vram
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: riosnai th-huth
X-Launchpad-Bug-Reporter: Eunseok Choi (riosnai)
X-Launchpad-Bug-Modifier: Eunseok Choi (riosnai)
References: <155849647074.15430.13880026935625975661.malonedeb@wampee.canonical.com>
Message-Id: <155851285378.21734.3576635759181429633.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 82ea2d36b1e26a74ed2566f3447362ff3f52e499
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829964] Re: HOST VRAM Leak when performs
 android-x86 window rotation with Virt-GPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1829964 <1829964@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I tested many qemu & linux versions....

in case of qemu,
2.12
3.10
3.12
4.0.0
All versions I tested have same problem....

also I tested many versions of linux =

ubuntu 18.04 18.10
centos 7
fedora 18 19
rhel

Actually it is not only problem of windows rotation, if home launcher
refreshed, vram usage is also up...

I think it related gl related functions...

so I don't sure it is qemu-virt-gpu problem or virt-gpu driver...

That is why I already report this problem to android-x86 devel forum and
author of virt-gpu drvier...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829964

Title:
  HOST VRAM Leak when performs android-x86 window rotation with Virt-GPU

Status in QEMU:
  Incomplete

Bug description:
  I will report something strange thing about host VRAM leakage after
  anroid-x86 window rotation when it runs with virt-gpu(+ virgl-
  renderer)

  Please watching below video link.

  https://www.youtube.com/watch?v=3DmJIbGZLWF1s&feature=3Dyoutu.be

  (orginal video file : https://drive.google.com/file/d
  /1lkdTx_8yTbSVjKXlnxnnk96fWe-w6Mxb/view?usp=3Dsharing)

  I don't sure what is the problem...

  Here are my tested history
  -------------------------------------------------------------------------=
-------------------------
  Install android-x86 on I7 desktop PCs with intel UHD GPU  - No leak.
  Install android-x86 on I7 desktop PCs with NVIDIA GTX GPU series - No lea=
k.
  Install android-x86 on guest machine emulated skylake cpu with QEMU(+virt=
-gpu, virgl-renderer) - Leak
  (HOST CPU - I5, INTEL UHD GPU)
  Install android-x86 on guest machine emulated skylake cpu with QEMU(+virt=
-gpu, virgl-renderer) - Leak
  (HOST CPU - I7, NVIDIA GTX GPU)

  COMMON:
  In case of NVIDIA GPU : check vram using nvidia-smi
  In case of intel UHD GPU : check shared-vram using free cmd

  We checked guest android-x86 system down when vram is full after performi=
ng many rotation
  -------------------------------------------------------------------------=
------------------

  Is it virt-gpu driver's problem?

  I hope someone can help me...

  Thanks in advance!!


  PS


  Here are qemu options I used...

  -machine type=3Dq35,accel=3Dkvm -cpu host --enable-kvm \
  -smp cpus=3D4,cores=3D4,threads=3D1 -m 4096 \
  -drive file=3Dctb0319.qcow2,format=3Dqcow2,if=3Dvirtio,aio=3Dthreads \
  -device virtio-vga,virgl=3Don \
  -device qemu-xhci,id=3Dxhci -device usb-mouse,bus=3Dxhci.0 -device usb-kb=
d,bus=3Dxhci.0 \
  -soundhw hda -display sdl,gl=3Don -netdev user,id=3Dqemunet0,hostfwd=3Dtc=
p::4000-:7000,hostfwd=3Dtcp::5555-:5555,hostfwd=3Dtcp::4012-:7012,hostfwd=
=3Dtcp::4013-:7013 -device virtio-net,netdev=3Dqemunet0 -boot menu=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829964/+subscriptions

