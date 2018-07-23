Received: from eggs.gnu.org ([2001:4830:134:3::10]:40322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhSVG-00034N-Od
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhSVE-0000Zv-A4
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:39126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhSVE-0000Yu-3Y
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhSVB-0006rX-5H
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 04:31:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E23D2E818B
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 04:31:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jul 2018 04:17:19 -0000
From: Launchpad Bug Tracker <1257352@bugs.launchpad.net>
Reply-To: Bug 1257352 <1257352@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131203160523.17652.24548.malonedeb@wampee.canonical.com>
Message-Id: <153231943983.16639.15149854647733901246.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1257352] Re: kvm hangs occasionally when
 switching out of the qemu console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1257352

Title:
  kvm hangs occasionally when switching out of the qemu console

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

Bug description:
  To recreate (although this does *NOT* fail most of the time alas):

  1) press "ctrl-alt-2" to switch to the qemu console.
  2) type say "sendkey ctrl-alt-f1"
  3) press "ctrl-alt-1".

  Expected outcome: Switch to tty1 in the VM.

  Actual outcome: No switch to tty1 in the VM. and qemu console
  unresponsive to any keyboard input.

  =

  Rather a vague problem description I'm afraid but this has happened to me=
 3 times recently. No crash and no excessive CPU is observed.

  I'll grab an strace when it happens again and attach...

  ProblemType: Bug
  DistroRelease: Ubuntu 14.04
  Package: qemu-system-x86 1.6.0+dfsg-2ubuntu4
  ProcVersionSignature: Ubuntu 3.12.0-4.12-generic 3.12.1
  Uname: Linux 3.12.0-4-generic i686
  NonfreeKernelModules: nvidia
  ApportVersion: 2.12.7-0ubuntu1
  Architecture: i386
  CurrentDesktop: Unity
  Date: Tue Dec  3 15:41:40 2013
  InstallationDate: Installed on 2010-10-21 (1139 days ago)
  InstallationMedia: Ubuntu 10.10 "Maverick Meerkat" - Release i386 (201010=
07)
  SourcePackage: qemu
  UpgradeStatus: Upgraded to trusty on 2013-11-01 (31 days ago)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1257352/+subscriptions
