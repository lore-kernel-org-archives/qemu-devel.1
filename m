Received: from eggs.gnu.org ([2001:4830:134:3::10]:50747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaF-0007TT-N3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaE-0001l1-LW
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:07 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 11 Sep 2017 16:20:53 +0200
Message-Id: <20170911142056.15643-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] hmp: fix "dump-quest-memory" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Fix aarch64 and ppc when dump-guest-memory is
used with none machine type and no CPU.

The other machine types don't have the problem.

Update test-hmp, to test none machine type
with (2 MB) and without memory, and add a test
to test dump-quest-memory without filter parameters
(it needs the fix from Cornelia Huck to work)

v2:
  - add arm fix
  - update test-hmp

Laurent Vivier (3):
  hmp: fix "dump-quest-memory" segfault (ppc)
  hmp: fix "dump-quest-memory" segfault (arm)
  tests/hmp: test "none" machine with memory

 target/arm/arch_dump.c | 52 +++++++++++++++++++++++++++++++++-----------------
 target/ppc/arch_dump.c | 17 +++++++++++------
 tests/test-hmp.c       |  5 +++++
 3 files changed, 50 insertions(+), 24 deletions(-)

-- 
2.13.5
