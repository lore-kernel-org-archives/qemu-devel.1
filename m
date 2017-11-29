Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8xO-0006cL-27
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8xL-000867-3Y
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:46 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Nov 2017 21:26:58 +0100
Message-Id: <20171129202701.16117-14-david@redhat.com>
In-Reply-To: <20171129202701.16117-1-david@redhat.com>
References: <20171129202701.16117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 13/16] s390x/tcg: use
 s390_program_interrupt() in SACF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Convert this user, too.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index f008897e84..5d91e458a8 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -564,7 +564,7 @@ void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
         break;
     default:
         HELPER_LOG("unknown sacf mode: %" PRIx64 "\n", a1);
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
         break;
     }
 }
-- 
2.14.3
