Received: from eggs.gnu.org ([2001:4830:134:3::10]:50786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoH-0004YX-OC
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoC-0000vG-Oq
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadoC-0000uf-KL
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09CE9402242D
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 09:10:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 17:10:35 +0800
Message-Id: <20180704091038.29449-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 0/3] monitor: allow per-monitor events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com

This series tries to allow QEMU to send events to specific monitor.
Markus told me to send this out before I threw the code away, so I
did.  Testing only covered compilation and qtest to make sure the
broadcast way should be working at least.

No real user, no nice testing, no idea on whether it could finally be
used - it takes the RFC tag then.

Thanks,

Peter Xu (3):
  monitor: allow monitor_qapi_event_emit specify mon
  monitor: let QMPEventFuncEmit take a monitor arg
  qapi: provide send/bcast interface for events

 include/qapi/qmp-event.h   |  6 +++-
 block/block-backend.c      |  6 ++--
 block/qcow2.c              |  2 +-
 block/quorum.c             |  4 +--
 block/write-threshold.c    |  2 +-
 blockjob.c                 | 10 +++---
 cpus.c                     |  8 ++---
 dump.c                     |  2 +-
 hw/acpi/core.c             |  2 +-
 hw/acpi/cpu.c              |  2 +-
 hw/acpi/memory_hotplug.c   |  4 +--
 hw/char/virtio-console.c   |  2 +-
 hw/core/qdev.c             |  2 +-
 hw/net/virtio-net.c        |  2 +-
 hw/ppc/spapr_rtc.c         |  2 +-
 hw/timer/mc146818rtc.c     |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 hw/watchdog/watchdog.c     | 14 ++++-----
 job.c                      |  2 +-
 migration/migration.c      |  4 +--
 migration/ram.c            |  2 +-
 monitor.c                  | 62 +++++++++++++++++++++++++++++---------
 scsi/pr-manager-helper.c   |  2 +-
 tests/test-qmp-event.c     | 10 +++---
 ui/spice-core.c            |  8 ++---
 ui/vnc.c                   |  6 ++--
 vl.c                       | 14 ++++-----
 scripts/qapi/common.py     | 16 ++++++++--
 scripts/qapi/events.py     | 27 ++++++++++++-----
 trace-events               |  2 +-
 30 files changed, 146 insertions(+), 83 deletions(-)

-- 
2.17.1
