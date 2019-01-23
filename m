Received: from eggs.gnu.org ([209.51.188.92]:49526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmIE4-000691-1Q
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmIE3-0002wN-2B
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:05:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:53724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmIE2-0002qw-R1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:05:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmIDo-00022g-7x
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 36F852E80C8
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Jan 2019 12:51:45 -0000
From: Shahab Vahedi <shahab.vahedi@gmail.com>
Reply-To: Bug 1813010 <1813010@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154824790547.2554.12417850699297619175.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813010] [NEW] Parallel builds fail (make -j >=2)
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

specs:
QEMU commit: 9f33051abce238ab43a23125e237aac8b0931b88
# of Cores: 8
Host kernel: Linux 4.19.16-1-lts
Host type: x86_64 GNU/Linux
Host distro: Archlinux
Guest: we never get that far


steps:
# fresh copy of the latest commit
> git clone https://git.qemu.org/git/qemu.git

# separate build dir
> mkdir build
> cd build

# sample configuration for riscv (this happens for other targets as well)
> ../qemu/configure --target-list=3Driscv64-softmmu --enable-debug --extra-=
cflags=3D'-O0 -g3 -save-temps' --prefix=3D/install/riscv-qemu

# this will fail (see attached log file)
> make -j 2

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "build_fail.log"
   https://bugs.launchpad.net/bugs/1813010/+attachment/5231736/+files/build=
_fail.log

** Description changed:

  specs:
+ QEMU commit: 9f33051abce238ab43a23125e237aac8b0931b88
+ # of Cores: 8
  Host kernel: Linux 4.19.16-1-lts
  Host type: x86_64 GNU/Linux
  Host distro: Archlinux
  Guest: we never get that far
- QEMU commit: 9f33051abce238ab43a23125e237aac8b0931b88
  =

  =

  steps:
  # fresh copy of the latest commit
  > git clone https://git.qemu.org/git/qemu.git
  =

  # separate build dir
  > mkdir build
  > cd build
  =

  # sample configuration for riscv (this happens for other targets as well)
  > ../qemu/configure --target-list=3Driscv64-softmmu --enable-debug --extr=
a-cflags=3D'-O0 -g3 -save-temps' --prefix=3D/install/riscv-qemu
  =

  # this will fail (see attached log file)
  > make -j 2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813010

Title:
  Parallel builds fail (make -j >=3D2)

Status in QEMU:
  New

Bug description:
  specs:
  QEMU commit: 9f33051abce238ab43a23125e237aac8b0931b88
  # of Cores: 8
  Host kernel: Linux 4.19.16-1-lts
  Host type: x86_64 GNU/Linux
  Host distro: Archlinux
  Guest: we never get that far

  =

  steps:
  # fresh copy of the latest commit
  > git clone https://git.qemu.org/git/qemu.git

  # separate build dir
  > mkdir build
  > cd build

  # sample configuration for riscv (this happens for other targets as well)
  > ../qemu/configure --target-list=3Driscv64-softmmu --enable-debug --extr=
a-cflags=3D'-O0 -g3 -save-temps' --prefix=3D/install/riscv-qemu

  # this will fail (see attached log file)
  > make -j 2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813010/+subscriptions
