Received: from eggs.gnu.org ([2001:4830:134:3::10]:38265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh2-0004NN-5v
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVgy-0004pT-T9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGVgy-0004ou-KQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61E25C0467CB
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 19:23:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 21:23:12 +0200
Message-Id: <20170601192327.29712-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Migration PULL request
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
	This pull requset includes:
	- fd leaks for return patch (peter)
	- remove loadvm_handlers
	- cleanup of include files for migration

Please, apply.

Thanks, Juan.


The following changes since commit c077a998eb3fcae2d048e3baeb5bc592d30fdd=
de:

  Merge remote-tracking branch 'remotes/riku/tags/pull-linux-user-2017053=
1' into staging (2017-06-01 15:50:40 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170601

for you to fetch changes up to 2c9e6fec89ff032a3f75a5a1caccc31901fb4056:

  migration: Move include/migration/block.h into migration/ (2017-06-01 1=
8:49:24 +0200)

----------------------------------------------------------------
migration/next for 20170601

----------------------------------------------------------------
Juan Quintela (13):
      migration: Use savevm_handlers instead of loadvm copy
      migration: loadvm handlers are not used
      migration: Remove section_id parameter from vmstate_load
      migration: Remove unneeded includes of migration/vmstate.h
      migration: Split qemu-file.h
      migration: Export exec.c functions in its own file
      migration: Export fd.c functions in its own file
      migration: Export socket.c functions in its own file
      migration: Export tls.c functions in its own file
      migration: Export rdma.c functions in its own file
      migration: Create include for migration snapshots
      migration: Export ram.c functions in its own file
      migration: Move include/migration/block.h into migration/

Peter Xu (2):
      migration: fix leak of src file on dst
      migration: shut src return path unconditionally

 hmp.c                                        |   5 +-
 hw/core/qdev.c                               |   1 -
 hw/i2c/i2c-ddc.c                             |   1 +
 hw/intc/s390_flic.c                          |   1 -
 hw/intc/s390_flic_kvm.c                      |   1 -
 hw/s390x/s390-skeys.c                        |   1 -
 include/block/block_int.h                    |   4 +-
 include/hw/acpi/memory_hotplug.h             |   1 -
 include/hw/acpi/pcihp.h                      |   1 -
 include/hw/hw.h                              |   2 +-
 include/hw/pci/shpc.h                        |   1 -
 include/migration/migration.h                |  73 ------------
 include/migration/misc.h                     |  29 +++++
 include/migration/qemu-file-types.h          | 164 +++++++++++++++++++++=
++++++
 include/migration/snapshot.h                 |  21 ++++
 include/migration/vmstate.h                  |   2 -
 include/qemu/typedefs.h                      |   1 -
 include/sysemu/sysemu.h                      |   3 -
 migration/block.c                            |   5 +-
 {include/migration =3D> migration}/block.h     |   2 -
 migration/channel.c                          |   1 +
 migration/colo.c                             |   4 +-
 migration/exec.c                             |   1 +
 migration/exec.h                             |  26 +++++
 migration/fd.c                               |   1 +
 migration/fd.h                               |  23 ++++
 migration/migration.c                        |  25 +++-
 migration/postcopy-ram.c                     |   4 +-
 migration/qemu-file-channel.c                |   3 +-
 migration/qemu-file.c                        |   2 +-
 {include/migration =3D> migration}/qemu-file.h | 157 +------------------=
------
 migration/ram.c                              |   4 +-
 migration/ram.h                              |  70 ++++++++++++
 migration/rdma.c                             |   5 +-
 migration/rdma.h                             |  25 ++++
 migration/savevm.c                           |  71 +++++-------
 migration/socket.c                           |   3 +-
 migration/socket.h                           |  28 +++++
 migration/tls.c                              |   1 +
 migration/tls.h                              |  34 ++++++
 migration/vmstate-types.c                    |   3 +-
 migration/vmstate.c                          |   2 +-
 replay/replay-snapshot.c                     |   5 +-
 target/alpha/cpu.c                           |   1 -
 target/hppa/cpu.c                            |   1 -
 target/s390x/cpu.c                           |   1 -
 target/tilegx/cpu.c                          |   1 -
 tests/test-vmstate.c                         |   3 +-
 vl.c                                         |   5 +-
 49 files changed, 510 insertions(+), 319 deletions(-)
 create mode 100644 include/migration/misc.h
 create mode 100644 include/migration/qemu-file-types.h
 create mode 100644 include/migration/snapshot.h
 rename {include/migration =3D> migration}/block.h (93%)
 create mode 100644 migration/exec.h
 create mode 100644 migration/fd.h
 rename {include/migration =3D> migration}/qemu-file.h (62%)
 create mode 100644 migration/ram.h
 create mode 100644 migration/rdma.h
 create mode 100644 migration/socket.h
 create mode 100644 migration/tls.h
