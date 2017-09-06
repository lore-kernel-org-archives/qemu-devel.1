Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGj-0002yj-Mv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGf-0001Yk-1C
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGe-0001Y2-RW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9766F4E909
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:25 +0100
Message-Id: <20170906184133.25524-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac06=
5e:

  Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170906a

for you to fetch changes up to a31fedeed764ce0b0d6097d4334c5770e74641a0:

  migration: dump str in migrate_set_state trace (2017-09-06 16:36:38 +01=
00)

----------------------------------------------------------------
migration pull 2017-09-06

----------------------------------------------------------------
Dr. David Alan Gilbert (4):
      migration: Report when bdrv_inactivate_all fails
      runstate/migrate: Two more transitions
      migration: Reset rather than destroy main_thread_load_event
      snapshot/tests: Try loadvm twice

Markus Armbruster (3):
      xbzrle: Drop unused cache_resize()
      host-utils: Proactively fix pow2floor(), switch to unsigned
      host-utils: Simplify pow2ceil()

Peter Xu (1):
      migration: dump str in migrate_set_state trace

 include/qemu/host-utils.h  | 36 +++++++++++++++++------------
 migration/migration.c      |  5 +++--
 migration/page_cache.c     | 56 ----------------------------------------=
------
 migration/page_cache.h     | 11 ---------
 migration/savevm.c         |  2 ++
 migration/trace-events     |  2 +-
 tests/qemu-iotests/068     |  2 +-
 tests/qemu-iotests/068.out |  4 ++++
 vl.c                       |  2 ++
 9 files changed, 35 insertions(+), 85 deletions(-)
