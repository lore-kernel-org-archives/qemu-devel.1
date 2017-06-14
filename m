Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL6px-0007q4-WD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL6pt-0000Ra-Vd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:51:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL6pt-0000RO-Pi
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99C7181F01
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 11:51:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Jun 2017 13:51:33 +0200
Message-Id: <20170614115138.19571-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Migration PULL request
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

In this pull requset:
- I included the v1 of peter return path, fix it
- fix the compliation with older compilers (new compliers don't
   complain about a repeated typedef, so I didn't noticed)
- Add test for disabled features
- Last bit of misc cleanup, remove of not needed includes

Please, apply.

Thanks, Juan.

The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170614

for you to fetch changes up to 3416ab5bb452f1b6cea58aed8983ffb9a455b7c4:

  migration: Don't create decompression threads if not enabled (2017-06-14 11:11:06 +0200)

----------------------------------------------------------------
migration/next for 20170614

----------------------------------------------------------------
Juan Quintela (4):
      migration: Fix compilation with older compilers
      migration: Remove unneeded includes
      migration: Test for disabled features on reception
      migration: Don't create decompression threads if not enabled

Peter Xu (1):
      migration: fix incorrect enable return path

 include/migration/colo.h     |  3 ---
 include/migration/misc.h     |  2 ++
 include/migration/register.h |  3 ---
 include/migration/vmstate.h  |  1 -
 include/qemu/typedefs.h      |  2 ++
 migration/block.c            |  6 ------
 migration/colo-failover.c    |  2 ++
 migration/colo.c             |  2 --
 migration/exec.c             |  2 --
 migration/fd.c               |  2 --
 migration/global_state.c     |  1 -
 migration/migration.c        | 12 +++++-------
 migration/migration.h        |  2 --
 migration/postcopy-ram.c     |  2 --
 migration/qemu-file.c        |  2 --
 migration/ram.c              | 24 +++++++++++++++++++-----
 migration/savevm.c           |  6 ------
 17 files changed, 30 insertions(+), 44 deletions(-)
