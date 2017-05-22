Received: from eggs.gnu.org ([2001:4830:134:3::10]:44641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dClcn-00035S-MX
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dClck-0002FF-IO
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:35:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:34383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dClck-0002F5-9P
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:35:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dClcj-0000Oe-7W
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 11:35:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2AECD2E8075
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 11:35:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2017 11:17:00 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1527765 <1527765@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151218220640.25998.28926.malonedeb@soybean.canonical.com>
Message-Id: <149545181996.6496.6895309386081423077.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1527765] Re: sh4: ghc randomly segfaults on
 qemu-sh4-static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just tested with the latest git snapshot of qemu, still no improvement:

...
checking for gfind... no
checking for find... /usr/bin/find
checking for sort... /usr/bin/sort
checking for GHC Git commit id... given 4986837f8168cacf95c24fecc84d7b36c47=
f3c11
checking version of ghc... 8.0.1
ghc: pthread_mutex_lock.c:81: __pthread_mutex_lock: Assertion `mutex->__dat=
a.__owner =3D=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
ghc: pthread_mutex_lock.c:81: __pthread_mutex_lock: Assertion `mutex->__dat=
a.__owner =3D=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
ghc: pthread_mutex_lock.c:81: __pthread_mutex_lock: Assertion `mutex->__dat=
a.__owner =3D=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
Bootstrapping GHC is a cross compiler. This probably isn't going to work
checking build system type... sh4-unknown-linux-gnu
checking host system type... sh4-unknown-linux-gnu
checking target system type... sh4-unknown-linux-gnu
Build platform inferred as: sh4-unknown-linux
Host platform inferred as: sh4-unknown-linux
Target platform inferred as: sh4-unknown-linux
GHC build  : sh4-unknown-linux
GHC host   : sh4-unknown-linux
GHC target : sh4-unknown-linux
configure: Building in-tree ghc-pwd
(hangs here)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1527765

Title:
  sh4: ghc randomly segfaults on qemu-sh4-static

Status in QEMU:
  New

Bug description:
  Hello!

  I am currently in the process of bootstrapping ghc for the Debian sh4
  port and ran into a strange problem with qemu-sh4-static which
  randomly segfaults when running ghc to compile a Haskell source:

  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ls
  Main.hi  Main.hs  Setup.hs  ghc-pwd.cabal  ghc.mk
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  [1 of 1] Compiling Main             ( Main.hs, Main.o )
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  [1 of 1] Compiling Main             ( Main.hs, Main.o )
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  [1 of 1] Compiling Main             ( Main.hs, Main.o )
  Bad interface file: /usr/local/lib/sh4-unknown-linux-gnu-ghc-7.10.3/time/=
dist-install/build/Data/Time/Format/Parse.hi
  =C2=A0=C2=A0=C2=A0=C2=A0ghc: panic! (the 'impossible' happened)
  =C2=A0=C2=A0(GHC version 7.10.3 for sh4-unknown-linux):
  =C2=A0getSymtabName:unknown known-key unique
  <<details unavailable>>

  Please report this as a GHC bug:
  http://www.haskell.org/ghc/reportabug

  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd# ghc Main.hs
  /bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  [1 of 1] Compiling Main             ( Main.hs, Main.o )
  Linking Main ...
  root@jessie32:~/ghc-7.8.4/utils/ghc-pwd#

  As seen above, compiling a Haskell source code often results in a
  segfault but simply by retrying to run ghc over and over again, the
  compile process will eventually succeed and no segfault occurs.

  I have created a tarball which contains the sh4 chroot from the
  example above which also includes ghc, gcc and the source code in
  question (in /root/ghc-7.8.4/utils/ghc-pwd). To test, it's probably a
  good idea to replace the qemu-sh4-static binary in /usr/bin with a
  current git snapshot (which I tried but didn't help).

  > http://users.physik.fu-berlin.de/~glaubitz/sid-sh4-sbuild-ghc.tgz

  In case anyone wants to try ghc with their own sh4 chroot, here's my
  version of ghc:

  > https://people.debian.org/~glaubitz/sh4-unknown-linux-gnu-
  ghc-7.10.3.tar.gz

  Just extract this tarball into the root directory of the sh4 chroot.

  Please note, that it might be advisable on sh4 to apply the patches
  from these two bug reports as otherwise qemu-sh4-static won't work
  properly on amd64 and misses syscall 186:

  > https://bugs.launchpad.net/ubuntu/+source/qemu-linaro/+bug/1254824
  > https://bugs.launchpad.net/qemu/+bug/1516408

  The above issue is reproducible with the two patches applied and
  without. It's also reproducible with both libc6 2.19 and 2.21 in the
  chroot. Thus, I am currently out of ideas what else to test.

  Cheers,
  Adrian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1527765/+subscriptions
