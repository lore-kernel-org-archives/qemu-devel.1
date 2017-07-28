Received: from eggs.gnu.org ([2001:4830:134:3::10]:60804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RP-0006Sm-8n
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RO-0006GZ-Gn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db1RO-0006Eg-Bh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Jul 2017 11:19:57 +0200
Message-Id: <20170728092000.19216-2-cohuck@redhat.com>
In-Reply-To: <20170728092000.19216-1-cohuck@redhat.com>
References: <20170728092000.19216-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 1/4] target/s390x: fix pgm irq ilen for
 stsi
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

The instruction is 4 bytes long.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170721125609.11117-2-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 44c5c401fb..d23ffcd890 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -192,7 +192,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
     if ((r0 & STSI_LEVEL_MASK) <= STSI_LEVEL_3 &&
         ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK))) {
         /* valid function code, invalid reserved bits */
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
     }
 
     sel1 = r0 & STSI_R0_SEL1_MASK;
-- 
2.13.3
