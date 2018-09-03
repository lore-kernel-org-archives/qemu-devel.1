Received: from eggs.gnu.org ([2001:4830:134:3::10]:37569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwhXJ-0006mJ-JM
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 01:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwhXF-0003iD-3w
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 01:36:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fwhXE-0003fy-UA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 01:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ECC987A6F
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 05:36:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
Date: Mon, 03 Sep 2018 07:36:18 +0200
In-Reply-To: <20180903043149.4076-1-peterx@redhat.com> (Peter Xu's message of
	"Mon, 3 Sep 2018 12:31:42 +0800")
Message-ID: <87tvn7dtwt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 0/7] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> (this series is based on Markus's monitor-next tree so if patchew
>  spits something out with "apply failure" then it's expected)

Easy to avoid with suitable Based: tags in the cover letter:

Based-on: <20180828191048.29806-1-armbru@redhat.com>
Based-on: <20180901111716.1675-1-armbru@redhat.com>

The first one gets you "[PULL 0/6] QAPI patches for 2018-08-28", which
includes your PATCH 1+2.  The second one gets you "[PULL 0/6] Monitor
patches for 2018-09-01", which is monitor-next.

I pushed the result for reviewers' convenience:
http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/peterx-oob

>
> v7:
> - use Markus's commit message for patch "qapi: Drop
>   qapi_event_send_FOO()'s Error ** argument" [Markus]
> - update commit message for "qapi: remove COMMAND_DROPPED event" since
>   QEMU 3.0 is released [Eric/Dave]
> - rebase to Markus's monitor-next tree:
>   http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/monitor-next
>   the patch "monitor: suspend monitor instead of send CMD_DROP"
>   re-written since people prefer to drop need_resume flag so now I
>   hand-made it.  Dropped a few patches since not appliable any more.
>
> Please review.  Thanks,
>
> Markus Armbruster (1):
>   qapi: Fix build_params() for empty parameter list
>
> Peter Xu (6):
>   qapi: Drop qapi_event_send_FOO()'s Error ** argument
>   monitor: suspend monitor instead of send CMD_DROP
>   qapi: remove COMMAND_DROPPED event
>   monitor: remove "x-oob", turn oob on by default
>   Revert "tests: Add parameter to qtest_init_without_qmp_handshake"
>   tests: add oob functional test for test-qmp-cmds
>
>  block/block-backend.c        |  8 ++---
>  block/qcow2.c                |  2 +-
>  block/quorum.c               |  4 +--
>  block/write-threshold.c      |  3 +-
>  blockjob.c                   | 13 ++++----
>  cpus.c                       |  8 ++---
>  docs/devel/qapi-code-gen.txt |  6 ++--
>  docs/interop/qmp-spec.txt    |  5 ++--
>  dump.c                       |  3 +-
>  hw/acpi/core.c               |  2 +-
>  hw/acpi/cpu.c                |  2 +-
>  hw/acpi/memory_hotplug.c     |  5 ++--
>  hw/char/virtio-console.c     |  3 +-
>  hw/core/qdev.c               |  3 +-
>  hw/net/virtio-net.c          |  2 +-
>  hw/ppc/spapr_rtc.c           |  2 +-
>  hw/timer/mc146818rtc.c       |  2 +-
>  hw/virtio/virtio-balloon.c   |  3 +-
>  hw/watchdog/watchdog.c       | 15 +++++-----
>  include/monitor/monitor.h    |  1 -
>  include/qapi/qmp-event.h     |  3 +-
>  job.c                        |  2 +-
>  migration/migration.c        |  4 +--
>  migration/ram.c              |  2 +-
>  monitor.c                    | 58 ++++++++++++++----------------------
>  qapi/misc.json               | 40 -------------------------
>  scripts/qapi/common.py       | 10 +++----
>  scripts/qapi/events.py       | 23 ++++----------
>  scsi/pr-manager-helper.c     |  3 +-
>  tests/libqtest.c             | 10 +++----
>  tests/libqtest.h             |  4 +--
>  tests/qmp-test.c             |  6 ++--
>  tests/test-qmp-cmds.c        | 16 ++++++++++
>  tests/test-qmp-event.c       | 11 ++++---
>  ui/spice-core.c              | 10 +++----
>  ui/vnc.c                     |  7 ++---
>  vl.c                         | 21 +++++--------
>  37 files changed, 120 insertions(+), 202 deletions(-)

Diffstat looks friendlier without PATCH 1+2:

 docs/interop/qmp-spec.txt |  5 +++--
 include/monitor/monitor.h |  1 -
 monitor.c                 | 55 ++++++++++++++++++-----------------------------
 qapi/misc.json            | 40 ----------------------------------
 tests/libqtest.c          | 10 ++++-----
 tests/libqtest.h          |  4 +---
 tests/qmp-test.c          |  6 +++---
 tests/test-qmp-cmds.c     | 16 ++++++++++++++
 vl.c                      |  5 -----
 9 files changed, 48 insertions(+), 94 deletions(-)
