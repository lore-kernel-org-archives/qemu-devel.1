Received: from eggs.gnu.org ([2001:4830:134:3::10]:35927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGQyL-0000i3-D3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGQyG-0007YU-Bp
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:21:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dGQyG-0007YI-0N
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:21:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dGQyB-0007oL-Kl
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 14:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A76A62E8237
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 14:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Jun 2017 14:15:19 -0000
From: Kurban Mallachiev <1694998@bugs.launchpad.net>
Reply-To: Bug 1694998 <1694998@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149632651904.23369.12296046707149421968.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1694998] [NEW] PPC: msgsnd instruction leads to
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

Public bug reported:

I tried to send doorbells (using msgsnd) between cores in guest OS. On QEMU=
 v2.9.0 usage of msgsnd instruction leads to error:
ERROR: <...>/qemu-new/translate-common.c:34:tcg_handle_interrupt: assertion=
 failed: (qemu_mutex_iothread_locked())


QEMU v2.8.0 works fine.

QEMU run options: qemu-system-ppc -serial stdio -M ppce500 -cpu e500mc
-smp 2 -m 512M -kernel pok.elf

pok.elf attached

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "os image"
   https://bugs.launchpad.net/bugs/1694998/+attachment/4887363/+files/pok.e=
lf

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1694998

Title:
  PPC: msgsnd instruction leads to assertion

Status in QEMU:
  New

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
