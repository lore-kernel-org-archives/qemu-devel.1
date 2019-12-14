Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2430C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 20:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A114D24125
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 20:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A114D24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEQP-0004xc-Mj
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 15:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1igEPU-0003xt-0R
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1igEPS-0005xX-O5
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:53:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:49778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1igEPS-0005s2-HB
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:53:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1igAO9-00022w-Ps
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 16:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B49822E80C8
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 16:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Dec 2019 16:25:57 -0000
From: Simon Brand <1856399@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: simonbrand1992
X-Launchpad-Bug-Reporter: Simon Brand (simonbrand1992)
X-Launchpad-Bug-Modifier: Simon Brand (simonbrand1992)
References: <157634067875.7231.7677894888746798043.malonedeb@soybean.canonical.com>
Message-Id: <157634075737.22377.10319888574778130371.malone@gac.canonical.com>
Subject: [Bug 1856399] Re: Intel GVT-g works in X11, crashes in wayland
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8b72deb31f3ee234b3369992fe5cee8609ee87af
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1856399 <1856399@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Forgot to mention, the crash is a segfault.
If there is more information needed, I am happy to provide it.

** Description changed:

  Hello,
  =

  I am using an uptodate Arch Linux 64bit with qemu version 4.2.0, but the =
problem was also present in older versions. The problem occurs with Linux 5=
.4 and 4.19.
  The problem also occurs with Debian as guest. I am running sway.
  If I provide -vga std, then qemu works fine until I use the qemu window t=
o switch to the vfio-pci device. There are no problems under X11/xwayland a=
t all.
  =

- =

  Commandline:
  qemu-system-x86_64
-     -enable-kvm
-     -cpu host
-     -smp 2
-     -m 8192
-     -display gtk,gl=3Don
-     -device vfio-pci,sysfsdev=3D/sys/devices/pci0000:00/0000:00:02.0/[ID]=
/,x-igd-opregion=3Don,display=3Don
-     -cdrom archlinux-2019.11.01-x86_64.iso
-     -vga none
+ =C2=A0=C2=A0=C2=A0=C2=A0-enable-kvm
+ =C2=A0=C2=A0=C2=A0=C2=A0-cpu host
+ =C2=A0=C2=A0=C2=A0=C2=A0-smp 2
+ =C2=A0=C2=A0=C2=A0=C2=A0-m 8192
+ =C2=A0=C2=A0=C2=A0=C2=A0-display gtk,gl=3Don
+ =C2=A0=C2=A0=C2=A0=C2=A0-device vfio-pci,sysfsdev=3D/sys/devices/pci0000:=
00/0000:00:02.0/[ID]/,x-igd-opregion=3Don,display=3Don
+ =C2=A0=C2=A0=C2=A0=C2=A0-cdrom archlinux-2019.11.01-x86_64.iso
+ =C2=A0=C2=A0=C2=A0=C2=A0-vga none

** Summary changed:

- Intel GVT-g works in X11, crashes in wayland
+ Intel GVT-g works in X11, segfaults in wayland

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856399

Title:
  Intel GVT-g works in X11, segfaults in wayland

Status in QEMU:
  New

Bug description:
  Hello,

  I am using an uptodate Arch Linux 64bit with qemu version 4.2.0, but the =
problem was also present in older versions. The problem occurs with Linux 5=
.4 and 4.19.
  The problem also occurs with Debian as guest. I am running sway.
  If I provide -vga std, then qemu works fine until I use the qemu window t=
o switch to the vfio-pci device. There are no problems under X11/xwayland a=
t all.

  Commandline:
  qemu-system-x86_64
  =C2=A0=C2=A0=C2=A0=C2=A0-enable-kvm
  =C2=A0=C2=A0=C2=A0=C2=A0-cpu host
  =C2=A0=C2=A0=C2=A0=C2=A0-smp 2
  =C2=A0=C2=A0=C2=A0=C2=A0-m 8192
  =C2=A0=C2=A0=C2=A0=C2=A0-display gtk,gl=3Don
  =C2=A0=C2=A0=C2=A0=C2=A0-device vfio-pci,sysfsdev=3D/sys/devices/pci0000:=
00/0000:00:02.0/[ID]/,x-igd-opregion=3Don,display=3Don
  =C2=A0=C2=A0=C2=A0=C2=A0-cdrom archlinux-2019.11.01-x86_64.iso
  =C2=A0=C2=A0=C2=A0=C2=A0-vga none

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856399/+subscriptions

