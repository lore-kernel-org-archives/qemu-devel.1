Received: from eggs.gnu.org ([2001:4830:134:3::10]:44148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eF6q0-00044D-QD
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eF6px-0003TQ-Kj
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:11:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:41214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eF6px-0003TC-Do
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:11:17 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eF6pu-0000mT-PJ
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 23:11:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 887352E80CE
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 23:11:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Nov 2017 22:58:48 -0000
From: pgnet <1659901@bugs.launchpad.net>
Reply-To: Bug 1659901 <1659901@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170127171804.11595.14600.malonedeb@soybean.canonical.com>
Message-Id: <151078672853.8427.1111378630637482489.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1659901] Re: Regression: SIGSEGV running Java
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

fyi, similar seen for Raspbian9:

https://bugs.launchpad.net/raspbian/+bug/1732556

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1659901

Title:
  Regression: SIGSEGV running Java

Status in QEMU:
  New

Bug description:
  I have a build script that bootstraps a Debian armhf image. Part of
  the process involves running a Java program while inside a chroot. I
  am using Debian's qemu-user-static package to run the armhf Java
  binary on an amd64 system.

  qemu-user-static version 1:2.7+dfsg-3~bpo8+2 works fine. Version
  1:2.8+dfsg-1~bpo8+1 always causes Java to crash with a SIGSEGV. The
  location of the crash appears to be random and hasn't been the same
  twice.

  I am using the Azul Systems Zulu Embedded Java runtime, rather than
  the regular OpenJDK runtime, because the Zulu runtime has an arm32 JIT
  whereas OpenJDK is interpreter-only on arm32.

  I can reproduce the problem easily by mounting the image created by my
  build script and executing "java -XshowSettings -version" in a chroot.
  I can give you the image if that would help debug the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1659901/+subscriptions
