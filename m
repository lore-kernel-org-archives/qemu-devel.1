Received: from eggs.gnu.org ([2001:4830:134:3::10]:33742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpR-0001ec-O1
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpO-0008TE-KM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpO-0008SJ-E8
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32DAE61462
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:59:29 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-65.ams2.redhat.com
	[10.36.117.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2740E5033C
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:59:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:15 +0100
Message-Id: <20171116115926.16627-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Miscellaneous patches for QEMU 2.11-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d24aaf2a2915424962fb101142f28fa4307f47=
40:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-11-06 11:24:14 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 4950b1a766a16bd3feef4c9471b9794e6fe0e1b2:

  fix scripts/update-linux-headers.sh here document (2017-11-15 16:27:01 =
+0100)

----------------------------------------------------------------
Miscellaneous bugfixes

----------------------------------------------------------------
Dariusz Stojaczyk (1):
      vhost-user-scsi: add missing virtqueue_size param

Dr. David Alan Gilbert (1):
      ioapic/tracing: Remove last DPRINTFs

Emilio G. Cota (1):
      thread-posix: fix qemu_rec_mutex_trylock macro

Gerd Hoffmann (1):
      fix scripts/update-linux-headers.sh here document

Max Reitz (1):
      util/stats64: Fix min/max comparisons

Mike Nawrocki (1):
      Enable 8-byte wide MMIO for 16550 serial devices

Paolo Bonzini (1):
      exec: Do not resolve subpage in mru_section

Pavel Dovgalyuk (2):
      cpu-exec: don't overwrite exception_index
      cpu-exec: avoid cpu_exec_nocache infinite loop with record/replay

Philippe Mathieu-Daud=C3=A9 (1):
      Makefile: simpler/faster "make help"

Wanpeng Li (1):
      target-i386: adds PV_TLB_FLUSH CPUID feature bit

 Makefile                        |  2 +-
 accel/tcg/cpu-exec.c            | 99 ++++++++++++++++++++++++-----------=
------
 exec.c                          | 12 ++---
 hw/char/serial.c                |  8 +++-
 hw/intc/ioapic.c                | 17 ++-----
 hw/intc/trace-events            |  5 ++-
 hw/scsi/vhost-user-scsi.c       |  2 +
 include/qemu/thread-posix.h     |  2 +-
 scripts/update-linux-headers.sh |  2 +-
 target/i386/cpu.c               |  2 +-
 util/stats64.c                  |  4 +-
 11 files changed, 81 insertions(+), 74 deletions(-)
--=20
2.14.3
