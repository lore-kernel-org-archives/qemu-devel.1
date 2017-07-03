Received: from eggs.gnu.org ([2001:4830:134:3::10]:39998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRvMG-0003F0-Gh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRvMD-0001hz-Em
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:01:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:36618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRvMD-0001hW-8s
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:01:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRvMB-0000fA-3z
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 07:01:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D36F2E80E6
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 07:01:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jul 2017 06:52:05 -0000
From: Thomas Huth <1694998@bugs.launchpad.net>
Reply-To: Bug 1694998 <1694998@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149632651904.23369.12296046707149421968.malonedeb@wampee.canonical.com>
Message-Id: <149906472560.6077.5309854100870258628.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1694998] Re: PPC: msgsnd instruction leads to
 assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has now been included:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Df1c29ebc51be77bd64178c=
8d

** Changed in: qemu
       Status: New =3D> Fix Committed

** Changed in: qemu
     Assignee: (unassigned) =3D> Thomas Huth (th-huth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1694998

Title:
  PPC: msgsnd instruction leads to assertion

Status in QEMU:
  Fix Committed

Bug description:
  I tried to send doorbells (using msgsnd) between cores in guest OS. On QE=
MU v2.9.0 usage of msgsnd instruction leads to error:
  ERROR: <...>/qemu-new/translate-common.c:34:tcg_handle_interrupt: asserti=
on failed: (qemu_mutex_iothread_locked())

  =

  QEMU v2.8.0 works fine.

  QEMU run options: qemu-system-ppc -serial stdio -M ppce500 -cpu e500mc
  -smp 2 -m 512M -kernel pok.elf

  pok.elf attached

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1694998/+subscriptions
