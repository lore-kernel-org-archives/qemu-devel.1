Received: from eggs.gnu.org ([2001:4830:134:3::10]:47730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrb-0005u5-Hr
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrY-0000Ot-Eq
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLDrY-0000OY-8F
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B48881241
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 19:21:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Jun 2017 21:21:49 +0200
Message-Id: <1497468113-2874-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Poison some more target-specific defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This series marks some more #defines as poisoned, which are
target-specific (declared in config-target.h) and thus must
not be used in common code.

Note that these are just the easy cases - we should later also add
CONFIG_SOFTMMU and CONFIG_USER_ONLY, but they require some other
additional clean-up first.

Thomas Huth (4):
  include/exec/poison: Add missing TARGET defines
  include/exec/poison: Mark some CONFIG defines as poisoned, too
  include/hw/i386/pc.h: Move CONFIG_KVM related definitions to
    kvm_i386.h
  include/exec/poison: Mark CONFIG_KVM as poisoned, too

 hw/acpi/ich9.c         |  1 -
 hw/i386/pc_q35.c       |  1 +
 include/exec/poison.h  | 32 ++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h   | 13 -------------
 include/sysemu/kvm.h   | 37 +++++++++++++++++++++++++++++++++++--
 target/i386/kvm_i386.h | 13 +++++++++++++
 6 files changed, 81 insertions(+), 16 deletions(-)

-- 
1.8.3.1
