Received: from eggs.gnu.org ([2001:4830:134:3::10]:35624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmKg9-0000Wd-VO
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmKg6-0006GT-OT
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:10:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:51992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmKg6-0006Fw-Bw
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:10:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmKg4-0003Al-DI
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 15:10:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 602D42E80C8
	for <qemu-devel@nongnu.org>; Sun,  5 Aug 2018 15:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Aug 2018 15:00:25 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1785485 <1785485@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153348122541.17257.2126697988098618689.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785485] [NEW] Mouse moves erratically when using
 scroll wheel on Windows NT 4, Windows 95, and Windows 3.1 guests
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

QEMU version: 3.0.0 RC3
Guests: Windows NT 4.0, Windows 95, Windows 3.1

Program: When the user uses the scroll wheel, the mouse's movement
becomes erratic.

This is noticed immediately when the scroll wheel is used. Sometimes the
problem can be fixed by moving the scroll wheel some more.

My theory is this problem is because of the lack of support for the
Microsoft Intellimouse in these guest operating systems.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-system-i386

** Tags added: qemu-system-i386

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785485

Title:
  Mouse moves erratically when using scroll wheel on Windows NT 4,
  Windows 95, and Windows 3.1 guests

Status in QEMU:
  New

Bug description:
  QEMU version: 3.0.0 RC3
  Guests: Windows NT 4.0, Windows 95, Windows 3.1

  Program: When the user uses the scroll wheel, the mouse's movement
  becomes erratic.

  This is noticed immediately when the scroll wheel is used. Sometimes
  the problem can be fixed by moving the scroll wheel some more.

  My theory is this problem is because of the lack of support for the
  Microsoft Intellimouse in these guest operating systems.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785485/+subscriptions
