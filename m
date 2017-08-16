Received: from eggs.gnu.org ([2001:4830:134:3::10]:43379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhslV-0006NM-SK
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhslU-00058N-R9
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhslU-000582-Kk
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 16 Aug 2017 15:20:55 +0800
Message-Id: <20170816072104.24420-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests (for
 non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

Build tests in one 32 bit Linux guest and three BSD images are defined in this
series. This is a more managable way than the manually maintained virtual
machines in patchew. Also, one big advantage of ephemeral VMs over long running
guests is the reduced RAM usage of host, which makes it possible to have one
host test all these BSD variants and probably more.

The BSD guest templates are manually prepared following

https://wiki.qemu.org/Hosts/BSD

as it is not easy to automate. (The ideal approach is like the ubuntu.i386
script, which configures the guest on top of an official released image, fully
automatically.)

Need for help: "gmake check" in the added OpenBSD image fails with -ENOMEM
errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? And there
is a warning from ./configure about OpenBSD going to be unsupported in coming
releases, is it still the case?

Fam

Fam Zheng (9):
  gitignore: Ignore vm test images
  qemu.py: Add variable vga type
  qemu.py: Add "wait()" method
  tests: Add vm test lib
  tests: Add ubuntu.i386 image
  tests: Add FreeBSD image
  tests: Add NetBSD image
  tests: Add OpenBSD image
  Makefile: Add rules to run vm tests

 .gitignore                |   2 +
 Makefile                  |   2 +
 configure                 |   2 +-
 scripts/qemu.py           |   8 +-
 tests/vm/Makefile.include |  41 ++++++++
 tests/vm/basevm.py        | 246 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          |  44 +++++++++
 tests/vm/netbsd           |  44 +++++++++
 tests/vm/openbsd          |  45 +++++++++
 tests/vm/ubuntu.i386      |  88 +++++++++++++++++
 10 files changed, 520 insertions(+), 2 deletions(-)
 create mode 100644 tests/vm/Makefile.include
 create mode 100755 tests/vm/basevm.py
 create mode 100755 tests/vm/freebsd
 create mode 100755 tests/vm/netbsd
 create mode 100755 tests/vm/openbsd
 create mode 100755 tests/vm/ubuntu.i386

-- 
2.13.4
