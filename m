Received: from eggs.gnu.org ([2001:4830:134:3::10]:58779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKM2D-0003QY-RT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKM2A-0001Zk-O4
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:25:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:50068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eKM2A-0001Z0-I0
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:25:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eKM29-0002fc-1r
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 10:25:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0BF4C2E8059
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 10:25:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Nov 2017 10:19:26 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1735384 <1735384@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735384] [NEW] OpenJDK JVM segfaults on qemu-sh4
 (regression)
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

Some of the recent changes introduced a regression which makes the
OpenJDK JVM crash on qemu-sh4:

(sid-sh4-sbuild)root@nofan:/# java -version
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
(sid-sh4-sbuild)root@nofan:/#

An older version works fine:

(sid-sh4-sbuild)root@nofan:/# java -version
openjdk version "9.0.1"
OpenJDK Runtime Environment (build 9.0.1+11-Debian-1)
OpenJDK Zero VM (build 9.0.1+11-Debian-1, interpreted mode)
(sid-sh4-sbuild)root@nofan:/#

Haven't had time for bisecting this yet.

Adrian

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735384

Title:
  OpenJDK JVM segfaults on qemu-sh4 (regression)

Status in QEMU:
  New

Bug description:
  Some of the recent changes introduced a regression which makes the
  OpenJDK JVM crash on qemu-sh4:

  (sid-sh4-sbuild)root@nofan:/# java -version
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  (sid-sh4-sbuild)root@nofan:/#

  An older version works fine:

  (sid-sh4-sbuild)root@nofan:/# java -version
  openjdk version "9.0.1"
  OpenJDK Runtime Environment (build 9.0.1+11-Debian-1)
  OpenJDK Zero VM (build 9.0.1+11-Debian-1, interpreted mode)
  (sid-sh4-sbuild)root@nofan:/#

  Haven't had time for bisecting this yet.

  Adrian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735384/+subscriptions
