Received: from eggs.gnu.org ([2001:4830:134:3::10]:53522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdNKf-0002or-S6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdNKc-0006VU-Nt
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:34:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:54477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdNKc-0006VO-IV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:34:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdNKb-0002SC-Le
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:34:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9615C2E80CC
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:34:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Feb 2017 20:25:22 -0000
From: Thomas Huth <994412@bugs.launchpad.net>
Reply-To: Bug 994412 <994412@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120504064349.15106.35375.malonedeb@soybean.canonical.com>
Message-Id: <20170213202522.5112.31214.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 994412] Re: reverse vnc to unix domain sockets
 does not work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like this should work nowadays (of course you need to start a
listening program first), so closing this bug ticket now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/994412

Title:
  reverse vnc to unix domain sockets does not work

Status in QEMU:
  Fix Released

Bug description:
  I tried to connect to a unix domain socket, but failed.

  $ qemu -vnc unix:/tmp/my.sock,reverse
  connect(unix:/tmp/my.sock,reverse): No such file or directory

  I guess it is because unix_connect does not remove characters after
  first comma.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/994412/+subscriptions
