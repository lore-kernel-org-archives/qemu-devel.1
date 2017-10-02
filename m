Received: from eggs.gnu.org ([2001:4830:134:3::10]:47214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyyd3-00057S-1D
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyyd0-0001ay-8i
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyyd0-0001aS-32
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 254CB4A6E1
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 11:11:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-91.ams2.redhat.com
	[10.36.116.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E846B5C88B
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 11:11:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 13:11:08 +0200
Message-Id: <20171002111111.26932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-10-02
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-10-02

for you to fetch changes up to f0df84c6c46cb632dac2d9fae5fdbe6001527c3b:

  watchdog: Allow setting action on the fly (2017-10-02 13:09:09 +0200)

----------------------------------------------------------------
QAPI patches for 2017-10-02

----------------------------------------------------------------
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
2.13.6
