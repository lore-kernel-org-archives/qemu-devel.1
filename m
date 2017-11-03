Received: from eggs.gnu.org ([2001:4830:134:3::10]:54247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAgou-0002Rh-2F
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAgoq-0004zV-Tw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAgoq-0004z2-NI
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAgon-0006Jj-Og
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 18:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 87ACC2E80D8
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 18:35:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 18:28:21 -0000
From: Kevin <1728448@bugs.launchpad.net>
Reply-To: Bug 1728448 <1728448@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150930506825.20259.326196094575831329.malonedeb@soybean.canonical.com>
Message-Id: <150973370140.4312.7524581396586106645.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728448] Re: qemu-system-arm segmentation fault
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

Thank you for you answer.

I wanted to emulate under cortex-M3 because I need to ex=C3=A9utute an
executable who will install a kernel but only runs under cortex-M3, for
then realized fuzzing on this kernel.

But, I will try with freeRTOS.

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
