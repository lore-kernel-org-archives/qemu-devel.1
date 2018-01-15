Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1ebBDC-0007IP-Ff
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1ebBD7-0005qW-Ea
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1ebBD7-0005ps-9P
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CBD140226
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 20:18:23 +0000 (UTC)
Date: Mon, 15 Jan 2018 18:17:01 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20180115201700.GA4439@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] qemu: improve hugepage allocation failure
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>


Improve hugepage allocation failure message, indicating
what is happening to the user.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v2: move to allocate_system_memory_nonnuma (Paolo)
    s/whats/what is/ (Eric)

diff --git a/numa.c b/numa.c
index 7b9c33a..1f1aff1 100644
--- a/numa.c
+++ b/numa.c
@@ -463,6 +463,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
             if (mem_prealloc) {
                 exit(1);
             }
+            error_report("falling back to regular RAM allocation.");
 
             /* Legacy behavior: if allocation failed, fall back to
              * regular RAM allocation.
