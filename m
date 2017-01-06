Received: from eggs.gnu.org ([2001:4830:134:3::10]:44163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPUpx-0005M8-Mr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPUpu-0005ed-GK
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:45:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:48623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPUpu-0005eI-AA
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:45:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPUps-0000N0-Py
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 13:45:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B2A952E80C3
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 13:45:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jan 2017 13:39:59 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1654137 <1654137@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170105043743.14700.719.malonedeb@wampee.canonical.com>
Message-Id: <20170106133959.14243.54408.malone@soybean.canonical.com>
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

I am also seeing this problem.  In case it was not clear from Paul's
original report, it affects guests using a serial console.

Also, it is not specific to NetBSD.  I can reproduce it using a Linux
guest on a Linux host, by running the following on a Debian 8 system:

  wget http://landley.net/aboriginal/downloads/old/binaries/1.4.5/system-im=
age-i686.tar.gz
  tar xfz system-image-i686.tar.gz =

  cd system-image-i686
  sh run-emulator.sh =


and typing Control-A b m once the guest has started.

Using qemu 2.1.2, this successfully causes the guest to print a memory
usage summary.  Using current qemu sources from git
(dbe2b65566e76d3c3a0c3358285c0336ac61e757), nothing happens.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1654137

Title:
  Ctrl-A b not working in 2.8.0

Status in QEMU:
  New

Bug description:
  With a recent update from 2.7.0 to 2.8.0 I have discovered that I can
  no longer send a "break" to the VM.  Ctrl-A b is simply ignored.
  Other Ctrl-A sequences seem to work correctly.

  This is on a NetBSD amd64 system, version 7.99.53, and qemu was
  installed on this system from source.

  Reverting to the previous install restores "break" capability.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1654137/+subscriptions
