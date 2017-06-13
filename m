Received: from eggs.gnu.org ([2001:4830:134:3::10]:40011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP8-00037G-BJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP6-00043b-E9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dKsP6-000431-9P
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id o21so37629583qtb.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:27:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 13:26:57 -0700
Message-Id: <20170613202659.1920-2-rth@twiddle.net>
In-Reply-To: <20170613202659.1920-1-rth@twiddle.net>
References: <20170613202659.1920-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 1/3] target/s390x: correctly indicate PER
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170609142156.18767-2-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/misc_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index edcdf17..d6eda83 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -668,6 +668,7 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
         if (env->cregs[9] & PER_CR9_EVENT_NULLIFICATION) {
             CPUState *cs = CPU(s390_env_get_cpu(env));
 
+            env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
             env->int_pgm_code = PGM_PER;
             env->int_pgm_ilen = get_ilen(cpu_ldub_code(env, addr));
 
-- 
2.9.4
