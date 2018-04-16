Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f86jZ-0003NT-HK
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f86jV-0005tB-FB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:12:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f86jV-0005rf-8O
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:11:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f86jT-0002S4-6y
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 16:11:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 810012E80E9
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 16:11:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Apr 2018 15:55:56 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1654137 <1654137@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170105043743.14700.719.malonedeb@wampee.canonical.com>
Message-Id: <152389415648.12104.8962858836696812604.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1654137] Re: Ctrl-A b not working in 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This regression is still unfixed three months after being reported, and
it's rendering qemu 2.11.1 unusable for my present use case, so I just
reverted my system to the ever reliable qemu 0.15.1.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1654137

Title:
  Ctrl-A b not working in 2.8.0

Status in QEMU:
  Confirmed

Bug description:
  With a recent update from 2.7.0 to 2.8.0 I have discovered that I can
  no longer send a "break" to the VM.  Ctrl-A b is simply ignored.
  Other Ctrl-A sequences seem to work correctly.

  This is on a NetBSD amd64 system, version 7.99.53, and qemu was
  installed on this system from source.

  Reverting to the previous install restores "break" capability.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1654137/+subscriptions
