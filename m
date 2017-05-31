Received: from eggs.gnu.org ([2001:4830:134:3::10]:33052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzjI-0007jj-46
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzjE-0001qh-Op
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFzjE-0001nk-IV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A0A6C05681A
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:15:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 31 May 2017 11:15:33 +0200
Message-Id: <20170531091538.21626-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Migration pull request
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

This are the migration patches ready for inclusion:
- autoconverge improvements: (felipe franciosi)
- create savem.h

Please, Apply.

The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170531

for you to fetch changes up to b4a3c64b16856a018869bfd4a9ed3b2a74554541:

  migration: use dirty_rate_high_cnt more aggressively (2017-05-31 09:39:20 +0200)

----------------------------------------------------------------
migration/next for 20170531

----------------------------------------------------------------
Felipe Franciosi (4):
      migration: keep bytes_xfer_prev init'd to zero
      migration: set dirty_pages_rate before autoconverge logic
      migration: set bytes_xfer_* outside of autoconverge logic
      migration: use dirty_rate_high_cnt more aggressively

Juan Quintela (1):
      migration: Create savevm.h for functions exported from savevm.c

 include/sysemu/sysemu.h  | 47 -----------------------------------------------
 migration/colo.c         |  1 +
 migration/migration.c    |  1 +
 migration/postcopy-ram.c |  1 +
 migration/ram.c          | 23 +++++++++++------------
 migration/savevm.c       | 29 +++++++++++++++++++++++++----
 migration/savevm.h       | 41 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 80 insertions(+), 63 deletions(-)
 create mode 100644 migration/savevm.h
