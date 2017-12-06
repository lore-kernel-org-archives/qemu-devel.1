Received: from eggs.gnu.org ([2001:4830:134:3::10]:44968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMX6H-0002N3-EA
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMX6D-00059J-DO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:38:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMX6D-000591-6p
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:38:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMX6A-00034V-C7
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 10:38:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 041402E80CC
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 10:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 10:22:33 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1735384 <1735384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<20171206093050.25308-1-alex.bennee@linaro.org>
Message-Id: <dafcc30d-e7df-eef6-bf7a-f164f07531bc@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1735384] [RFC PATCH] target/sh4/translate.c:
 fix TCG leak during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12/06/2017 10:30 AM, Alex Benn=C3=A9e wrote:
> This fixes bug #1735384 while running java under qemu-sh4. When debug
> was enabled it showed a problem with TCG temps. Once fixed I was able
> to run java -version normally.
> =

> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I can confirm that this fixes the issue for me, too.

So, just in case:

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

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
