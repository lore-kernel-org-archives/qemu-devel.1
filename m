Received: from eggs.gnu.org ([2001:4830:134:3::10]:35066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ57X-000143-0i
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ57U-00044l-Cr
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:30:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:47091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQ57U-00044Y-6j
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:30:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQ57T-0004rt-CP
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 04:30:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E9152E80AE
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 04:30:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jan 2017 04:17:23 -0000
From: Launchpad Bug Tracker <878019@bugs.launchpad.net>
Reply-To: Bug 878019 <878019@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111019092638.19752.17248.malonedeb@gac.canonical.com>
Message-Id: <20170108041724.16754.50474.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 878019] Re: 0.15.1 black screen and 100% cpu on
 start
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
https://bugs.launchpad.net/bugs/878019

Title:
  0.15.1 black screen and 100% cpu on start

Status in QEMU:
  Expired

Bug description:
  Trying the freshly compiled 0.15.1 (command line: "qemu"), the window
  stays black, it uses 100% cpu, and can't be killed with ctrl-c, has to
  be killed with killall -9.

  Strace shows it's waiting on a futex forever?

  Build config:
  ./configure --prefix=3D/usr/local --interp-prefix=3D/usr/local/share/qemu=
 \
  --enable-mixemu --disable-brlapi --enable-io-thread --audio-drv-list=3D"o=
ss alsa sdl" \
  --disable-opengl

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/878019/+subscriptions
