Received: from eggs.gnu.org ([2001:4830:134:3::10]:35148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKbm-0006O9-B4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKbl-0003Ci-A9
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:30 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddKbk-0003BV-Q9
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:29 -0400
Received: by mail-pf0-x242.google.com with SMTP id t86so2188886pfe.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 11:12:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 11:12:23 -0700
Message-Id: <20170803181224.21748-3-rth@twiddle.net>
In-Reply-To: <20170803181224.21748-1-rth@twiddle.net>
References: <20170803181224.21748-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.10 2/3] target/s390x: Fix CSST for 16-byte
 store
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

Found by Coverity (CID 1378273).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
