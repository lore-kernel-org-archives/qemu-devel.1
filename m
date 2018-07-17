Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZB-00054f-IQ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZ5-00079O-Sp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZ5-00078p-NA
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB78B402312B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:06:58 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1282026D68
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:06:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:42 +0200
Message-Id: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] Misc fixes for QEMU 3.0.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 9277d81f5c2c6f4d0b5e47c8476eb7ee7e5c0b=
eb:

  docs: Grammar and spelling fixes (2018-07-13 10:16:04 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git=20

for you to fetch changes up to dfaa7d50b0f72060764096ffcae4a0c06ce24f9b:

  Document command line options with single dash (2018-07-17 16:24:50 +02=
00)

----------------------------------------------------------------
Bug fixes.

----------------------------------------------------------------
BALATON Zoltan (1):
      Document command line options with single dash

Calvin Lee (1):
      PC Chipset: Improve serial divisor calculation

Daniel P. Berrang=C3=A9 (3):
      i386: fix regression parsing multiboot initrd modules
      i386: only parse the initrd_filename once for multiboot modules
      opts: remove redundant check for NULL parameter

Emanuele Giuseppe Esposito (1):
      vhost-user-test: added proper TestServer *dest initialization in te=
st_migrate()

Marc-Andr=C3=A9 Lureau (1):
      hw/char/serial: retry write if EAGAIN

Roman Kagan (2):
      hyperv: rename vcpu_id to vp_index
      hyperv: ensure VP index equal to QEMU cpu_index

Stefan Hajnoczi (2):
      qdev: add HotplugHandler->post_plug() callback
      virtio-scsi: fix hotplug ->reset() vs event race

Stefan Weil (1):
      accel: Fix typo and grammar in comment

Viktor Prutyanov (1):
      dump: add kernel_gs_base to QEMU CPU state

 accel/tcg/translate-all.c |  2 +-
 hw/char/serial.c          | 46 +++++++++++++++++++++++++++--------------=
-----
 hw/core/hotplug.c         | 10 ++++++++++
 hw/core/qdev.c            |  4 ++++
 hw/i386/multiboot.c       | 35 ++++++++++++++++-------------------
 hw/i386/pc.c              |  5 +++++
 hw/misc/hyperv_testdev.c  | 16 ++++++++--------
 hw/scsi/virtio-scsi.c     | 11 ++++++++++-
 include/hw/hotplug.h      | 11 +++++++++++
 qemu-options.hx           |  8 ++++----
 target/i386/arch_dump.c   | 10 ++++++++++
 target/i386/hyperv.c      | 16 +++++++++++++---
 target/i386/hyperv.h      |  7 +++++--
 target/i386/kvm-stub.c    |  5 +++++
 target/i386/kvm.c         | 47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 target/i386/kvm_i386.h    |  2 ++
 tests/vhost-user-test.c   |  3 +++
 util/qemu-option.c        |  8 +++-----
 18 files changed, 184 insertions(+), 62 deletions(-)
--=20
1.8.3.1
