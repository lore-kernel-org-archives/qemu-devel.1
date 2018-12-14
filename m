Received: from eggs.gnu.org ([2001:4830:134:3::10]:44217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXrWs-0000a6-8B
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXrWp-0002Ot-2r
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:45:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXrWo-0002ML-Sd
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:45:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXrWn-0005GX-At
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 17:45:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 49B9E2E8078
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 17:45:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Dec 2018 17:39:42 -0000
From: Alan Jones <1808563@bugs.launchpad.net>
Reply-To: Bug 1808563 <1808563@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154480918291.23267.15132018418369155034.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1808563] [NEW] Listing the contents of / lists
 QEMU_LD_PREFIX instead
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

Seeing this in qemu-user version 3.1.0

Demo:
$ QEMU_LD_PREFIX=3D$(pwd)/usr/armv7a-cros-linux-gnueabi ../run/qemu-arm /tm=
p/coreutils --coreutils-prog=3Dls / =

etc  lib  usr
$ ls /
boot  etc   lib     lib64   lost+found  mnt    root  sbin  sys  usr
bin   dev   export  home    lib32       net    proc  run   tmp  var
$ ls usr/armv7a-cros-linux-gnueabi
etc  lib  usr

In strace, the openat for "/" is remapped to the directory specified in QEM=
U_LD_PREFIX:
[pid  5302] openat(AT_FDCWD, "/tmp/qemu/usr/armv7a-cros-linux-gnueabi", O_R=
DONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) =3D 3

As an aside, if I change the code to do chdir("/"); opendir("."); it
works fine.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808563

Title:
  Listing the contents of / lists QEMU_LD_PREFIX instead

Status in QEMU:
  New

Bug description:
  Seeing this in qemu-user version 3.1.0

  Demo:
  $ QEMU_LD_PREFIX=3D$(pwd)/usr/armv7a-cros-linux-gnueabi ../run/qemu-arm /=
tmp/coreutils --coreutils-prog=3Dls / =

  etc  lib  usr
  $ ls /
  boot  etc   lib     lib64   lost+found  mnt    root  sbin  sys  usr
  bin   dev   export  home    lib32       net    proc  run   tmp  var
  $ ls usr/armv7a-cros-linux-gnueabi
  etc  lib  usr

  In strace, the openat for "/" is remapped to the directory specified in Q=
EMU_LD_PREFIX:
  [pid  5302] openat(AT_FDCWD, "/tmp/qemu/usr/armv7a-cros-linux-gnueabi", O=
_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) =3D 3

  As an aside, if I change the code to do chdir("/"); opendir("."); it
  works fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808563/+subscriptions
