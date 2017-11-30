Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKOE1-0002V7-Bx
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKODy-00077X-97
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:45:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eKODy-00075r-2x
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:45:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eKODw-0004yE-Ho
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 12:45:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 05C362E80D9
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 12:45:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Nov 2017 12:39:19 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1735384 <1735384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<151204437224.3145.2784740143531482152.malone@gac.canonical.com>
Message-Id: <74ce90f9-f123-8fba-1038-7dd181d9148c@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 11/30/2017 01:19 PM, Peter Maydell wrote:
> This sounds like it may be the bug fixed by this patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg05067.html

Unfortunately not. I will upload a prepared chroot for testing later
and link it in this bug report.

Adrian

-- =

  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

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
