Received: from eggs.gnu.org ([2001:4830:134:3::10]:46644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYUm0-0007AP-7Q
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYUlw-00040m-64
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:30:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYUlw-00040a-0K
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:30:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYUlu-0008KS-Dh
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 09:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 63C282E80AE
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 09:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2017 09:12:31 -0000
From: Thomas Huth <1026176@bugs.launchpad.net>
Reply-To: Bug 1026176 <1026176@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120718144939.31209.59720.malonedeb@gac.canonical.com>
Message-Id: <20170131091231.11663.46003.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1026176] Re: unable to boot squashfs through mtd
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... QEMU 1.1 is pretty much outdated, can we
close this bug nowadays? Can you still reproduce the issue with the
latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1026176

Title:
  unable to boot squashfs through mtd device

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  I have built latest qemu archive qemu-1.1.1 to be sure of up to date sour=
ce code.
  I have then built buildroot squashfs image, which can be used correctly w=
ith cmdline like:

  qemu-system-i386 -m 64 -k fr -boot c -kernel images/bzImage -drive
  if=3Dide,file=3Dimages/rootfs.squashfs  -append "root=3D/dev/sda"

  Then I wanted to modify cmdline to use real MTD device, like:

  qemu-system-i386 -m 64 -k fr -boot c -kernel images/bzImage -drive
  if=3Dmtd,file=3Dimages/rootfs.squashfs  -append "root=3D/dev/mtdblock0".

  But nothing was good under kernel.
  Even if mtd0 is reported through qemu interface (Ctrl Alt+2), no device c=
an be found under kernel even if all drivers are built to use it.

  Is this feature okay on qemu-1.1.1 ??
  did I do mistake in my cmdline??

  thank you for your help.
  regards,

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1026176/+subscriptions
