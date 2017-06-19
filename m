Received: from eggs.gnu.org ([2001:4830:134:3::10]:33344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GE-0008NJ-UP
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GE-0002EZ-1q
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:50 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GD-0002EI-SB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:49 -0400
Received: by mail-pg0-x243.google.com with SMTP id f127so17441415pgc.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:33 -0700
Message-Id: <20170619181839.25249-7-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 06/12] tcg/arm: Remove limit on code buffer size
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

Since we're no longer using a direct branch, we have no
limit on the branch distance.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 translate-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/translate-all.c b/translate-all.c
index 46c5592..d4f364d 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -523,8 +523,6 @@ static inline PageDesc *page_find(tb_page_addr_t index)
 # define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
 #elif defined(__aarch64__)
 # define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
-#elif defined(__arm__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (16u * 1024 * 1024)
 #elif defined(__s390x__)
   /* We have a +- 4GB range on the branches; leave some slop.  */
 # define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
-- 
2.9.4
