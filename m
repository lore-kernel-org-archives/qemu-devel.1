Received: from eggs.gnu.org ([2001:4830:134:3::10]:34288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKK-0004Nm-TF
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKH-00037n-MN
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwxKH-000365-GU
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 442B24020687
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 22:28:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  4 Sep 2018 00:27:53 +0200
Message-Id: <20180903222758.13267-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Migration queue
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

  git://github.com/juanquintela/qemu.git tags/migration/20180903

for you to fetch changes up to a28652cd4c138e9ed5d7dd9f7d10e3562f89ccac:

  Add a hint message to loadvm and exits on failure (2018-09-03 19:50:42 =
+0200)

----------------------------------------------------------------
migration/next for 20180903

Reviewed patches for migration:
- fix clang warning (david)
- Improve loadvm handling (Jose)
- Include migration test for s390 (thomas)
- Improve compression handling (xiao)

Please apply.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      migration/rdma: Fix uninitialised rdma_return_path

Jose Ricardo Ziviani (1):
      Add a hint message to loadvm and exits on failure

Thomas Huth (1):
      tests/migration: Enable the migration test on s390x, too

Xiao Guangrong (2):
      migration: fix calculating xbzrle_counters.cache_miss_rate
      migration: handle the error condition properly

 migration/ram.c                      |   36 +-
 migration/rdma.c                     |    2 +-
 migration/savevm.c                   |    4 +-
 tests/Makefile.include               |    1 +
 tests/Makefile.include.orig          | 1025 ++++++++++++++++++++++++++++=
++++++
 tests/migration-test.c               |   23 +
 tests/migration-test.c.orig          |  780 ++++++++++++++++++++++++++
 tests/migration/s390x-a-b-rebuild.sh |   42 ++
 tests/migration/s390x-a-b.c          |   35 ++
 tests/migration/s390x-a-b.h          |  427 ++++++++++++++
 vl.c                                 |    1 +
 11 files changed, 2362 insertions(+), 14 deletions(-)
 create mode 100644 tests/Makefile.include.orig
 create mode 100644 tests/migration-test.c.orig
 create mode 100755 tests/migration/s390x-a-b-rebuild.sh
 create mode 100644 tests/migration/s390x-a-b.c
 create mode 100644 tests/migration/s390x-a-b.h
