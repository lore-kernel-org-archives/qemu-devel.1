Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2281CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB636218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB636218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWcd-0002F1-SU
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ihWbR-0001W8-N2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ihWbQ-0006sm-6P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:39026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ihWbP-0006n2-VH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:30:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ihWbO-0000Wm-KY
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 92F992E8078
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Dec 2019 10:23:09 -0000
From: ecsdn <1856834@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ecsdn
X-Launchpad-Bug-Reporter: ecsdn (ecsdn)
X-Launchpad-Bug-Modifier: ecsdn (ecsdn)
Message-Id: <157666458990.14847.6716769636962803095.malonedeb@wampee.canonical.com>
Subject: [Bug 1856834] [NEW] softmmu qemu-system-ppc freezes at virtio vda
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 94885bca3e338c2f688db636115c5961043b0fd6
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
Reply-To: Bug 1856834 <1856834@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The same qemu -M mpc... command that works on qemu-system-ppc version
2.8.0 freezes guest on bootup and shows error for qemu-system-ppc
version 4.2.0release and 4.19dirtygit:

qemu-system-ppc: virtio-blk failed to set guest notifier (-24), ensure -acc=
el kvm is set.
qemu-system-ppc: virtio_bus_start_ioeventfd: failed. Fallback to userspace =
(slower).

ends/freezes at:
nbd: registered device at major 43
=C2=A0vda:

I'm using -drive file=3D/home/me/rawimage.dd,if=3Dvirtio and works fine in
version 2.8.0 installed with apt-get install (Ubuntu 17.04) and also
with 2.8.0 official release from git/github that I compiled/built
myself. But both of the newer releases fail on the same exact machine
same config.

I also noticed that qemu-2.8.0 was fine with mtd but the newer ones I tried=
 weren't, ie gave
qemu-system-ppc: -drive if=3Dmtd: machine type does not support if=3Dmtd,bu=
s=3D0,unit=3D0
(but I removed -drive if=3Dmtd since wasn't using it anyway)

I also tried on windows but I think virtio doesn't work on windows hosts
at all? On windows host it fails the same way, even version 2.12 as well
as 4.1.10...

used:
./configure --prefix=3D/opt/... --enable-fdt --enable-kvm --enable-debug

(basically all steps the same on same exact system same config, yet
2.8.0 works fine whether apt-get installed or built from source while
the others I built, 4.19/4.2.0 or 2.12/4.1.10(win) don't.)

In case newer qemu versions act weird on various kernels, I did try with bo=
th vmlinuz-4.10.0-19-generic and vmlinuz-4.13.12-041312-generic (I didn't c=
ompile them but I can provide config-..files. This is on Ubuntu 17.04 x86_6=
4 host emulating e500v2 cpm guest, ie -M mpc... GUEST kernel 2.6.32.44 whic=
h is why I can't use -M ppce500 instead..)
tx
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ecs

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856834

Title:
  softmmu qemu-system-ppc freezes at virtio vda

Status in QEMU:
  New

Bug description:
  The same qemu -M mpc... command that works on qemu-system-ppc version
  2.8.0 freezes guest on bootup and shows error for qemu-system-ppc
  version 4.2.0release and 4.19dirtygit:

  qemu-system-ppc: virtio-blk failed to set guest notifier (-24), ensure -a=
ccel kvm is set.
  qemu-system-ppc: virtio_bus_start_ioeventfd: failed. Fallback to userspac=
e (slower).

  ends/freezes at:
  nbd: registered device at major 43
  =C2=A0vda:

  I'm using -drive file=3D/home/me/rawimage.dd,if=3Dvirtio and works fine in
  version 2.8.0 installed with apt-get install (Ubuntu 17.04) and also
  with 2.8.0 official release from git/github that I compiled/built
  myself. But both of the newer releases fail on the same exact machine
  same config.

  I also noticed that qemu-2.8.0 was fine with mtd but the newer ones I tri=
ed weren't, ie gave
  qemu-system-ppc: -drive if=3Dmtd: machine type does not support if=3Dmtd,=
bus=3D0,unit=3D0
  (but I removed -drive if=3Dmtd since wasn't using it anyway)

  I also tried on windows but I think virtio doesn't work on windows
  hosts at all? On windows host it fails the same way, even version 2.12
  as well as 4.1.10...

  used:
  ./configure --prefix=3D/opt/... --enable-fdt --enable-kvm --enable-debug

  (basically all steps the same on same exact system same config, yet
  2.8.0 works fine whether apt-get installed or built from source while
  the others I built, 4.19/4.2.0 or 2.12/4.1.10(win) don't.)

  In case newer qemu versions act weird on various kernels, I did try with =
both vmlinuz-4.10.0-19-generic and vmlinuz-4.13.12-041312-generic (I didn't=
 compile them but I can provide config-..files. This is on Ubuntu 17.04 x86=
_64 host emulating e500v2 cpm guest, ie -M mpc... GUEST kernel 2.6.32.44 wh=
ich is why I can't use -M ppce500 instead..)
  tx
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ecs

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856834/+subscriptions

