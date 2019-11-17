Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C2BC432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 19:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3020D20730
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 19:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3020D20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWQel-0001Ef-7R
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 14:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iWQe8-0000bV-6f
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 14:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iWQe6-0001hp-Ks
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 14:55:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:52542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iWQe6-0001gh-FF
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 14:55:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iWQe4-0004yO-7N
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 19:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 35A832E8005
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 19:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Nov 2019 19:49:28 -0000
From: Matti Hameister <1846427@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h kwolf-redhat lersek mattihami
 michael-weiser psyhomb sej7278
X-Launchpad-Bug-Reporter: Michael Weiser (michael-weiser)
X-Launchpad-Bug-Modifier: Matti Hameister (mattihami)
References: <157005622285.15919.12087374175062502233.malonedeb@gac.canonical.com>
Message-Id: <157402016867.22769.13903133770787527472.malone@chaenomeles.canonical.com>
Subject: [Bug 1846427] Re: 4.1.0: qcow2 corruption on savevm/quit/loadvm cycle
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5371171d0459490abe0eb62a73cc4dacbe3d00b3
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
Reply-To: Bug 1846427 <1846427@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The image was fine before upgrading qemu. I rechecked the image after
the first use and it was fine. But after the larger Windows 1903 -> 1909
upgrade done in qemu 4.1.0 the image was damaged. I will try the git
master version of qemu in the coming days and report back.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1846427

Title:
  4.1.0: qcow2 corruption on savevm/quit/loadvm cycle

Status in QEMU:
  Fix Committed

Bug description:
  I'm seeing massive corruption of qcow2 images with qemu 4.1.0 and git
  master as of 7f21573c822805a8e6be379d9bcf3ad9effef3dc after a few
  savevm/quit/loadvm cycles. I've narrowed it down to the following
  reproducer (further notes below):

  # qemu-img check debian.qcow2
  No errors were found on the image.
  251601/327680 =3D 76.78% allocated, 1.63% fragmented, 0.00% compressed cl=
usters
  Image end offset: 18340446208
  # bin/qemu/bin/qemu-system-x86_64 -machine pc-q35-4.0.1,accel=3Dkvm -m 40=
96 -chardev stdio,id=3Dcharmonitor -mon chardev=3Dcharmonitor -drive file=
=3Ddebian.qcow2,id=3Dd -S
  qemu-system-x86_64: warning: dbind: Couldn't register with accessibility =
bus: Did not receive a reply. Possible causes include: the remote applicati=
on did not send a reply, the message bus security policy blocked the reply,=
 the reply timeout expired, or the network connection was broken.
  QEMU 4.1.50 monitor - type 'help' for more information
  (qemu) loadvm foo
  (qemu) c
  (qemu) qcow2_free_clusters failed: Invalid argument
  qcow2_free_clusters failed: Invalid argument
  qcow2_free_clusters failed: Invalid argument
  qcow2_free_clusters failed: Invalid argument
  quit
  [m@nargothrond:~] qemu-img check debian.qcow2
  Leaked cluster 85179 refcount=3D2 reference=3D1
  Leaked cluster 85180 refcount=3D2 reference=3D1
  ERROR cluster 266150 refcount=3D0 reference=3D2
  [...]
  ERROR OFLAG_COPIED data cluster: l2_entry=3D422840000 refcount=3D1

  9493 errors were found on the image.
  Data may be corrupted, or further writes to the image may corrupt it.

  2 leaked clusters were found on the image.
  This means waste of disk space, but no harm to data.
  259266/327680 =3D 79.12% allocated, 1.67% fragmented, 0.00% compressed cl=
usters
  Image end offset: 18340446208

  This is on a x86_64 Linux 5.3.1 Gentoo host with qemu-system-x86_64
  and accel=3Dkvm. The compiler is gcc-9.2.0 with the rest of the system
  similarly current.

  Reproduced with qemu-4.1.0 from distribution package as well as
  vanilla git checkout of tag v4.1.0 and commit
  7f21573c822805a8e6be379d9bcf3ad9effef3dc (today's master). Does not
  happen with qemu compiled from vanilla checkout of tag v4.0.0. Build
  sequence:

  ./configure --prefix=3D$HOME/bin/qemu-bisect --target-list=3Dx86_64-softm=
mu --disable-werror --disable-docs
  [...]
  CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
  [...] (can provide full configure output if helpful)
  make -j8 install

  The kind of guest OS does not matter: seen with Debian testing 64bit,
  Windows 7 x86/x64 BIOS and Windows 7 x64 EFI.

  The virtual storage controller does not seem to matter: seen with
  VirtIO SCSI, emulated SCSI and emulated SATA AHCI.

  Caching modes (none, directsync, writeback), aio mode (threads,
  native) or discard (ignore, unmap) or detect-zeroes (off, unmap) does
  not influence occurence either.

  Having more RAM in the guest seems to increase odds of corruption:
  With 512MB to the Debian guest problem hardly occurs at all, with 4GB
  RAM it happens almost instantly.

  An automated reproducer works as follows:

  - the guest *does* mount its root fs and swap with option discard and
  my testing leaves me with the impression that file deletion rather
  than reading is causing the issue

  - foo is a snapshot of the running Debian VM which is already running
  command

  # while true ; do dd if=3D/dev/zero of=3Dfoo bs=3D10240k count=3D400 ; do=
ne

  to produce some I/O to the disk (4GB file with 4GB of RAM).

  - on the host a loop continuously resumes and saves the guest state
  and quits qemu inbetween:

  # while true ; do (echo loadvm foo ; echo c ; sleep 10 ; echo stop ;
  echo savevm foo ; echo quit ) | bin/qemu-bisect/bin/qemu-system-x86_64
  -machine pc-q35-3.1,accel=3Dkvm -m 4096 -chardev stdio,id=3Dcharmonitor
  -mon chardev=3Dcharmonitor -drive file=3Ddebian.qcow2,id=3Dd -S -display
  none ; done

  - quitting qemu inbetween saves and loads seems to be necessary for
  the problem to occur. Just continusouly in one session saving and
  loading guest state does not trigger it.

  - For me, after about 2 to 6 iterations of above loop the image is
  corrupted.

  - corruption manifests with other messages from qemu as well, e.g.:

  (qemu) loadvm foo
  Error: Device 'd' does not have the requested snapshot 'foo'

  Using above reproducer I have to the be best of my ability bisected
  the introduction of the problem to commit
  69f47505ee66afaa513305de0c1895a224e52c45 (block: avoid recursive
  block_status call if possible). qemu compiled from the commit before
  does not exhibit the issue, from that commit on it does and reverting
  the commit off of current master makes it disappear.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1846427/+subscriptions

