Received: from eggs.gnu.org ([2001:4830:134:3::10]:59039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPca-0007ay-83
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPcV-000189-Hh
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fkPcV-00017W-Af
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id a3-v6so15571632wrt.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:03:03 -0700 (PDT)
Received: from donizetti.redhat.com
	(94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
	by smtp.gmail.com with ESMTPSA id
	j8-v6sm21748565wru.41.2018.07.31.01.03.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 31 Jul 2018 01:03:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 31 Jul 2018 10:02:55 +0200
Message-Id: <20180731080259.15934-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Misc patches for 2018-07-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to cc4c77e12b422db8a685cec97866950895a684bc:

  backends/cryptodev: remove dead code (2018-07-30 14:00:11 +0200)

----------------------------------------------------------------
Bug fixes.

----------------------------------------------------------------
Jay Zhou (1):
      backends/cryptodev: remove dead code

Paolo Bonzini (2):
      i386: do not migrate MSR_SMI_COUNT on machine types <2.12
      i386: implement MSR_SMI_COUNT for TCG

Pavel Dovgalyuk (1):
      timer: remove replay clock probe in deadline calculation

 backends/cryptodev-vhost-user.c |  5 -----
 include/hw/i386/pc.h            |  4 ++++
 target/i386/cpu.c               |  2 ++
 target/i386/cpu.h               |  1 +
 target/i386/machine.c           |  2 +-
 target/i386/misc_helper.c       |  3 +++
 target/i386/smm_helper.c        |  1 +
 util/qemu-timer.c               | 11 ++---------
 8 files changed, 14 insertions(+), 15 deletions(-)
-- 
1.8.3.1
