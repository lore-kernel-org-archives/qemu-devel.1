Received: from eggs.gnu.org ([2001:4830:134:3::10]:54819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d1yrz-0001N0-KJ
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d1yrv-0000Wm-Mq
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:30:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:57547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d1yrv-0000WZ-GP
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d1yrt-000234-T1
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 17:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9CFD2E80C9
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 17:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Apr 2017 17:20:53 -0000
From: Ronsor <1685526@bugs.launchpad.net>
Reply-To: Bug 1685526 <1685526@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170422172053.5751.58959.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1685526] [NEW] UEFI firmware can't write to
 "fake" FAT hard disk
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

Using the Tianocore OVMF UEFI firmware, a UEFI application cannot write
to the emulated fat disk (-hda fat:rw:path/here). A file will get
created or written, but will be corrupted.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1685526

Title:
  UEFI firmware can't write to "fake" FAT hard disk

Status in QEMU:
  New

Bug description:
  Using the Tianocore OVMF UEFI firmware, a UEFI application cannot
  write to the emulated fat disk (-hda fat:rw:path/here). A file will
  get created or written, but will be corrupted.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1685526/+subscriptions
