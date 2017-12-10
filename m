Received: from eggs.gnu.org ([2001:4830:134:3::10]:60254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNvFy-00026Z-MU
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNvFu-0005yw-Q1
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eNvFu-0005xh-Kn
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8E694DAFB
	for <qemu-devel@nongnu.org>; Sun, 10 Dec 2017 06:38:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Sun, 10 Dec 2017 14:38:14 +0800
Message-Id: <20171210063819.14892-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] i8259: cleanups and enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

It's mostly a cleanup, but patch 4 allows kvm-i8259 to support "info
pic" and "info irq" too.

I'm thinking whether it'll be good to move on this work to spread
these commands to IOAPICs too, by removing "info ioapic" command and
let "info pic" dump the things altogether (after all I think ioapic is
also one type of PIC).  Also, we can let ioapic to have statistics
too.  Let me know if anyone thinks this can be useful/cleaner and want
me to continue (which won't need too much time for sure).

Please review.  Thanks,

Peter Xu (5):
  i8259: convert DPRINTFs into trace
  i8259: use DEBUG_IRQ_COUNT always
  i8259: generalize statistics into common code
  kvm-i8259: support "info pic" and "info irq"
  i8259: move TYPE_INTERRUPT_STATS_PROVIDER upper

 hw/i386/kvm/i8259.c             |  1 +
 hw/intc/i8259.c                 | 86 ++++++-----------------------------------
 hw/intc/i8259_common.c          | 49 +++++++++++++++++++++++
 hw/intc/trace-events            |  7 ++++
 include/hw/isa/i8259_internal.h |  7 +++-
 5 files changed, 74 insertions(+), 76 deletions(-)

-- 
2.14.3
