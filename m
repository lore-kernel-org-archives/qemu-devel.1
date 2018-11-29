Received: from eggs.gnu.org ([2001:4830:134:3::10]:56147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSEW5-0003co-OK
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 00:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSEW2-0006RS-Ie
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 00:05:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:40440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gSEW2-0006QJ-9p
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 00:05:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gSEW1-0007ac-7O
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 05:05:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1608E2E80CB
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 05:05:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Nov 2018 04:57:15 -0000
From: GH Cao <1804961@bugs.launchpad.net>
Reply-To: Bug 1804961 <1804961@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154309137717.32238.5287661827417174062.malonedeb@wampee.canonical.com>
Message-Id: <154346743526.16870.13148512763185660507.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1804961] Re: qemu-system-aarch64: Windows 10
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

And the namespace objects tree of virt-2.12 is this.
https://pastebin.com/GybigJ9r

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
  https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg01719.html
  works (although minor change is required to adapt to the qemu 3.0.0
  code), the table is accepted by Windows (Windows require both DBG2 and
  SPCR to be valid for serial kernel debugging to work), so it may help
  further diagnosing this issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1804961/+subscriptions
