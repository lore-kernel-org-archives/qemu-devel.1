Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0U-0004Q9-TB
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0R-00073t-OJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPh0R-00073T-Im
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D40F0401EF05
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 04:22:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  4 Jun 2018 06:21:51 +0200
Message-Id: <20180604042156.13812-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce014=
7a:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-=
010618-1' into staging (2018-06-01 17:32:30 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180604

for you to fetch changes up to c5e76115ccb4979cec795a8ae38becd07c2fde9f:

  migration: not wait RDMA_CM_EVENT_DISCONNECTED event after rdma_disconn=
ect (2018-06-04 05:46:15 +0200)

----------------------------------------------------------------
migration/next for 20180604

- RDMA fixes from (lidong)
- Fix docempress-error-check (Xiao)
- make -S and block work better (dave)
- don't migrate "bad" ramblocks (C=C3=A9dric)

Please apply, Juan.

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      migration: discard non-migratable RAMBlocks

Dr. David Alan Gilbert (1):
      migration: Don't activate block devices if using -S

Lidong Chen (2):
      migration: remove unnecessary variables len in QIOChannelRDMA
      migration: not wait RDMA_CM_EVENT_DISCONNECTED event after rdma_dis=
connect

Xiao Guangrong (1):
      migration: introduce decompress-error-check

 exec.c                    | 38 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c             |  4 ++++
 hw/i386/pc_piix.c         |  1 +
 hw/i386/pc_q35.c          |  1 +
 include/exec/cpu-common.h |  4 ++++
 include/hw/compat.h       |  7 ++++++-
 migration/migration.c     | 38 ++++++++++++++++++++++++++++++-------
 migration/migration.h     |  7 +++++++
 migration/postcopy-ram.c  | 12 ++++++------
 migration/ram.c           | 48 ++++++++++++++++++++++++++++++++++-------=
------
 migration/rdma.c          | 27 +++++++++-----------------
 migration/savevm.c        |  2 ++
 migration/trace-events    |  1 -
 qapi/migration.json       |  6 +++++-
 14 files changed, 149 insertions(+), 47 deletions(-)
