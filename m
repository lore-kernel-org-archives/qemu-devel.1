Received: from eggs.gnu.org ([209.51.188.92]:43454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDhrF-000729-Fd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 23:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDhrD-0008MV-Uy
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 23:55:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:55542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDhrD-0008LK-L6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 23:55:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDhrB-0000yI-Fz
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 03:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6FBDB2E80C7
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 03:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2019 03:46:49 -0000
From: Chen Zhang <1823831@bugs.launchpad.net>
Reply-To: Bug 1823831 <1823831@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155478160922.20745.7830680070590942423.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1823831] [NEW] BSD bootloader halts with
 hypervisor.framework
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

Guest: FreeBSD 12.0 Install CD
Host: MacOS 11.14.3 qemu master at 90fb864a7df0a9af677352e94f8225f7b03de922

Command arguments:

qemu-system-x86_64 -m 4000m -cdrom Downloads/FreeBSD-12.0-RELEASE-
amd64-bootonly.iso

When qemu was run with -accel hvf, the bootloader would halt after
showing the menu. The bootloader would not respond to any keyboard
events.

Without acceleration option, the bootloader would count down to zero and
proceed.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: hvf osx

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823831

Title:
  BSD bootloader halts with hypervisor.framework

Status in QEMU:
  New

Bug description:
  Guest: FreeBSD 12.0 Install CD
  Host: MacOS 11.14.3 qemu master at 90fb864a7df0a9af677352e94f8225f7b03de9=
22

  Command arguments:

  qemu-system-x86_64 -m 4000m -cdrom Downloads/FreeBSD-12.0-RELEASE-
  amd64-bootonly.iso

  When qemu was run with -accel hvf, the bootloader would halt after
  showing the menu. The bootloader would not respond to any keyboard
  events.

  Without acceleration option, the bootloader would count down to zero
  and proceed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823831/+subscriptions
