Received: from eggs.gnu.org ([2001:4830:134:3::10]:50802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhLvY-0000Zt-Mj
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 17:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhLvV-0000bf-Fl
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 17:30:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhLvV-0000aN-9T
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 17:30:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhLvT-0002Z4-GY
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 21:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B99C2E81A0
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 21:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jul 2018 21:06:58 -0000
From: Peter Maloney <1769189@bugs.launchpad.net>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Message-Id: <153229361813.2927.7188400353223146067.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + SATA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could this affect virtio-scsi? I'm not so sure since it's not perfectly
reliable to reproduce, but v2.12.0 was hanging for me for a few minutes
at a time with virtio-scsi cache=3Dwriteback showing 100% disk util%. I
never had issues booting up, and didn't try SATA. v2.11.1 was fine.

My first attempt to bisect didn't turn out right... had some false
positives I guess. The 2nd attempt (telling git the bads from first try)
got to 89e46eb477113550485bc24264d249de9fd1260a as latest good (which is
4 commits *after* the bisect by John Snow) and
7273db9d28d5e1b7a6c202a5054861c1f0bcc446 as bad.

But testing with this patch, it seems to work (or false positive
still... after a bunch of usage). And so I didn't finish the bisect.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769189

Title:
  Issue with qemu 2.12.0 + SATA

Status in QEMU:
  Fix Committed

Bug description:
  [EDIT: I first thought that OVMF was the issue, but it turns out to be
  SATA]

  I had a Windows 10 VM running perfectly fine with a SATA drive, since
  I upgraded to qemu 2.12, the guests hangs for a couple of minutes,
  works for a few seconds, and hangs again, etc. By "hang" I mean it
  doesn't freeze, but it looks like it's waiting on IO or something, I
  can move the mouse but everything needing disk access is unresponsive.

  What doesn't work: qemu 2.12 with SATA
  What works: using VirIO-SCSI with qemu 2.12 or downgrading qemu to 2.11.1=
 and keep using SATA.

  Platform is arch linux 4.16.7 on skylake and Haswell, I have attached
  the vm xml file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769189/+subscriptions
