Received: from eggs.gnu.org ([209.51.188.92]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gme53-0000rT-5y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gme52-0004ru-DU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 15:25:23 +0300
Message-Id: <20190124122525.145968-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] fix qmp-cont vs migration-finish race-crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, lcapitulino@redhat.com, dgilbert@redhat.com

Hi.

It's a simple fix for problems reported in "Aborts in iotest 169"
by Max:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05907.html

In thread Kevin described that a problem itself is bigger and needs
more effort:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06136.html

So, we may continue discussion in "Aborts in iotest 169", and in
parallel apply these patches at least as a temporary fix.

The problem of this fix is that we finally have a bit weird interface:

User gets event MIGRATION_COMPLETED, and after it he can get error
message "Migration is not finalized yet". 

But it is better than crash, anyway.

Vladimir Sementsov-Ogievskiy (2):
  qmp: forbid qmp_cont in RUN_STATE_FINISH_MIGRATE
  iotest: fix 169: do not run qmp_cont in RUN_STATE_FINISH_MIGRATE

 qmp.c                  | 3 +++
 tests/qemu-iotests/169 | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.18.0
