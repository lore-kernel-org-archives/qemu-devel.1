Received: from eggs.gnu.org ([2001:4830:134:3::10]:46592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8tN0-0002u7-9T
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 15:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8tMv-0004n9-Cp
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 15:35:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:55840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8tMv-0004mb-5Y
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 15:35:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8tMs-0002mK-3s
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1B54D2E80C3
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Oct 2017 19:24:28 -0000
From: Kevin <1728448@bugs.launchpad.net>
Reply-To: Bug 1728448 <1728448@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150930506825.20259.326196094575831329.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728448] [NEW] qemu-system-arm segmentation fault
 with cpu cortex-m*
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

I try to run an emulation with qemu-system-arm under a cpu cortex-m3 but
any execution under the processor result by a segmentation fault.

My command is : qemu-system-arm -m 256 -M versatilepb -cpu cortex-m3
-kernel ~/qemu/wheezy/vmlinuz-3.2.0-4-versatile -initrd
~/qemu/wheezy/initrd.img-3.2.0-4-versatile -hda ~/qemu/wheezy/hda.img
-append 'root=3D/dev/sda1'

If a lauch the emulation without specifying a cpu equivalent to
cortex-m*, the vm opens up well and works but I absolutely need to run
it under cortex-m3.


Do you have any idea why I have this problem only with this type of process=
or ?

I also try with other boards different from versatilepb but I have the
same result.

I am under ubuntu 17 64bits during my test.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm cortex cpu qemu segfault

** Tags added: qemu

** Tags added: arm

** Tags added: cortex cpu

** Tags added: segfault

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728448

Title:
  qemu-system-arm segmentation fault with cpu cortex-m*

Status in QEMU:
  New

Bug description:
  I try to run an emulation with qemu-system-arm under a cpu cortex-m3
  but any execution under the processor result by a segmentation fault.

  My command is : qemu-system-arm -m 256 -M versatilepb -cpu cortex-m3
  -kernel ~/qemu/wheezy/vmlinuz-3.2.0-4-versatile -initrd
  ~/qemu/wheezy/initrd.img-3.2.0-4-versatile -hda ~/qemu/wheezy/hda.img
  -append 'root=3D/dev/sda1'

  If a lauch the emulation without specifying a cpu equivalent to
  cortex-m*, the vm opens up well and works but I absolutely need to run
  it under cortex-m3.

  =

  Do you have any idea why I have this problem only with this type of proce=
ssor ?

  I also try with other boards different from versatilepb but I have the
  same result.

  I am under ubuntu 17 64bits during my test.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728448/+subscriptions
