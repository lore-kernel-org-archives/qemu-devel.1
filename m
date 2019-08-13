Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D3C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED29B205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED29B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxQom-00008w-RW
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hxQng-00076I-TN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hxQnf-0004Bp-Iw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:00:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:39908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hxQnf-0004At-DX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hxQnd-0006Df-OM
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 07:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A8ABF2E80CB
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 07:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Aug 2019 06:55:31 -0000
From: Al Sn <1839807@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm snapshots
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alsn pmaydell
X-Launchpad-Bug-Reporter: Al Sn (alsn)
X-Launchpad-Bug-Modifier: Al Sn (alsn)
References: <156559266426.18172.16579923111498222299.malonedeb@wampee.canonical.com>
Message-Id: <156567933201.17428.11092825856618786498.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19021";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b9fd66c0dfbee6ae5ad9de61b071133ef4a6ccfb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839807] Re: Snapshots freeze guest Sabrelite
 IMX.6 board
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
Reply-To: Bug 1839807 <1839807@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello again,

I have tried to disable TrustZone using argument mentioned in comment #5
by changing -M sabrelite to -M sabrelite,secure=3Doff, but I get error
"qemu-system-arm: Property '.secure' not found". It works with virt
though. Is there any other way to disable it?

Thank you,
...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839807

Title:
  Snapshots freeze guest Sabrelite IMX.6 board

Status in QEMU:
  Confirmed

Bug description:
  Hello,

  I'm trying to take and restore  a snapshot with the whole system state of=
 the Sabrelite IMX.6 board running on QEMU with commands savevm/loadvm.
  It seems that I am able to take a snapshot but loading the snapshot fails.

  For comparison I checked out snapshots on 32bit ARM Virt with Debian as w=
ell as on the Versatilepb board with a bare metal application and it works =
fine.
  The problem occurs only with that one particular board.

  My environment is:
  Ubuntu 18.04
  QEMU 3.0.1 (I see the same issue in QEMU 4.0.0 as well)
  The kernel and device tree used for the board was 5.1.14 version from ker=
nel.org

  The file system was build from imx_v6_v7_defconfig config in buildroot
  as and sd card image.

  Problem:

  Loading snapshot stops the whole machine and it's impossible to resume
  it.

  Steps to reproduce problem:

  1.      I converted the sdcard.img built from the buildroot to qcow2
  using command qemu-img convert -f raw -O qcow2 sdcard.img
  sdcard.qcow2, since the raw doesn't support snapshots.

  2.      I start QEMU with a command
  ./arm-softmmu/qemu-system-arm -m 512 -M sabrelite -kernel zImage -append =
"rootfstype=3Dext4 root=3D/dev/mmcblk2p2 rw rootwait" -rtc base=3Dlocaltime=
,clock=3Dvm -dtb imx6dl-sabresd.dtb -drive file=3Dsdcard.qcow2,index=3D2,fo=
rmat=3Dqcow2,id=3Dmycard -device sd-card,drive=3Dmycard -nographic -net nic=
 -net user

  3.      I run a simple program which print characters to the console
  in the background and add some files in user directory, to differ from
  original image.

  4.      I switch to QEMU monitor, and type =E2=80=9Csavevm <name>=E2=80=
=9D.
  When I type =E2=80=9Cinfo snapshots=E2=80=9D, the snapshot is listed.
  So I assume it was saved correctly.

  5.      Then I switch back to Linux console from monitor, remove the
  added files and stop the background printing process.

  6.      I switch back to monitor and I'm trying now to load the
  snapshot by =E2=80=9Cloadvm <name>=E2=80=9D command.

  That=E2=80=99s where the problem occurs. QEMU stops and I can't switch ba=
ck from monitor to Linux.
  Typing =E2=80=9Ccont=E2=80=9D doesn=E2=80=99t help.
  It seems like the simulation has freezed. CPU usage on my Laptop machine =
equals 100% until I exit QEMU.

  =

  What=E2=80=99s interesting when I exit the QEMU and then start it again t=
he Linux boots and after it reaches the command prompt I can see the files =
which were removed after saving the snapshot.

  It looks like loading the snapshots works for restoring disk space but
  it fails for restoring the running processes.

  Due to the answer on QEMU mailing list
  (https://lists.nongnu.org/archive/html/qemu-
  discuss/2019-08/msg00016.html) it is QEMUs bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839807/+subscriptions

