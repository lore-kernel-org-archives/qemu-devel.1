Received: from eggsout.gnu.org ([209.51.188.92]:38296 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gflPS-00047k-3a
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 07:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gflPO-0004y4-D5
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 07:50:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:51882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gflPO-0004rS-5i
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 07:50:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gflPM-0004SB-Br
	for <qemu-devel@nongnu.org>; Sat, 05 Jan 2019 12:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 51C142E80C7
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 12:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Jan 2019 12:43:52 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1810590 <1810590@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154669223236.4865.11026787151425960550.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810590] [NEW] Record/replay example does not work
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

Trying the record part of the record/replay example at
https://github.com/qemu/qemu/blob/master/docs/replay.txt qemu
immediately hangs with no guest output displayed.  This is with qemu
from today's git (e59dbbac0364344a3ad84c3497a98c56003d3fb8).

To reproduce:

  wget
https://people.debian.org/~aurel32/qemu/i386/debian_squeeze_i386_standard.q=
cow2

  mv debian_squeeze_i386_standard.qcow2 disk.qcow2

  qemu-system-i386 \
       -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin \
       -drive file=3Ddisk.qcow2,if=3Dnone,id=3Dimg-direct \
       -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkr=
eplay \
       -device ide-hd,drive=3Dimg-blkreplay \
       -netdev user,id=3Dnet1 -device rtl8139,netdev=3Dnet1 \
       -object filter-replay,id=3Dreplay,netdev=3Dnet1

The above qemu command line is exactly the same as in the example.

Tested on a Debian 9 x86_64 host.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810590

Title:
  Record/replay example does not work

Status in QEMU:
  New

Bug description:
  Trying the record part of the record/replay example at
  https://github.com/qemu/qemu/blob/master/docs/replay.txt qemu
  immediately hangs with no guest output displayed.  This is with qemu
  from today's git (e59dbbac0364344a3ad84c3497a98c56003d3fb8).

  To reproduce:

    wget
  https://people.debian.org/~aurel32/qemu/i386/debian_squeeze_i386_standard=
.qcow2

    mv debian_squeeze_i386_standard.qcow2 disk.qcow2

    qemu-system-i386 \
         -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin \
         -drive file=3Ddisk.qcow2,if=3Dnone,id=3Dimg-direct \
         -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-bl=
kreplay \
         -device ide-hd,drive=3Dimg-blkreplay \
         -netdev user,id=3Dnet1 -device rtl8139,netdev=3Dnet1 \
         -object filter-replay,id=3Dreplay,netdev=3Dnet1

  The above qemu command line is exactly the same as in the example.

  Tested on a Debian 9 x86_64 host.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810590/+subscriptions
