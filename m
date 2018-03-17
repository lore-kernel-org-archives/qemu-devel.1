Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exCm7-0002MT-Ov
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 10:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exCm3-0007eh-J7
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 10:25:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:39682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1exCm3-0007cx-8c
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 10:25:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1exCm2-00026P-9t
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 14:25:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4100F2E80CB
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 14:25:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Mar 2018 14:20:24 -0000
From: Giles Gaffney <1756538@bugs.launchpad.net>
Reply-To: Bug 1756538 <1756538@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152129153470.15061.1404987375350201277.malonedeb@chaenomeles.canonical.com>
Message-Id: <152129642408.6868.15407120391613262602.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756538] Re: Minimal Ubuntu vs. Debian differences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

One more: Qemu on Debian 9-10 minimal requires -show cursor command to
use the mouse inside a windows guest, but with Qemu on Ubuntu minimal
the cursor is controllable by default. Again, this is all within the
context of an Android/Arm8/Linux minimal/Chroot-based host.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756538

Title:
  Minimal Ubuntu vs. Debian differences

Status in QEMU:
  New

Bug description:
  I'm using Qemu on Ubuntu (minimal) and Debian (minimal) on Android
  (Arch64) via Linux Deploy to run Windows guests. Here's a few issues I
  encountered:

  1) Qemu on (minimal) Debian 9 and Ubuntu cannot run Windows 7-10
  guests (only Windows XP and below) because there's a black screen
  after the boot menu. Qemu on Debian 10, however, can run Windows 7.
  Incidentally, these distros run on the host in bios compatibility mode
  instead of UEFI. Ubuntu Desktop (full distro) on other hosts does not
  display the black screen when running Qemu.

  2) Qemu on Debian 9-10 (minimal) does not display fullscreen - but
  Ubuntu minimal does display full-screen.

  3) Qemu on Limbo PC Emulator and on Debian 9-10 only run windows
  guests at 1 GHz using the default Qemu CPU, but Ubuntu runs windows
  guests at 2 GHz using the default Qemu CPU.

  4) Enable KVM doesn't work, and virtualization isn't detected through
  Limbo PC Emulator and minimal Linux distros running on Android -
  perhaps is a problem with running Linux distros via Linux Deploy using
  Chroot on Android (not so much a Qemu-KVM issue) and failing to detect
  ARMv8-A CPUs that are indeed capable of virtualization.

  Can anyone explain these differences? I believe they are all using the
  latest versions of Qemu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756538/+subscriptions
