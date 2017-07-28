Received: from eggs.gnu.org ([2001:4830:134:3::10]:60837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RR-0006Wk-Dd
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RQ-0006Kb-Jc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db1RQ-0006IV-D9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:16 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Jul 2017 11:19:58 +0200
Message-Id: <20170728092000.19216-3-cohuck@redhat.com>
In-Reply-To: <20170728092000.19216-1-cohuck@redhat.com>
References: <20170728092000.19216-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 2/4] target/s390x: fix pgm irq ilen in
 translate_pages()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

0 is certainly wrong. Let's use ILEN_AUTO.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170721125609.11117-3-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index a873dc48a0..1ad01584b4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -440,7 +440,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write)) {
-            program_interrupt(env, PGM_ADDRESSING, 0);
+            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
             return -EFAULT;
         }
         addr += TARGET_PAGE_SIZE;
-- 
2.13.3
