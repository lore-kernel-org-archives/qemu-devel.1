Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKR-0001eH-7o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKN-0003Ff-80
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwKN-0003FI-1h
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:31 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:12 +0200
Message-Id: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 00/14] A set of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit b5a74cd81d76cb467552f38f2b39520d07c65ea2:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170724' into staging (2017-07-24 18:15:45 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170725

for you to fetch changes up to 7e01376daea75e888c370aab521a7d4aeaf2ffd1:

  s390x/css: fix ilen in IO instruction handlers (2017-07-25 09:17:42 +0200)

----------------------------------------------------------------
Various changes for the s390x code:
- updates for cpu model handling
- fix compilation with --disable-tcg
- fixes in vfio-ccw and I/O instruction handling

----------------------------------------------------------------

Christian Borntraeger (1):
  s390/cpumodel: remove KSS from the default model of z14

David Hildenbrand (5):
  target/s390x: drop BE_BIT()
  target/s390x: indicate query subfunction in s390_fill_feat_block
  target/s390x: introduce (test|set)_be_bit
  s390x/kvm: better comment regarding zPCI feature availability
  target/s390x: improve baselining if certain base features are missing

Dong Jia Shi (1):
  vfio/ccw: fix initialization of the Object DeviceState pointer in the
    common base-device

Halil Pasic (1):
  s390x/css: fix ilen in IO instruction handlers

Jing Zhang (1):
  vfio/ccw: allocate irq info with the right size

Thomas Huth (5):
  target/s390x: Move s390_cpu_dump_state() to helper.c
  target/s390x: Move diag helpers to a separate file
  target/s390x: Rework program_interrupt() and related functions
  target/s390x: Move exception-related functions to a new excp_helper.c
    file
  target/s390x: Add remaining switches to compile with --disable-tcg

 hw/vfio/ccw.c               |   3 +-
 target/s390x/Makefile.objs  |   8 +-
 target/s390x/cpu.c          |   4 +
 target/s390x/cpu.h          |  17 +-
 target/s390x/cpu_features.c |  33 ++-
 target/s390x/cpu_features.h |   9 +-
 target/s390x/cpu_models.c   |  34 +++
 target/s390x/diag.c         | 179 +++++++++++++++
 target/s390x/excp_helper.c  | 515 ++++++++++++++++++++++++++++++++++++++++++
 target/s390x/gen-features.c |   1 -
 target/s390x/helper.c       | 528 +++++---------------------------------------
 target/s390x/interrupt.c    |  39 ++++
 target/s390x/ioinst.c       |  42 ++--
 target/s390x/kvm.c          |  45 +---
 target/s390x/misc_helper.c  | 193 ----------------
 target/s390x/translate.c    |  60 -----
 16 files changed, 914 insertions(+), 796 deletions(-)
 create mode 100644 target/s390x/diag.c
 create mode 100644 target/s390x/excp_helper.c

-- 
2.13.3
