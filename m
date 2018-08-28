Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXO-0006PK-0i
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujO6-0004jD-JI
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujO6-0004gL-B4
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7CF6B5CB
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C3F70A30A3
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 21:10:42 +0200
Message-Id: <20180828191048.29806-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] QAPI patches for 2018-08-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-08-28

for you to fetch changes up to 8c643361eeba94b7b831ad95b70969d962034345:

  qapi: Add comments to aid debugging generated introspection (2018-08-28 18:21:38 +0200)

----------------------------------------------------------------
QAPI patches for 2018-08-28

* Generate comments to aid debugging generated introspection
* Doc updates
* Cleanups

----------------------------------------------------------------
Eric Blake (2):
      qapi: Minor introspect.py cleanups
      qapi: Add comments to aid debugging generated introspection

Markus Armbruster (3):
      qapi: Fix build_params() for empty parameter list
      qapi: Emit a blank line before dummy declaration
      qapi: Update docs for generator changes since commit 9ee86b85267

Peter Xu (1):
      qapi: Drop qapi_event_send_FOO()'s Error ** argument

 block/block-backend.c        |   8 +--
 block/qcow2.c                |   2 +-
 block/quorum.c               |   4 +-
 block/write-threshold.c      |   3 +-
 blockjob.c                   |  13 ++--
 cpus.c                       |   8 +--
 docs/devel/qapi-code-gen.txt | 142 ++++++++++++++++++++++++++++++++-----------
 dump.c                       |   3 +-
 hw/acpi/core.c               |   2 +-
 hw/acpi/cpu.c                |   2 +-
 hw/acpi/memory_hotplug.c     |   5 +-
 hw/char/virtio-console.c     |   3 +-
 hw/core/qdev.c               |   3 +-
 hw/net/virtio-net.c          |   2 +-
 hw/ppc/spapr_rtc.c           |   2 +-
 hw/timer/mc146818rtc.c       |   2 +-
 hw/virtio/virtio-balloon.c   |   3 +-
 hw/watchdog/watchdog.c       |  15 +++--
 include/qapi/qmp-event.h     |   3 +-
 job.c                        |   2 +-
 migration/migration.c        |   4 +-
 migration/ram.c              |   2 +-
 monitor.c                    |   5 +-
 scripts/qapi/common.py       |  11 ++--
 scripts/qapi/events.py       |  23 ++-----
 scripts/qapi/introspect.py   |  34 ++++++++---
 scsi/pr-manager-helper.c     |   3 +-
 tests/test-qmp-event.c       |  11 ++--
 ui/spice-core.c              |  10 ++-
 ui/vnc.c                     |   7 +--
 vl.c                         |  16 +++--
 31 files changed, 202 insertions(+), 151 deletions(-)

-- 
2.17.1
