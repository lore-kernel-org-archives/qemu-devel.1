Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8O-0005QH-J5
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8M-0007QB-0i
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUp8L-0007Md-RP
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60CA0356E3
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 07:31:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Dec 2017 15:30:59 +0800
Message-Id: <20171229073104.3810-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] ioapic: support
 TYPE_INTERRUPT_STATS_PROVIDER
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

Let ioapic join the big family.  At last, I obsoleted "info ioapic",
kept the interface but telling people to start use "info pic".  We can
fully remove it after some releases.

Please review, thanks.

Peter Xu (5):
  doc: another fix to "info pic"
  ioapic: support "info pic"
  ioapic: some proper indents when dump info
  ioapic: support "info irq"
  hmp: obsolete "info ioapic"

 hmp-commands-info.hx              |  2 +-
 hw/i386/kvm/ioapic.c              | 11 ++-------
 hw/intc/ioapic.c                  | 12 +---------
 hw/intc/ioapic_common.c           | 47 +++++++++++++++++++++++++++++++++++----
 include/hw/i386/ioapic_internal.h |  3 +++
 include/hw/i386/pc.h              |  3 ---
 target/i386/monitor.c             |  8 ++-----
 7 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.14.3
