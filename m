Received: from eggs.gnu.org ([2001:4830:134:3::10]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1egdAx-00050f-NE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1egd9t-0005sj-DX
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:10:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:60624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1egd9t-0005rb-5D
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:09:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1egd9s-000879-7b
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 21:09:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 38C172E854E
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 21:09:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jan 2018 20:59:47 -0000
From: Thomas Huth <1084148@bugs.launchpad.net>
Reply-To: Bug 1084148 <1084148@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121128170711.9800.68216.malonedeb@chaenomeles.canonical.com>
Message-Id: <151734598764.25362.7985800794889991965.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1084148] Re: Qt5 Beta 1 QProcess start and
 execute causes segmentation fault on armhf
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
https://bugs.launchpad.net/bugs/1084148

Title:
  Qt5 Beta 1 QProcess start and execute causes segmentation fault on
  armhf

Status in QEMU:
  Incomplete
Status in Linaro QEMU:
  Confirmed

Bug description:
  Steps
  1) pbuilder-dist quantal armhf create
  2) add ppa from https://launchpad.net/~canonical-qt5-edgers/+archive/qt5-=
beta1 to the pbuilder
  2.0) pbuilder-dist quantal armhf login
  2.1) apt-get install software-properties-common
  2.2) apt-add-repository ppa:canonical-qt5-edgers/qt5-beta1
  2.3) apt-get update
  3) apt-get install qtbase qtdeclarative qttools bzr
  4) bzr branch lp:~juhapekka-piiroinen/+junk/qemu-crash
  5) cd qemu-crash; /opt/qt5/bin/qmake; make; ./untitled

  Expected Result:
  Would execute 'ls'

  Actual result:
  # ./untitled =

  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

  Note: this code works on i386, amd64 and armel.

  Packages:
  $ apt-cache policy qemu-user-static
  qemu-user-static:
    Installed: 1.2.0-2012.09-0ubuntu1
    Candidate: 1.2.0-2012.09-0ubuntu1
    Version table:
   *** 1.2.0-2012.09-0ubuntu1 0
          500 http://fi.archive.ubuntu.com/ubuntu/ quantal/universe amd64 P=
ackages
          100 /var/lib/dpkg/status
       1.2.0-2012.09-0ubuntu1~linaro1 0
          500 http://ppa.launchpad.net/linaro-maintainers/tools/ubuntu/ qua=
ntal/main amd64 Packages

  # apt-cache policy qtbase
  qtbase:
    Installed: 5.0-release~beta+20120831-1ubuntu54
    Candidate: 5.0-release~beta+20120831-1ubuntu54
    Version table:
   *** 5.0-release~beta+20120831-1ubuntu54 0
          500 http://ppa.launchpad.net/canonical-qt5-edgers/qt5-beta1/ubunt=
u/ quantal/main armhf Packages
          100 /var/lib/dpkg/status

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1084148/+subscriptions
