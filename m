Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F4C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 04:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D78A2199C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 04:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D78A2199C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpPya-00010Q-Q3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 00:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55975)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hpPyQ-0000bj-6n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 00:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hpPyO-0000Kb-WF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 00:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:46094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hpPyO-0000Jx-PH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 00:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hpPyN-0000di-Ez
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5FE4B2E80D3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jul 2019 04:17:18 -0000
From: Launchpad Bug Tracker <1829964@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: android-x86 leak virt-gpu vram
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor riosnai th-huth
X-Launchpad-Bug-Reporter: Eunseok Choi (riosnai)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <155849647074.15430.13880026935625975661.malonedeb@wampee.canonical.com>
Message-Id: <156376903818.732.13715935382743547170.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e9dd16f4f8945cd5379c444295bc3019dadca9a1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829964] Re: HOST VRAM Leak when performs
 android-x86 window rotation with Virt-GPU
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
Reply-To: Bug 1829964 <1829964@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829964

Title:
  HOST VRAM Leak when performs android-x86 window rotation with Virt-GPU

Status in QEMU:
  Expired

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

