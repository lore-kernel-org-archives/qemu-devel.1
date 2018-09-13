Received: from eggs.gnu.org ([2001:4830:134:3::10]:47522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8G-0003Cb-5B
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8B-0002pk-L1
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0R8B-0002ow-CJ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DC793082120
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 12:53:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Sep 2018 14:53:31 +0200
Message-Id: <20180913125343.10912-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] Migration queue
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

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180913

for you to fetch changes up to 418fe4f69648b4f3f0afd2588926deafac81cfe8:

  tests/migration: Enable the migration test on s390x, too (2018-09-13 14=
:06:26 +0200)

----------------------------------------------------------------
migration/next for 20180913

Hi this patchset has all pending migration queue that I have (It
superceedes the previous one).

- fix rdma_return_path (david)

- s390 migration-test (thomas)
  I ported it to the nema Makefile architecuter
  Please thomas, confirm that you agree with my changes

- aarch64 migration-test (wei)
- lots of compression fixes (xiao)

Please, apply.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      migration/rdma: Fix uninitialised rdma_return_path

Jose Ricardo Ziviani (1):
      Add a hint message to loadvm and exits on failure

Thomas Huth (1):
      tests/migration: Enable the migration test on s390x, too

Wei Huang (4):
      tests/migration: Convert x86 boot block compilation script into Mak=
efile
      tests/migration: Support cross compilation in generating boot heade=
r file
      tests/migration: Add migration-test header file
      tests: Add migration test for aarch64

Xiao Guangrong (5):
      migration: fix calculating xbzrle_counters.cache_miss_rate
      migration: handle the error condition properly
      migration: do not flush_compressed_data at the end of iteration
      migration: show the statistics of compression
      migration: use save_page_use_compression in flush_compressed_data

 hmp.c                                              |  13 +
 migration/migration.c                              |  12 +
 migration/ram.c                                    | 103 +++--
 migration/ram.h                                    |   1 +
 migration/rdma.c                                   |   2 +-
 migration/savevm.c                                 |   4 +-
 qapi/migration.json                                |  26 +-
 tests/Makefile.include                             |   2 +
 tests/migration-test.c                             |  83 +++-
 tests/migration/Makefile                           |  35 ++
 tests/migration/aarch64/Makefile                   |  20 +
 tests/migration/aarch64/a-b-kernel.S               |  75 ++++
 tests/migration/aarch64/a-b-kernel.h               |  19 +
 tests/migration/i386/Makefile                      |  22 ++
 .../{x86-a-b-bootblock.s =3D> i386/a-b-bootblock.S}  |   4 -
 .../{x86-a-b-bootblock.h =3D> i386/a-b-bootblock.h}  |   8 +-
 tests/migration/migration-test.h                   |  34 ++
 tests/migration/rebuild-x86-bootblock.sh           |  33 --
 tests/migration/s390x/Makefile                     |  22 ++
 tests/migration/s390x/a-b-bios.c                   |  35 ++
 tests/migration/s390x/a-b-bios.h                   | 427 +++++++++++++++=
++++++
 vl.c                                               |   1 +
 22 files changed, 899 insertions(+), 82 deletions(-)
 create mode 100644 tests/migration/Makefile
 create mode 100644 tests/migration/aarch64/Makefile
 create mode 100644 tests/migration/aarch64/a-b-kernel.S
 create mode 100644 tests/migration/aarch64/a-b-kernel.h
 create mode 100644 tests/migration/i386/Makefile
 rename tests/migration/{x86-a-b-bootblock.s =3D> i386/a-b-bootblock.S} (=
93%)
 rename tests/migration/{x86-a-b-bootblock.h =3D> i386/a-b-bootblock.h} (=
92%)
 create mode 100644 tests/migration/migration-test.h
 delete mode 100755 tests/migration/rebuild-x86-bootblock.sh
 create mode 100644 tests/migration/s390x/Makefile
 create mode 100644 tests/migration/s390x/a-b-bios.c
 create mode 100644 tests/migration/s390x/a-b-bios.h
