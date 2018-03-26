Received: from eggs.gnu.org ([2001:4830:134:3::10]:57066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIu-0006Sk-P8
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIq-0006qp-9w
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:52 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIq-0006qM-3O
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:48 -0400
Received: by mail-wr0-x22b.google.com with SMTP id d10so18956417wrf.3
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:47 -0700 (PDT)
Received: from 640k.lan (94-36-194-48.adsl-ull.clienti.tiscali.it.
	[94.36.194.48]) by smtp.gmail.com with ESMTPSA id
	g186sm6710105wmd.41.2018.03.26.06.36.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Mar 2018 06:36:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:27 +0200
Message-Id: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/16] Misc fixes for QEMU 2.12.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 7b1db0908d88f0c9cfac24e214ff72a860692e23:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180323' into staging (2018-03-25 13:51:33 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f8e1a989644f22ba2f7afb0e13b6ce2309ea9503:

  qemu-pr-helper: Actually allow users to specify pidfile (2018-03-26 14:37:15 +0200)

----------------------------------------------------------------
Miscellaenous bugfixes, including crash fixes from Alexey, Peter M. and
Thomas.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      fdc: Exit if ISA controller does not support DMA

Ian Jackson (1):
      scripts/get_maintainer.pl: Print proper error message for missing $file

Justin Terry (VM) (3):
      WHPX fix WHvGetCapability out WrittenSizeInBytes
      WHPX fix WHvSetPartitionProperty in PropertyCode
      WHPX improve vcpu_post_run perf

Marc-André Lureau (2):
      vhost-user-test: do not hang if chardev creation failed
      vhost-user-test: add back memfd check

Michal Privoznik (1):
      qemu-pr-helper: Actually allow users to specify pidfile

Paolo Bonzini (2):
      chardev-socket: remove useless if
      scsi: turn "is this a SCSI device?" into a conditional hint

Peter Maydell (1):
      chardev/char-fe: Allow NULL chardev in qemu_chr_fe_init()

Peter Xu (1):
      iothread: fix breakage on windows

Richard Henderson (1):
      tcg: Really fix cpu_io_recompile

Thomas Huth (3):
      hw/net/can: Fix segfaults when using the devices without bus
      hw/audio: Fix crashes when devices are used on ISA bus without DMA
      scripts/device-crash-test: Remove fixed isapc-with-iommu entry

 accel/tcg/translate-all.c | 37 +++++--------------
 chardev/char-fe.c         | 22 ++++++-----
 chardev/char-socket.c     | 10 ++---
 configure                 |  4 +-
 hw/audio/cs4231a.c        |  8 +++-
 hw/audio/gus.c            |  7 +++-
 hw/audio/sb16.c           |  9 ++++-
 hw/block/fdc.c            |  5 ++-
 hw/net/can/can_sja1000.c  |  4 ++
 hw/scsi/scsi-disk.c       |  7 ++--
 hw/scsi/scsi-generic.c    |  7 ++--
 iothread.c                |  4 ++
 scripts/device-crash-test |  4 --
 scripts/get_maintainer.pl |  4 +-
 scsi/qemu-pr-helper.c     |  7 ++--
 target/i386/whpx-all.c    | 46 +++++++----------------
 tests/vhost-user-test.c   | 94 +++++++++++++++++++++++++++++++++--------------
 util/aio-win32.c          |  4 +-
 18 files changed, 159 insertions(+), 124 deletions(-)
-- 
1.8.3.1
