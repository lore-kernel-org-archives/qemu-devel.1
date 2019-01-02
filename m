Received: from eggs.gnu.org ([208.118.235.92]:54718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1geeZt-0004wb-Q5
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1geeZl-0002Nk-4C
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:20:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:34348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1geeZj-0002La-76
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:20:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1geeZh-0001Qe-9S
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 11:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 409D32E80C7
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 11:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jan 2019 11:08:33 -0000
From: Thomas Huth <1810000@bugs.launchpad.net>
Reply-To: Bug 1810000 <1810000@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154603590627.5548.1380267988808710453.malonedeb@wampee.canonical.com>
Message-Id: <154642731349.4953.17413195003535364372.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810000] Re: qemu system emulator crashed with
 the attachment of usb-bt-dongle device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the bug report! Unfortunately, the bluetooth code in QEMU is
completely unmaintained and quite bit-rotten already, so it is already
marked as deprecated and will be removed soon unless somebody steps up
and volunteers to maintain it:

 https://qemu.weilnetz.de/doc/qemu-doc.html#bluetooth-_0028since-
3_002e1_0029

For the time being, you likely have to use "-device pci-ohci" instead of
"-device qemu-xhci" if you want to try to use it...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810000

Title:
  qemu system emulator crashed with the attachment of usb-bt-dongle
  device

Status in QEMU:
  New

Bug description:
  I am testing usb-bt-dongle device on xchi host controller, and found
  that the qemu crashed directly with an assertion failer.

  Here is the information to reproduce the crash:

  Qemu git revision: 9b2e891ec5ccdb4a7d583b77988848282606fdea
  System emulator: qemu-x86_64
  VM image: https://people.debian.org/~aurel32/qemu/amd64/debian_squeeze_am=
d64_desktop.qcow2
  CommandLine: qemu-system-x86_64 -M q35 -device qemu-xhci,id=3Dxhci -enabl=
e-kvm -device usb-bt-dongle  -hda ./debian_wheezy_amd64_standard.qcow2

  Error message:

  qemu-system-x86_64: /build/qemu-
  Eap4uc/qemu-2.11+dfsg/hw/usb/core.c:592: usb_packet_copy: Assertion
  `p->actual_length + bytes <=3D iov->size' failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810000/+subscriptions
