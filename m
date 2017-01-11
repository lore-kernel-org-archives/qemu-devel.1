Received: from eggs.gnu.org ([2001:4830:134:3::10]:34887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ub-0005iL-RK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ua-00031n-Sn
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:25 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ua-00031M-Nt
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:24 -0500
Received: by mail-pf0-x244.google.com with SMTP id f144so12524019pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:17 -0800
Message-Id: <20170111021820.24416-3-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/65] tcg: Minor adjustments to deposit
 expanders
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

Assert that len is not 0.

Since we have asserted that ofs + len <= N, a later
check for len == N implies that ofs == 0.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg-op.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c185b9c..b17f03f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -533,10 +533,11 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     TCGv_i32 t1;
 
     tcg_debug_assert(ofs < 32);
+    tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
     tcg_debug_assert(ofs + len <= 32);
 
-    if (ofs == 0 && len == 32) {
+    if (len == 32) {
         tcg_gen_mov_i32(ret, arg2);
         return;
     }
@@ -1718,10 +1719,11 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     TCGv_i64 t1;
 
     tcg_debug_assert(ofs < 64);
+    tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
     tcg_debug_assert(ofs + len <= 64);
 
-    if (ofs == 0 && len == 64) {
+    if (len == 64) {
         tcg_gen_mov_i64(ret, arg2);
         return;
     }
-- 
2.9.3
