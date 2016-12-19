Received: from eggs.gnu.org ([2001:4830:134:3::10]:33547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2x6-0003Ma-Va
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2x2-0004W1-2w
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:46:25 -0500
Received: from indium.canonical.com ([91.189.90.7]:51514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cJ2x1-0004VL-Su
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:46:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cJ2wz-0002s6-Eq
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:46:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1ABE82E80DF
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:46:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2016 18:30:57 -0000
From: Thomas Huth <1251470@bugs.launchpad.net>
Reply-To: Bug 1251470 <1251470@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131114233217.18611.57360.malonedeb@wampee.canonical.com>
Message-Id: <20161219183057.14763.5434.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1251470] Re: Guest not working in KVM mode but
 does in TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to comment #3, this bug has been fixed, so I'm closing this
ticket now. If you can still reproduce this issue with the latest
version from QEMU, please feel free to open this ticket again.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1251470

Title:
  Guest not working in KVM mode but does in TCG mode

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Saucy:
  Won't Fix

Bug description:
  Qemu: 1.5.0 (Debian 1.5.0+dfsg-3ubuntu5)
  Host: Ubuntu 13.10 x86_64 (Intel Core i7-950)
  Guest: FreeBSD 9.2 RELEASE x86_64

  As initially reported here: https://www.redhat.com/archives/libvirt-users=
/2013-November/msg00066.html
  I was told that this is a bug in Qemu.

  Basically this command works:
  qemu-system-x86_64 -hda images/FreeBSD-9.2-RELEASE-amd64.img

  But this one doesn't:
  qemu-system-x86_64 -machine accel=3Dkvm -hda images/FreeBSD-9.2-RELEASE-a=
md64.img

  FreeBSD is stuck after the bootloader:
  Booting...
  CPU doesn't support long mode

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1251470/+subscriptions
