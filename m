Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBoJo-0006lr-QI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBoJj-0005ee-Se
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:20:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:43176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBoJj-0005eK-MJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBoJi-0008AO-Oo
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 21:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9F1182E80C7
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 21:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 21:14:50 -0000
From: nada <1767200@bugs.launchpad.net>
Reply-To: Bug 1767200 <1767200@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152477729035.32740.12821774063572767433.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1767200] [NEW] Kernel Panic Unable to mount root
 fs on unknown-block(31, 3)
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

Using the latest qemu:
qemu-system-arm.exe -kernel C:\Users\a\Downloads\kernel-qemu-4.4.34-jessie =
-cpu arm1176 -m 256 -machine versatilepb -cdrom C:\Users\a\Downloads\picore=
-9.0.3.img

Gives error:
Kernel Panic Unable to mount root fs on unknown-block(31,3)

I have tried different ARMv6 ARMv7 images/kernels with the same result.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "VFS Kernel Panic Unable to mount root fs on unknown-b=
lock(31,3)"
   https://bugs.launchpad.net/bugs/1767200/+attachment/5127917/+files/Qemu-=
PANIC-VFS-31-3.JPG

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1767200

Title:
  Kernel Panic Unable to mount root fs on unknown-block(31,3)

Status in QEMU:
  New

Bug description:
  Using the latest qemu:
  qemu-system-arm.exe -kernel C:\Users\a\Downloads\kernel-qemu-4.4.34-jessi=
e -cpu arm1176 -m 256 -machine versatilepb -cdrom C:\Users\a\Downloads\pico=
re-9.0.3.img

  Gives error:
  Kernel Panic Unable to mount root fs on unknown-block(31,3)

  I have tried different ARMv6 ARMv7 images/kernels with the same
  result.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1767200/+subscriptions
