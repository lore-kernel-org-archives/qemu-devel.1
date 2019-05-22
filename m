Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48606C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE9B20644
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE9B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37221 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTKrR-0007FJ-6z
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 02:36:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTKqa-0006uS-Od
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTKqZ-0002UN-KW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:35:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:44480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hTKqZ-0002Pd-Dy
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:35:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hTKqW-0002kj-R2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC4AA2E8075
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2019 06:26:41 -0000
From: Eunseok Choi <1829964@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: android-x86 leak virt-gpu vram
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: riosnai th-huth
X-Launchpad-Bug-Reporter: Eunseok Choi (riosnai)
X-Launchpad-Bug-Modifier: Eunseok Choi (riosnai)
References: <155849647074.15430.13880026935625975661.malonedeb@wampee.canonical.com>
Message-Id: <155850640109.15974.11279339579142693905.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 57aed22174d098252ecac1ca88b2a5ea8c2cfc89
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

To Thomas Huth,

This is not android problem, qemu or virt-gpu  problem,.
-------------------- our test log --------------------------------------
Running android-x86 on I7 bare metal desktop PCs with intel UHD GPU - No le=
ak.
Running android-x86 on QEMU(+virt-gpu, virgl-renderer) - Leak
------------------------------------------------------------------------

Also in case of a guest linux, it also have leak after windows manager
rotation.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829964

Title:
  HOST VRAM Leak when performs android-x86 window rotation with Virt-GPU

Status in QEMU:
  Invalid

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

