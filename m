Received: from eggs.gnu.org ([2001:4830:134:3::10]:47637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xeQ-00043E-M2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xeN-00033b-9b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xeN-00033R-3F
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19BF37CFA0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:24:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:24:40 +0200
Message-Id: <20170425102446.4008-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Move snapshots commands to hmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This series:
- Move snapshots commands to hmp.c, as they don't have code for migration
- Make them work with errors in a modern way instead of writting to the monitor
- make paolo happy and use hmp_handle_error

Later, Juan.

Juan Quintela (6):
  monitor: Remove monitor parameter from save_vmstate
  monitor: Move hmp_loadvm from monitor.c to hmp.c
  monitor: Move hmp_savevm from savevm.c to hmp.c
  monitor: Move hmp_delvm from savevm.c to hmp.c
  monitor: Move hmp_info_snapshots from savevm.c to hmp.c
  migration: Pass Error ** argument to {save,load}_vmstate

 hmp.c                    | 179 +++++++++++++++++++++++++++++++++++++++
 hmp.h                    |   4 +
 include/sysemu/sysemu.h  |   7 +-
 migration/savevm.c       | 216 ++++++-----------------------------------------
 monitor.c                |  13 ---
 replay/replay-snapshot.c |   6 +-
 vl.c                     |   4 +-
 7 files changed, 217 insertions(+), 212 deletions(-)

-- 
2.9.3
