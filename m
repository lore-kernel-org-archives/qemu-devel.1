Received: from eggs.gnu.org ([2001:4830:134:3::10]:35344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7wlO-000379-8a
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7wlL-0001zo-6d
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7wlL-0001zM-1S
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF4AF4E02E
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 04:28:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 May 2017 12:28:25 +0800
Message-Id: <1494304108-9805-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] kvm: irqchip: skip msi update when msi
 disabled
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

First two patches are new traces, please collect them if needed.

The third patch is a fix to a qemu crash reported here:

  https://bugzilla.redhat.com/show_bug.cgi?id=1448813

Please see its commit message for more information.

Please review. Thanks.

Peter Xu (3):
  kvm: irqchip: trace changes on msi add/remove
  msix: trace control bit write op
  kvm: irqchip: skip update msi when disabled

 hw/pci/msix.c       | 11 +++++++++--
 hw/pci/trace-events |  3 +++
 kvm-all.c           |  4 +++-
 target/i386/kvm.c   | 12 ++++++++----
 trace-events        |  3 ++-
 5 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.7.4
