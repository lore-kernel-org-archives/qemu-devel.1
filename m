Received: from eggs.gnu.org ([2001:4830:134:3::10]:54421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpron-0003CR-Ak
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dproi-0000QP-A5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dproi-0000Pf-3o
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C6E5C057FAF
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:05:39 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Thu,  7 Sep 2017 10:05:23 +0200
Message-Id: <cover.1504771369.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/3] watchdog.h: Drop local redefinition of
 actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com

diff to v4:
- in 3/3 compare passed action string case insensitively to the qapi enum

Michal Privoznik (3):
  qapi: Rename WatchdogExpirationAction enum
  watchdog.h: Drop local redefinition of actions enum
  watchdog: Allow setting action on the fly

 hw/watchdog/watchdog.c    | 65 ++++++++++++++++++++++++-----------------------
 hw/watchdog/wdt_diag288.c |  6 ++---
 include/sysemu/watchdog.h | 12 ++-------
 monitor.c                 |  4 +--
 qapi-schema.json          |  9 +++++++
 qapi/run-state.json       |  6 ++---
 6 files changed, 52 insertions(+), 50 deletions(-)

-- 
2.13.5
