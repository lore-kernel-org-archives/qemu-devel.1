Received: from eggs.gnu.org ([209.51.188.92]:52234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqA-0006pE-MV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgq8-0006cP-OR
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:02 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:43 +0100
Message-Id: <20190218111153.22681-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 1e36232994c8ad01774501d2e299deba3a2469=
af:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20190=
215' into staging (2019-02-15 11:12:14 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190218

for you to fetch changes up to 0922e8c093a564219fcb7f43b18ceb12714dd931:

  s390x: upgrade status of KVM cores to "supported" (2019-02-18 12:00:44 =
+0100)

----------------------------------------------------------------
s390x updates:
- tcg: implement STCK and friends for CONFIG_USER_ONLY
- add zpci to qemu cpu model, as pci is now always built
- add mepoch to default z14 cpu model
- add cpu model for z14 GA2
- various improvements

----------------------------------------------------------------

Collin Walling (3):
  s390x/cpumodel: mepochptff: warn when no mepoch and re-align group
    init
  s390x/cpumodel: default enable mepoch for z14 and later
  s390x/cpumodel: add z14 GA2 model

Cornelia Huck (3):
  s390x: always provide pci support
  s390x/kvm: add tracepoint to ioeventfd interface
  s390x: upgrade status of KVM cores to "supported"

David Hildenbrand (1):
  s390x: add zPCI feature to "qemu" CPU model

Richard Henderson (2):
  target/s390x: Split out s390-tod.h
  target/s390x: Implement STCK et al for CONFIG_USER_ONLY

Thomas Huth (1):
  s390x: Fix the confusing contributions-after-2012 license statements

 MAINTAINERS                   |  2 +-
 hw/s390x/Makefile.objs        |  3 +-
 hw/s390x/s390-pci-stub.c      | 77 -----------------------------------
 hw/s390x/s390-virtio-ccw.c    |  8 ++--
 include/hw/s390x/tod.h        | 16 +-------
 linux-user/s390x/target_cpu.h | 19 ++++-----
 target/s390x/cpu.c            | 19 ++++-----
 target/s390x/cpu.h            | 19 ++++-----
 target/s390x/cpu_features.c   |  2 +-
 target/s390x/cpu_models.c     | 34 +++++++++++++---
 target/s390x/cpu_models.h     |  2 +
 target/s390x/gen-features.c   | 18 ++++++--
 target/s390x/helper.h         |  2 +-
 target/s390x/insn-data.def    | 11 ++---
 target/s390x/kvm.c            | 25 +++++-------
 target/s390x/misc_helper.c    | 34 ++++++++++------
 target/s390x/s390-tod.h       | 29 +++++++++++++
 target/s390x/trace-events     |  1 +
 target/s390x/translate.c      |  2 +
 19 files changed, 150 insertions(+), 173 deletions(-)
 delete mode 100644 hw/s390x/s390-pci-stub.c
 create mode 100644 target/s390x/s390-tod.h

--=20
2.17.2
