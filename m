Received: from eggs.gnu.org ([2001:4830:134:3::10]:38046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1frhXQ-0007mJ-LZ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1frhXN-0007pA-2F
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:50482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1frhXM-0007oJ-R2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1frhXL-0007UQ-Hz
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:35:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C16F2E8524
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:35:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Aug 2018 10:16:42 -0000
From: Thomas Huth <1485010@bugs.launchpad.net>
Reply-To: Bug 1485010 <1485010@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150814151143.30623.64529.malonedeb@soybean.canonical.com>
Message-Id: <153476020255.16984.7399178651068485928.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1485010] Re: qemu-guest-agent should support
 systemd in addition to pmutils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This should now be fixed:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D067927d62e097a8a3624a9

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1485010

Title:
  qemu-guest-agent should support systemd in addition to pmutils

Status in QEMU:
  Fix Released

Bug description:
  Hello,

  Shouldn't the qemu-guest-agent also support systemd function in
  addition to the existing call to pm-suspend, shutdown, hwclock?

  Some machines doesn't have pm-utils at all now.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1485010/+subscriptions
