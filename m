Received: from eggs.gnu.org ([2001:4830:134:3::10]:51674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9cC-0000Xz-4A
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9c9-00069p-DV
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJ9c9-00069R-8Z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  8 Jun 2017 22:25:22 -0400
Message-Id: <1496975122-16999-8-git-send-email-cota@braap.org>
In-Reply-To: <1496975122-16999-1-git-send-email-cota@braap.org>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 7/7] trace: [trivial] Statically enable all
 guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

The optimizations of this series makes it feasible to have them
available on all builds.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/trace-events b/trace-events
index d7a4d94..b040d7e 100644
--- a/trace-events
+++ b/trace-events
@@ -125,7 +125,7 @@ vcpu guest_cpu_reset(void)
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
 
 # @num: System call number.
 # @arg*: System call argument value.
@@ -134,7 +134,7 @@ disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x
 #
 # Mode: user
 # Targets: TCG(all)
-disable vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=0x%016"PRIx64" arg1=0x%016"PRIx64" arg2=0x%016"PRIx64" arg3=0x%016"PRIx64" arg4=0x%016"PRIx64" arg5=0x%016"PRIx64" arg6=0x%016"PRIx64" arg7=0x%016"PRIx64" arg8=0x%016"PRIx64
+vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=0x%016"PRIx64" arg1=0x%016"PRIx64" arg2=0x%016"PRIx64" arg3=0x%016"PRIx64" arg4=0x%016"PRIx64" arg5=0x%016"PRIx64" arg6=0x%016"PRIx64" arg7=0x%016"PRIx64" arg8=0x%016"PRIx64
 
 # @num: System call number.
 # @ret: System call result value.
@@ -143,4 +143,4 @@ disable vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint
 #
 # Mode: user
 # Targets: TCG(all)
-disable vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=0x%016"PRIx64" ret=0x%016"PRIx64
+vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=0x%016"PRIx64" ret=0x%016"PRIx64
-- 
2.7.4
