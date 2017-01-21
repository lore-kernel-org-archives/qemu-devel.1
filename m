Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUvb6-0004cS-Nv
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 08:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUvb3-000160-KO
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 08:20:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:53914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUvb3-00015p-9T
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 08:20:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUvb1-00042M-IT
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 13:20:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA43E2E80C0
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 13:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Jan 2017 13:14:21 -0000
From: Bilal Amarni <1658120@bugs.launchpad.net>
Reply-To: Bug 1658120 <1658120@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
Message-Id: <20170121131421.20674.39095.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658120] Re: building with gcc-aarch64-linux-gnu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for your replies,

I've managed to compile it using a chroot as suggested by Peter. I just
grabbed a pre-built rootfs from here : https://wiki.debian.org/Arm64Port
#Pre-built_Rootfses, then installed qemu-user-static with apt-get and
run the build from the chroot.

Somehow "apt-get build-dep -a arm64 qemu" didn't work, I had tried to do
"dpkg --add-architecture arm64 && apt-get update" before running this
command but it couldn't find the needed packages, not sure why.

In any case thanks for your help :)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658120

Title:
  building with gcc-aarch64-linux-gnu

Status in QEMU:
  Invalid

Bug description:
  Hi, while trying to build qemu v2.8.0 with gcc-aarch64-linux-gnu
  cross-compiler I'm getting the following :

  =

  In file included from /usr/include/x86_64-linux-gnu/sys/syscall.h:31:0,
                   from /root/qemu/util/compatfd.c:21:
  /root/qemu/util/compatfd.c: In function 'qemu_signalfd':
  /root/qemu/util/compatfd.c:103:19: error: '__NR_signalfd' undeclared (fir=
st use in this function)
       ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
                     ^
  /root/qemu/util/compatfd.c:103:19: note: each undeclared identifier is re=
ported only once for each function it appears in
  /root/qemu/rules.mak:59: recipe for target 'util/compatfd.o' failed
  make: *** [util/compatfd.o] Error 1

  =

  I had configured it with :

  ../configure --target-list=3Dx86_64-linux-user --static --cpu=3Daarch64

  And I'm on :

  Linux ubuntu-512mb-fra1-01 4.4.0-59-generic #80-Ubuntu SMP Fri Jan 6
  17:47:47 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658120/+subscriptions
