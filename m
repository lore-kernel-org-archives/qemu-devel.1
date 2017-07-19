Received: from eggs.gnu.org ([2001:4830:134:3::10]:37175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi6-0005B7-MU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi5-0001nV-FS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:37840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXgi5-0001n7-9I
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXgi4-0003q0-Ao
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E4932E8078
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 04:17:52 -0000
From: Launchpad Bug Tracker <924943@bugs.launchpad.net>
Reply-To: Bug 924943 <924943@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120201160448.7612.88961.malonedeb@gac.canonical.com>
Message-Id: <150043787286.28289.9340363670691258410.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/924943

Title:
  usb-host devices given by command line are routed incomplete to the
  guest

Status in QEMU:
  Expired

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
