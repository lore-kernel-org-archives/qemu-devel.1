Received: from eggs.gnu.org ([2001:4830:134:3::10]:35983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJnpe-0005xU-7y
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 15:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJnpV-0007Qv-1d
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 15:49:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cJnpU-0007PY-Gg
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 15:49:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cJnpT-00052Y-4Q
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 20:49:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1B2792E80C7
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 20:49:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Dec 2016 20:36:38 -0000
From: Thomas Huth <696530@bugs.launchpad.net>
Reply-To: Bug 696530 <696530@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110102153123.20075.24776.malonedeb@soybean.canonical.com>
Message-Id: <20161221203638.536.67305.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 696530] Re: qemu-0.13.0-r2 special keys different
 when using -alt-grab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Comment #1 sounds like this issue has been dealt with? Is there still
something left that needs to be fixed here?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/696530

Title:
  qemu-0.13.0-r2 special keys different when using -alt-grab

Status in QEMU:
  Incomplete

Bug description:
  I use -alt-grab with qemu-0.13.0-r2 and special keys like Ctrl-Alt-f
  for full screen did not work for me with a windows guest. They work
  normally when omitting the -alt-grab startup parameter.

  After quite a long time, I found out that I have to add the shift key
  to the keys from the documentation when I use the -alt-grab option.

  Probably -ctrl-grab behaves similarly. It would be really nice to have
  this documented in the default documentation in the man page as has
  not been documented there yet.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/696530/+subscriptions
