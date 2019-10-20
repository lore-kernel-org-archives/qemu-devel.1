Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24482CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 12:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93FF2089C
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 12:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93FF2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMANt-0004xG-Vw
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 08:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iM7JQ-0002md-Ks
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 05:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iM7JP-0004LI-Em
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 05:15:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:40778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iM7JP-0004Kt-9L
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 05:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iM7JN-0002Et-1j
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 09:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0C1F12E80C0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 09:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Oct 2019 09:07:07 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: roland-micite zlice0
X-Launchpad-Bug-Reporter: zlice (zlice0)
X-Launchpad-Bug-Modifier: roland (roland-micite)
References: <151853690975.29423.7587323391423810191.malonedeb@chaenomeles.canonical.com>
Message-Id: <157156242749.21444.3084812580500074297.malone@wampee.canonical.com>
Subject: [Bug 1749223] Re: mouse offset or invisible wall 2.11.0-3 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: df502df87b05d2033b76f2f13a49ed43b669b6fe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sun, 20 Oct 2019 08:29:20 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Bug 1749223 <1749223@bugs.launchpad.net>, roland <roland@micite.net>
From: roland via <qemu-devel@nongnu.org>

It sounds like I have the same problem.

There is a virtual wall where the mouse cursor goes from the guest window t=
o the host desktop.
This virtual wall/cut off point is consistent.
Moving the mouse faster seems to break through this wall and puts the wall =
at a different place.

For me this happens on a host with ubuntu 19.10 with wayland.
I don't have the issue on ubuntu 19.10 with X.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1749223

Title:
  mouse offset or invisible wall 2.11.0-3

Status in QEMU:
  New

Bug description:
  (There was another post, I'm not sure if it is related though. Also
  not sure if it's Arch related, I wouldn't be surprised as I normally
  use Gentoo and have less problems with Gentoo.)

  =

  qemu-system-x86_64 -enable-kvm -M q35 -cpu host -m 8192 -vga vmware -smp =
4,sockets=3D1,cores=3D4,threads=3D1 -drive file=3D/path/to/my.img,if=3Dvirt=
io -soundhw ac97 -usb -monitor unix:/tmp/qemu-mon,server,nowait -usb --usbd=
evice host:0000:ffff -device vfio-pci,host=3D00:00.0 -alt-grab &


  When I grab the mouse in/out of the VM I tend to get an "invisible wall" =
half of the time.
  I can push past if I fling the mouse through it but not if I slowly keep =
moving down.

  The direction always seems to be down when I hit a wall (so a Y offset? m=
aybe?)
  This has been happening since at least version 2.10.

  Not sure if "-alt-grab" has anything to do with it, that'd be my first
  guess.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1749223/+subscriptions

