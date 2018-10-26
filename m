Received: from eggs.gnu.org ([2001:4830:134:3::10]:52217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uA-00021G-QY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u5-000612-AD
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2tz-0005lg-G8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:20 +0800
Message-Id: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99c=
f2:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-s=
f0' into staging (2018-10-25 17:41:03 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/testing-pull-request

for you to fetch changes up to 63a24c5e2354833a84f18bdf0e857fad8812f65b:

  tests/vm: Do not abuse parallelism when HOST !=3D TARGET architecture (=
2018-10-26 22:03:21 +0800)

----------------------------------------------------------------
Testing patches

One fix for mingw build and some improvements in VM based testing, many t=
hanks
to Paolo and Phil.

----------------------------------------------------------------

Paolo Bonzini (1):
  tests: docker: update test-mingw for GTK+ 2.0 removal

Philippe Mathieu-Daud=C3=A9 (8):
  tests/vm: Extract the kvm_available() handy function
  tests/vm: Do not abuse parallelism when KVM is not available
  tests/vm: Do not use the -smp option with a single cpu
  tests/vm: Display remaining seconds to wait for a VM to start
  tests/vm: Add a BaseVM::arch property
  tests/vm: Let kvm_available() work in cross environments
  tests/vm: Do not use -enable-kvm if HOST !=3D TARGET architecture
  tests/vm: Do not abuse parallelism when HOST !=3D TARGET architecture

 scripts/qemu.py         |  6 ++++++
 tests/docker/test-mingw |  3 +--
 tests/vm/basevm.py      | 30 +++++++++++++++++++++---------
 tests/vm/centos         |  1 +
 tests/vm/freebsd        |  1 +
 tests/vm/netbsd         |  1 +
 tests/vm/openbsd        |  1 +
 tests/vm/ubuntu.i386    |  1 +
 8 files changed, 33 insertions(+), 11 deletions(-)

--=20
2.17.1
