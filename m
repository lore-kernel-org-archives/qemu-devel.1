Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E82C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1956C2469A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1956C2469A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhIQ-0002xI-4j
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ihhHM-0002Mp-LZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ihhHL-0007iM-8Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:54:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:60338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ihhHL-0007gD-22
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:54:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ihhHJ-0006Yt-E7
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 21:54:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 577B32E807B
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 21:54:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Dec 2019 21:45:29 -0000
From: ecsdn <1596832@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andree182 ecsdn
X-Launchpad-Bug-Reporter: Andrej Krutak (andree182)
X-Launchpad-Bug-Modifier: ecsdn (ecsdn)
References: <20160628075027.23593.17849.malonedeb@gac.canonical.com>
Message-Id: <157670552938.15344.4033961201302554366.malone@wampee.canonical.com>
Subject: [Bug 1596832] Re: e500 -bios/-kernel broken with big images
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 558aa5482bb3e933410c9e361abac6c5ee1803c1
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
Reply-To: Bug 1596832 <1596832@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Curious: Is your guest kernel >=3D3.6 with qemu-ppce500 config ie qemu_ppce=
500 defined etc? =

In case u-boot loads/maps uImage format kernel differently have you tried u=
Image vs vmlinux?

And are you able to boot ok with an mpc... machine instead of ppce500 by
specifying a dtb file or dtb compatibility? Do you know if more recent
qemu (2.8 or 3 or 4.2) has same issue for you?

Oh wow I just noticed this is from 2016! It would be nice for such bugs
to have follow-up, closure, or summary of
solution/circumvention/workaround taken by those who posted them :)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1596832

Title:
  e500 -bios/-kernel broken with big images

Status in QEMU:
  New

Bug description:
  This is tested using qemu 2.4.1, but it looks like the code
  qemu/hw/ppc/e500.c has not changed since. This looks like the source
  of the problem:
  http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D3812c71ffaa2cf733c30=
87792b859fef30b7545f

  =

  What works:
  ----------

  Basic invocation qemu-system-ppc -machine ppce500  -monitor stdio
  -bios u-boot.e500 works, I get the uboot prompt and this:

  (qemu) info roms
  addr=3D0000000000f00000 size=3D0x044b8c mem=3Dram name=3D"phdr #0: .../qe=
mu/share/qemu/u-boot.e500"
  addr=3D0000000000f81000 size=3D0x006b00 mem=3Dram name=3D"phdr #1: .../qe=
mu/share/qemu/u-boot.e500"

  =

  Passing u-boot.e500 image as kernel (-bios u-boot.e500 -kernel u-boot.e50=
0) appears to work, $qemu_kernel_addr is filled in, though (as expected) ub=
oot complains about the image format.

  (qemu) info roms
  addr=3D0000000000f00000 size=3D0x044b8c mem=3Dram name=3D"phdr #0: .../qe=
mu/share/qemu/u-boot.e500"
  addr=3D0000000000f81000 size=3D0x006b00 mem=3Dram name=3D"phdr #1: .../qe=
mu/share/qemu/u-boot.e500"
  addr=3D0000000002000000 size=3D0x054e8c mem=3Dram name=3D".../qemu/share/=
qemu/u-boot.e500


  What doesn't work:
  -----------------

  However, once I try to load a big image (>=3D32 MiB), uboot doesn't even
  show anything:

  qemu-system-ppc -machine ppce500  -monitor stdio -bios u-boot.e500
  -kernel boot/vmlinux -m 1024

  (qemu) info roms
  addr=3D0000000000f00000 size=3D0x044b8c mem=3Dram name=3D"phdr #0: .../qe=
mu/share/qemu/u-boot.e500"
  addr=3D0000000000f81000 size=3D0x006b00 mem=3Dram name=3D"phdr #1: .../qe=
mu/share/qemu/u-boot.e500"
  addr=3D0000000002000000 size=3D0x27aeedc mem=3Dram name=3D"boot/vmlinux"

  ...
  (gdb) bt
  #0  0x00f2efcc in ?? ()
  #1  0x00f31554 in ?? ()
  #2  0x00f03f4c in ?? ()
  #3  0x00f04458 in ?? ()
  #4  0x00f028dc in ?? ()
  #5  0x00f01080 in ?? ()


  The thing is, this used to work +- before the commit, where I'd just
  pass the image as -kernel option, and it booted.

  =

  If I do that now (w/o the -bios option, using the exact same image), the =
kernel gets loaded twice, only at different addresses (the cause is obvious=
 from the commit), causing overlap error:

  qemu-system-ppc -machine ppce500  -monitor stdio  -kernel boot/vmlinux -m=
 1024
  QEMU 2.4.1 monitor - type 'help' for more information
  (qemu) rom: requested regions overlap (rom boot/vmlinux. free=3D0x0000000=
0027492fc, addr=3D0x0000000002000000)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1596832/+subscriptions

