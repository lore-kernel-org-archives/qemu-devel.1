Received: from eggs.gnu.org ([2001:4830:134:3::10]:41488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAZ0d-0001Cb-R6
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAZ0Y-00072f-Tg
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:15:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:57550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAZ0Y-00072D-Nw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:15:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAZ0W-0004nq-SG
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 10:15:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 65A632E85A0
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 10:05:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 09:51:20 -0000
From: Thomas Huth <893367@bugs.launchpad.net>
Reply-To: Bug 893367 <893367@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111121224725.1095.57791.malonedeb@wampee.canonical.com>
Message-Id: <150970268090.9364.11326447158017620704.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 893367] Re: HPET supports only one IRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I assume this has been fixed by this commit here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7a10ef51c2397ac4323b
Or is there still something left to do here?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/893367

Title:
  HPET supports only one IRQ

Status in QEMU:
  Incomplete

Bug description:
  The emulated HPET only supports triggering IRQ 2. Since MSIs are by
  default disabled, this severely limits the usefulness of the HPET as
  only one timer block can effectively be used (otherwise they would
  share IRQ 2). Ideally, the HPET should support as much timer blocks as
  CPUs and each timer block can be driven by a different IRQ.

  TIMER: HPET at fed00000 -> 0xbf500000.
  TIMER: HPET vendor 8086 revision 01: LEGACY 64BIT
  TIMER: HPET: cap 8086a201 config 0 period 10000000
  TIMER: HPET Timer[0]: config 30 int 4
  TIMER: HPET Timer[1]: config 30 int 4
  TIMER: HPET Timer[2]: config 30 int 4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/893367/+subscriptions
