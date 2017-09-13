Received: from eggs.gnu.org ([2001:4830:134:3::10]:35537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8X8-0004bl-Kl
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8X5-0003Qy-Ij
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:20:54 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 13 Sep 2017 16:20:32 +0200
Message-Id: <20170913142036.2469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/4] hmp: fix "dump-quest-memory" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Fix aarch64 and ppc when dump-guest-memory is
used with none machine type and no CPU.

The other machine types don't have the problem.

Update test-hmp, to test none machine type
with (2 MB) and without memory, and add a test
to test dump-quest-memory without filter parameters

v4:
  - update comment in test-hmp.c
  - add cohuck's patch

v3:
  - remove blank line after a comment
  - forbid memory dump when there is no CPU

v2:
  - add arm fix
  - update test-hmp

Cornelia Huck (1):
  dump: do not dump non-existent guest memory

Laurent Vivier (3):
  hmp: fix "dump-quest-memory" segfault (ppc)
  hmp: fix "dump-quest-memory" segfault (arm)
  tests/hmp: test "none" machine with memory

 dump.c                 |  6 ++++++
 target/arm/arch_dump.c | 11 +++++++++--
 target/ppc/arch_dump.c | 11 +++++++++--
 tests/test-hmp.c       |  4 ++++
 4 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.13.5
