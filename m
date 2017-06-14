Received: from eggs.gnu.org ([2001:4830:134:3::10]:45001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m5-0001qW-HN
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m4-0007Lo-No
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:25 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL0m4-0007Le-K6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:24 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so39071450qtg.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:23:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 22:23:07 -0700
Message-Id: <20170614052311.13785-7-rth@twiddle.net>
In-Reply-To: <20170614052311.13785-1-rth@twiddle.net>
References: <20170614052311.13785-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 06/10] tcg/arm: Remove limit on code buffer size
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
