Received: from eggs.gnu.org ([208.118.235.92]:54022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gd0rC-0006FH-54
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gd0eW-0001MJ-Vm
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:30:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:44770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gd0eR-0001AE-MR
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:30:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gd0eQ-0006qK-5Z
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 22:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 249962E804F
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 22:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Dec 2018 22:25:06 -0000
From: PH <1810000@bugs.launchpad.net>
Reply-To: Bug 1810000 <1810000@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154603590627.5548.1380267988808710453.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810000] [NEW] qemu system emulator crashed with
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

Public bug reported:

I am testing usb-bt-dongle device on xchi host controller, and found
that the qemu crashed directly with an assertion failer.

Here is the information to reproduce the crash:

Qemu git revision: 9b2e891ec5ccdb4a7d583b77988848282606fdea
System emulator: qemu-x86_64
VM image: https://people.debian.org/~aurel32/qemu/amd64/debian_squeeze_amd6=
4_desktop.qcow2
CommandLine: qemu-system-x86_64 -M q35 -device qemu-xhci,id=3Dxhci -enable-=
kvm -device usb-bt-dongle  -hda ./debian_wheezy_amd64_standard.qcow2

Error message:

qemu-system-x86_64: /build/qemu-Eap4uc/qemu-2.11+dfsg/hw/usb/core.c:592:
usb_packet_copy: Assertion `p->actual_length + bytes <=3D iov->size'
failed.

** Affects: qemu
     Importance: Undecided
         Status: New

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
