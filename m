Received: from eggs.gnu.org ([2001:4830:134:3::10]:38736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cutdP-0001u6-As
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 00:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cutdM-0007GM-HM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 00:30:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:48229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cutdM-0007G2-BJ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 00:30:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cutdL-0004kg-0u
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:30:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E041F2E80CD
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 04:30:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Apr 2017 04:17:23 -0000
From: Launchpad Bug Tracker <1207228@bugs.launchpad.net>
Reply-To: Bug 1207228 <1207228@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130801084204.30116.68647.malonedeb@soybean.canonical.com>
Message-Id: <20170403041723.29960.94834.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1207228

Title:
  Qemu (trunk code) crashes when using --soundhw all option in ioport.c

Status in QEMU:
  Expired

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
