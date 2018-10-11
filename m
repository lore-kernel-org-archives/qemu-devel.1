Received: from eggs.gnu.org ([2001:4830:134:3::10]:44881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaa-0004vu-RW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001ch-E4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001U6-0X
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:34 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 11 Oct 2018 20:25:06 +0100
Message-Id: <20181011192513.63634-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: wei@redhat.com, thuth@redhat.com, i.maximets@samsung.com, den@openvz.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a=
5b:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10'=
 into staging (2018-10-11 10:43:37 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20181011a

for you to fetch changes up to 36bd9e3c8b049cb9124e04ed8bf8f9451d63de03:

  migration-test: Only generate a single target architecture (2018-10-11 =
19:58:26 +0100)

----------------------------------------------------------------
Migration pull 2018-10-11

With one bonus HMP/PCI fix from Denis.

----------------------------------------------------------------
Denis V. Lunev (1):
      qmp, hmp: make subsystem/system-vendor identities optional

Ilya Maximets (3):
      migration: Stop postcopy fault thread before notifying
      vhost-user: Fix userfaultfd leak
      vhost-user: Don't ask for reply on postcopy mem table set

Juan Quintela (1):
      migration-test: Only generate a single target architecture

Thomas Huth (1):
      tests/migration: Enable the migration test on s390x, too

Wei Huang (1):
      tests: Add migration test for aarch64

 hmp.c                                |   6 +-
 hw/pci/pci.c                         |  13 +-
 hw/virtio/vhost-user.c               |  20 ++-
 migration/postcopy-ram.c             |  11 +-
 qapi/misc.json                       |   4 +-
 tests/Makefile.include               |   2 +
 tests/migration-test.c               |  51 ++++++-
 tests/migration/Makefile             |  25 ++--
 tests/migration/aarch64/Makefile     |  18 +++
 tests/migration/aarch64/a-b-kernel.S |  75 +++++++++++
 tests/migration/aarch64/a-b-kernel.h |  18 +++
 tests/migration/migration-test.h     |  13 ++
 tests/migration/s390x/Makefile       |  24 ++++
 tests/migration/s390x/a-b-bios.c     |  36 +++++
 tests/migration/s390x/a-b-bios.h     | 253 +++++++++++++++++++++++++++++=
++++++
 15 files changed, 531 insertions(+), 38 deletions(-)
 create mode 100644 tests/migration/aarch64/Makefile
 create mode 100644 tests/migration/aarch64/a-b-kernel.S
 create mode 100644 tests/migration/aarch64/a-b-kernel.h
 create mode 100644 tests/migration/s390x/Makefile
 create mode 100644 tests/migration/s390x/a-b-bios.c
 create mode 100644 tests/migration/s390x/a-b-bios.h
