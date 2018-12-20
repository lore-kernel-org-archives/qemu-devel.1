Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZutU-0006WH-HM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZutS-000161-J0
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:45:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZutQ-0000wr-JZ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:45:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD324C0546DD
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:45:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98A4F6FED2
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:45:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Dec 2018 10:45:12 +0100
Message-Id: <20181220094514.3904-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Miscellaneous patches for 2018-12-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-12-20

for you to fetch changes up to 3a6b016d6487f3492bc1b80b2c3bc25c67aab8e2:

  build: Remake config-host.mak when VERSION changes (2018-12-20 10:31:08 +0100)

----------------------------------------------------------------
Miscellaneous patches for 2018-12-20

----------------------------------------------------------------
Markus Armbruster (2):
      Clean up includes
      build: Remake config-host.mak when VERSION changes

 Makefile                                  | 2 +-
 contrib/elf2dmp/pdb.h                     | 2 --
 contrib/elf2dmp/pe.h                      | 1 -
 contrib/elf2dmp/qemu_elf.h                | 1 -
 contrib/vhost-user-blk/vhost-user-blk.c   | 1 -
 contrib/vhost-user-scsi/vhost-user-scsi.c | 1 -
 hw/rdma/rdma_utils.c                      | 1 +
 hw/rdma/rdma_utils.h                      | 1 -
 hw/rdma/vmw/pvrdma_dev_ring.h             | 1 -
 hw/vfio/ap.c                              | 2 +-
 include/qemu/vfio-helpers.h               | 1 -
 include/sysemu/whpx.h                     | 1 -
 target/i386/sev.c                         | 3 ++-
 target/i386/whp-dispatch.h                | 1 -
 target/riscv/fpu_helper.c                 | 1 -
 tests/fp/platform.h                       | 1 -
 tests/tpm-util.h                          | 1 -
 tests/vhost-user-bridge.c                 | 2 +-
 util/qemu-thread-common.h                 | 1 -
 19 files changed, 6 insertions(+), 19 deletions(-)

-- 
2.17.2
