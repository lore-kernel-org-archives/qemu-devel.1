Received: from eggs.gnu.org ([2001:4830:134:3::10]:33293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6RP-0005Pv-1K
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6RL-0002Et-1i
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dn6RK-0002EP-RG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Aug 2017 19:05:50 +0200
Message-Id: <20170830170601.15855-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 00/11] next round of s390x cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

No new functionality, only cleanups, some of the discussed during the last
round of cleanups.

Not sure if the first two patches should be sent separatly? Anyhow, they
are most probably not worth the trouble :)

The biggest part of this series is getting rid of s390-virtio.c and
cleaning up our cpu number/id handling.

Based on: git://github.com/cohuck/qemu s390-next


David Hildenbrand (11):
  exec,dump: don't include exec/exec-all.h explicitly
  cpu: drop old comments describing members
  s390x: store cpu states inside machine state
  s390x: get rid of s390-virtio.c
  s390x: rename s390-virtio.h to s390-virtio-hcall.h
  target/s390x: cleanup cpu number/address handling
  target/s390x: rename next_cpu_id to next_cpu_addr
  s390x: allow only 1 CPU with TCG
  target/s390x: tcg_s390_program_interrupt() will never return
  target/s390x: use trigger_pgm_exception() in
    s390_cpu_handle_mmu_fault()
  target/s390x: use program_interrupt() in per_check_exception()

 dump.c                             |   1 -
 exec.c                             |   1 -
 hw/s390x/Makefile.objs             |   1 -
 hw/s390x/s390-virtio-ccw.c         | 169 ++++++++++++++++++++++++++++++-
 hw/s390x/s390-virtio-hcall.c       |   2 +-
 hw/s390x/s390-virtio-hcall.h       |  20 ++++
 hw/s390x/s390-virtio.c             | 201 -------------------------------------
 hw/s390x/s390-virtio.h             |  35 -------
 include/hw/s390x/s390-virtio-ccw.h |   3 +
 include/qom/cpu.h                  |   6 +-
 target/s390x/cpu-qom.h             |   2 +-
 target/s390x/cpu.c                 |  74 ++++----------
 target/s390x/cpu.h                 |   5 +-
 target/s390x/cpu_models.c          |   2 +-
 target/s390x/excp_helper.c         |   5 +-
 target/s390x/helper.c              |   8 +-
 target/s390x/interrupt.c           |   3 +-
 target/s390x/misc_helper.c         |  13 +--
 target/s390x/translate.c           |   5 +-
 19 files changed, 230 insertions(+), 326 deletions(-)
 create mode 100644 hw/s390x/s390-virtio-hcall.h
 delete mode 100644 hw/s390x/s390-virtio.c
 delete mode 100644 hw/s390x/s390-virtio.h

-- 
2.13.5
