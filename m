Received: from eggs.gnu.org ([2001:4830:134:3::10]:41535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI2-0003Hj-0o
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI1-0008Vz-6y
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1coRI1-0008VG-1l
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D93FC05B1D1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:01:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 16 Mar 2017 10:01:35 +0100
Message-Id: <20170316090141.13421-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi

This are this week fixes for Migration:
- fix calculation of dirty-pages-rate (it was being too optimistic)
- Make sure we can remove tls params for migration (Dan)
- Disable postcopy with shared memory (Dave)
- migration-block: Don't call blk_drain too much (Lidong)
- Fix failed iotests cases (QingFeng)

Please apply, Juan.

The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170316

for you to fetch changes up to 8679638b0e231f97ad3456c681bf569ca7f7f6d5:

  postcopy: Check for shared memory (2017-03-16 09:02:26 +0100)

----------------------------------------------------------------
migration/next for 20170316

----------------------------------------------------------------
Chao Fan (1):
      Change the method to calculate dirty-pages-rate

Daniel P. Berrange (1):
      migration: use "" as the default for tls-creds/hostname

Dr. David Alan Gilbert (2):
      RAMBlocks: qemu_ram_is_shared
      postcopy: Check for shared memory

Lidong Chen (1):
      migration/block: Avoid invoking blk_drain too frequently

QingFeng Hao (1):
      vmstate: fix failed iotests case 68 and 91

 exec.c                    |  5 +++++
 include/exec/cpu-common.h |  1 +
 include/exec/ram_addr.h   |  5 ++++-
 migration/block.c         |  3 +++
 migration/migration.c     |  4 ++++
 migration/postcopy-ram.c  | 18 ++++++++++++++++++
 migration/ram.c           | 12 +++++-------
 migration/tls.c           |  2 +-
 migration/vmstate.c       |  8 ++++----
 qapi-schema.json          |  4 ++++
 10 files changed, 49 insertions(+), 13 deletions(-)
