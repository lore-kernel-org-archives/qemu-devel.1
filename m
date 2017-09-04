Received: from eggs.gnu.org ([2001:4830:134:3::10]:42581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dokl1-0002NJ-5O
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dokkx-0000Y9-6n
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:21:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:51471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dokkx-0000XV-1J
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:21:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dokkv-0007aV-FC
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 06:21:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3737D2E81A5
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 06:21:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Sep 2017 06:09:37 -0000
From: Thomas Huth <1714750@bugs.launchpad.net>
Reply-To: Bug 1714750 <1714750@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150442540217.17409.6458222878014636993.malonedeb@gac.canonical.com>
Message-Id: <150450537717.17031.12348170271594679605.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714750] Re: 2.10.0 cannot be installed on
 case-insensitive file system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That's apparently a problem with U-Boot. Could you please report this
issue to the U-Boot project instead (see
https://github.com/u-boot/u-boot)? We only include the u-boot sources in
the QEMU tarballs, but we do not maintain them in the QEMU project, so
we can not fix this issue here for you, sorry.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714750

Title:
  2.10.0 cannot be installed on case-insensitive file system

Status in QEMU:
  New

Bug description:
  The https://download.qemu.org/qemu-2.10.0.tar.bz2 tarball cannot be
  unpacked on a case-insensitive file system because it has a file
  qemu-2.10.0/roms/u-boot/scripts/Kconfig and a directory
  qemu-2.10.0/roms/u-boot/scripts/kconfig. This prevents installation on
  most macOS systems since by default the file system is case
  insensitive. The 2.10.0 upgrade is blocked in Homebrew due to this
  issue. See https://github.com/Homebrew/homebrew-core/pull/17467. This
  is a regression from 2.9.0, which didn't have this problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714750/+subscriptions
