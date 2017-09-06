Received: from eggs.gnu.org ([2001:4830:134:3::10]:51424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpYRx-0001aK-CK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpYRs-0005D9-Eh
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpYRs-0005Cm-8n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79C995D68C
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:24:46 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Wed,  6 Sep 2017 13:24:37 +0200
Message-Id: <cover.1504696921.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/3] watchdog: Allow setting action on the
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
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com

diff to v3:
- Broken the last patch into two:
  - dropping local redefine of the WatchdogAction enum,
  - introducing new monitor command.
- Dropped two unused #include-s

Michal Privoznik (3):
  qapi: Rename WatchdogExpirationAction enum
  watchdog.h: Drop local redefinition of actions enum
  watchdog: Allow setting action on the fly

 hw/watchdog/watchdog.c    | 62 +++++++++++++++++++++++------------------------
 hw/watchdog/wdt_diag288.c |  6 ++---
 include/sysemu/watchdog.h | 12 ++-------
 monitor.c                 |  4 +--
 qapi-schema.json          |  9 +++++++
 qapi/run-state.json       |  6 ++---
 6 files changed, 49 insertions(+), 50 deletions(-)

-- 
2.13.5
