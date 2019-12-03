Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31278C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 00:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB86206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 00:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB86206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibw7M-0006rh-3N
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 19:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ibw5b-0006AQ-AS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ibw5Z-0003nB-Np
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:30:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:46820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ibw5Z-0003jj-GF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:30:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ibw5X-0000Oj-Sj
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 00:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D42CD2E8075
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 00:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Dec 2019 00:17:18 -0000
From: Ben321 <1854878@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ben321
X-Launchpad-Bug-Reporter: Ben321 (ben321)
X-Launchpad-Bug-Modifier: Ben321 (ben321)
Message-Id: <157533223880.21849.7736454567189329387.malonedeb@soybean.canonical.com>
Subject: [Bug 1854878] [NEW] Physical USB thumbdrive treated as read-only
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5e8d74a9cb447d50e4a21afcd3c8b47064ed67f7
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
Reply-To: Bug 1854878 <1854878@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

So I have installed FreeDOS on my USB thumbdrive, by using Rufus.
Everything goes as expected so far. That's good.

When I run QEMU with this command line:
qemu-system-x86_64.exe -drive file=3D\\.\PhysicalDrive1

it of course is read-only, just like the resulting console message says:
WARNING: Image format was not specified for '\\.\PhysicalDrive1' and probin=
g guessed raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.


So what I then did, was I ran QEMU with this command line:
qemu-system-x86_64.exe -drive file=3D\\.\PhysicalDrive1,format=3Draw

As expected, the above mentioned console message no longer appears.
However, beyond that, QEMU doesn't behave as it should regarding read-only =
status. When I try any operation that involves writing to the drive, it bec=
omes quite clear that the drive is still read-only. Any writing operations =
to the drive result in FreeDOS giving me the error message:
Error writing to drive C: DOS area: sector not found.

The above situation is clearly a bug. QEMU should not be treating it as
read-only once I specify format=3Draw.

Note that drive C is how the guest OS refers to the USB thumbdrive (it's
drive E in my host OS, and drive C in my host OS is the actual system
drive).

And yes, it is a QEMU bug. It's not a FreeDOS bug I tested it with this com=
mand line, so that all changes would be written to a temporary snapshot fil=
e:
qemu-system-x86_64.exe -drive file=3D\\.\PhysicalDrive1,format=3Draw,snapsh=
ot
That last drive option "snapshot" tells QEMU to create a temporary snapshot=
 file, and to write all changes to that. When I do that, all write operatio=
ns are successful. So it seems that there is a bug in QEMU where it keeps r=
ead-only mode in place for a physical drive, even when format=3Draw is spec=
ified. Please fix this bug. Thanks in advance.

Here's my current setup.
Host OS: Windows 10 (64bit)
Guest OS: FreeDOS
QEMU version: 4.1.0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1854878

Title:
  Physical USB thumbdrive treated as read-only

Status in QEMU:
  New

Bug description:
  So I have installed FreeDOS on my USB thumbdrive, by using Rufus.
  Everything goes as expected so far. That's good.

  When I run QEMU with this command line:
  qemu-system-x86_64.exe -drive file=3D\\.\PhysicalDrive1

  it of course is read-only, just like the resulting console message says:
  WARNING: Image format was not specified for '\\.\PhysicalDrive1' and prob=
ing guessed raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.

  =

  So what I then did, was I ran QEMU with this command line:
  qemu-system-x86_64.exe -drive file=3D\\.\PhysicalDrive1,format=3Draw

  As expected, the above mentioned console message no longer appears.
  However, beyond that, QEMU doesn't behave as it should regarding read-onl=
y status. When I try any operation that involves writing to the drive, it b=
ecomes quite clear that the drive is still read-only. Any writing operation=
s to the drive result in FreeDOS giving me the error message:
  Error writing to drive C: DOS area: sector not found.

  The above situation is clearly a bug. QEMU should not be treating it
  as read-only once I specify format=3Draw.

  Note that drive C is how the guest OS refers to the USB thumbdrive
  (it's drive E in my host OS, and drive C in my host OS is the actual
  system drive).

  And yes, it is a QEMU bug. It's not a FreeDOS bug I tested it with this c=
ommand line, so that all changes would be written to a temporary snapshot f=
ile:
  qemu-system-x86_64.exe -drive file=3D\\.\PhysicalDrive1,format=3Draw,snap=
shot
  That last drive option "snapshot" tells QEMU to create a temporary snapsh=
ot file, and to write all changes to that. When I do that, all write operat=
ions are successful. So it seems that there is a bug in QEMU where it keeps=
 read-only mode in place for a physical drive, even when format=3Draw is sp=
ecified. Please fix this bug. Thanks in advance.

  Here's my current setup.
  Host OS: Windows 10 (64bit)
  Guest OS: FreeDOS
  QEMU version: 4.1.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1854878/+subscriptions

