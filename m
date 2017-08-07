Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deln4-0005Rv-CV
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1delmz-0003Jm-GU
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:26:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:49837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1delmz-0003IX-B1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:26:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1delmw-0003um-Mp
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 17:25:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ABCDB2E80D0
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 17:25:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Aug 2017 17:08:25 -0000
From: Thomas Huth <1088617@bugs.launchpad.net>
Reply-To: Bug 1088617 <1088617@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121210194219.16564.99346.malonedeb@chaenomeles.canonical.com>
Message-Id: <150212570602.19046.5194992862895647230.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1088617] Re: qemu-system-mipsel save/restore
 broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1088617

Title:
  qemu-system-mipsel save/restore broken

Status in QEMU:
  Incomplete

Bug description:
  Save and restore on mipsel seems to be broken (tested with commit
  1c97e303d4ea80a2691334b0febe87a50660f99d). To reproduce:

  1. Download debian_squeeze_mipsel_standard.qcow2 and vmlinux-2.6.32-5
  -4kc-malta from from http://people.debian.org/~aurel32/qemu/mipsel/

  2. Boot the system. I had to ^D past a Bus error in fsck, which may be an=
other bug (haven't investigated). The command line used was:
  qemu-system-mipsel -M malta -kernel vmlinux-2.6.32-5-4kc-malta -hda debia=
n_squeeze_mipsel_standard.qcow2 -append "root=3D/dev/sda1 console=3Dtty0" -=
k en-us -vnc :0

  3. Once the system is booted, go to the monitor and do "savevm
  booted". Then quit.

  4. Re-run qemu-system-mipsel again with "-loadvm booted". The guest
  system comes back but is hung (the monitor remains responsive,
  however).

  I also captured a debug log, which is attached. The immediate cause of
  the freeze seems to be that it's stuck in a loop repeatedly handling
  the same page fault over and over.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1088617/+subscriptions
