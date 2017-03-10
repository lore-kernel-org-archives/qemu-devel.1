Received: from eggs.gnu.org ([2001:4830:134:3::10]:45733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmKIl-0002Aw-Je
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmKIi-0001yj-EF
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:09:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cmKIi-0001y4-7f
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:09:44 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 10 Mar 2017 21:09:28 +0800
Message-Id: <1489151370-15453-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] hostmem: introduce
 host_memory_backend_mr_inited
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

This is a tiny cleanup series for host backend mem. Patch 1 introduced
the new interface, patch 2 uses them. Please review, thanks.

Peter Xu (2):
  hostmem: introduce host_memory_backend_mr_inited()
  hostmem: use host_memory_backend_mr_inited() where proper

 backends/hostmem-file.c  |  6 +++---
 backends/hostmem.c       | 19 ++++++++++++++-----
 include/sysemu/hostmem.h |  1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.7.4
