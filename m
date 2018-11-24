Received: from eggs.gnu.org ([2001:4830:134:3::10]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gQeeP-00011Z-7o
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 15:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gQeeM-0007TU-28
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 15:35:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:51708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gQeeL-0007QI-Ss
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 15:35:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gQeeK-00026Y-OD
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 20:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ADC9A2E8031
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 20:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Nov 2018 20:29:37 -0000
From: GH Cao <1804961@bugs.launchpad.net>
Reply-To: Bug 1804961 <1804961@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154309137717.32238.5287661827417174062.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1804961] [NEW] qemu-system-aarch64: Windows 10
 ARM64 BSoD on boot while using virt-3.0
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

When I emulate a virt-3.0 machine, Windows 10 BSoD on boot, with the
error code being ACPI_BIOS_ERROR(0x000000A5), virt-2.12 boots fine.

Windows Build: 10.0.17134.1
QEMU version: 3.0.0
Commandline: qemu-system-aarch64 -M virt -accel tcg,thread=3Dmulti -cpu cor=
tex-a57 -smp 2 -m 2048 -bios QEMU_EFI.fd -device ramfb -device nec-usb-xhci=
 -device usb-kbd -device usb-tablet -hda disk.vhd -vnc :0

By the way, the patch to add DBG2 table discussed here
https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg02550.html
works (although minor change is required to adapt to the qemu 3.0.0
code), the table is accepted by Windows (Windows require both DBG2 and
SPCR to be valid for serial kernel debugging to work), so it may help
further diagnosing this issue.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1804961

Title:
  qemu-system-aarch64: Windows 10 ARM64 BSoD on boot while using
  virt-3.0

Status in QEMU:
  New

Bug description:
  When I emulate a virt-3.0 machine, Windows 10 BSoD on boot, with the
  error code being ACPI_BIOS_ERROR(0x000000A5), virt-2.12 boots fine.

  Windows Build: 10.0.17134.1
  QEMU version: 3.0.0
  Commandline: qemu-system-aarch64 -M virt -accel tcg,thread=3Dmulti -cpu c=
ortex-a57 -smp 2 -m 2048 -bios QEMU_EFI.fd -device ramfb -device nec-usb-xh=
ci -device usb-kbd -device usb-tablet -hda disk.vhd -vnc :0

  By the way, the patch to add DBG2 table discussed here
  https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg02550.html
  works (although minor change is required to adapt to the qemu 3.0.0
  code), the table is accepted by Windows (Windows require both DBG2 and
  SPCR to be valid for serial kernel debugging to work), so it may help
  further diagnosing this issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1804961/+subscriptions
