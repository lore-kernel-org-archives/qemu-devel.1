Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUd2-0008CZ-Cz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUcy-0005p8-FF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUcy-0005mk-8z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF3BB7F40C
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:41:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 18 Jul 2017 17:41:11 +0200
Message-Id: <20170718154127.6459-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/16] Migration
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

This pull request contain the RDMA migration fixes frmo Dave and
migration properties changes by Peter.

Please apply, Juan.


The following changes since commit e9277a19a1a50ab5662c16795531bac332f142=
f9:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2017-07-17-v=
2-tag' into staging (2017-07-18 14:14:32 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170718

for you to fetch changes up to 6b19a7d91c8de9904c67b87203a46e55db4181ab:

  migration: check global caps for validity (2017-07-18 17:36:26 +0200)

----------------------------------------------------------------
migration/next for 20170718

----------------------------------------------------------------
Dr. David Alan Gilbert (6):
      migration/rdma: Fix race on source
      migration: Close file on failed migration load
      migration/rdma: fix qemu_rdma_block_for_wrid error paths
      migration/rdma: Allow cancelling while waiting for wrid
      migration/rdma: Safely convert control types
      migration/rdma: Send error during cancelling

Peter Xu (10):
      qdev: provide DEFINE_PROP_INT64()
      migration: export parameters to props
      migration: export capabilities to props
      migration: introduce migrate_params_check()
      migration: provide migrate_params_apply()
      migration: check global params for validity
      migration: remove check against colo support
      migration: provide migrate_caps_check()
      migration: provide migrate_cap_add()
      migration: check global caps for validity

 hw/core/qdev-properties.c    |  32 ++++++
 include/hw/qdev-properties.h |   3 +
 include/migration/colo.h     |   1 -
 migration/colo.c             |   5 -
 migration/migration.c        | 268 +++++++++++++++++++++++++++++++++----=
------
 migration/rdma.c             | 137 ++++++++++++++++------
 6 files changed, 343 insertions(+), 103 deletions(-)
