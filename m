Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrU5-0004zO-Lm
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrU2-0006iW-GQ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:45:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:51494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYrU2-0006iM-AJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:45:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYrU0-0006rQ-US
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 09:45:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E3F102E80C4
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 09:45:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Feb 2017 09:30:07 -0000
From: Thomas Huth <1207228@bugs.launchpad.net>
Reply-To: Bug 1207228 <1207228@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130801084204.30116.68647.malonedeb@soybean.canonical.com>
Message-Id: <20170201093007.26559.24387.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1207228] Re: Qemu (trunk code) crashes when using
 --soundhw all option in ioport.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Please always specify the exact version (git commit ID) that you are
using... can you still reproduce this issue with the latest version of
QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1207228

Title:
  Qemu (trunk code) crashes when using --soundhw all option in ioport.c

Status in QEMU:
  Incomplete

Bug description:
  After not building qemu (git version) for about 3 weeks, I've done it
  again this morning.

  With up-to-date trunk code, I got this error on start, when using
  --soundhw all option

  $ qemu-system-i386 -soundhw all
  qemu-system-i386: /home/fred/T=C3=A9l=C3=A9chargements/logs/qemu-git/src/=
qemu/ioport.c:240: portio_list_add: Assertion `pio->offset >=3D off_last' f=
ailed.
  Abandon (core dumped)

  And if I use only soundhw with one or more options, it doesn't crash.

  Tell me what you'll need to fix this bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1207228/+subscriptions
