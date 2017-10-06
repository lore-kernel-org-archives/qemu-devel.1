Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0TPn-0005jn-Ja
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0TPi-0007X4-JE
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:15:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:41658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e0TPi-0007VE-D3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e0TPh-0004o1-8E
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 14:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 37DD12E80D0
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 14:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Oct 2017 14:09:18 -0000
From: Jan Heidbrink <1721788@bugs.launchpad.net>
Reply-To: Bug 1721788 <1721788@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721788] [NEW] Failed to get shared "write" lock
 with 'qemu-img info'
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

When running 'qemu-img info test.qcow2' while test.qcow2 is currently
used by a Qemu process, I get the error

qemu-img: Could not open 'test.qcow2': Failed to get shared "write"
lock.


Why does displaying information about a disk image need a write lock for th=
e file?

Steps to reproduce:

qemu-img create -f qcow2 test.qcow2 10M
qemu-system-x86_64 -nographic -drive file=3Dtest.qcow2
qemu-img info test.qcow2

The above was tested with Qemu version 2.10.0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721788

Title:
  Failed to get shared "write" lock with 'qemu-img info'

Status in QEMU:
  New

Bug description:
  When running 'qemu-img info test.qcow2' while test.qcow2 is currently
  used by a Qemu process, I get the error

  qemu-img: Could not open 'test.qcow2': Failed to get shared "write"
  lock.

  =

  Why does displaying information about a disk image need a write lock for =
the file?

  Steps to reproduce:

  qemu-img create -f qcow2 test.qcow2 10M
  qemu-system-x86_64 -nographic -drive file=3Dtest.qcow2
  qemu-img info test.qcow2

  The above was tested with Qemu version 2.10.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721788/+subscriptions
