Received: from eggs.gnu.org ([2001:4830:134:3::10]:36241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVA9-0007TL-JN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVA8-00019R-KD
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:41 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVA8-00018P-E4
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:40 -0400
Received: by mail-pg0-x241.google.com with SMTP id l64so793295pge.2
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:28:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:28:25 -0700
Message-Id: <20170804052833.10187-4-rth@twiddle.net>
In-Reply-To: <20170804052833.10187-1-rth@twiddle.net>
References: <20170804052833.10187-1-rth@twiddle.net>
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
Cc: agraf@suse.de, cohuck@redhat.com, borntraeger@de.ibm.com

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
