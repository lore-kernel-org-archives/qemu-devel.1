Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRLK6-0003Jb-8j
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRLJx-0001pW-2U
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:04:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:46676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRLJw-0001mM-NS
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:04:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRLJv-0001uo-G5
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 756602E80C3
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2017 16:53:16 -0000
From: Thomas Huth <1299858@bugs.launchpad.net>
Reply-To: Bug 1299858 <1299858@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140330182810.9542.11623.malonedeb@soybean.canonical.com>
Message-Id: <151370239683.11391.10220494445402039493.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1299858] Re: qemu all apps crash on OS X 10.6.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1299858

Title:
  qemu all apps crash on OS X 10.6.8

Status in QEMU:
  Incomplete

Bug description:
  qemu-2.0.0-rc0 (and 1.7.1) crashes with SIGABORT in all apps when
  configured with --with-coroutine=3Dsigaltstack (which is what configure
  selects by default) but all  run fine if configured with --with-
  coroutine=3Dgthread.

  Crash is at line 253 (last line of Coroutine
  *qemu_coroutine_new(void)) in coroutine-sigaltstack.c in 2.0.0-rc0
  tarball.

  Platform is OS X 10.6.8 (Darwin Kernel Version 10.8.0), compiler gcc
  4.2.1

  Sorry for the sparse report but I'm short on time today.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1299858/+subscriptions
