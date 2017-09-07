Received: from eggs.gnu.org ([2001:4830:134:3::10]:44211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dprQy-0006Zg-2W
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dprQu-00052E-Vt
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:41:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:39240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dprQu-00051X-Pu
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:41:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dprQq-0006jR-FW
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 07:41:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C1EB2E80D4
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 07:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Sep 2017 07:34:58 -0000
From: "Marcelo \"Marc\" Ranolfi" <1715573@bugs.launchpad.net>
Reply-To: Bug 1715573 <1715573@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150476969887.8690.16755555210360995739.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715573] [NEW] Android-x86_64 guest - "Could not
 disable RealTimeClock events (20160831/evxfevnt-267)";
 UI sluggish, ACPI doesn't work with QEMU 2.10.0
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

I'm running a custom-built Android-x86_64 guest in an Arch Linux host
with the 4.12.10 kernel.

Following the latest Arch Linux upgrade to QEMU 2.10.0-1, upon booting
the virtual machine, I get the error mentioned in the title. Afterwards,
the virtual machine becomes slower and slower. The ACPI functions (the
libvirt's Shutdown button, for example) don't work.

When I downgrade to QEMU 2.9.0-3 everything works fine once again.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715573

Title:
  Android-x86_64 guest - "Could not disable RealTimeClock events
  (20160831/evxfevnt-267)"; UI sluggish, ACPI doesn't work with QEMU
  2.10.0

Status in QEMU:
  New

Bug description:
  I'm running a custom-built Android-x86_64 guest in an Arch Linux host
  with the 4.12.10 kernel.

  Following the latest Arch Linux upgrade to QEMU 2.10.0-1, upon booting
  the virtual machine, I get the error mentioned in the title.
  Afterwards, the virtual machine becomes slower and slower. The ACPI
  functions (the libvirt's Shutdown button, for example) don't work.

  When I downgrade to QEMU 2.9.0-3 everything works fine once again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715573/+subscriptions
