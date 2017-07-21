Received: from eggs.gnu.org ([2001:4830:134:3::10]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dYYyF-00066K-8B
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dYYyC-0001Zu-WD
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:31:59 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:40382 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dYYyC-0001Vy-Kk
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:31:56 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Jul 2017 17:31:47 +0300
Message-Id: <20170721143149.43721-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, dgilbert@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Current trace system have a drawback: parameters of trace functions
are calculated even if corresponding tracepoint is disabled. Also, it
looks like trace function are not actually inlined by compiler (at
least for me).

Here is a fix proposal: move from function call to macros. Patch 02
is an example, of how to reduce extra calculations with help of
patch 01.

Vladimir Sementsov-Ogievskiy (2):
  trace: do not calculate arguments for disabled trace-points
  monitor: improve tracing in handle_qmp_command

 monitor.c                     |  6 +++---
 scripts/tracetool/format/h.py | 13 +++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.11.1
