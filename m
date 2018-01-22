Received: from eggs.gnu.org ([2001:4830:134:3::10]:51402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamW-0001XC-Tl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamS-0005lq-W4
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:00:57 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 22 Jan 2018 13:00:36 +0100
Message-Id: <20180122120045.13538-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180122

for you to fetch changes up to 9f0d13f4f1de3cf9b70435cc4e87a301ee12471f:

  s390x/kvm: provide stfle.81 (2018-01-22 11:22:43 +0100)

----------------------------------------------------------------
Various fixes/improvements, and support for the new 81/82
facility bits.

----------------------------------------------------------------

Alistair Francis (1):
  hw/s390x: Replace fprintf(stderr, "*\n" with qemu_log_mask()

Christian Borntraeger (3):
  s390x/sclp: fixup highest CPU address
  s390x/kvm: Handle bpb feature
  s390x/kvm: provide stfle.81

Claudio Imbrenda (1):
  s390x: fix storage attributes migration for non-small guests

Cornelia Huck (1):
  linux-headers: update

David Hildenbrand (3):
  s390x/tcg: implement TEST PROTECTION
  s390x/sclp: fix missing be conversion
  s390x/tcg: fixup TEST PROTECTION

 hw/s390x/s390-stattrib-kvm.c                   |  4 +--
 hw/s390x/sclp.c                                |  6 ++--
 hw/s390x/virtio-ccw.c                          |  5 ++--
 include/standard-headers/asm-s390/virtio-ccw.h |  6 +---
 linux-headers/asm-powerpc/kvm.h                | 25 ++++++++++++++++
 linux-headers/asm-s390/kvm.h                   |  9 +++---
 linux-headers/asm-s390/kvm_para.h              |  4 ---
 linux-headers/linux/kvm.h                      |  8 ++++--
 target/s390x/cpu.c                             |  1 +
 target/s390x/cpu.h                             |  3 ++
 target/s390x/cpu_features.c                    |  2 ++
 target/s390x/cpu_features_def.h                |  2 ++
 target/s390x/gen-features.c                    |  2 ++
 target/s390x/helper.h                          |  2 +-
 target/s390x/kvm.c                             | 14 +++++++++
 target/s390x/machine.c                         | 17 +++++++++++
 target/s390x/mem_helper.c                      | 40 ++++++++++++++++++++++++--
 target/s390x/translate.c                       |  2 +-
 18 files changed, 124 insertions(+), 28 deletions(-)

-- 
2.13.6
