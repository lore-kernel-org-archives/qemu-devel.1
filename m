Received: from eggs.gnu.org ([2001:4830:134:3::10]:34127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9C9-00017C-CK
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9C6-0007hN-6W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:05:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:41470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC9C6-0007hC-0V
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:05:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC9C5-0000Fm-4e
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 19:05:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D0D52E80C7
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 19:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 18:47:19 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1426593 <1426593@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150228000102.17292.81743.malonedeb@gac.canonical.com>
Message-Id: <151008043941.8833.1062868786666794646.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1426593] Re: linux-user: doesn't handle guest
 setting its memory ulimit very small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

*** This bug is a duplicate of bug 1163034 ***
    https://bugs.launchpad.net/bugs/1163034

I've just noticed that this is a duplicate of bug 1163034 (gnutls uses a
very similar configure test), so I'm going to mark this one as a dup of
that one, since it's older.


** This bug has been marked a duplicate of bug 1163034
   linux-user mode can't handle guest setting RLIMIT_AS (hangs running gnut=
ls28 configure check code)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1426593

Title:
  linux-user: doesn't handle guest setting its memory ulimit very small

Status in QEMU:
  Confirmed

Bug description:
  using the latest build from git (hash 041ccc922ee474693a2869d4e3b59e920c7=
39bc0 ) and all older versions i have tested.
  i am using an amd64 host with an arm chroot using "qemu-user arm cortex-a=
8" cpu emulation to run it

  building coreutils hangs on "checking whether printf survives out-of-
  memory conditions"

  i have not had time to dig into the build system to isolate the test
  yet, there were old reports of this bug but i can no longer find them
  on google.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1426593/+subscriptions
