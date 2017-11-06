Received: from eggs.gnu.org ([2001:4830:134:3::10]:55970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBjN9-0007f0-7W
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBjN5-0001K3-87
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:31:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBjN5-0001JY-1y
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:31:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBjN2-00049P-4v
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 15:31:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D0262E81C1
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 15:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 15:20:56 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1728448 <1728448@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150930506825.20259.326196094575831329.malonedeb@soybean.canonical.com>
Message-Id: <150998165617.8759.1831986123205057831.malone@wampee.canonical.com>
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

I'm closing this bug as it's a command line issue. Please open a new bug
if you have further problems.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728448

Title:
  qemu-system-arm segmentation fault with cpu cortex-m*

Status in QEMU:
  Invalid

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
