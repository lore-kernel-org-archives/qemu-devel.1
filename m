Received: from eggs.gnu.org ([2001:4830:134:3::10]:33666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzOXI-0007zL-9f
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzOXD-0001Ll-Qm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:51:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:52158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzOXD-0001Iy-K5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzOXB-0006yH-AV
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 14:50:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CC3A62E80DB
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 14:50:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 14:42:45 -0000
From: ilovezfs <1714750@bugs.launchpad.net>
Reply-To: Bug 1714750 <1714750@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150442540217.17409.6458222878014636993.malonedeb@gac.canonical.com>
Message-Id: <150704176538.28030.14661794696600457772.malone@gac.canonical.com>
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

Hurray!

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
