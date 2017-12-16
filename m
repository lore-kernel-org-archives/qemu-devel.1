Received: from eggs.gnu.org ([2001:4830:134:3::10]:49378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQ19f-00043A-Op
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 20:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQ19c-0006xT-7f
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 20:20:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQ19c-0006wF-1I
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 20:20:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQ19b-0006HW-5I
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 01:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1FEAA2E80CB
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 01:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Dec 2017 01:08:50 -0000
From: webczat <webczat_200@poczta.onet.pl>
Reply-To: Bug 1738507 <1738507@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151338646328.26229.15531211351993382335.malonedeb@wampee.canonical.com>
Message-Id: <151338653018.18527.15553429081686895415.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738507] Re: qemu sometimes stuck when booting
 windows 10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "log of libvirt's domain containing qemu command line =
arguments passed"
   https://bugs.launchpad.net/qemu/+bug/1738507/+attachment/5023251/+files/=
libvirt-log.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738507

Title:
  qemu sometimes stuck when booting windows 10

Status in QEMU:
  New

Bug description:
  I am using qemu-2.10.1, or actually libvirt, to create a virtual machine,=
 running microsoft windows 10 pro operating system.
  It installed fine and was actually working, however sometimes when trying=
 to boot the vm, the whole boot process gets stuck.
  For some reason, it seemed to happen only when enough physical memory is =
taken so that, when booting a windows vm that has 4gb of available ram, hos=
t starts swapping some other processes. It is not always happening there, b=
ut often it happens, and I do not remember seeing any case of this happenin=
g when not swapping, maybe a kind of a timing issue?
  When this happens, I usually try to hard reset the machine by libvirt res=
et command or equivalent system_reset on qemu monitor, however the whole re=
set does not happen, and the command is a noop. That makes me think it is a=
 qemu bug, not windows refusing operation. At the time of this event, qemu =
monitor and spice server are working correctly, are not stuck, and even doi=
ng things like system reset does not result in a monitor hang. It is also p=
ossible to quit qemu normally.
  I tried to workaround the bug by guessing what may cause it. Switched fro=
m bios to uefi, changed virtio-scsi to ahci temporarily, and disabled virti=
o-balloon in case it would be buggy, with no visible change.
  I will attach a libvirt log, because it contains qemu command line. I wil=
l also attach an example qemu backtrace.
  From what i know, both vcpu threads are working normally, at least none o=
f them is stuck in a vcpu, nor deadlocked, etc. So backtrace could be diffe=
rent each time I tried to get it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738507/+subscriptions
