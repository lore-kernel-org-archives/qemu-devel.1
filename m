Received: from eggs.gnu.org ([2001:4830:134:3::10]:40990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7DqJ-0008RO-Pc
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7DqG-0006n4-KC
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:55451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d7DqG-0006n0-Eb
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d7DqF-0003h8-J1
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 04:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8EF732E80C0
	for <qemu-devel@nongnu.org>; Sun,  7 May 2017 04:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 May 2017 04:25:29 -0000
From: =?utf-8?q?Manfred_H=C3=A4rtel?= <1689003@bugs.launchpad.net>
Reply-To: Bug 1689003 <1689003@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170507042529.2427.25374.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1689003] [NEW] USB passthrough should not fail if
 SET CONFIGURATION fails
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

QEMU's USB passthrough was not working for my new smartphone.

While analyzing the problem, I found out that a SET CONFIGURATION
Request was NACKed by the USB device (probably because a SET
CONFIGURATION request was already sent from the host to the device).

So I wrote a simple program to fake a successful call to
libusb_set_configuration and did an LD_PRELOAD on this program before
starting qemu, and it worked.

Looking at QEMU's code in host-libusb.c, I can see that QEMU does not
try to claim the interface if its call to libusb_set_configuration
fails.

I think QEMU should try to claim the device anyway even if
libusb_set_configuration fails.

I did my tests against QEMU 2.6.2, but as I can see from the source
code, this problem should happen on all versions.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1689003

Title:
  USB passthrough should not fail if SET CONFIGURATION fails

Status in QEMU:
  New

Bug description:
  QEMU's USB passthrough was not working for my new smartphone.

  While analyzing the problem, I found out that a SET CONFIGURATION
  Request was NACKed by the USB device (probably because a SET
  CONFIGURATION request was already sent from the host to the device).

  So I wrote a simple program to fake a successful call to
  libusb_set_configuration and did an LD_PRELOAD on this program before
  starting qemu, and it worked.

  Looking at QEMU's code in host-libusb.c, I can see that QEMU does not
  try to claim the interface if its call to libusb_set_configuration
  fails.

  I think QEMU should try to claim the device anyway even if
  libusb_set_configuration fails.

  I did my tests against QEMU 2.6.2, but as I can see from the source
  code, this problem should happen on all versions.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1689003/+subscriptions
