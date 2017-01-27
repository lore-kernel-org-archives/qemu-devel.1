Received: from eggs.gnu.org ([2001:4830:134:3::10]:58500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cXAHP-0002Ff-3S
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cXAHK-0000Th-0d
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:25:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:52736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cXAHJ-0000TV-NO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:25:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cXAHH-0003KP-Pf
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 17:25:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A69092E80C8
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 17:25:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Jan 2017 17:18:03 -0000
From: Rich DiCroce <1659901@bugs.launchpad.net>
Reply-To: Bug 1659901 <1659901@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170127171804.11595.14600.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1659901] [NEW] Regression: SIGSEGV running Java
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I have a build script that bootstraps a Debian armhf image. Part of the
process involves running a Java program while inside a chroot. I am
using Debian's qemu-user-static package to run the armhf Java binary on
an amd64 system.

qemu-user-static version 1:2.7+dfsg-3~bpo8+2 works fine. Version
1:2.8+dfsg-1~bpo8+1 always causes Java to crash with a SIGSEGV. The
location of the crash appears to be random and hasn't been the same
twice.

I am using the Azul Systems Zulu Embedded Java runtime, rather than the
regular OpenJDK runtime, because the Zulu runtime has an arm32 JIT
whereas OpenJDK is interpreter-only on arm32.

I can reproduce the problem easily by mounting the image created by my
build script and executing "java -XshowSettings -version" in a chroot. I
can give you the image if that would help debug the problem.

** Affects: qemu
     Importance: Undecided
         Status: New

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
