Received: from eggs.gnu.org ([2001:4830:134:3::10]:34773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dS6ft-0005AK-V3
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dS6fo-0002Qg-45
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:06:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:48029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dS6fn-0002QV-Tn
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:06:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dS6fm-0006UT-Uk
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 19:06:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA8382E8195
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 19:06:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jul 2017 18:47:04 -0000
From: 123p <1377095@bugs.launchpad.net>
Reply-To: Bug 1377095 <1377095@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141003105035.5331.35277.malonedeb@wampee.canonical.com>
Message-Id: <149910762442.26937.2866302761545979712.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1377095] Re: KVM guest VM does not reattach a
 throughpassed USB printer from Host after switching printer off and on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is a very annoying bug, and it is still not solved after 2.7 years.
Last versions tested and affected by this bug:

KVM host qemu version 2.9.0

KVM host Linux version 4.9.6 x86_64

Please fix this.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1377095

Title:
  KVM guest VM does not reattach a throughpassed USB printer from Host
  after switching printer off and on

Status in QEMU:
  New

Bug description:
  =

  Host OS: Gentoo, all packages built 2014-10-01

  qemu version 2.1.0-r1

  Linux kernel 3.14.14   x86_64 Intel(R) Core(TM) i3-3220T CPU @ 2.80GHz
  GenuineIntel GNU/Linux

  =

  Guest VM: Debian 7 (Wheezy) Linux 3.2.0 686

  =

  Start command:
  /usr/bin/qemu-system-i386 -enable-kvm -name wheezy -k de -serial null -pa=
rallel null -hda /var/kvm/wheezy.kvm-img -daemonize -net nic,macaddr=3D02:0=
0:00:00:01:31 -net tap,ifname=3Dtap3,script=3Dno,downscript=3Dno -m 512 -pi=
dfile /var/run/kvm/wheezy.pid -usb -usbdevice tablet -runas myuser -vnc 127=
.0.0.1:3 -usbdevice host:04e8:3242

  Problem:
  USB printer pass-through from KVM host to guest vm only works if I start =
the qemu kvm when the USB printer (vendor/product ID 04e8:3242) is switched=
 on and therefore shown in lsusb on the host. Then it is available in the s=
tarted VM.

  But when I switch the usb printer attached to the host off, it
  disappears in lsusb both on the host and the VM (as expected) but when
  I switch the USB printer on again, it is shown on the host and also on
  the QEMU Monitor (Crtl Alt Shift 2 -> info usbhost), but in the VM
  lsusb does not show it again- so USB pass-through / hot plugging does
  not work. It worked with a previous Version of qemu (1.0 or
  something).

  That is very annoying, because every time I want to print something, I ne=
ed to shutdown the VM, start the printer, and then start the VM (which runs=
 cups as printer server).
  But after printing, I do not want the printer to keep running, so I switc=
h it off.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1377095/+subscriptions
