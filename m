Received: from eggs.gnu.org ([2001:4830:134:3::10]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVbam-0003bi-38
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVbai-0001Zs-4X
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:11:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:42841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVbah-0001Zn-V8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:11:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVbag-0002ya-3K
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:11:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 13BF02E8199
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:11:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 09:57:38 -0000
From: Kai Cong <1658634@bugs.launchpad.net>
Reply-To: Bug 1658634 <1658634@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170123095738.20994.7212.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658634] [NEW] Can't get correct display with
 latest QEMU and OVMF BIOS
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

I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and OVM=
F UEFI BIOS, however I can't get correct display output with default vga co=
nfiguration (-vga std). However, qemu works with a couple of different conf=
igurations:
1. "-vga cirrus" + "-bios OVMF.fd": works
2. "-vga std" + non-UEFI bios: works

The same error with QEMU 2.8.0 release. Everything works well on
2.7.0/1.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658634

Title:
  Can't get correct display with latest QEMU and OVMF BIOS

Status in QEMU:
  New

Bug description:
  I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and O=
VMF UEFI BIOS, however I can't get correct display output with default vga =
configuration (-vga std). However, qemu works with a couple of different co=
nfigurations:
  1. "-vga cirrus" + "-bios OVMF.fd": works
  2. "-vga std" + non-UEFI bios: works

  The same error with QEMU 2.8.0 release. Everything works well on
  2.7.0/1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
