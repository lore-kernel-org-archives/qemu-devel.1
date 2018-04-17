Received: from eggs.gnu.org ([2001:4830:134:3::10]:52228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f8XQ5-0005HO-UX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f8XQ1-0002Qt-0D
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:41:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:59484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f8XQ0-0002ID-QH
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:41:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f8XPy-00049V-Gq
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 20:41:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7020C2E80E2
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 20:41:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Apr 2018 20:32:31 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1654137@bugs.launchpad.net>
Reply-To: Bug 1654137 <1654137@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170105043743.14700.719.malonedeb@wampee.canonical.com>
Message-Id: <152399715198.13092.8340134701167106298.malone@chaenomeles.canonical.com>
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

Hi Andreas, beware... while 1b2503fcf7b5 fixes this bug, it introduces anot=
her regression.
I suggest waiting for the release tag before cherry-picking it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1654137

Title:
  Ctrl-A b not working in 2.8.0

Status in QEMU:
  Fix Committed

Bug description:
  With a recent update from 2.7.0 to 2.8.0 I have discovered that I can
  no longer send a "break" to the VM.  Ctrl-A b is simply ignored.
  Other Ctrl-A sequences seem to work correctly.

  This is on a NetBSD amd64 system, version 7.99.53, and qemu was
  installed on this system from source.

  Reverting to the previous install restores "break" capability.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1654137/+subscriptions
