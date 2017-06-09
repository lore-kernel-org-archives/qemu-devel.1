Received: from eggs.gnu.org ([2001:4830:134:3::10]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJKng-0000eA-TQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJKnc-00014m-NQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dJKnc-00014S-IW
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:22:04 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Jun 2017 16:21:55 +0200
Message-Id: <20170609142156.18767-2-david@redhat.com>
In-Reply-To: <20170609142156.18767-1-david@redhat.com>
References: <20170609142156.18767-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/2] target/s390x: correctly indicate PER
 nullification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 75fd13e..9f51af3 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -671,6 +671,7 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
         if (env->cregs[9] & PER_CR9_EVENT_NULLIFICATION) {
             CPUState *cs = CPU(s390_env_get_cpu(env));
 
+            env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
             env->int_pgm_code = PGM_PER;
             env->int_pgm_ilen = get_ilen(cpu_ldub_code(env, addr));
 
-- 
2.9.3
