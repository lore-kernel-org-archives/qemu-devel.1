Received: from eggs.gnu.org ([2001:4830:134:3::10]:37429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBoAP-0007J7-4Q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBoAO-0006rT-0A
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:60530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBoAN-0006pN-Pq
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBoAM-0008Tj-VJ
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 20:06:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E91C52E8048
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 20:06:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 19:47:53 -0000
From: Thomas Huth <924943@bugs.launchpad.net>
Reply-To: Bug 924943 <924943@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120201160448.7612.88961.malonedeb@gac.canonical.com>
Message-Id: <149522327356.12490.12135253117559574215.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 924943] Re: usb-host devices given by command
 line are routed incomplete to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you somehow still reproduce this
problem with the latest version of QEMU (currently v2.9), or could we
close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/924943

Title:
  usb-host devices given by command line are routed incomplete to the
  guest

Status in QEMU:
  Incomplete

Bug description:
  affected qemus: qemu-1.0, qemu-kvm-1.0, qemu and qemu-kvm master branches=
 (older versions not tested)
  affected guests: linux, windows
  test hardware: standard usb key (or any other piece of USB hardware) that=
 works perfectly when plugged in after guest bootup

  Several Sequences have been tested:
  - start qemu with  -readconfig /etc/ich9-ehci-uhci.cfg -device usb-tablet=
 -device usb-host,bus=3Dehci.0
  - start qemu with -readconfig /etc/ich9-ehci-uhci.cfg -device usb-tablet =
-S (to not start up the guest directly) + at the console prompt: "device_ad=
d usb-host" then "c" to start the guest.

  For the linux guest, I get a usb device listed and detected as /dev/sdb w=
hen plugging it in at runtime. At startup linux does NOT detect it.
  For the windows guest, I get a usb device listed and detected as "removab=
le media" when plugging it in at runtime. At startup Windows does detect "s=
omething" that is listed in the device manager as Generic Mass Storage devi=
ce, but with a yellow exclamation mark and there is no removable media list=
ed in Explorer

  If you need further testings, just let me know.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/924943/+subscriptions
