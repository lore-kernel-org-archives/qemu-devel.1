Received: from eggs.gnu.org ([2001:4830:134:3::10]:45223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFt-0008Bs-JP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFq-0000at-Ed
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DFq-0000ab-8M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 353F43D948
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:40:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:43 +0200
Message-Id: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] Migration PULL requset
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

This pull request includes:
- Add return path to exec (danp)
- add traces (dave)
- move hmp commands to hmp.c (quintela)
- minor migration cleanups (quintela)

Please, apply.

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into staging (2017-05-02 15:16:29 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170504

for you to fetch changes up to 1db9d8e501fc99fa2201f228627952aee6cfc349:

  migration: Extra tracing (2017-05-04 10:41:23 +0200)

----------------------------------------------------------------
migration/next for 20170504

----------------------------------------------------------------
Daniel P. Berrange (1):
      migration: setup bi-directional I/O channel for exec: protocol

Dr. David Alan Gilbert (1):
      migration: Extra tracing

Juan Quintela (8):
      ram: Split dirty bitmap by RAMBlock
      migration: to_dst_file at that point is NULL
      monitor: Remove monitor parameter from save_vmstate
      monitor: Move hmp_loadvm from monitor.c to hmp.c
      monitor: Move hmp_savevm from savevm.c to hmp.c
      monitor: Move hmp_delvm from savevm.c to hmp.c
      monitor: Move hmp_info_snapshots from savevm.c to hmp.c
      migration: Move postcopy-ram.h to migration/

 hmp.c                                           | 174 +++++++++++++++
 hmp.h                                           |   4 +
 include/exec/ram_addr.h                         |  13 +-
 include/migration/migration.h                   |   3 +-
 include/sysemu/sysemu.h                         |   5 +-
 migration/exec.c                                |   4 +-
 migration/migration.c                           |   2 +-
 migration/postcopy-ram.c                        |   7 +-
 {include/migration => migration}/postcopy-ram.h |   3 -
 migration/ram.c                                 | 275 ++++++++++--------------
 migration/savevm.c                              | 185 +---------------
 migration/socket.c                              |   1 -
 migration/tls.c                                 |   1 -
 migration/trace-events                          |   2 +
 monitor.c                                       |  13 --
 replay/replay-snapshot.c                        |   2 +-
 16 files changed, 317 insertions(+), 377 deletions(-)
 rename {include/migration => migration}/postcopy-ram.h (95%)
