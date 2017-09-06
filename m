Received: from eggs.gnu.org ([2001:4830:134:3::10]:58227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpWAp-0003TV-Mb
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpWAn-0000n3-5C
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpWAm-0000mm-Up
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E310A4E334
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 08:58:59 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Wed,  6 Sep 2017 10:58:52 +0200
Message-Id: <cover.1504688205.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] watchdog: Allow setting action on the
 fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com

diff to v2:
- Introduced 1/2 patch that renames WatchdogExpirationAction
- Better handling of unknown state in switch()
- Passs &error_abort to qmp_watchdog_set_action()

Michal Privoznik (2):
  qapi: Rename WatchdogExpirationAction enum
  watchdog: Allow setting action on the fly

 hw/watchdog/watchdog.c    | 64 +++++++++++++++++++++++------------------------
 hw/watchdog/wdt_diag288.c |  6 ++---
 include/sysemu/watchdog.h | 12 ++-------
 monitor.c                 |  4 +--
 qapi-schema.json          |  9 +++++++
 qapi/run-state.json       |  6 ++---
 6 files changed, 51 insertions(+), 50 deletions(-)

-- 
2.13.5
