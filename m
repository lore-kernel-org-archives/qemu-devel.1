Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTVSa-0008VP-Hk
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTVSX-00008O-Ed
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:50:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTVSX-00007K-7S
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:50:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTVSU-0007WJ-7h
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:50:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 209B22E818A
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:50:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 16:36:02 -0000
From: John Snow <1769189@bugs.launchpad.net>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Message-Id: <152899416237.2025.5939797243918106224.malone@chaenomeles.canonical.com>
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

5694c7eacce6b263ad7497cc1bb76aad746cfd4e ahci: fix PxCI register race

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5694c7eacce6b263ad749=
7cc1bb76aad746cfd4e

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
