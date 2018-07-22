Received: from eggs.gnu.org ([2001:4830:134:3::10]:50888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60g-0002nY-Sq
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60f-0007I1-IK
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:49992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fh60f-0007Gb-BG
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fh60e-0007QV-I7
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 838CB2E80C3
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jul 2018 04:17:25 -0000
From: Launchpad Bug Tracker <1242963@bugs.launchpad.net>
Reply-To: Bug 1242963 <1242963@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131022003829.24859.20433.malonedeb@wampee.canonical.com>
Message-Id: <153223304581.12964.9504194523679914333.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1242963] Re: QEMU loadvm causes guest OS freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1242963

Title:
  QEMU loadvm causes guest OS freeze

Status in QEMU:
  Expired

Bug description:
  HOST: ubuntu 13.10 x64
  GUEST: winxp sp 3 x86

  AFFECT QEMU(tested): v1.5.2, v1.5.3,  v1.6.0, v1.6.1

  I compile QEMU by myself with "./configure --target-list=3Di386-softmmu &=
& make && make install".
  After installing a winxp sp3 into the qemu-system-i386 with command line:
  > qemu-system-i386 -m 512 -hda xp.img -net user -net nic,model=3Drtl8139 =
-rtc base=3Dlocaltime,clock=3Dvm

  I use monitor to create a live snapshot: =

  > stop
  > savevm xxx
  > cont

  And then I load this snapshot (I also try it in commad line: -loadvm xxx):
  > loadvm xxx
  > cont

  After that, the windows system is freeze (don't accept any keyboard or
  mouse input, although I knew vcpu is still working).

  If I compile with -enable-kvm and launch qemu-system-i386 with -enable-kv=
m, it looks like everything works well.
  I think it is a bug for qemu system.

  BTW: freeze is not appearing 100%, but in my test, 95% cases would
  cause system freeze.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1242963/+subscriptions
