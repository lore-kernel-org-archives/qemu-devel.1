Received: from eggs.gnu.org ([2001:4830:134:3::10]:37821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dyw2x-0000KZ-JI
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dyw2t-00071b-K3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:25:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:53858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dyw2t-00071L-E4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:25:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dyw2s-0000G4-Ei
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 08:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 641B22E80C9
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 08:25:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Oct 2017 08:09:24 -0000
From: degaart <1720747@bugs.launchpad.net>
Reply-To: Bug 1720747 <1720747@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150693176480.12531.16110985684288309886.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1720747] [NEW] cannot extract release tarball on
 case-insensitive filesystems
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Public bug reported:

Extracting the release tarball for qemu-2.10.0 results in an error on
case-insensitive filesystems (e.g: macOS) because one is a directory
(qemu-2.10.0/roms/u-boot/scripts/Kconfig) and the other one is a file
(qemu-2.10.0/roms/u-boot/scripts/kconfig).

All other files are extracted correctly, and the resulting source can be
built correctly.

But tar returns with an error, which creates difficulties when trying to
automate the build process (e.g: homebrew).

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Extracting the release tarball for qemu-2.10.0 results in an error on
- case-insensitive filesystems because of the files
- qemu-2.10.0/roms/u-boot/scripts/Kconfig and
- qemu-2.10.0/roms/u-boot/scripts/kconfig.
+ case-insensitive filesystems because one is a directory
+ (qemu-2.10.0/roms/u-boot/scripts/Kconfig) and the other one is a file
+ (qemu-2.10.0/roms/u-boot/scripts/kconfig).
  =

  All other files are extracted correctly, and the resulting source can be
  built correctly.
  =

  But tar returns with an error, which creates difficulties when trying to
  automate the build process (e.g: homebrew).

** Description changed:

  Extracting the release tarball for qemu-2.10.0 results in an error on
- case-insensitive filesystems because one is a directory
+ case-insensitive filesystems (e.g: macOS) because one is a directory
  (qemu-2.10.0/roms/u-boot/scripts/Kconfig) and the other one is a file
  (qemu-2.10.0/roms/u-boot/scripts/kconfig).
  =

  All other files are extracted correctly, and the resulting source can be
  built correctly.
  =

  But tar returns with an error, which creates difficulties when trying to
  automate the build process (e.g: homebrew).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1720747

Title:
  cannot extract release tarball on case-insensitive filesystems

Status in QEMU:
  New

Bug description:
  Extracting the release tarball for qemu-2.10.0 results in an error on
  case-insensitive filesystems (e.g: macOS) because one is a directory
  (qemu-2.10.0/roms/u-boot/scripts/Kconfig) and the other one is a file
  (qemu-2.10.0/roms/u-boot/scripts/kconfig).

  All other files are extracted correctly, and the resulting source can
  be built correctly.

  But tar returns with an error, which creates difficulties when trying
  to automate the build process (e.g: homebrew).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1720747/+subscriptions
