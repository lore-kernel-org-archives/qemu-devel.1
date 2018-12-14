Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXmme-0001mT-QQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXmmV-0000Uy-ME
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:41:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:46014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXmmU-0000GF-EC
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:41:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXmmF-0003qM-3l
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:41:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC9202E819D
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:41:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Dec 2018 12:33:13 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1735384 <1735384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
Message-Id: <154479079312.1887.787787485673295746.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on qemu-sh4
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

This has been fixed now and Java works fine again on qemu-sh4 on git
master:

(sid-sh4-sbuild)root@nofan:/# java --version
openjdk 10 2018-03-20
OpenJDK Runtime Environment (build 10+46-Debian-5)
OpenJDK Zero VM (build 10+46-Debian-5, interpreted mode)
(sid-sh4-sbuild)root@nofan:/#

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735384

Title:
  OpenJDK JVM segfaults on qemu-sh4 (regression)

Status in QEMU:
  Fix Released

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
