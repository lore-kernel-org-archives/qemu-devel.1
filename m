Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dbAMD-0004Ts-ML
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dbAM9-00042x-SD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:29 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dbAM9-00042m-OG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:25 -0400
Received: by mail-qt0-x244.google.com with SMTP id c15so8164025qta.3
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 11:51:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 28 Jul 2017 11:50:50 -0700
Message-Id: <20170728185050.20395-3-rth@twiddle.net>
In-Reply-To: <20170728185050.20395-1-rth@twiddle.net>
References: <20170728185050.20395-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.10 2/2] target/s390x: Fix CSST for
 16-byte store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Found by Coverity.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index cdc78aa3d4..c71dce4b1e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1580,6 +1580,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
                 cpu_stq_data_ra(env, a2 + 0, svh, ra);
                 cpu_stq_data_ra(env, a2 + 8, svl, ra);
             }
+            break;
         default:
             g_assert_not_reached();
         }
-- 
2.13.3
